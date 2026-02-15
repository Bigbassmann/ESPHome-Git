# Statement of Work: SenseCAP Next Modularization

## Objective
Build a parallel, non-disruptive "next" configuration stack that improves modularity, boot reliability, and multi-service expansion (ESP-Now/MQTT/Telegram) without changing the current production `sensecap-d1s.yaml` behavior.

## Scope
In scope:
- New main file path for next stack (current active path: `sensecap-d1s-v2.yaml`, target naming may revert to `sensecap-d1s-next.yaml` later).
- New package namespace: `packages/sensecap_next/`.
- New device profile folder: `devices/<device_id>/`.
- Feature bundle pattern: `<feature>_lvgl`, `<feature>_ha`, `<feature>_runtime`, `<feature>_actions`.
- Boot orchestration cleanup with one shared boot entry point.
- Clear profile selector files (`profile_full`, `profile_minimal`, `profile_debug`).
- Profile-aware core wiring (`profile_core_full`, `profile_core_minimal`) so both profiles compile.
- Post-migration cleanup and consolidation of temporary wrappers/aliases.

Out of scope (this phase):
- Final UI polish/theme redesign.
- Production cutover from current stable stack until checklist sign-off.

## Deliverables
- Scaffolded "next" config tree and placeholders.
- Documented migration plan and sequence.
- Validation checkpoints per phase.
- Cleanup plan with keep/merge/delete decisions.
- Multi-device/multi-location architecture and usage pattern.

## Execution Plan
1. Foundation and Safety
- Keep `sensecap-d1s.yaml` untouched.
- Build all new files under `sensecap-d1s-v2.yaml` (or `sensecap-d1s-next.yaml`) and `packages/sensecap_next/`.
- Add one orchestrated boot script path only.

2. Core Migration
- Move common device/runtime globals to `core_*` files.
- Keep cross-feature references out of `main`.
- Ensure `profile_full` and `profile_minimal` both compile.

3. Feature-by-Feature Migration
- Migrate one feature at a time (Home, Settings, Thermostat, Lighting, Fans, Overrides, etc.).
- For each feature: split into lvgl/ha/runtime/actions files.
- Add page-level update gating (update on show + required periodic exceptions only).

4. Modularity Hardening and Cleanup
- Remove naming ambiguity and temporary aliases (`legacy` naming, transitional wrappers).
- Collapse wrapper+impl files where practical (`*_runtime_impl`, `*_actions_impl`, `*_page` -> canonical files).
- Keep one canonical nav per profile (`core_nav_full`, `core_nav_minimal`).
- Keep one canonical core profile entry per profile (`profile_core_full`, `profile_core_minimal`).
- Maintain compatibility only where needed, then remove dead files.

5. Service Expansion Layer
- Add per-device endpoint mapping for ESP-Now, MQTT, Telegram under `devices/<device_id>/`.
- Add explicit routing rules (no outbound commands by default).
- Add setup/admin surfaces for credentials and status.

6. Integration and Test
- Validate boot sequence, page navigation, sleep/idle scroll, and HA sync behavior.
- Verify no command writes to HA except explicit user actions.
- Add debug logs for transitions and write actions.

7. Cutover
- Freeze current stable branch/tag.
- Promote next stack to active only after test checklist passes.

## Modular Structure: Current Intent
- `sensecap-d1s-v2.yaml` (main): substitutions + profile include + device profile include only.
- `packages/sensecap_next/base/`: hardware/display/fonts/icons/topbar/boot primitives.
- `packages/sensecap_next/core_*.yaml`: orchestration, globals, nav, shared HA bindings, profile-aware core wiring.
- `packages/sensecap_next/features/<feature>/`: feature-isolated lvgl/ha/runtime/actions and bundle include.
- `devices/<device_id>/`:
  - `device_profile.yaml`: include wiring for that device.
  - `device_entities.yaml`: entity IDs and per-device mappings.
  - `device_endpoints.yaml`: ESP-Now/MQTT/Telegram endpoint and routing configuration.

## Multi-Device / Multi-Location Application Model
1. Create one device folder per panel
- Example:
  - `devices/sensecap_d1s_01/`
  - `devices/sensecap_d1s_02/`

2. Keep shared logic in `packages/sensecap_next/`
- No hardcoded per-home entity IDs in shared feature files unless deliberately global.

3. Put device-specific mappings in device files
- `device_entities.yaml`: HA entities used by that panel.
- `device_endpoints.yaml`: service endpoints (ESP-Now peers, MQTT topics, Telegram IDs).

4. Support multi-location by site substitutions
- `site_id` in each main/device profile controls site-scoped naming/routing.
- Keep location-specific secrets in shared secrets management (not in package files).

5. Reuse profiles across devices
- `profile_full` for full UX devices.
- `profile_minimal` for lightweight/satellite displays.

6. Route writes explicitly
- Actions files perform writes.
- Runtime files remain read/sync/update only.
- Add policy checks for outbound channels before Step 5 completion.

## Acceptance Criteria
- Current production config remains unchanged and bootable.
- Next stack compiles with `profile_minimal` and `profile_full`.
- Feature packages can be included/excluded with profile/device includes, not main-file rewrites.
- No unresolved cross-package ID references in `on_boot`.
- Service endpoints are device-scoped and not hardcoded in shared packages.
- Cleanup pass removes temporary wrappers/aliases or marks them as intentional compatibility shims.

## Risks and Mitigations
- Risk: Hidden cross-package dependencies.
  Mitigation: migrate one feature at a time with compile checks and profile-specific validation.
- Risk: Boot race conditions.
  Mitigation: one orchestrator and delayed page initialization gates.
- Risk: HA write storms.
  Mitigation: runtime read-only policy, writes only in actions files.
- Risk: Stray transitional files after migration.
  Mitigation: explicit keep/merge/delete inventory and cleanup checkpoint before Step 5.

## Next Immediate Steps
1. Complete cleanup checkpoint
- Remove or merge transitional files (`core_nav.yaml`, `profile_core.yaml`, wrapper/impl duplicates) after reference checks.

2. Freeze final next structure
- Confirm canonical file list and naming conventions.

3. Start Step 5 (Service Expansion)
- Implement `device_endpoints.yaml` schema for ESP-Now/MQTT/Telegram.
- Add routing policy flags and admin visibility for endpoint status.

4. Expand to additional devices/locations
- Clone `devices/<device_id>/` pattern and validate each device against profile and site substitutions.
