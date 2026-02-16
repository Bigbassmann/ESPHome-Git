# SenseCAP v2 Canonical Structure Freeze

Date: 2026-02-15
Status: Frozen for current v2 stabilization pass

## Purpose
Lock naming conventions and define `keep` vs `deprecated` files so commits stay consistent while we finish runtime validation.

## Canonical Naming Rules (Frozen)
- Core/shared files: `packages/sensecap_next/core_*.yaml`
- Profile selectors: `packages/sensecap_next/profile_*.yaml`
- Feature directory pattern: `packages/sensecap_next/features/<feature>/`
- Feature file pattern:
  - `<feature>_bundle.yaml` (required)
  - `<feature>_bundle_minimal.yaml` (optional for minimal profile)
  - `<feature>_lvgl.yaml`
  - `<feature>_ha.yaml`
  - `<feature>_runtime.yaml`
  - `<feature>_actions.yaml`
- Device-scoped files:
  - `devices/<device_id>/device_profile.yaml`
  - `devices/<device_id>/device_entities.yaml`
  - `devices/<device_id>/device_endpoints.yaml`

## Keep (Canonical)

### Root main files
- `sensecap-d1s-v2.yaml` (active v2)
- `sensecap-d1s.yaml` (v1 remains independent)

### Core/Profile
Keep these in `packages/sensecap_next/`:
- `core_base_ui.yaml`
- `core_boot.yaml`
- `core_device.yaml`
- `core_globals.yaml`
- `core_ha_common.yaml`
- `core_hw.yaml`
- `core_nav_full.yaml`
- `core_nav_minimal.yaml`
- `core_styles.yaml`
- `profile_core_full.yaml`
- `profile_core_minimal.yaml`
- `profile_debug.yaml`
- `profile_full.yaml`
- `profile_minimal.yaml`

### Features
Keep these feature directories:
- `packages/sensecap_next/features/admin/`
- `packages/sensecap_next/features/fans/`
- `packages/sensecap_next/features/home/`
- `packages/sensecap_next/features/lighting/`
- `packages/sensecap_next/features/menu/`
- `packages/sensecap_next/features/other_controls/`
- `packages/sensecap_next/features/overrides/`
- `packages/sensecap_next/features/settings/`
- `packages/sensecap_next/features/thermostat/`
- `packages/sensecap_next/features/wifi/`

Current accepted runtime/helper files (kept as-is for stability):
- `packages/sensecap_next/features/admin/admin_page_runtime.yaml`
- `packages/sensecap_next/features/home/home_page_runtime.yaml`
- `packages/sensecap_next/features/home/home_clock_page_runtime.yaml`
- `packages/sensecap_next/features/settings/settings_page_runtime.yaml`
- `packages/sensecap_next/features/fans/fans_overrides_actions.yaml`
- `packages/sensecap_next/features/fans/fans_overrides_runtime.yaml`

### Device scope
Keep these in `devices/sensecap_d1s_01/`:
- `device_profile.yaml`
- `device_entities.yaml`
- `device_endpoints.yaml`

## Deprecated / Archive

### Archived transitional files
All `DELETE-*` files are archived under:
- `v2-archive/packages/sensecap_next/...`

### Deprecated candidate (temp audit)
- `packages/sensecap_next/profile_full_audit_tmp.yaml`

Action for later cleanup pass:
- Rename temp files to `DELETE-*` and move into `v2-archive/` (same structure), or remove after manual review.

## Commit Guidance for this Freeze
- Do not introduce new top-level naming patterns.
- Keep v1 and v2 separated.
- New work should land in canonical paths only.
- If a temporary file is required, suffix with `_tmp` and list it in this document until archived.
