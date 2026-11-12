# Authors

## Maintainer

**Paul Frémondière** — [@paulfremfrem-cmyk](https://github.com/paulfremfrem-cmyk)
Idea, design decisions, on-device testing (Xiaomi Pad 6), screenshots, releases.
The person responsible for this repository and for what the module does.

## AI assistants (tools, not authors)

This project was written in pair-programming with AI assistants. They are credited for
transparency, but they are not GitHub accounts and they are not authors of the code:

| Assistant | Contribution |
|---|---|
| **Claude** (Anthropic) | first versions of the HUD, the dex-patch pipeline, the window-expansion trick, animation curves |
| **DeepSeek V4.1 Flash** | faster gauge fill (~0.6 s), higher resting position, this repository (anchor-based patcher, `--dry-run`, `SAFETY.md`, English docs) |

GitHub's **Contributors** panel only lists GitHub accounts behind commits — which is why it
shows a single contributor. Anything else would mean impersonating a bot account.

## Third-party

- The hidden-API whitelist is the AOSP file (Apache-2.0) plus one line.
- The module is built with `apktool`, `d8`/`zipalign`/`apksigner` from the Android SDK.
