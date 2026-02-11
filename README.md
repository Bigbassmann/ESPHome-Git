# ESPHome-Git

This repo is the source of truth for ESPHome configs. GitHub is the backup/central copy.

## Structure
```
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
