# Statement of Work: SenseCAP Next Modularization

## Objective
Build a parallel, non-disruptive "next" configuration stack that improves modularity, boot reliability, and multi-service expansion (ESP-Now/MQTT/Telegram) without changing the current production `sensecap-d1s.yaml` behavior.

## Scope
In scope:
- New main file: `sensecap-d1s-next.yaml`
- New package namespace: `packages/sensecap_next/`
- New device profile folder: `devices/<device_id>/`
- Feature bundle pattern: `<feature>_lvgl`, `<feature>_ha`, `<feature>_runtime`, `<feature>_actions`
- Boot orchestration cleanup with one shared boot entry point
- Clear profile selector files (`profile_full`, `profile_minimal`, `profile_debug`)

Out of scope (this phase):
- Migrating all existing feature logic from legacy files
- Final UI polish/theme redesign
- Production cutover from current stable stack

## Deliverables
- Scaffolded "next" config tree and placeholders
- Documented migration plan and sequence
- Validation checkpoints per phase

## Execution Plan
1. Foundation and Safety
- Keep `sensecap-d1s.yaml` untouched.
- Build all new files under `sensecap-d1s-next.yaml` and `packages/sensecap_next/`.
- Add one orchestrated boot script path only.

2. Core Migration
- Move common device/runtime globals to `core_*` files.
- Keep cross-feature references out of `main`.
- Confirm compile with minimal profile first.

3. Feature-by-Feature Migration
- Migrate one feature at a time (Home, Settings, Thermostat, Lighting, Fans, Overrides, etc.).
- For each feature: split into lvgl/ha/runtime/actions files.
- Add page-level update gating (update on show + required periodic exceptions only).

4. Service Expansion Layer
- Add per-device endpoint mapping for ESP-Now, MQTT, Telegram.
- Add explicit routing rules (no outbound commands by default).
- Add setup/admin surfaces for credentials and status.

5. Integration and Test
- Validate boot sequence, page navigation, sleep/idle scroll, and HA sync behavior.
- Verify no command writes to HA except explicit user actions.
- Add debug logs for transitions and write actions.

6. Cutover
- Freeze current stable branch/tag.
- Promote `sensecap-d1s-next.yaml` to active only after test checklist passes.

## Acceptance Criteria
- Current production config remains unchanged and bootable.
- New stack compiles with `profile_minimal` and `profile_full`.
- Feature packages can be included/excluded without main-file edits.
- No unresolved cross-package ID references in `on_boot`.
- Service endpoints are device-scoped and not hardcoded in shared packages.

## Risks and Mitigations
- Risk: Hidden cross-package dependencies.
  Mitigation: migrate one feature at a time with compile checks.
- Risk: Boot race conditions.
  Mitigation: one orchestrator and delayed page initialization gates.
- Risk: HA write storms.
  Mitigation: default outbound disabled; explicit user-trigger-only writes.

## Next Immediate Steps
1. Validate scaffold exists and compile-check `sensecap-d1s-next.yaml`.
2. Migrate Home + Settings as first two feature bundles.
3. Migrate Thermostat (v2 + legacy) using shared HA bindings.
4. Add ESP-Now/MQTT/Telegram endpoint schema in `devices/sensecap_d1s_01/`.
