# ESPHome-Git

This repo is the source of truth for ESPHome configs. GitHub is the backup/central copy.

## Project Status
This project has reached a stable milestone for daily testing and use, but it is **not complete**.

- Core SenseCAP D1S UI/navigation/runtime behavior is working.
- Home Assistant sync paths are mostly aligned.
- Sleep/idle scroll/boot behavior is much more reliable than earlier iterations.
- There is still more polish, cleanup, and feature hardening to do.

## What We Have Built So Far
- A modular ESPHome package layout for SenseCAP D1S.
- Multi-page LVGL interface with persistent navigation.
- Home, Home Clock, Settings, Admin, Overrides, Fans, Thermostat (V2 + Legacy), Lighting, Other Controls, Menu, and WiFi setup pages.
- Runtime gating so most page updates happen only when needed.
- Boot page handling, wake/sleep behavior, and idle scrolling.
- HA-integrated controls for thermostat, fans, lighting, lock, and key status fields.

## Known State
- Good progress and currently usable.
- Not final.
- Expect additional UX cleanup, refactors, and reliability improvements before calling this complete.

## Progress Images (2026-02-14)
Embedded preview set (`.jpeg/.jpg`) with `.heic` originals retained in the same folder.

![Boot screen](docs/images/sensecap-progress-2026-02-14/IMG_2314.jpeg)
![Home page](docs/images/sensecap-progress-2026-02-14/IMG_2315.jpeg)
![Overrides page](docs/images/sensecap-progress-2026-02-14/IMG_2316.jpeg)
![Fan controls page](docs/images/sensecap-progress-2026-02-14/IMG_2317.jpeg)
![Thermostat V2 page](docs/images/sensecap-progress-2026-02-14/IMG_2318.jpeg)
![Thermostat legacy page](docs/images/sensecap-progress-2026-02-14/IMG_2319.jpeg)
![Lighting page](docs/images/sensecap-progress-2026-02-14/IMG_2320.jpeg)
![Other controls page](docs/images/sensecap-progress-2026-02-14/IMG_2321.jpeg)
![Menu page](docs/images/sensecap-progress-2026-02-14/IMG_2322.jpeg)
![Settings page](docs/images/sensecap-progress-2026-02-14/IMG_2323.jpeg)
![WiFi setup page](docs/images/sensecap-progress-2026-02-14/IMG_2324.jpg)
![Admin page](docs/images/sensecap-progress-2026-02-14/IMG_2325.jpeg)
## Structure
```text
ESPHome-Git/
  custom_components/   # custom ESPHome components
  fonts/               # font files
  icon_s/              # svg/png icons
  packages/            # reusable packages only
    shared/            # wifi, fonts, icons, etc.
    sensecap/          # SenseCAP-specific packages
  projects/            # full projects / device configs
  boards/              # board pinouts / substitutions
  docs/                # cheatsheets, pinouts, notes
```

## Workflow (Short)
1. Edit on laptop repo.
2. Commit + push to GitHub.
3. Deploy to Home1/Home2 via robocopy (no Git on Home targets).

See `docs/ESPHome-Git-Cheatsheet.md` for full commands and details.

