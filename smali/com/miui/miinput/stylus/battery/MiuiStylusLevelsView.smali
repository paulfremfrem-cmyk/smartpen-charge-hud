.class public Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;
.super Landroid/view/View;
.source "MiuiStylusLevelsView.java"

# interfaces
.implements Ljava/lang/Runnable;


# static fields
.field private static final BATT_BORDER:F = 3.0f

.field private static final BATT_CY:F = 79.0f

.field private static final BATT_FILL_R:F = 2.3f

.field private static final BATT_GREY:I = -0x71716d

.field private static final BATT_H:F = 30.0f

.field private static final BATT_L:F = 190.0f

.field private static final BATT_PAD:F = 1.4f

.field private static final BATT_RADIUS:F = 8.0f

.field private static final BATT_W:F = 66.0f

.field private static final BOLT_GAP:F = 5.0f

.field private static final BOLT_H:F = 17.0f

.field private static final BOLT_W:F = 10.551724f

.field private static final COMPACT_HOLD_MS:J = 0x334L

.field private static final COMPACT_MS:J = 0x2e4L

.field private static final DROP_HOLD_MS:J = 0x5dcL

.field private static final DROP_MS:J = 0x2a8L

.field private static final FADE_MS:J = 0x46L

.field private static final HOLD_MS:J = 0x578L

.field private static final ID_BOLT:I = 0x7f080187

.field private static final ID_CHARGING_ICON:I = 0x7f0a0491

.field private static final NUB_GAP:F = 1.4f

.field private static final NUB_H:F = 8.0f

.field private static final NUB_W:F = 5.0f

.field private static final OUT_MS:J = 0x208L

.field private static final PCT_BASELINE:F = 89.5f

.field private static final PCT_COLOR:I = -0x34000000

.field private static final PCT_RIGHT:F = 171.0f

.field private static final PCT_SIZE:F = 27.2f

.field private static final REF_H:F = 111.0f

.field private static final REF_W:F = 374.0f

.field private static final RESET_MS:J = 0x0L

.field private static final REST_LIFT_DP:F = 6.0f

.field private static final ROW_FADE_MS:J = 0x154L

.field private static final ROW_SHIFT_MS:J = 0x26cL

.field private static final TILE_RATIO:F = 0.945f

.field private static final TITLE:Ljava/lang/String; = "Smart Pen"

.field private static final TITLE_CAP_TOP_BIG:F = 40.6f

.field private static final TITLE_CAP_TOP_SMALL:F = 29.0f

.field private static final TITLE_COLOR:I = -0x1000000

.field private static final TITLE_SIZE_BIG:F = 42.8f

.field private static final TITLE_SIZE_SMALL:F = 27.2f

.field private static final WHITE:I = -0x1


# instance fields
.field private final artPaint:Landroid/graphics/Paint;

.field private final battBody:Landroid/graphics/RectF;

.field private final battFill:Landroid/graphics/RectF;

.field private final battInner:Landroid/graphics/RectF;

.field private final battNub:Landroid/graphics/RectF;

.field private boltBmp:Landroid/graphics/Bitmap;

.field private final boltIcon:Landroid/graphics/drawable/Drawable;

.field private capRatio:F

.field private charging:Z

.field private chargingIcon:Landroid/view/View;

.field private compact:F

.field private contentH:I

.field private final dstRect:Landroid/graphics/RectF;

.field private fade:F

.field private final fadeEase:Landroid/view/animation/PathInterpolator;

.field private final fillPaint:Landroid/graphics/Paint;

.field private firstFrame:Z

.field private gateFrames:I

.field private final innerPaint:Landroid/graphics/Paint;

.field private level:F

.field private final nubPaint:Landroid/graphics/Paint;

.field private final outEase:Landroid/view/animation/PathInterpolator;

.field private final pctPaint:Landroid/graphics/Paint;

.field private pctText:Ljava/lang/String;

.field private pctValue:I

.field private pctWidth:F

.field private pendingLevel:I

.field private playing:Z

.field private restLift:F

.field private rowA:F

.field private rowY:F

.field private final shellPaint:Landroid/graphics/Paint;

.field private slide:F

.field private final smooth:Landroid/view/animation/PathInterpolator;

.field private final spring:Landroid/view/animation/PathInterpolator;

.field private startAt:J

.field private targetLevel:F

.field private final textBounds:Landroid/graphics/Rect;

.field private final textPaint:Landroid/graphics/Paint;

.field private tileBmp:Landroid/graphics/Bitmap;

.field private tileBuildW:I

.field private tilePad:I

.field private final tilePaint:Landroid/graphics/Paint;

.field private travel:F

.field private winExtra:I

.field private winLp:Landroid/view/WindowManager$LayoutParams;

.field private winMgr:Landroid/view/WindowManager;

.field private winPrepared:Z

.field private winRoot:Landroid/view/View;

.field private winY0:I


# direct methods
.method public constructor <init>(Landroid/content/Context;Landroid/util/AttributeSet;)V
    .locals 6

    .line 204
    invoke-direct {p0, p1, p2}, Landroid/view/View;-><init>(Landroid/content/Context;Landroid/util/AttributeSet;)V

    .line 109
    const/4 p2, 0x0

    iput-boolean p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->firstFrame:Z

    .line 111
    iput p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->gateFrames:I

    .line 119
    new-instance v0, Landroid/view/animation/PathInterpolator;

    const v1, 0x3e428f5c    # 0.19f

    const v2, 0x3f87ae14    # 1.06f

    const v3, 0x3e851eb8    # 0.26f

    const/high16 v4, 0x3f800000    # 1.0f

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/view/animation/PathInterpolator;-><init>(FFFF)V

    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->spring:Landroid/view/animation/PathInterpolator;

    .line 121
    new-instance v0, Landroid/view/animation/PathInterpolator;

    const v1, 0x3ea3d70a    # 0.32f

    const v2, 0x3f3851ec    # 0.72f

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3, v4}, Landroid/view/animation/PathInterpolator;-><init>(FFFF)V

    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->smooth:Landroid/view/animation/PathInterpolator;

    .line 124
    new-instance v0, Landroid/view/animation/PathInterpolator;

    const v1, 0x3e4ccccd    # 0.2f

    const v5, 0x3ecccccd    # 0.4f

    invoke-direct {v0, v1, v3, v5, v4}, Landroid/view/animation/PathInterpolator;-><init>(FFFF)V

    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fadeEase:Landroid/view/animation/PathInterpolator;

    .line 127
    new-instance v0, Landroid/view/animation/PathInterpolator;

    const v1, 0x3eb33333    # 0.35f

    const v4, 0x3f4ccccd    # 0.8f

    invoke-direct {v0, v1, v3, v4, v4}, Landroid/view/animation/PathInterpolator;-><init>(FFFF)V

    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->outEase:Landroid/view/animation/PathInterpolator;

    .line 130
    iput v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->slide:F

    .line 131
    iput v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fade:F

    .line 132
    iput v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->compact:F

    .line 133
    iput v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowA:F

    .line 134
    iput v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowY:F

    .line 135
    iput v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->level:F

    .line 137
    const/high16 v0, 0x42200000    # 40.0f

    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->targetLevel:F

    .line 138
    iput-boolean p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->playing:Z

    .line 139
    iput-boolean p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->charging:Z

    .line 140
    const/4 v0, -0x1

    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pendingLevel:I

    .line 141
    const-wide/16 v4, 0x0

    iput-wide v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->startAt:J

    .line 154
    iput p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winY0:I

    .line 156
    iput p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    .line 158
    iput p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    .line 160
    iput v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->travel:F

    .line 163
    iput v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->restLift:F

    .line 164
    iput-boolean p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winPrepared:Z

    .line 167
    new-instance v1, Landroid/graphics/Paint;

    const/4 v4, 0x2

    invoke-direct {v1, v4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tilePaint:Landroid/graphics/Paint;

    .line 168
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->artPaint:Landroid/graphics/Paint;

    .line 169
    new-instance v1, Landroid/graphics/Paint;

    const/4 v4, 0x1

    invoke-direct {v1, v4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textPaint:Landroid/graphics/Paint;

    .line 170
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctPaint:Landroid/graphics/Paint;

    .line 171
    new-instance v1, Landroid/graphics/Rect;

    invoke-direct {v1}, Landroid/graphics/Rect;-><init>()V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textBounds:Landroid/graphics/Rect;

    .line 172
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->dstRect:Landroid/graphics/RectF;

    .line 180
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->shellPaint:Landroid/graphics/Paint;

    .line 182
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->innerPaint:Landroid/graphics/Paint;

    .line 184
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->nubPaint:Landroid/graphics/Paint;

    .line 185
    new-instance v1, Landroid/graphics/Paint;

    invoke-direct {v1, v4}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fillPaint:Landroid/graphics/Paint;

    .line 186
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battBody:Landroid/graphics/RectF;

    .line 187
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battInner:Landroid/graphics/RectF;

    .line 188
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battNub:Landroid/graphics/RectF;

    .line 189
    new-instance v1, Landroid/graphics/RectF;

    invoke-direct {v1}, Landroid/graphics/RectF;-><init>()V

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battFill:Landroid/graphics/RectF;

    .line 191
    iput v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->capRatio:F

    .line 192
    const-string v1, ""

    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctText:Ljava/lang/String;

    .line 193
    iput v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctWidth:F

    .line 194
    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctValue:I

    .line 198
    iput p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tilePad:I

    .line 199
    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tileBuildW:I

    .line 206
    const-string v1, "ic_stylus_in_charging"

    const v2, 0x7f080187

    invoke-static {p1, v1, v2}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->loadDrawable(Landroid/content/Context;Ljava/lang/String;I)Landroid/graphics/drawable/Drawable;

    move-result-object p1

    iput-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->boltIcon:Landroid/graphics/drawable/Drawable;

    .line 208
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->shellPaint:Landroid/graphics/Paint;

    sget-object v1, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v1}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 209
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->shellPaint:Landroid/graphics/Paint;

    const v1, -0x71716d

    invoke-virtual {p1, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 210
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->innerPaint:Landroid/graphics/Paint;

    sget-object v2, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v2}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 211
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->innerPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 212
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->nubPaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 213
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->nubPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 214
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fillPaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Style;->FILL:Landroid/graphics/Paint$Style;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setStyle(Landroid/graphics/Paint$Style;)V

    .line 219
    sget-object p1, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    const/16 v0, 0x258

    invoke-static {p1, v0, p2}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;IZ)Landroid/graphics/Typeface;

    move-result-object p1

    .line 220
    sget-object v0, Landroid/graphics/Typeface;->SANS_SERIF:Landroid/graphics/Typeface;

    const/16 v1, 0x1f4

    invoke-static {v0, v1, p2}, Landroid/graphics/Typeface;->create(Landroid/graphics/Typeface;IZ)Landroid/graphics/Typeface;

    move-result-object p2

    .line 222
    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textPaint:Landroid/graphics/Paint;

    const/high16 v1, -0x1000000

    invoke-virtual {v0, v1}, Landroid/graphics/Paint;->setColor(I)V

    .line 223
    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textPaint:Landroid/graphics/Paint;

    invoke-virtual {v0, p1}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 224
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textPaint:Landroid/graphics/Paint;

    sget-object v0, Landroid/graphics/Paint$Align;->CENTER:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 225
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v4}, Landroid/graphics/Paint;->setSubpixelText(Z)V

    .line 227
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctPaint:Landroid/graphics/Paint;

    const/high16 v0, -0x34000000    # -3.3554432E7f

    invoke-virtual {p1, v0}, Landroid/graphics/Paint;->setColor(I)V

    .line 228
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 229
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctPaint:Landroid/graphics/Paint;

    sget-object p2, Landroid/graphics/Paint$Align;->RIGHT:Landroid/graphics/Paint$Align;

    invoke-virtual {p1, p2}, Landroid/graphics/Paint;->setTextAlign(Landroid/graphics/Paint$Align;)V

    .line 230
    iget-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctPaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v4}, Landroid/graphics/Paint;->setSubpixelText(Z)V

    .line 231
    return-void
.end method

.method private buildGauge(I)V
    .locals 4

    .line 570
    if-gtz p1, :cond_0

    return-void

    .line 571
    :cond_0
    int-to-float p1, p1

    const v0, 0x3f71eb85    # 0.945f

    mul-float/2addr p1, v0

    const/high16 v0, 0x43bb0000    # 374.0f

    div-float/2addr p1, v0

    .line 573
    const v0, 0x4128d3dd

    mul-float/2addr v0, p1

    const/high16 v1, 0x40000000    # 2.0f

    mul-float/2addr v0, v1

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    const/4 v2, 0x1

    invoke-static {v2, v0}, Ljava/lang/Math;->max(II)I

    move-result v0

    .line 574
    const/high16 v3, 0x41880000    # 17.0f

    mul-float/2addr p1, v3

    mul-float/2addr p1, v1

    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    invoke-static {v2, p1}, Ljava/lang/Math;->max(II)I

    move-result p1

    .line 575
    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->boltIcon:Landroid/graphics/drawable/Drawable;

    invoke-static {v1, v0, p1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->raster(Landroid/graphics/drawable/Drawable;II)Landroid/graphics/Bitmap;

    move-result-object p1

    iput-object p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->boltBmp:Landroid/graphics/Bitmap;

    .line 576
    return-void
.end method

.method private buildTile(I)V
    .locals 13

    .line 545
    if-gtz p1, :cond_0

    return-void

    .line 546
    :cond_0
    int-to-float v0, p1

    const v1, 0x3f71eb85    # 0.945f

    mul-float/2addr v0, v1

    .line 547
    const/high16 v1, 0x43bb0000    # 374.0f

    div-float v1, v0, v1

    .line 548
    const/high16 v2, 0x42de0000    # 111.0f

    mul-float/2addr v2, v1

    .line 551
    const/high16 v3, 0x40000000    # 2.0f

    mul-float/2addr v1, v3

    float-to-double v4, v1

    invoke-static {v4, v5}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v4

    double-to-int v1, v4

    const/4 v4, 0x2

    invoke-static {v4, v1}, Ljava/lang/Math;->max(II)I

    move-result v1

    .line 553
    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v4

    mul-int/lit8 v5, v1, 0x2

    add-int/2addr v4, v5

    .line 554
    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v6

    add-int/2addr v6, v5

    .line 555
    if-lez v4, :cond_2

    if-gtz v6, :cond_1

    goto :goto_0

    .line 557
    :cond_1
    sget-object v5, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v4, v6, v5}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v4

    .line 558
    new-instance v5, Landroid/graphics/Canvas;

    invoke-direct {v5, v4}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 559
    new-instance v12, Landroid/graphics/Paint;

    const/4 v6, 0x1

    invoke-direct {v12, v6}, Landroid/graphics/Paint;-><init>(I)V

    .line 560
    const/4 v6, -0x1

    invoke-virtual {v12, v6}, Landroid/graphics/Paint;->setColor(I)V

    .line 561
    div-float v10, v2, v3

    .line 562
    int-to-float v6, v1

    add-float v8, v6, v0

    add-float v9, v6, v2

    move v7, v6

    move v11, v10

    invoke-virtual/range {v5 .. v12}, Landroid/graphics/Canvas;->drawRoundRect(FFFFFFLandroid/graphics/Paint;)V

    .line 564
    iput-object v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tileBmp:Landroid/graphics/Bitmap;

    .line 565
    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tilePad:I

    .line 566
    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tileBuildW:I

    .line 567
    return-void

    .line 555
    :cond_2
    :goto_0
    return-void
.end method

.method private static clamp(F)F
    .locals 2

    .line 785
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gez v1, :cond_0

    :goto_0
    move p0, v0

    goto :goto_1

    :cond_0
    const/high16 v0, 0x42c80000    # 100.0f

    cmpl-float v1, p0, v0

    if-lez v1, :cond_1

    goto :goto_0

    :cond_1
    :goto_1
    return p0
.end method

.method private static clamp01(F)F
    .locals 2

    .line 516
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gez v1, :cond_0

    :goto_0
    move p0, v0

    goto :goto_1

    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-lez v1, :cond_1

    goto :goto_0

    :cond_1
    :goto_1
    return p0
.end method

.method private clearBackgrounds(Landroid/view/View;)V
    .locals 2

    .line 295
    if-nez p1, :cond_0

    return-void

    .line 296
    :cond_0
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 297
    const/4 v0, 0x0

    invoke-virtual {p1, v0}, Landroid/view/View;->setElevation(F)V

    .line 298
    instance-of v0, p1, Landroid/view/ViewGroup;

    if-eqz v0, :cond_2

    .line 299
    check-cast p1, Landroid/view/ViewGroup;

    .line 300
    const/4 v0, 0x0

    :goto_0
    invoke-virtual {p1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v1

    if-ge v0, v1, :cond_2

    .line 301
    invoke-virtual {p1, v0}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v1

    .line 302
    if-eq v1, p0, :cond_1

    invoke-direct {p0, v1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->clearBackgrounds(Landroid/view/View;)V

    .line 300
    :cond_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    .line 305
    :cond_2
    return-void
.end method

.method private clearWindowBlur()V
    .locals 2

    .line 315
    :try_start_0
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getRootView()Landroid/view/View;

    move-result-object v0

    .line 316
    if-nez v0, :cond_0

    return-void

    .line 317
    :cond_0
    invoke-virtual {v0}, Landroid/view/View;->getBackground()Landroid/graphics/drawable/Drawable;

    move-result-object v1

    if-eqz v1, :cond_1

    .line 318
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setBackground(Landroid/graphics/drawable/Drawable;)V

    .line 319
    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Landroid/view/View;->setElevation(F)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 322
    :cond_1
    goto :goto_0

    .line 321
    :catchall_0
    move-exception v0

    .line 323
    :goto_0
    return-void
.end method

.method private drawBattery(Landroid/graphics/Canvas;FFFI)V
    .locals 16

    .line 694
    move-object/from16 v0, p0

    move-object/from16 v1, p1

    move/from16 v2, p5

    const/high16 v3, 0x429e0000    # 79.0f

    mul-float v3, v3, p4

    add-float v3, p3, v3

    .line 695
    const/high16 v4, 0x433e0000    # 190.0f

    mul-float v4, v4, p4

    add-float v4, p2, v4

    .line 696
    const/high16 v5, 0x42840000    # 66.0f

    mul-float v5, v5, p4

    .line 697
    const/high16 v6, 0x41f00000    # 30.0f

    mul-float v6, v6, p4

    .line 698
    const/high16 v7, 0x40400000    # 3.0f

    mul-float v7, v7, p4

    .line 699
    const/high16 v8, 0x41000000    # 8.0f

    mul-float v8, v8, p4

    .line 701
    iget-object v9, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->shellPaint:Landroid/graphics/Paint;

    invoke-virtual {v9, v2}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 702
    iget-object v9, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->innerPaint:Landroid/graphics/Paint;

    invoke-virtual {v9, v2}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 703
    iget-object v9, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->nubPaint:Landroid/graphics/Paint;

    invoke-virtual {v9, v2}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 706
    add-float v9, v4, v5

    const v10, 0x3fb33333    # 1.4f

    mul-float v10, v10, p4

    add-float v11, v9, v10

    .line 707
    const/high16 v12, 0x40000000    # 2.0f

    div-float v13, v8, v12

    sub-float v13, v3, v13

    .line 708
    iget-object v14, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battNub:Landroid/graphics/RectF;

    const/high16 v15, 0x40a00000    # 5.0f

    mul-float v15, v15, p4

    add-float/2addr v15, v11

    move/from16 p2, v12

    add-float v12, v13, v8

    invoke-virtual {v14, v11, v13, v15, v12}, Landroid/graphics/RectF;->set(FFFF)V

    .line 709
    iget-object v11, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battNub:Landroid/graphics/RectF;

    iget-object v12, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->nubPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v11, v10, v10, v12}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 713
    iget-object v11, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battBody:Landroid/graphics/RectF;

    div-float v12, v6, p2

    sub-float v13, v3, v12

    add-float/2addr v3, v12

    invoke-virtual {v11, v4, v13, v9, v3}, Landroid/graphics/RectF;->set(FFFF)V

    .line 714
    iget-object v11, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battBody:Landroid/graphics/RectF;

    iget-object v12, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->shellPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v11, v8, v8, v12}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 715
    iget-object v11, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battInner:Landroid/graphics/RectF;

    add-float v12, v4, v7

    add-float v14, v13, v7

    sub-float/2addr v9, v7

    sub-float/2addr v3, v7

    invoke-virtual {v11, v12, v14, v9, v3}, Landroid/graphics/RectF;->set(FFFF)V

    .line 717
    iget-object v3, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battInner:Landroid/graphics/RectF;

    sub-float/2addr v8, v7

    const/4 v9, 0x0

    invoke-static {v9, v8}, Ljava/lang/Math;->max(FF)F

    move-result v11

    invoke-static {v9, v8}, Ljava/lang/Math;->max(FF)F

    move-result v8

    iget-object v9, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->innerPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v3, v11, v8, v9}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 720
    add-float/2addr v7, v10

    .line 721
    add-float/2addr v4, v7

    .line 722
    add-float/2addr v13, v7

    .line 723
    mul-float v7, v7, p2

    sub-float/2addr v6, v7

    .line 724
    sub-float/2addr v5, v7

    .line 725
    iget v3, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->level:F

    const/high16 v7, 0x42c80000    # 100.0f

    div-float/2addr v3, v7

    mul-float/2addr v5, v3

    .line 726
    const/high16 v3, 0x3f000000    # 0.5f

    cmpg-float v3, v5, v3

    if-gtz v3, :cond_0

    return-void

    .line 728
    :cond_0
    iget-object v3, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fillPaint:Landroid/graphics/Paint;

    iget v7, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->level:F

    invoke-static {v7}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fillColor(F)I

    move-result v7

    invoke-virtual {v3, v7}, Landroid/graphics/Paint;->setColor(I)V

    .line 729
    iget-object v3, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fillPaint:Landroid/graphics/Paint;

    invoke-virtual {v3, v2}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 730
    const v2, 0x40133333    # 2.3f

    mul-float v2, v2, p4

    div-float v3, v6, p2

    div-float v7, v5, p2

    invoke-static {v3, v7}, Ljava/lang/Math;->min(FF)F

    move-result v3

    invoke-static {v2, v3}, Ljava/lang/Math;->min(FF)F

    move-result v2

    .line 731
    iget-object v3, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battFill:Landroid/graphics/RectF;

    add-float/2addr v5, v4

    add-float/2addr v6, v13

    invoke-virtual {v3, v4, v13, v5, v6}, Landroid/graphics/RectF;->set(FFFF)V

    .line 732
    iget-object v3, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->battFill:Landroid/graphics/RectF;

    iget-object v0, v0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fillPaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v3, v2, v2, v0}, Landroid/graphics/Canvas;->drawRoundRect(Landroid/graphics/RectF;FFLandroid/graphics/Paint;)V

    .line 733
    return-void
.end method

.method private static dropAt(F)F
    .locals 7

    .line 506
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gtz v1, :cond_0

    return v0

    .line 507
    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-ltz v1, :cond_1

    return v0

    .line 510
    :cond_1
    const v1, -0x3f5a3d70    # -5.1800003f

    mul-float/2addr v1, p0

    float-to-double v1, v1

    invoke-static {v1, v2}, Ljava/lang/Math;->exp(D)D

    move-result-wide v1

    double-to-float v1, v1

    .line 511
    const-wide v2, 0x3fdcf41f00000000L    # 0.45239996910095215

    invoke-static {v2, v3}, Ljava/lang/Math;->sqrt(D)D

    move-result-wide v2

    double-to-float v2, v2

    const/high16 v3, 0x40e00000    # 7.0f

    mul-float/2addr v2, v3

    .line 512
    mul-float/2addr p0, v2

    float-to-double v3, p0

    invoke-static {v3, v4}, Ljava/lang/Math;->cos(D)D

    move-result-wide v5

    double-to-float p0, v5

    const v5, 0x40a5c290    # 5.1800003f

    div-float/2addr v5, v2

    invoke-static {v3, v4}, Ljava/lang/Math;->sin(D)D

    move-result-wide v2

    double-to-float v2, v2

    mul-float/2addr v5, v2

    add-float/2addr p0, v5

    mul-float/2addr v1, p0

    sub-float/2addr v0, v1

    return v0
.end method

.method private static fillColor(F)I
    .locals 7

    .line 738
    const/high16 v0, 0x41a00000    # 20.0f

    cmpg-float v1, p0, v0

    const/high16 v2, 0x40400000    # 3.0f

    const v3, 0x3f170a3d    # 0.59f

    const/high16 v4, 0x3f800000    # 1.0f

    if-gtz v1, :cond_0

    .line 739
    goto :goto_0

    .line 740
    :cond_0
    const/high16 v1, 0x42000000    # 32.0f

    cmpg-float v5, p0, v1

    const v6, 0x3db851ec    # 0.09f

    if-gtz v5, :cond_1

    .line 741
    sub-float/2addr p0, v0

    const/high16 v0, 0x41400000    # 12.0f

    div-float/2addr p0, v0

    .line 742
    mul-float/2addr v1, p0

    add-float/2addr v2, v1

    mul-float/2addr p0, v6

    sub-float/2addr v3, p0

    .line 743
    goto :goto_0

    :cond_1
    const/high16 v0, 0x42340000    # 45.0f

    cmpg-float v1, p0, v0

    const/high16 v2, 0x420c0000    # 35.0f

    const/high16 v5, 0x3f000000    # 0.5f

    if-gtz v1, :cond_2

    .line 744
    move v3, v5

    goto :goto_0

    .line 745
    :cond_2
    const/high16 v1, 0x42500000    # 52.0f

    cmpg-float v1, p0, v1

    if-gtz v1, :cond_3

    .line 746
    sub-float/2addr p0, v0

    const/high16 v0, 0x40e00000    # 7.0f

    div-float/2addr p0, v0

    .line 747
    const/high16 v0, 0x42aa0000    # 85.0f

    mul-float/2addr v0, p0

    add-float/2addr v2, v0

    mul-float v0, p0, v5

    sub-float/2addr v4, v0

    mul-float/2addr p0, v6

    add-float v3, p0, v5

    .line 748
    goto :goto_0

    .line 749
    :cond_3
    const/high16 v2, 0x42f00000    # 120.0f

    move v4, v5

    .line 751
    :goto_0
    invoke-static {v2, v4, v3}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->hsl(FFF)I

    move-result p0

    return p0
.end method

.method private static frac(F)F
    .locals 2

    .line 781
    const/4 v0, 0x0

    cmpg-float v1, p0, v0

    if-gez v1, :cond_0

    :goto_0
    move p0, v0

    goto :goto_1

    :cond_0
    const/high16 v0, 0x3f800000    # 1.0f

    cmpl-float v1, p0, v0

    if-lez v1, :cond_1

    goto :goto_0

    :cond_1
    :goto_1
    return p0
.end method

.method private static hsl(FFF)I
    .locals 4

    .line 755
    const/high16 v0, 0x40000000    # 2.0f

    mul-float v1, p2, v0

    const/high16 v2, 0x3f800000    # 1.0f

    sub-float/2addr v1, v2

    invoke-static {v1}, Ljava/lang/Math;->abs(F)F

    move-result v1

    sub-float v1, v2, v1

    mul-float/2addr v1, p1

    .line 756
    const/high16 p1, 0x42700000    # 60.0f

    div-float/2addr p0, p1

    .line 757
    rem-float p1, p0, v0

    sub-float/2addr p1, v2

    invoke-static {p1}, Ljava/lang/Math;->abs(F)F

    move-result p1

    sub-float p1, v2, p1

    mul-float/2addr p1, v1

    .line 758
    nop

    .line 759
    cmpg-float v2, p0, v2

    const/4 v3, 0x0

    if-gez v2, :cond_0

    move p0, v3

    move v3, p1

    move p1, v1

    goto :goto_0

    .line 760
    :cond_0
    cmpg-float v2, p0, v0

    if-gez v2, :cond_1

    move p0, v3

    move v3, v1

    goto :goto_0

    .line 761
    :cond_1
    const/high16 v2, 0x40400000    # 3.0f

    cmpg-float v2, p0, v2

    if-gez v2, :cond_2

    move p0, p1

    move p1, v3

    move v3, v1

    goto :goto_0

    .line 762
    :cond_2
    const/high16 v2, 0x40800000    # 4.0f

    cmpg-float v2, p0, v2

    if-gez v2, :cond_3

    move p0, v3

    move v3, p1

    move p1, p0

    move p0, v1

    goto :goto_0

    .line 763
    :cond_3
    const/high16 v2, 0x40a00000    # 5.0f

    cmpg-float p0, p0, v2

    if-gez p0, :cond_4

    move p0, v1

    goto :goto_0

    .line 764
    :cond_4
    move p0, p1

    move p1, v1

    .line 765
    :goto_0
    div-float/2addr v1, v0

    sub-float/2addr p2, v1

    .line 766
    add-float/2addr p1, p2

    invoke-static {p1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->to255(F)I

    move-result p1

    add-float/2addr v3, p2

    invoke-static {v3}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->to255(F)I

    move-result v0

    add-float/2addr p0, p2

    invoke-static {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->to255(F)I

    move-result p0

    .line 767
    shl-int/lit8 p1, p1, 0x10

    const/high16 p2, -0x1000000

    or-int/2addr p1, p2

    shl-int/lit8 p2, v0, 0x8

    or-int/2addr p1, p2

    or-int/2addr p0, p1

    return p0
.end method

.method private isCharging()Z
    .locals 1

    .line 777
    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->chargingIcon:Landroid/view/View;

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->chargingIcon:Landroid/view/View;

    invoke-virtual {v0}, Landroid/view/View;->getVisibility()I

    move-result v0

    if-nez v0, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    return v0
.end method

.method private keepWindow()V
    .locals 3

    .line 484
    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winRoot:Landroid/view/View;

    if-eqz v0, :cond_4

    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winMgr:Landroid/view/WindowManager;

    if-nez v0, :cond_0

    goto :goto_2

    .line 485
    :cond_0
    iget v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    if-lez v0, :cond_3

    iget v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    if-gtz v0, :cond_1

    goto :goto_1

    .line 486
    :cond_1
    iget v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    add-int/2addr v0, v1

    .line 487
    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winY0:I

    iget v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    sub-int/2addr v1, v2

    .line 488
    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    if-ne v2, v0, :cond_2

    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    iget v2, v2, Landroid/view/WindowManager$LayoutParams;->y:I

    if-ne v2, v1, :cond_2

    return-void

    .line 489
    :cond_2
    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    iput v0, v2, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 490
    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 492
    :try_start_0
    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winMgr:Landroid/view/WindowManager;

    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winRoot:Landroid/view/View;

    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    invoke-interface {v0, v1, v2}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 497
    goto :goto_0

    .line 493
    :catchall_0
    move-exception v0

    .line 494
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winRoot:Landroid/view/View;

    .line 495
    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    .line 496
    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winMgr:Landroid/view/WindowManager;

    .line 498
    :goto_0
    return-void

    .line 485
    :cond_3
    :goto_1
    return-void

    .line 484
    :cond_4
    :goto_2
    return-void
.end method

.method private static loadDrawable(Landroid/content/Context;Ljava/lang/String;I)Landroid/graphics/drawable/Drawable;
    .locals 3

    .line 235
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    const-string v1, "drawable"

    .line 236
    invoke-virtual {p0}, Landroid/content/Context;->getPackageName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, p1, v1, v2}, Landroid/content/res/Resources;->getIdentifier(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)I

    move-result p1

    .line 237
    if-nez p1, :cond_0

    goto :goto_0

    :cond_0
    move p2, p1

    .line 238
    :goto_0
    invoke-virtual {p0, p2}, Landroid/content/Context;->getDrawable(I)Landroid/graphics/drawable/Drawable;

    move-result-object p0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    return-object p0

    .line 239
    :catchall_0
    move-exception p0

    .line 240
    const/4 p0, 0x0

    return-object p0
.end method

.method private play(I)V
    .locals 2

    .line 347
    invoke-virtual {p0, p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 349
    int-to-float p1, p1

    invoke-static {p1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->clamp(F)F

    move-result p1

    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->targetLevel:F

    .line 350
    const/4 p1, 0x0

    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->level:F

    .line 351
    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->compact:F

    .line 352
    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowA:F

    .line 353
    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowY:F

    .line 354
    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->slide:F

    .line 355
    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fade:F

    .line 356
    invoke-direct {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->isCharging()Z

    move-result p1

    iput-boolean p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->charging:Z

    .line 357
    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->playing:Z

    .line 361
    const/4 p1, 0x0

    iput-boolean p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->firstFrame:Z

    .line 362
    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->gateFrames:I

    .line 364
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->startAt:J

    .line 365
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->invalidate()V

    .line 366
    invoke-virtual {p0, p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->postOnAnimation(Ljava/lang/Runnable;)V

    .line 367
    return-void
.end method

.method private prepareWindow()V
    .locals 8

    .line 430
    iget-boolean v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winPrepared:Z

    if-eqz v0, :cond_0

    return-void

    .line 431
    :cond_0
    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winPrepared:Z

    .line 433
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getWidth()I

    move-result v1

    int-to-float v1, v1

    const v2, 0x3f71eb85    # 0.945f

    mul-float/2addr v1, v2

    const/high16 v2, 0x43bb0000    # 374.0f

    div-float/2addr v1, v2

    .line 434
    const/high16 v2, 0x42de0000    # 111.0f

    mul-float/2addr v2, v1

    .line 435
    const/high16 v3, 0x430d0000    # 141.0f

    mul-float/2addr v1, v3

    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->travel:F

    .line 436
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getHeight()I

    move-result v1

    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    .line 439
    :try_start_0
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getRootView()Landroid/view/View;

    move-result-object v1

    .line 440
    if-nez v1, :cond_1

    return-void

    .line 441
    :cond_1
    invoke-virtual {v1}, Landroid/view/View;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v3

    .line 442
    instance-of v4, v3, Landroid/view/WindowManager$LayoutParams;

    if-nez v4, :cond_2

    return-void

    .line 443
    :cond_2
    check-cast v3, Landroid/view/WindowManager$LayoutParams;

    .line 444
    iget v4, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    if-lez v4, :cond_6

    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getWidth()I

    move-result v4

    if-gtz v4, :cond_3

    goto :goto_0

    .line 446
    :cond_3
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getContext()Landroid/content/Context;

    move-result-object v4

    .line 447
    invoke-virtual {v4}, Landroid/content/Context;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    const-string v5, "window"

    .line 448
    invoke-virtual {v4, v5}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Landroid/view/WindowManager;

    .line 449
    if-nez v4, :cond_4

    return-void

    .line 451
    :cond_4
    iget v5, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    iput v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    .line 452
    iget v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    int-to-float v5, v5

    const/high16 v6, 0x40000000    # 2.0f

    div-float/2addr v5, v6

    div-float v6, v2, v6

    sub-float/2addr v5, v6

    .line 453
    const/4 v6, 0x2

    new-array v7, v6, [I

    .line 454
    invoke-virtual {v1, v7}, Landroid/view/View;->getLocationOnScreen([I)V

    .line 456
    aget v0, v7, v0

    int-to-float v0, v0

    add-float/2addr v0, v5

    add-float/2addr v0, v2

    invoke-static {v0}, Ljava/lang/Math;->round(F)I

    move-result v0

    add-int/2addr v0, v6

    .line 457
    if-gtz v0, :cond_5

    return-void

    .line 459
    :cond_5
    iget v2, v3, Landroid/view/WindowManager$LayoutParams;->y:I

    iput v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winY0:I

    .line 460
    iget v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winY0:I

    sub-int/2addr v2, v0

    iput v2, v3, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 461
    iget v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    add-int/2addr v2, v0

    iput v2, v3, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 462
    iput-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winRoot:Landroid/view/View;

    .line 463
    iput-object v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    .line 464
    iput-object v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winMgr:Landroid/view/WindowManager;

    .line 465
    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    .line 466
    int-to-float v0, v0

    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->travel:F

    .line 467
    invoke-interface {v4, v1, v3}, Landroid/view/WindowManager;->updateViewLayout(Landroid/view/View;Landroid/view/ViewGroup$LayoutParams;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 474
    goto :goto_1

    .line 444
    :cond_6
    :goto_0
    return-void

    .line 468
    :catchall_0
    move-exception v0

    .line 469
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winRoot:Landroid/view/View;

    .line 470
    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    .line 471
    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winMgr:Landroid/view/WindowManager;

    .line 472
    const/4 v0, 0x0

    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    .line 473
    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    .line 475
    :goto_1
    return-void
.end method

.method private static raster(Landroid/graphics/drawable/Drawable;II)Landroid/graphics/Bitmap;
    .locals 3

    .line 579
    if-eqz p0, :cond_1

    if-lez p1, :cond_1

    if-gtz p2, :cond_0

    goto :goto_0

    .line 580
    :cond_0
    sget-object v0, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p1, p2, v0}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    .line 581
    new-instance v1, Landroid/graphics/Canvas;

    invoke-direct {v1, v0}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    .line 582
    const/4 v2, 0x0

    invoke-virtual {p0, v2, v2, p1, p2}, Landroid/graphics/drawable/Drawable;->setBounds(IIII)V

    .line 583
    invoke-virtual {p0, v1}, Landroid/graphics/drawable/Drawable;->draw(Landroid/graphics/Canvas;)V

    .line 584
    return-object v0

    .line 579
    :cond_1
    :goto_0
    const/4 p0, 0x0

    return-object p0
.end method

.method private static to255(F)I
    .locals 1

    .line 771
    const/high16 v0, 0x437f0000    # 255.0f

    mul-float/2addr p0, v0

    invoke-static {p0}, Ljava/lang/Math;->round(F)I

    move-result p0

    .line 772
    if-gez p0, :cond_0

    const/4 p0, 0x0

    goto :goto_0

    :cond_0
    const/16 v0, 0xff

    if-le p0, v0, :cond_1

    move p0, v0

    :cond_1
    :goto_0
    return p0
.end method


# virtual methods
.method protected onAttachedToWindow()V
    .locals 5

    .line 265
    invoke-super {p0}, Landroid/view/View;->onAttachedToWindow()V

    .line 267
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getLayoutParams()Landroid/view/ViewGroup$LayoutParams;

    move-result-object v0

    .line 268
    if-eqz v0, :cond_1

    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    const/4 v2, -0x1

    if-ne v1, v2, :cond_0

    iget v1, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    if-eq v1, v2, :cond_1

    .line 271
    :cond_0
    iput v2, v0, Landroid/view/ViewGroup$LayoutParams;->width:I

    .line 272
    iput v2, v0, Landroid/view/ViewGroup$LayoutParams;->height:I

    .line 273
    invoke-virtual {p0, v0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->setLayoutParams(Landroid/view/ViewGroup$LayoutParams;)V

    .line 276
    :cond_1
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getRootView()Landroid/view/View;

    move-result-object v0

    .line 277
    invoke-direct {p0, v0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->clearBackgrounds(Landroid/view/View;)V

    .line 279
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getParent()Landroid/view/ViewParent;

    move-result-object v1

    .line 280
    instance-of v2, v1, Landroid/view/ViewGroup;

    if-eqz v2, :cond_3

    .line 281
    check-cast v1, Landroid/view/ViewGroup;

    .line 282
    const/4 v2, 0x0

    :goto_0
    invoke-virtual {v1}, Landroid/view/ViewGroup;->getChildCount()I

    move-result v3

    if-ge v2, v3, :cond_3

    .line 283
    invoke-virtual {v1, v2}, Landroid/view/ViewGroup;->getChildAt(I)Landroid/view/View;

    move-result-object v3

    .line 284
    if-eq v3, p0, :cond_2

    const/16 v4, 0x8

    invoke-virtual {v3, v4}, Landroid/view/View;->setVisibility(I)V

    .line 282
    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 288
    :cond_3
    const v1, 0x7f0a0491

    invoke-virtual {v0, v1}, Landroid/view/View;->findViewById(I)Landroid/view/View;

    move-result-object v0

    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->chargingIcon:Landroid/view/View;

    .line 290
    iget v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pendingLevel:I

    if-ltz v0, :cond_4

    iget v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pendingLevel:I

    invoke-direct {p0, v0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->play(I)V

    .line 291
    :cond_4
    return-void
.end method

.method protected onDetachedFromWindow()V
    .locals 2

    .line 329
    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    if-eqz v0, :cond_0

    .line 330
    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winY0:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->y:I

    .line 331
    iget v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    if-lez v0, :cond_0

    iget-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    iput v1, v0, Landroid/view/WindowManager$LayoutParams;->height:I

    .line 333
    :cond_0
    const/4 v0, 0x0

    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winMgr:Landroid/view/WindowManager;

    .line 334
    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winRoot:Landroid/view/View;

    .line 335
    iput-object v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winLp:Landroid/view/WindowManager$LayoutParams;

    .line 336
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winPrepared:Z

    .line 337
    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    .line 338
    iput v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    .line 339
    const/4 v1, 0x0

    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->travel:F

    .line 340
    invoke-virtual {p0, p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->removeCallbacks(Ljava/lang/Runnable;)Z

    .line 341
    iput-boolean v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->playing:Z

    .line 342
    invoke-super {p0}, Landroid/view/View;->onDetachedFromWindow()V

    .line 343
    return-void
.end method

.method protected onDraw(Landroid/graphics/Canvas;)V
    .locals 11

    .line 590
    invoke-super {p0, p1}, Landroid/view/View;->onDraw(Landroid/graphics/Canvas;)V

    .line 592
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getWidth()I

    move-result v0

    int-to-float v0, v0

    .line 593
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getHeight()I

    move-result v1

    int-to-float v1, v1

    .line 594
    const/4 v2, 0x0

    cmpg-float v3, v0, v2

    if-lez v3, :cond_d

    cmpg-float v3, v1, v2

    if-gtz v3, :cond_0

    goto/16 :goto_3

    .line 598
    :cond_0
    invoke-direct {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->prepareWindow()V

    .line 599
    invoke-direct {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->keepWindow()V

    .line 604
    iget-boolean v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->firstFrame:Z

    if-nez v3, :cond_4

    .line 605
    iget v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    const/4 v4, 0x1

    if-lez v3, :cond_2

    iget v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    iget v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->winExtra:I

    add-int/2addr v3, v5

    int-to-float v3, v3

    cmpl-float v3, v1, v3

    if-ltz v3, :cond_1

    goto :goto_0

    :cond_1
    const/4 v3, 0x0

    goto :goto_1

    :cond_2
    :goto_0
    move v3, v4

    .line 606
    :goto_1
    if-nez v3, :cond_3

    iget v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->gateFrames:I

    const/16 v5, 0xc

    if-ge v3, v5, :cond_3

    .line 607
    iget p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->gateFrames:I

    add-int/2addr p1, v4

    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->gateFrames:I

    .line 608
    iput v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fade:F

    .line 609
    iput v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->slide:F

    .line 610
    return-void

    .line 612
    :cond_3
    iput-boolean v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->firstFrame:Z

    .line 613
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v3

    iput-wide v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->startAt:J

    .line 616
    :cond_4
    iget-object v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tileBmp:Landroid/graphics/Bitmap;

    if-eqz v3, :cond_5

    iget v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tileBuildW:I

    float-to-int v4, v0

    if-eq v3, v4, :cond_6

    .line 617
    :cond_5
    float-to-int v3, v0

    invoke-direct {p0, v3}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->buildTile(I)V

    .line 618
    invoke-direct {p0, v3}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->buildGauge(I)V

    .line 621
    :cond_6
    const v3, 0x3f71eb85    # 0.945f

    mul-float/2addr v3, v0

    .line 622
    const/high16 v4, 0x43bb0000    # 374.0f

    div-float v9, v3, v4

    .line 623
    const/high16 v4, 0x42de0000    # 111.0f

    mul-float/2addr v4, v9

    .line 626
    iget v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    if-lez v5, :cond_7

    iget v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->contentH:I

    int-to-float v5, v5

    goto :goto_2

    :cond_7
    move v5, v1

    .line 627
    :goto_2
    sub-float/2addr v1, v5

    invoke-static {v2, v1}, Ljava/lang/Math;->max(FF)F

    move-result v1

    .line 628
    const/high16 v6, 0x40000000    # 2.0f

    div-float/2addr v5, v6

    add-float/2addr v1, v5

    div-float/2addr v4, v6

    sub-float/2addr v1, v4

    .line 629
    sub-float/2addr v0, v3

    div-float v7, v0, v6

    .line 630
    iget v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->restLift:F

    sub-float/2addr v1, v0

    iget v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->travel:F

    iget v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->slide:F

    const/high16 v4, 0x3f800000    # 1.0f

    sub-float v3, v4, v3

    mul-float/2addr v0, v3

    sub-float v8, v1, v0

    .line 632
    const/high16 v0, 0x437f0000    # 255.0f

    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fade:F

    mul-float/2addr v1, v0

    float-to-int v0, v1

    .line 634
    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tileBmp:Landroid/graphics/Bitmap;

    if-eqz v1, :cond_8

    .line 635
    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tilePaint:Landroid/graphics/Paint;

    invoke-virtual {v1, v0}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 636
    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tileBmp:Landroid/graphics/Bitmap;

    iget v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tilePad:I

    int-to-float v3, v3

    sub-float v3, v7, v3

    iget v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tilePad:I

    int-to-float v5, v5

    sub-float v5, v8, v5

    iget-object v6, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tilePaint:Landroid/graphics/Paint;

    invoke-virtual {p1, v1, v3, v5, v6}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;FFLandroid/graphics/Paint;)V

    .line 640
    :cond_8
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 641
    invoke-virtual {p1, v7, v8}, Landroid/graphics/Canvas;->translate(FF)V

    .line 642
    invoke-virtual {p1, v9, v9}, Landroid/graphics/Canvas;->scale(FF)V

    .line 644
    const v1, -0x3e866668    # -15.599998f

    iget v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->compact:F

    mul-float/2addr v3, v1

    const v1, 0x422b3333    # 42.8f

    add-float/2addr v3, v1

    .line 645
    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->capRatio:F

    mul-float/2addr v1, v3

    .line 646
    const v5, -0x3ec66668    # -11.599998f

    iget v6, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->compact:F

    mul-float/2addr v6, v5

    const v5, 0x42226666    # 40.6f

    add-float/2addr v6, v5

    .line 648
    iget-object v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textPaint:Landroid/graphics/Paint;

    invoke-virtual {v5, v3}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 649
    iget-object v3, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textPaint:Landroid/graphics/Paint;

    invoke-virtual {v3, v0}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 650
    add-float/2addr v6, v1

    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textPaint:Landroid/graphics/Paint;

    const-string v3, "Smart Pen"

    const/high16 v5, 0x433b0000    # 187.0f

    invoke-virtual {p1, v3, v5, v6, v1}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 652
    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowA:F

    const v3, 0x3c23d70a    # 0.01f

    cmpl-float v1, v1, v3

    if-lez v1, :cond_b

    .line 653
    int-to-float v1, v0

    iget v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowA:F

    mul-float/2addr v1, v5

    float-to-int v1, v1

    .line 654
    invoke-virtual {p1}, Landroid/graphics/Canvas;->save()I

    .line 655
    iget v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowY:F

    sub-float/2addr v4, v5

    const v5, 0x40c33333    # 6.1f

    mul-float/2addr v4, v5

    invoke-virtual {p1, v2, v4}, Landroid/graphics/Canvas;->translate(FF)V

    .line 657
    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctPaint:Landroid/graphics/Paint;

    const v4, 0x41d9999a    # 27.2f

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 658
    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 660
    iget v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->level:F

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result v2

    .line 661
    iget v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctValue:I

    if-eq v2, v4, :cond_9

    .line 662
    iput v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctValue:I

    .line 663
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v2}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "%"

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    iput-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctText:Ljava/lang/String;

    .line 664
    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctPaint:Landroid/graphics/Paint;

    iget-object v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctText:Ljava/lang/String;

    invoke-virtual {v2, v4}, Landroid/graphics/Paint;->measureText(Ljava/lang/String;)F

    move-result v2

    iput v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctWidth:F

    .line 666
    :cond_9
    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctText:Ljava/lang/String;

    const/high16 v4, 0x42b30000    # 89.5f

    iget-object v5, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctPaint:Landroid/graphics/Paint;

    const/high16 v6, 0x432b0000    # 171.0f

    invoke-virtual {p1, v2, v6, v4, v5}, Landroid/graphics/Canvas;->drawText(Ljava/lang/String;FFLandroid/graphics/Paint;)V

    .line 668
    iget-boolean v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->charging:Z

    if-eqz v2, :cond_a

    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->boltBmp:Landroid/graphics/Bitmap;

    if-eqz v2, :cond_a

    .line 669
    iget v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pctWidth:F

    sub-float/2addr v6, v2

    const/high16 v2, 0x40a00000    # 5.0f

    sub-float/2addr v6, v2

    const v2, 0x4128d3dd

    sub-float/2addr v6, v2

    .line 670
    nop

    .line 671
    iget-object v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->dstRect:Landroid/graphics/RectF;

    add-float/2addr v2, v6

    const/high16 v5, 0x42af0000    # 87.5f

    const/high16 v10, 0x428d0000    # 70.5f

    invoke-virtual {v4, v6, v10, v2, v5}, Landroid/graphics/RectF;->set(FFFF)V

    .line 672
    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->artPaint:Landroid/graphics/Paint;

    invoke-virtual {v2, v1}, Landroid/graphics/Paint;->setAlpha(I)V

    .line 673
    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->boltBmp:Landroid/graphics/Bitmap;

    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->dstRect:Landroid/graphics/RectF;

    iget-object v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->artPaint:Landroid/graphics/Paint;

    const/4 v5, 0x0

    invoke-virtual {p1, v1, v5, v2, v4}, Landroid/graphics/Canvas;->drawBitmap(Landroid/graphics/Bitmap;Landroid/graphics/Rect;Landroid/graphics/RectF;Landroid/graphics/Paint;)V

    .line 676
    :cond_a
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 679
    :cond_b
    invoke-virtual {p1}, Landroid/graphics/Canvas;->restore()V

    .line 682
    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowA:F

    cmpl-float v1, v1, v3

    if-lez v1, :cond_c

    .line 683
    int-to-float v0, v0

    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowA:F

    mul-float/2addr v0, v1

    float-to-int v10, v0

    .line 684
    move-object v5, p0

    move-object v6, p1

    invoke-direct/range {v5 .. v10}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->drawBattery(Landroid/graphics/Canvas;FFFI)V

    .line 686
    :cond_c
    return-void

    .line 594
    :cond_d
    :goto_3
    return-void
.end method

.method protected onSizeChanged(IIII)V
    .locals 3

    .line 522
    invoke-super {p0, p1, p2, p3, p4}, Landroid/view/View;->onSizeChanged(IIII)V

    .line 525
    invoke-direct {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->keepWindow()V

    .line 527
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->getResources()Landroid/content/res/Resources;

    move-result-object p2

    invoke-virtual {p2}, Landroid/content/res/Resources;->getDisplayMetrics()Landroid/util/DisplayMetrics;

    move-result-object p2

    iget p2, p2, Landroid/util/DisplayMetrics;->density:F

    const/high16 p3, 0x40c00000    # 6.0f

    mul-float/2addr p2, p3

    iput p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->restLift:F

    .line 531
    iget-object p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tileBmp:Landroid/graphics/Bitmap;

    if-eqz p2, :cond_0

    iget p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->tileBuildW:I

    if-ne p2, p1, :cond_0

    return-void

    .line 533
    :cond_0
    new-instance p2, Landroid/graphics/Paint;

    const/4 p3, 0x1

    invoke-direct {p2, p3}, Landroid/graphics/Paint;-><init>(I)V

    .line 534
    iget-object p4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textPaint:Landroid/graphics/Paint;

    invoke-virtual {p4}, Landroid/graphics/Paint;->getTypeface()Landroid/graphics/Typeface;

    move-result-object p4

    invoke-virtual {p2, p4}, Landroid/graphics/Paint;->setTypeface(Landroid/graphics/Typeface;)Landroid/graphics/Typeface;

    .line 535
    const/high16 p4, 0x42c80000    # 100.0f

    invoke-virtual {p2, p4}, Landroid/graphics/Paint;->setTextSize(F)V

    .line 536
    const/4 v0, 0x0

    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textBounds:Landroid/graphics/Rect;

    const-string v2, "H"

    invoke-virtual {p2, v2, v0, p3, v1}, Landroid/graphics/Paint;->getTextBounds(Ljava/lang/String;IILandroid/graphics/Rect;)V

    .line 537
    iget-object p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->textBounds:Landroid/graphics/Rect;

    iget p2, p2, Landroid/graphics/Rect;->top:I

    neg-int p2, p2

    int-to-float p2, p2

    div-float/2addr p2, p4

    iput p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->capRatio:F

    .line 538
    iget p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->capRatio:F

    const p3, 0x3dcccccd    # 0.1f

    cmpg-float p2, p2, p3

    if-gtz p2, :cond_1

    const p2, 0x3f3851ec    # 0.72f

    iput p2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->capRatio:F

    .line 540
    :cond_1
    invoke-direct {p0, p1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->buildTile(I)V

    .line 541
    invoke-direct {p0, p1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->buildGauge(I)V

    .line 542
    return-void
.end method

.method public run()V
    .locals 11

    .line 373
    iget-boolean v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->firstFrame:Z

    const/4 v1, 0x0

    if-nez v0, :cond_0

    .line 374
    invoke-direct {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->clearWindowBlur()V

    .line 375
    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fade:F

    .line 376
    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->slide:F

    .line 377
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->invalidate()V

    .line 378
    invoke-virtual {p0, p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->postOnAnimation(Ljava/lang/Runnable;)V

    .line 379
    return-void

    .line 382
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->uptimeMillis()J

    move-result-wide v2

    iget-wide v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->startAt:J

    sub-long/2addr v2, v4

    long-to-float v0, v2

    .line 385
    invoke-direct {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->clearWindowBlur()V

    .line 387
    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fadeEase:Landroid/view/animation/PathInterpolator;

    sub-float v1, v0, v1

    const/high16 v3, 0x428c0000    # 70.0f

    div-float v3, v1, v3

    invoke-static {v3}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->frac(F)F

    move-result v3

    invoke-virtual {v2, v3}, Landroid/view/animation/PathInterpolator;->getInterpolation(F)F

    move-result v2

    invoke-static {v2}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->clamp01(F)F

    move-result v2

    iput v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->fade:F

    .line 388
    const/high16 v2, 0x442a0000    # 680.0f

    div-float/2addr v1, v2

    invoke-static {v1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->frac(F)F

    move-result v1

    invoke-static {v1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->dropAt(F)F

    move-result v1

    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->slide:F

    .line 391
    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->smooth:Landroid/view/animation/PathInterpolator;

    const v2, 0x44bb8000    # 1500.0f

    sub-float v2, v0, v2

    const/high16 v3, 0x44390000    # 740.0f

    div-float v3, v2, v3

    invoke-static {v3}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->frac(F)F

    move-result v3

    invoke-virtual {v1, v3}, Landroid/view/animation/PathInterpolator;->getInterpolation(F)F

    move-result v1

    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->compact:F

    .line 392
    const/high16 v1, 0x43aa0000    # 340.0f

    div-float v1, v2, v1

    invoke-static {v1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->frac(F)F

    move-result v1

    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowA:F

    .line 393
    iget-object v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->spring:Landroid/view/animation/PathInterpolator;

    const/high16 v3, 0x441b0000    # 620.0f

    div-float/2addr v2, v3

    invoke-static {v2}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->frac(F)F

    move-result v2

    invoke-virtual {v1, v2}, Landroid/view/animation/PathInterpolator;->getInterpolation(F)F

    move-result v1

    iput v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->rowY:F

    .line 398
    iget v1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->targetLevel:F

    const/high16 v2, 0x40a00000    # 5.0f

    mul-float/2addr v1, v2

    const/high16 v2, 0x43820000    # 260.0f

    add-float/2addr v1, v2

    .line 399
    const/high16 v2, 0x45110000    # 2320.0f

    sub-float v3, v0, v2

    div-float/2addr v3, v1

    invoke-static {v3}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->frac(F)F

    move-result v3

    .line 400
    iget v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->targetLevel:F

    float-to-double v5, v3

    const-wide/high16 v7, 0x3ff0000000000000L    # 1.0

    sub-double v5, v7, v5

    const-wide v9, 0x400199999999999aL    # 2.2

    invoke-static {v5, v6, v9, v10}, Ljava/lang/Math;->pow(DD)D

    move-result-wide v5

    sub-double/2addr v7, v5

    double-to-float v3, v7

    mul-float/2addr v4, v3

    iput v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->level:F

    .line 402
    add-float/2addr v1, v2

    const/high16 v2, 0x44af0000    # 1400.0f

    add-float/2addr v1, v2

    .line 403
    cmpl-float v2, v0, v1

    const/high16 v3, 0x44020000    # 520.0f

    if-ltz v2, :cond_1

    .line 406
    iget-object v2, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->outEase:Landroid/view/animation/PathInterpolator;

    sub-float v4, v0, v1

    div-float/2addr v4, v3

    invoke-static {v4}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->frac(F)F

    move-result v4

    invoke-virtual {v2, v4}, Landroid/view/animation/PathInterpolator;->getInterpolation(F)F

    move-result v2

    const/high16 v4, 0x3f800000    # 1.0f

    sub-float/2addr v4, v2

    iput v4, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->slide:F

    .line 409
    :cond_1
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->invalidate()V

    .line 411
    add-float/2addr v1, v3

    cmpg-float v0, v0, v1

    if-gez v0, :cond_2

    .line 412
    invoke-virtual {p0, p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->postOnAnimation(Ljava/lang/Runnable;)V

    goto :goto_0

    .line 414
    :cond_2
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->playing:Z

    .line 416
    :goto_0
    return-void
.end method

.method public setElectricity(I)V
    .locals 1

    .line 247
    int-to-float p1, p1

    invoke-static {p1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->clamp(F)F

    move-result p1

    float-to-int p1, p1

    .line 248
    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->pendingLevel:I

    .line 250
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->isAttachedToWindow()Z

    move-result v0

    if-nez v0, :cond_0

    .line 251
    invoke-virtual {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->invalidate()V

    .line 252
    return-void

    .line 254
    :cond_0
    iget-boolean v0, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->playing:Z

    if-eqz v0, :cond_1

    .line 255
    int-to-float p1, p1

    iput p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->targetLevel:F

    .line 256
    invoke-direct {p0}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->isCharging()Z

    move-result p1

    iput-boolean p1, p0, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->charging:Z

    .line 257
    return-void

    .line 259
    :cond_1
    invoke-direct {p0, p1}, Lcom/miui/miinput/stylus/battery/MiuiStylusLevelsView;->play(I)V

    .line 260
    return-void
.end method
