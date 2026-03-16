# SenseCAP Chat Recovery Prompt

Use this prompt to restart work in a fresh chat and preserve project goals/constraints.

```text
Continue my SenseCAP fork work exactly where we left off.

Workspace/root:
- /config/esphome
- Main repo scope: /config/esphome/esphome-modular-lvgl-buttons

Mission:
- Keep modular SenseCAP structure stable.
- Keep color/UI tokenization consistent.
- Reduce drift and hardcoded literals.
- Preserve upstream templates; edit only fork-owned -sensecap files unless I explicitly approve otherwise.

Hard rules:
1) Scope ONLY under /config/esphome/esphome-modular-lvgl-buttons (except explicit read-only files I provide).
2) Do NOT edit /config/esphome root files unless I explicitly approve.
3) Before non-trivial edits, list exact files you will touch.
4) Prefer apply_patch for YAML edits.
5) After each small edit batch: artifact scan for literal `r`n/escaped newline issues + root validate.
6) Root validate command target is: /config/esphome/sensecap-d1s-v2.yaml
7) If constraints conflict, stop and ask.

Startup read order (first pass):
1. /config/esphome/AGENTS.md
2. /config/esphome/esphome-modular-lvgl-buttons/README-sensecap.md
3. /config/esphome/esphome-modular-lvgl-buttons/SENSECAP_SIMPLE_PATTERN-sensecap.md
4. /config/esphome/esphome-modular-lvgl-buttons/sensecap-d1s-v2-001.yaml
5. /config/esphome/esphome-modular-lvgl-buttons/sensecap-d1s-v2-001.yaml
6. /config/esphome/esphome-modular-lvgl-buttons/common/ha_entities-sensecap-dani.yaml
7. /config/esphome/esphome-modular-lvgl-buttons/common/ha_entities-sensecap-dani.yaml
8. /config/esphome/esphome-modular-lvgl-buttons/common/color-sensecap-dani.yaml
9. /config/esphome/esphome-modular-lvgl-buttons/common/color-sensecap-dani.yaml
10. /config/esphome/esphome-modular-lvgl-buttons/common/page_mapping-sensecap.yaml
11. /config/esphome/esphome-modular-lvgl-buttons/common/package_instance_mapping-sensecap-dani.yaml
12. /config/esphome/esphome-modular-lvgl-buttons/common/top_level_lvgl_defualts-001-dani.yaml
13. /config/esphome/esphome-modular-lvgl-buttons/common/core_ha_common-sensecap.yaml
14. /config/esphome/esphome-modular-lvgl-buttons/pages/home_grid-sensecap.yaml
15. /config/esphome/esphome-modular-lvgl-buttons/pages/overrides_grid-sensecap.yaml
14. /config/esphome/esphome-modular-lvgl-buttons/pages/lighting_dimmers_grid_template-sensecap.yaml
15. /config/esphome/esphome-modular-lvgl-buttons/pages/fans_grid-sensecap-dani.yaml
16. /config/esphome/esphome-modular-lvgl-buttons/pages/thermostat_v2_lvgl-sensecap-dani.yaml
17. /config/esphome/esphome-modular-lvgl-buttons/pages/page_shell_480-sensecap.yaml
18. /config/esphome/esphome-modular-lvgl-buttons/pages/loading_480px-sensecap.yaml

Then:
- Give a short "state + drift risks + next 3 actions" summary.
- Execute only the first approved action unless I tell you to do more.

Current task to continue:
<PASTE CURRENT TASK HERE>
```


- Verify each \\pages/*-sensecap*.yaml\\ file retains the \\PAGE EDIT GUIDE (SenseCAP)\\ header before major page edits.


- Baseline status: use `sensecap-d1s-v2-001.yaml` as authoritative baseline; retired non-dani duplicates are under `archive/retired_baseline_2026-03-10/` (including retired wrapper `wrappers/sensecap-d1s-v2-001-dani-wrapper.yaml`).

- Keep `common/core_globals-sensecap.yaml` retired; `rp2040_last_seen_ms` is defined in `common/sensecap_indicator_sensors-sensecap.yaml`.

- Theme test path: use Display Settings dropdown `display_theme_dropdown` to switch `current_theme` between `Dark`, `Dani`, and `Split` and verify style updates/redraw.


## Maintenance Notes
- 2026-03-10: Theme runtime logic now uses numeric slot `sense_theme_slot` (index-based) instead of `current_option()=="name"` comparisons in page/style conditionals. Keep new theme additions index-first and avoid name-based branching.


- 2026-03-10: Theme selector labels are tokenized as ui_theme_label_0..ui_theme_label_9. Page/runtime logic must use numeric slots (sense_theme_slot), while labels are UI-only.


- 2026-03-10: Theme slots 3..9 now have distinct style mappings in theme_style-sensecap-dani.yaml; display dropdown uses ui_theme_label_0..ui_theme_label_9 and slot-based selection.

- 2026-03-15: First broad page cleanup pass moved reusable page/button defaults toward canonical `ui_base_*` and `ui_sensor_*` tokens. Fans local slot overrides were removed; `pages/light_color-sensecap.yaml` remains the intentional hardcoded-color exemption for now.

