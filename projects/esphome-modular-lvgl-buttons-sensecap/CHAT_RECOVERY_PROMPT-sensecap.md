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

- 2026-03-15: First broad page cleanup pass moved reusable page/button defaults toward canonical `ui_base_*` and `ui_sensor_*` tokens. Shared page, fan, sensor, thermostat, per-entity family defaults, and active nav/template/static-style fallbacks now use generic `theme_*` IDs instead of `dani_*` IDs where cleaned. Runtime theme slots 0..9 now use slot-scoped `theme_slot*` IDs instead of direct `sense_*`/`dani_*`/`split_*` refs inside the theme engine. Theme change also repaints the three stateful home tiles (`Dani`, `Sleepy`, `Bedtime`) from centralized runtime logic. `pages/light_color-sensecap.yaml` is retained as an archived-style reference page but is no longer included in the active build. Active dimmer buttons no longer long-press into that retired page flow.
- 2026-03-15: Archived unused legacy non-`-sensecap` dimmer pages (`pages/lighting_dimmers_grid_template.yaml`, `pages/lighting_dimmers_grid.yaml`, `pages/lighting_dimmers_grid_2.yaml`) to `archive/retired_baseline_2026-03-15/pages/`. Active dimmer pages still come from `pages/lighting_dimmers_grid_template-sensecap.yaml` through `common/package_instance_mapping-sensecap-dani.yaml`.
- 2026-03-15: Archived `common/core_boot-sensecap.yaml` to `archive/retired_baseline_2026-03-15/common/`. It was inactive, still depended on old upstream boot globals/page IDs, and has been superseded by `pages/loading_480px-sensecap.yaml` plus `common/display_runtime-sensecap.yaml` in the active fork.
- Theme runtime refresh: centralized runtime repaint remains enabled for the three home tiles (`Dani`, `Sleepy`, `Bedtime`). Fans, Overrides, and Dimmers now follow theme changes through shared LVGL style bindings (`page_style`, `sense_display_row_btn_style`, `sense_nav_btn_style`, `sense_menu_cat*`) instead of page-level repaint scripts; local page/button logic updates only state text, icon/value content, and slider state where needed.
- Thermostat internals now follow shared theme text styles (`sense_text_title_style`, `sense_text_primary_style`, `sense_text_muted_style`). Thermostat mode dropdowns now use shared themed control styling, and the arc knob follows the same local mode accent as the indicator.
- Home page slot wiring is normalized through generic `page0_slot*` aliases and generic slot/tile IDs in the active home page and centralized theme-refresh path. Behavior is unchanged; naming/model is now page/slot-first instead of entity-name-first.















- Fixed the backing `current_theme` selector in `theme_style-sensecap-dani.yaml` so it now exposes `ui_theme_label_0..9`; the Display dropdown and the actual theme selector now advertise the same 10 themes.

- Restored `theme_style-sensecap-dani.yaml` from the provided copy and expanded the backing `current_theme` selector to `ui_theme_label_0..9` so the Display dropdown and selector stay aligned.
