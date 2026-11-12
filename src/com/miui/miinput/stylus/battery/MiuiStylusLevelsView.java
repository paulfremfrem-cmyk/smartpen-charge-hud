package com.miui.miinput.stylus.battery;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Paint;
import android.graphics.Rect;
import android.graphics.RectF;
import android.graphics.Typeface;
import android.graphics.drawable.Drawable;
import android.os.SystemClock;
import android.util.AttributeSet;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewParent;
import android.view.WindowManager;
import android.view.animation.PathInterpolator;

/**
 * Stylus charge HUD, drawn with SecurityCoreAdd's own components.
 *
 * The white tile (374 x 111 reference) drops in from the top of the
 * window, the title shrinks, the gauge fills, then the tile slides back up.
 *
 * Rendering: the tile is pre-rendered once into a Bitmap; the animation
 * loop only performs drawBitmap / drawText / drawRoundRect (no allocation).
 * The gauge follows the HTML mock-up: grey shell, white interior,
 * fully rounded fill (red -> orange -> green) and a thin nub. The light
 * veil MIUI paints behind the window (BackgroundBlurDrawable, set after
 * addView) is cleared on every frame from run().
 *
 * Exit: the popup window stops 84 px below the top of the screen (status
 * bar inset), which would clip the tile. So the window is expanded ONCE
 * upwards (negative y, LAYOUT_NO_LIMITS): the tile can then enter and
 * leave through the real screen edge, like translateY(-100% - 9cqw) in
 * the HTML, with no updateViewLayout during the animation.
 *
 * Module constraints:
 *  - the class is injected into SecurityCoreAdd.apk (dex patch): no own
 *    resources, no miuix dependency, a single class (no inner class, no
 *    lambda: the animation is driven by postOnAnimation and the blur is
 *    cleared from run()).
 */
public class MiuiStylusLevelsView extends View implements Runnable {


    // ---------------------------------------------------------------- geometrie
    private static final float REF_W = 374f;
    private static final float REF_H = 111f;
    private static final float TILE_RATIO = 0.945f;

    private static final float TITLE_SIZE_SMALL = 27.2f;
    private static final float TITLE_SIZE_BIG = 42.8f;
    private static final float TITLE_CAP_TOP_SMALL = 29.0f;
    private static final float TITLE_CAP_TOP_BIG = 40.6f;

    private static final float PCT_SIZE = 27.2f;
    private static final float PCT_RIGHT = 171f;
    private static final float PCT_BASELINE = 89.5f;

    // gauge: measured from the HTML reference (1 cqw = 7.192 ref for a 374
    // tile) -> grey outline, fully rounded fill, thin nub on the right.
    private static final float BATT_L = 190f;      // bord gauche de la coque
    private static final float BATT_W = 66f;       // 9.18cqw
    private static final float BATT_H = 30f;       // 4.17cqw
    private static final float BATT_CY = 79f;
    private static final float BATT_BORDER = 3f;   // 0.42cqw
    private static final float BATT_RADIUS = 8f;   // 1.11cqw
    private static final float BATT_PAD = 1.4f;    // 0.19cqw
    private static final float BATT_FILL_R = 2.3f; // 0.32cqw
    private static final float NUB_W = 5f;         // 0.70cqw
    private static final float NUB_H = 8f;         // 1.11cqw
    private static final float NUB_GAP = 1.4f;     // 0.20cqw

    // ic_stylus_in_charging bolt: viewport 18 x 29
    private static final float BOLT_H = 17f;
    private static final float BOLT_W = BOLT_H * 18f / 29f;
    private static final float BOLT_GAP = 5f;

    private static final String TITLE = "Smart Pen";

    // ---------------------------------------------------------------- couleurs
    private static final int WHITE = 0xFFFFFFFF;
    /** app's stylus_text_color. */
    private static final int TITLE_COLOR = 0xFF000000;
    /** app's stylus_battery_simple_text_color: #cc000000. */
    private static final int PCT_COLOR = 0xCC000000;
    /** gauge outline + nub: HTML --grey. */
    private static final int BATT_GREY = 0xFF8E8E93;

    // ---------------------------------------------------------------- animation
    private static final long RESET_MS = 0;
    private static final long DROP_MS = 680;
    /** very short fade: the tile is revealed by the screen edge, not by
     *  opacity (otherwise the drop is over before it becomes visible). */
    private static final long FADE_MS = 70;
    private static final long DROP_HOLD_MS = 1500;
    private static final long COMPACT_MS = 740;
    private static final long ROW_FADE_MS = 340;
    private static final long ROW_SHIFT_MS = 620;
    private static final long COMPACT_HOLD_MS = 820;
    private static final long HOLD_MS = 1400;
    /** the tile rests a few dp higher than before (shallower drop). */
    private static final float REST_LIFT_DP = 6f;
    private static final long OUT_MS = 520;

    /** false until the first frame has actually been drawn. */
    private boolean firstFrame = false;
    /** frames spent waiting for the window expansion (safety net). */
    private int gateFrames = 0;

    // ---------------------------------------------------------------- ressources
    /** id of the "charging" ImageView in stylus_info_layout.xml. */
    private static final int ID_CHARGING_ICON = 0x7f0a0491;

    private static final int ID_BOLT = 0x7f080187;

    private final PathInterpolator spring =
            new PathInterpolator(0.19f, 1.06f, 0.26f, 1f);
    private final PathInterpolator smooth =
            new PathInterpolator(0.32f, 0.72f, 0f, 1f);
    /** opacity: fast rise (the screen edge does the reveal). */
    private final PathInterpolator fadeEase =
            new PathInterpolator(0.2f, 0f, 0.4f, 1f);
    /** exit: soft start then near-constant speed, no dead time. */
    private final PathInterpolator outEase =
            new PathInterpolator(0.35f, 0f, 0.8f, 0.8f);

    private float slide = 0f;
    private float fade = 0f;
    private float compact = 0f;
    private float rowA = 0f;
    private float rowY = 0f;
    private float level = 0f;

    private float targetLevel = 40f;
    private boolean playing = false;
    private boolean charging = false;
    private int pendingLevel = -1;
    private long startAt = 0L;

    private View chargingIcon;

    // ---------------------------------------------------------------- fenetre
    // The popup window stops 84 px below the top of the screen (status bar
    // inset): the tile would be clipped there, on entry and on exit. So the
    // window is expanded ONCE upwards (negative y allowed by
    // LAYOUT_NO_LIMITS): the tile can then slide from / to the real screen
    // edge with no per-frame updateViewLayout (no dropped frame).
    private View winRoot;
    private WindowManager winMgr;
    private WindowManager.LayoutParams winLp;
    private int winY0 = 0;
    /** original window height (before expansion). */
    private int contentH = 0;
    /** height added above the original window. */
    private int winExtra = 0;
    /** vertical travel of the tile on screen (entry and exit). */
    private float travel = 0f;
    /** lift of the resting position (px): the tile stops a bit higher, so
     *  the drop is shallower. */
    private float restLift = 0f;
    private boolean winPrepared = false;

    // ---------------------------------------------------------------- pinceaux
    private final Paint tilePaint = new Paint(Paint.FILTER_BITMAP_FLAG);
    private final Paint artPaint = new Paint(Paint.FILTER_BITMAP_FLAG);
    private final Paint textPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint pctPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Rect textBounds = new Rect();
    private final RectF dstRect = new RectF();

    // ---------------------------------------------------------------- assets Xiaomi
    /** ic_stylus_in_charging, shown next to the charging percentage. */
    private final Drawable boltIcon;

    // ---------------------------------------------------------------- pile
    /** solid grey shell: the outline is a shell + a white inner fill. */
    private final Paint shellPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    /** white inner fill of the shell. */
    private final Paint innerPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    /** nub. */
    private final Paint nubPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final Paint fillPaint = new Paint(Paint.ANTI_ALIAS_FLAG);
    private final RectF battBody = new RectF();
    private final RectF battInner = new RectF();
    private final RectF battNub = new RectF();
    private final RectF battFill = new RectF();

    private float capRatio = 0.72f;
    private String pctText = "";
    private float pctWidth = 0f;
    private int pctValue = -1;

    // ---------------------------------------------------------------- cache raster
    private Bitmap tileBmp;
    private int tilePad = 0;
    private int tileBuildW = -1;

    private Bitmap boltBmp;

    public MiuiStylusLevelsView(Context context, AttributeSet attrs) {
        super(context, attrs);

        boltIcon = loadDrawable(context, "ic_stylus_in_charging", ID_BOLT);

        shellPaint.setStyle(Paint.Style.FILL);
        shellPaint.setColor(BATT_GREY);
        innerPaint.setStyle(Paint.Style.FILL);
        innerPaint.setColor(WHITE);
        nubPaint.setStyle(Paint.Style.FILL);
        nubPaint.setColor(BATT_GREY);
        fillPaint.setStyle(Paint.Style.FILL);

        // MiSans is HyperOS' SANS_SERIF family. We explicitly ask for the
        // Xiaomi weights (600 for the title, 500 for the digits) instead of
        // letting the engine pick regular.
        Typeface title = Typeface.create(Typeface.SANS_SERIF, 600, false);
        Typeface value = Typeface.create(Typeface.SANS_SERIF, 500, false);

        textPaint.setColor(TITLE_COLOR);
        textPaint.setTypeface(title);
        textPaint.setTextAlign(Paint.Align.CENTER);
        textPaint.setSubpixelText(true);

        pctPaint.setColor(PCT_COLOR);
        pctPaint.setTypeface(value);
        pctPaint.setTextAlign(Paint.Align.RIGHT);
        pctPaint.setSubpixelText(true);
    }

    private static Drawable loadDrawable(Context context, String name, int fallbackId) {
        try {
            int id = context.getResources()
                    .getIdentifier(name, "drawable", context.getPackageName());
            if (id == 0) id = fallbackId;
            return context.getDrawable(id);
        } catch (Throwable t) {
            return null;
        }
    }

    // ---------------------------------------------------------------- API MIUI
    /** Called by u2.a.b(IZ): battery level 0..100. */
    public void setElectricity(int electricity) {
        final int v = (int) clamp(electricity);
        pendingLevel = v;

        if (!isAttachedToWindow()) {
            invalidate();
            return;
        }
        if (playing) {
            targetLevel = v;
            charging = isCharging();
            return;
        }
        play(v);
    }

    // ---------------------------------------------------------------- mise en place
    @Override
    protected void onAttachedToWindow() {
        super.onAttachedToWindow();

        ViewGroup.LayoutParams lp = getLayoutParams();
        if (lp != null
                && (lp.width != ViewGroup.LayoutParams.MATCH_PARENT
                || lp.height != ViewGroup.LayoutParams.MATCH_PARENT)) {
            lp.width = ViewGroup.LayoutParams.MATCH_PARENT;
            lp.height = ViewGroup.LayoutParams.MATCH_PARENT;
            setLayoutParams(lp);
        }

        View root = getRootView();
        clearBackgrounds(root);

        ViewParent parent = getParent();
        if (parent instanceof ViewGroup) {
            ViewGroup group = (ViewGroup) parent;
            for (int i = 0; i < group.getChildCount(); i++) {
                View child = group.getChildAt(i);
                if (child != this) child.setVisibility(GONE);
            }
        }

        chargingIcon = root.findViewById(ID_CHARGING_ICON);

        if (pendingLevel >= 0) play(pendingLevel);
    }

    /** Clears background and elevation of the whole hierarchy (MIUI pill). */
    private void clearBackgrounds(View v) {
        if (v == null) return;
        v.setBackground(null);
        v.setElevation(0f);
        if (v instanceof ViewGroup) {
            ViewGroup g = (ViewGroup) v;
            for (int i = 0; i < g.getChildCount(); i++) {
                View child = g.getChildAt(i);
                if (child != this) clearBackgrounds(child);
            }
        }
    }

    /**
     * The MIUI popup sets an android.internal.graphics.drawable.BackgroundBlurDrawable
     * as the root view background, AFTER addView(). It paints the light veil
     * (white ~40 %) and the blur behind the window, and forces a re-blur
     * on every frame. We clear it in a loop as long as it comes back.
     */
    private void clearWindowBlur() {
        try {
            View root = getRootView();
            if (root == null) return;
            if (root.getBackground() != null) {
                root.setBackground(null);
                root.setElevation(0f);
            }
        } catch (Throwable ignored) {
        }
    }

    @Override
    protected void onDetachedFromWindow() {
        // LayoutParams is reused by u2.1/e for the next popup: restore the
        // original geometry (the position is rewritten anyway).
        if (winLp != null) {
            winLp.y = winY0;
            if (winExtra > 0) winLp.height = contentH;
        }
        winMgr = null;
        winRoot = null;
        winLp = null;
        winPrepared = false;
        winExtra = 0;
        contentH = 0;
        travel = 0f;
        removeCallbacks(this);
        playing = false;
        super.onDetachedFromWindow();
    }

    // ---------------------------------------------------------------- animation
    private void play(int pct) {
        removeCallbacks(this);

        targetLevel = clamp(pct);
        level = 0f;
        compact = 0f;
        rowA = 0f;
        rowY = 0f;
        slide = 0f;
        fade = 0f;
        charging = isCharging();
        playing = true;
        // the animation clock starts on the first frame that is REALLY
        // drawn: on a cold start addView -> first draw can take
        // 300-500 ms, and the drop would be over before it is seen.
        firstFrame = false;
        gateFrames = 0;

        startAt = SystemClock.uptimeMillis();
        invalidate();
        postOnAnimation(this);
    }

    @Override
    public void run() {
        // nothing is on screen yet: wait for the first draw to start the
        // timeline (otherwise the tile shows up already at rest = "pop")
        if (!firstFrame) {
            clearWindowBlur();
            fade = 0f;
            slide = 0f;
            invalidate();
            postOnAnimation(this);
            return;
        }

        final float e = (float) (SystemClock.uptimeMillis() - startAt);

        // the drawable comes back after addView(): keep insisting while it is there
        clearWindowBlur();

        fade = clamp01(fadeEase.getInterpolation(frac((e - RESET_MS) / FADE_MS)));
        slide = dropAt(frac((e - RESET_MS) / DROP_MS));

        final float compactStart = RESET_MS + DROP_HOLD_MS;
        compact = smooth.getInterpolation(frac((e - compactStart) / COMPACT_MS));
        rowA = frac((e - compactStart) / ROW_FADE_MS);
        rowY = spring.getInterpolation(frac((e - compactStart) / ROW_SHIFT_MS));

        final float fillStart = compactStart + COMPACT_HOLD_MS;
        // gauge fill: very fast
        // (0.57 s at 62 %, vs 1150 + level*18 ms = 2.3 s before)
        final float fillDur = 260f + targetLevel * 5f;
        final float ft = frac((e - fillStart) / fillDur);
        level = targetLevel * (float) (1d - Math.pow(1d - ft, 2.2d));

        final float outStart = fillStart + fillDur + HOLD_MS;
        if (e >= outStart) {
            // the tile rises inside the expanded window: nothing to move on the
            // WindowManager side, so no frame is lost during the exit
            slide = 1f - outEase.getInterpolation(frac((e - outStart) / OUT_MS));
        }

        invalidate();

        if (e < outStart + OUT_MS) {
            postOnAnimation(this);
        } else {
            playing = false;
        }
    }

    // ---------------------------------------------------------------- fenetre
    /**
     * Expands the popup window upwards, once: we only add the height needed
     * for the bottom of the tile to reach the top edge of the screen (y = 0).
     * The tile then enters and exits through the real screen edge, and no
     * WindowManager transaction happens during the animation.
     *
     *
     * Fallback when the window cannot be modified: the tile simply slides
     * inside the original window (clipped at its top edge).
     */
    private void prepareWindow() {
        if (winPrepared) return;
        winPrepared = true;

        final float s = (getWidth() * TILE_RATIO) / REF_W;
        final float th = REF_H * s;
        travel = (REF_H + 30f) * s;
        contentH = getHeight();

        try {
            final View root = getRootView();
            if (root == null) return;
            final ViewGroup.LayoutParams lp = root.getLayoutParams();
            if (!(lp instanceof WindowManager.LayoutParams)) return;
            final WindowManager.LayoutParams wlp = (WindowManager.LayoutParams) lp;
            if (wlp.height <= 0 || getWidth() <= 0) return;

            final WindowManager wm = (WindowManager) getContext()
                    .getApplicationContext()
                    .getSystemService(Context.WINDOW_SERVICE);
            if (wm == null) return;

            contentH = wlp.height;
            final float topPx = contentH / 2f - th / 2f;
            final int[] loc = new int[2];
            root.getLocationOnScreen(loc);
            // + 2 px: the tile starts (and ends) just above the edge
            final int extra = Math.round(loc[1] + topPx + th) + 2;
            if (extra <= 0) return;

            winY0 = wlp.y;
            wlp.y = winY0 - extra;
            wlp.height = contentH + extra;
            winRoot = root;
            winLp = wlp;
            winMgr = wm;
            winExtra = extra;
            travel = extra;
            wm.updateViewLayout(root, wlp);
        } catch (Throwable ignored) {
            winRoot = null;
            winLp = null;
            winMgr = null;
            winExtra = 0;
            contentH = 0;
        }
    }

    /**
     * u2.1/e rewrites LayoutParams (width/height) on every level update and
     * then calls updateViewLayout: our expansion is overwritten and the
     * window collapses above the screen (the tile disappears). So we re-arm
     * the geometry as soon as the height no longer matches.
     */
    private void keepWindow() {
        if (winLp == null || winRoot == null || winMgr == null) return;
        if (winExtra <= 0 || contentH <= 0) return;
        final int wantH = contentH + winExtra;
        final int wantY = winY0 - winExtra;
        if (winLp.height == wantH && winLp.y == wantY) return;
        winLp.height = wantH;
        winLp.y = wantY;
        try {
            winMgr.updateViewLayout(winRoot, winLp);
        } catch (Throwable ignored) {
            winRoot = null;
            winLp = null;
            winMgr = null;
        }
    }

    /**
     * Damped spring (same feel as the HTML cubic-bezier spring, but spread
     * over the whole duration so the drop is visible): the tile lands with a
     * slight bounce of about 3 % of the travel.
     */
    private static float dropAt(float t) {
        if (t <= 0f) return 0f;
        if (t >= 1f) return 1f;
        final float z = 0.74f;   // amortissement
        final float w = 7.0f;    // pulsation, en unites de DROP_MS
        final float e = (float) Math.exp(-z * w * t);
        final float wd = w * (float) Math.sqrt(1f - z * z);
        return 1f - e * ((float) Math.cos(wd * t) + (z * w / wd) * (float) Math.sin(wd * t));
    }

    private static float clamp01(float v) {
        return v < 0f ? 0f : (v > 1f ? 1f : v);
    }

    // ---------------------------------------------------------------- rendu des assets
    @Override
    protected void onSizeChanged(int w, int h, int ow, int oh) {
        super.onSizeChanged(w, h, ow, oh);

        // u2.1/e may have collapsed the window: re-arm it before drawing
        keepWindow();

        restLift = REST_LIFT_DP * getResources().getDisplayMetrics().density;

        // the window expansion only changes the height: no need to
        // rebuild the bitmaps (that was a ~60 ms gap at startup)
        if (tileBmp != null && tileBuildW == w) return;

        Paint probe = new Paint(Paint.ANTI_ALIAS_FLAG);
        probe.setTypeface(textPaint.getTypeface());
        probe.setTextSize(100f);
        probe.getTextBounds("H", 0, 1, textBounds);
        capRatio = -textBounds.top / 100f;
        if (capRatio <= 0.1f) capRatio = 0.72f;

        buildTile(w);
        buildGauge(w);
    }

    private void buildTile(int w) {
        if (w <= 0) return;
        final float tw = w * TILE_RATIO;
        final float s = tw / REF_W;
        final float th = REF_H * s;
        // no drop shadow: no halo/blur around the tile is wanted
        // (pad = anti-aliasing margin only)
        final int pad = Math.max(2, (int) Math.ceil(2f * s));

        final int bw = Math.round(tw) + pad * 2;
        final int bh = Math.round(th) + pad * 2;
        if (bw <= 0 || bh <= 0) return;

        Bitmap bmp = Bitmap.createBitmap(bw, bh, Bitmap.Config.ARGB_8888);
        Canvas c = new Canvas(bmp);
        Paint p = new Paint(Paint.ANTI_ALIAS_FLAG);
        p.setColor(WHITE);
        final float r = th / 2f;
        c.drawRoundRect(pad, pad, pad + tw, pad + th, r, r, p);

        tileBmp = bmp;
        tilePad = pad;
        tileBuildW = w;
    }

    private void buildGauge(int w) {
        if (w <= 0) return;
        final float s = (w * TILE_RATIO) / REF_W;

        final int bw = Math.max(1, Math.round(BOLT_W * s * 2f));
        final int bh = Math.max(1, Math.round(BOLT_H * s * 2f));
        boltBmp = raster(boltIcon, bw, bh);
    }

    private static Bitmap raster(Drawable d, int w, int h) {
        if (d == null || w <= 0 || h <= 0) return null;
        Bitmap bmp = Bitmap.createBitmap(w, h, Bitmap.Config.ARGB_8888);
        Canvas c = new Canvas(bmp);
        d.setBounds(0, 0, w, h);
        d.draw(c);
        return bmp;
    }

    // ---------------------------------------------------------------- dessin
    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);

        final float w = getWidth();
        final float h = getHeight();
        if (w <= 0f || h <= 0f) return;

        // expand the window upwards before the first draw (the tile is
        // still invisible: fade = 0 until the timeline has started)
        prepareWindow();
        keepWindow();

        // wait for the expansion to be applied before starting the clock:
        // otherwise the first frame lands during the relayout (~60 ms gap) and
        // the tile freezes half out of the edge.
        if (!firstFrame) {
            final boolean resized = winExtra <= 0 || h >= contentH + winExtra;
            if (!resized && gateFrames < 12) {
                gateFrames++;
                fade = 0f;
                slide = 0f;
                return;
            }
            firstFrame = true;
            startAt = SystemClock.uptimeMillis();
        }

        if (tileBmp == null || tileBuildW != (int) w) {
            buildTile((int) w);
            buildGauge((int) w);
        }

        final float tw = w * TILE_RATIO;
        final float s = tw / REF_W;
        final float th = REF_H * s;
        // the window may already be expanded: the original content is
        // therefore shifted by the surplus added above
        final float baseH = contentH > 0 ? contentH : h;
        final float offs = Math.max(0f, h - baseH);
        final float topPx = offs + baseH / 2f - th / 2f;
        final float left = (w - tw) / 2f;
        final float top = topPx - restLift - travel * (1f - slide);

        final int a = (int) (255 * fade);

        if (tileBmp != null) {
            tilePaint.setAlpha(a);
            canvas.drawBitmap(tileBmp, left - tilePad, top - tilePad, tilePaint);
        }

        // ---- text (374 x 111 reference frame)
        canvas.save();
        canvas.translate(left, top);
        canvas.scale(s, s);

        float tSize = TITLE_SIZE_BIG + (TITLE_SIZE_SMALL - TITLE_SIZE_BIG) * compact;
        float capH = capRatio * tSize;
        float capTop = TITLE_CAP_TOP_BIG
                + (TITLE_CAP_TOP_SMALL - TITLE_CAP_TOP_BIG) * compact;
        textPaint.setTextSize(tSize);
        textPaint.setAlpha(a);
        canvas.drawText(TITLE, REF_W / 2f, capTop + capH, textPaint);

        if (rowA > 0.01f) {
            final int ra = (int) (a * rowA);
            canvas.save();
            canvas.translate(0f, 6.1f * (1f - rowY));

            pctPaint.setTextSize(PCT_SIZE);
            pctPaint.setAlpha(ra);

            final int shown = Math.round(level);
            if (shown != pctValue) {
                pctValue = shown;
                pctText = shown + "%";
                pctWidth = pctPaint.measureText(pctText);
            }
            canvas.drawText(pctText, PCT_RIGHT, PCT_BASELINE, pctPaint);

            if (charging && boltBmp != null) {
                float bl = PCT_RIGHT - pctWidth - BOLT_GAP - BOLT_W;
                float bt = BATT_CY - BOLT_H / 2f;
                dstRect.set(bl, bt, bl + BOLT_W, bt + BOLT_H);
                artPaint.setAlpha(ra);
                canvas.drawBitmap(boltBmp, null, dstRect, artPaint);
            }

            canvas.restore();
        }

        canvas.restore();

        // ---- gauge: in pixels, outside the scaled reference frame
        if (rowA > 0.01f) {
            final int ra = (int) (a * rowA);
            drawBattery(canvas, left, top, s, ra);
        }
    }

    /**
     * HTML-style gauge: grey outlined shell, fully rounded fill and a thin
     * nub on the right. The fill colour follows the level
     * (red -> orange -> green), the width follows "level" animated by run().
     */
    private void drawBattery(Canvas c, float left, float top, float s, int alpha) {
        final float cy = top + BATT_CY * s;
        final float x0 = left + BATT_L * s;
        final float w = BATT_W * s;
        final float h = BATT_H * s;
        final float border = BATT_BORDER * s;
        final float rad = BATT_RADIUS * s;

        shellPaint.setAlpha(alpha);
        innerPaint.setAlpha(alpha);
        nubPaint.setAlpha(alpha);

        // nub: small solid bar, detached from the shell
        final float nubL = x0 + w + NUB_GAP * s;
        final float nubT = cy - NUB_H * s / 2f;
        battNub.set(nubL, nubT, nubL + NUB_W * s, nubT + NUB_H * s);
        c.drawRoundRect(battNub, 1.4f * s, 1.4f * s, nubPaint);

        // grey shell then white inner fill: the HTML border without
        // relying on STROKE style
        battBody.set(x0, cy - h / 2f, x0 + w, cy + h / 2f);
        c.drawRoundRect(battBody, rad, rad, shellPaint);
        battInner.set(x0 + border, cy - h / 2f + border,
                x0 + w - border, cy + h / 2f - border);
        c.drawRoundRect(battInner, Math.max(0f, rad - border), Math.max(0f, rad - border), innerPaint);

        // fill: inner box = HTML padding
        final float inset = border + BATT_PAD * s;
        final float innerL = x0 + inset;
        final float innerT = cy - h / 2f + inset;
        final float innerH = h - inset * 2f;
        final float innerW = w - inset * 2f;
        final float fillW = innerW * (level / 100f);
        if (fillW <= 0.5f) return;

        fillPaint.setColor(fillColor(level));
        fillPaint.setAlpha(alpha);
        final float fr = Math.min(BATT_FILL_R * s, Math.min(innerH / 2f, fillW / 2f));
        battFill.set(innerL, innerT, innerL + fillW, innerT + innerH);
        c.drawRoundRect(battFill, fr, fr, fillPaint);
    }

    /** Interpolation of the HTML hsl stops: red 20 %, orange 32-45 %, green 52 %. */
    private static int fillColor(float p) {
        float h, sa, l;
        if (p <= 20f) {
            h = 3f; sa = 1f; l = 0.59f;
        } else if (p <= 32f) {
            final float t = (p - 20f) / 12f;
            h = 3f + 32f * t; sa = 1f; l = 0.59f - 0.09f * t;
        } else if (p <= 45f) {
            h = 35f; sa = 1f; l = 0.50f;
        } else if (p <= 52f) {
            final float t = (p - 45f) / 7f;
            h = 35f + 85f * t; sa = 1f - 0.5f * t; l = 0.50f + 0.09f * t;
        } else {
            h = 120f; sa = 0.5f; l = 0.59f;
        }
        return hsl(h, sa, l);
    }

    private static int hsl(float h, float s, float l) {
        final float c = (1f - Math.abs(2f * l - 1f)) * s;
        final float hp = h / 60f;
        final float x = c * (1f - Math.abs(hp % 2f - 1f));
        float r = 0f, g = 0f, b = 0f;
        if (hp < 1f) { r = c; g = x; }
        else if (hp < 2f) { r = x; g = c; }
        else if (hp < 3f) { g = c; b = x; }
        else if (hp < 4f) { g = x; b = c; }
        else if (hp < 5f) { r = x; b = c; }
        else { r = c; b = x; }
        final float m = l - c / 2f;
        final int ri = to255(r + m), gi = to255(g + m), bi = to255(b + m);
        return 0xFF000000 | (ri << 16) | (gi << 8) | bi;
    }

    private static int to255(float v) {
        int i = Math.round(v * 255f);
        return i < 0 ? 0 : (i > 255 ? 255 : i);
    }

    // ---------------------------------------------------------------- interne
    private boolean isCharging() {
        return chargingIcon != null && chargingIcon.getVisibility() == VISIBLE;
    }

    private static float frac(float v) {
        return v < 0f ? 0f : (v > 1f ? 1f : v);
    }

    private static float clamp(float v) {
        return v < 0f ? 0f : (v > 100f ? 100f : v);
    }
}
