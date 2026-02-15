# ESPHome-Git

This repo is the source of truth for ESPHome configs. GitHub is the backup/central copy.

### Projects Include:
- Septic Tank monitor, alarming, valve control w/ ESP-Now and Telegram Bot
- Pimroni Enviro+ Phat conversion to ESPHome/HA
- Several variations of IAQ Sensors ESPHome/HA - Focused on battery operation
- SenseCAP Indicator ESPHome Modular Setup ESPHome/HA

# SenseCAP Indicator D1S

Main Files: (v1)sensecap-d1s.yaml and (v2)sensecap-d1s-next.yaml
v1 is stable, but not clean or fully modular.

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

# Boot Screen
![Boot screen](docs/images/sensecap-progress-2026-02-14/IMG_2314.jpeg)

# Home Page (RP2040 Sensors)
![Home page](docs/images/sensecap-progress-2026-02-14/IMG_2315.jpeg)

# HA Automation Overrides Page
![Overrides page](docs/images/sensecap-progress-2026-02-14/IMG_2316.jpeg)

# HA Fan Controls Page
![Fan controls page](docs/images/sensecap-progress-2026-02-14/IMG_2317.jpeg)

# HA Thermostat v2 Page (simulates HA Climate Card)
![Thermostat V2 page](docs/images/sensecap-progress-2026-02-14/IMG_2318.jpeg)

# HA Thermostat v1 Page (simple buttons/slider)
![Thermostat legacy page](docs/images/sensecap-progress-2026-02-14/IMG_2319.jpeg)

# HA Lighting Controls Page
![Lighting page](docs/images/sensecap-progress-2026-02-14/IMG_2320.jpeg)

# HA Other Controls Page (misc devices and entities)
![Other controls page](docs/images/sensecap-progress-2026-02-14/IMG_2321.jpeg)

# Menu Page (includes all pages on the device)
![Menu page](docs/images/sensecap-progress-2026-02-14/IMG_2322.jpeg)

# Settings Page (device settings)
![Settings page](docs/images/sensecap-progress-2026-02-14/IMG_2323.jpeg)

# WiFi Setup Page (keyboard for setup after factory reset)
![WiFi setup page](docs/images/sensecap-progress-2026-02-14/IMG_2324.jpg)

# Admin Page (system info and settings)
![Admin page](docs/images/sensecap-progress-2026-02-14/IMG_2325.jpeg)

## Structure
```text
ESPHome-Git/
  custom_components/   # custom ESPHome components (will replace with  external_components)
  fonts/               # font files
  icon_s/              # svg/png icons
  packages/            # reusable packages only
    shared/            # wifi, fonts, icons, etc.
    sensecap/          # SenseCAP-specific packages - v1/Legacy
    sensecap-next/     # v2 specific files - migration files
  projects/            # full projects / device configs
  boards/              # board pinouts / substitutions
  devices/             # modified files specific to a single device id
  docs/                # cheatsheets, pinouts, notes
```

## Workflow (Short)
1. Edit on laptop repo.
2. Commit + push to GitHub.
3. Deploy to Home1/Home2 via robocopy (no Git on Home targets).

See `docs/ESPHome-Git-Cheatsheet.md` for full commands and details.


## Repository Layout (SenseCAP Next)

This section reflects the current v2 modular architecture and how it scales across devices and locations.

```text
/config/esphome/
  sensecap-d1s-v2.yaml                 # active next stack main (profile + device include only)
  sensecap-d1s.yaml                    # v1 stable stack (kept independent)

  packages/
    sensecap/                          # v1 legacy packages (do not modify for v2 changes)
    sensecap_next/
      base/                            # hardware/display/fonts/icons/topbar/boot primitives
      core_*.yaml                      # orchestration, globals, nav, shared HA bindings
      profile_*.yaml                   # full/minimal/debug + profile core wiring
      features/
        <feature>/
          <feature>_bundle.yaml
          <feature>_lvgl.yaml
          <feature>_ha.yaml
          <feature>_runtime.yaml
          <feature>_actions.yaml

  devices/
    <device_id>/
      device_profile.yaml              # include wiring for that device
      device_entities.yaml             # device-specific HA entity mappings
      device_endpoints.yaml            # device-specific ESP-Now/MQTT/Telegram endpoints

  docs/
    SOW-sensecap-next-modularization.md
```

### Multi-Device and Multi-Location Usage
1. Create one folder per panel under `devices/<device_id>/`.
2. Keep shared logic in `packages/sensecap_next/`.
3. Keep per-device/per-site mappings in `device_entities.yaml` and `device_endpoints.yaml`.
4. Use `site_id` substitution in each main/device profile for location-specific routing/naming.
5. Keep secrets in ESPHome secrets, not in package files.
6. Use `profile_full` for full UX panels and `profile_minimal` for lightweight panels.

### Write Policy
- Runtime files should be read/sync/update only.
- HA/service writes should be centralized in actions files and triggered by explicit user action.
