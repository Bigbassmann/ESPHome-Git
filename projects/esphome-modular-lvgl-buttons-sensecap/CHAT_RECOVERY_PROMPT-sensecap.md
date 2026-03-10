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
5. /config/esphome/esphome-modular-lvgl-buttons/sensecap-d1s-v2-001-dani.yaml
6. /config/esphome/esphome-modular-lvgl-buttons/common/ha_entities-sensecap.yaml
7. /config/esphome/esphome-modular-lvgl-buttons/common/ha_entities-sensecap-dani.yaml
8. /config/esphome/esphome-modular-lvgl-buttons/common/color-sensecap.yaml
9. /config/esphome/esphome-modular-lvgl-buttons/common/color-sensecap-dani.yaml
10. /config/esphome/esphome-modular-lvgl-buttons/common/page_mapping-sensecap.yaml
11. /config/esphome/esphome-modular-lvgl-buttons/common/core_ha_common-sensecap.yaml
12. /config/esphome/esphome-modular-lvgl-buttons/pages/home_grid-sensecap.yaml
13. /config/esphome/esphome-modular-lvgl-buttons/pages/overrides_grid-sensecap.yaml
14. /config/esphome/esphome-modular-lvgl-buttons/pages/lighting_dimmers_grid_template-sensecap.yaml
15. /config/esphome/esphome-modular-lvgl-buttons/pages/fans_grid-sensecap.yaml
16. /config/esphome/esphome-modular-lvgl-buttons/pages/thermostat_v2_lvgl-sensecap.yaml
17. /config/esphome/esphome-modular-lvgl-buttons/pages/page_shell_480-sensecap.yaml
18. /config/esphome/esphome-modular-lvgl-buttons/pages/loading_480px-sensecap.yaml

Then:
- Give a short "state + drift risks + next 3 actions" summary.
- Execute only the first approved action unless I tell you to do more.

Current task to continue:
<PASTE CURRENT TASK HERE>
```
