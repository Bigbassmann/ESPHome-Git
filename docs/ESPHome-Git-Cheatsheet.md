# ESPHome Git Cheatsheet

This is a practical checklist for keeping Home1 (production), Home2, and the Laptop repo in sync.

## Quick Map
- Home1 (prod): `\\192.168.158.131\config\esphome`
- Home2 (prod): `\\<HOME2-IP>\config\esphome`
- Laptop repo: `C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git`

## Repo Hygiene (Must Haves)
- `.gitignore` should include: `.esphome/`, `**/.esphome/`, `**/__pycache__/`, `*.pyc`, `*.log`, `*.tmp`, `secrets.yaml`, `secrets.*.yaml`.
- Remove nested `.git` folders inside subprojects unless you truly want submodules.
- Keep `secrets.yaml` local to each Home. Don’t push secrets.

## Golden Rule
Make changes in only one place at a time, then immediately sync to the laptop repo and push to GitHub.

## Source Of Truth
Laptop repo is the source of truth. GitHub is the backup/central copy. Home1/Home2 are deployment targets (not Git repos).

## Standard Flow (Home1 -> Laptop -> GitHub)
1. Make edits in Home1.
2. Copy Home1 to Laptop repo.
3. Commit and push from laptop.

### PowerShell: Sync Home1 to Laptop
```powershell
Copy-Item -Recurse -Force "\\192.168.158.131\config\esphome\*" "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git\"
cd "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git"
git add .
git status -sb
```

### PowerShell: Sync Home1 to Laptop (Robocopy + Excludes)
```powershell
robocopy "\\192.168.158.131\config\esphome" "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git" /MIR /COPY:DAT /DCOPY:DAT /R:2 /W:2 /XJ /XD ".git" ".esphome" "__pycache__" /XF "*.pyc" "*.log" "*.tmp"
cd "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git"
git add .
git status -sb
```
Note: `/MIR` mirrors deletions. If you delete something in Home1, it will be deleted in the laptop repo too.

### PowerShell: Sync Home1 to Laptop (Robocopy Safe / No Deletes)
```powershell
robocopy "\\192.168.158.131\config\esphome" "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git" /E /COPY:DAT /DCOPY:DAT /R:2 /W:2 /XJ /XD ".git" ".esphome" "__pycache__" /XF "*.pyc" "*.log" "*.tmp"
cd "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git"
git add .
git status -sb
```

### Commit + Push
```powershell
git commit -m "Sync from Home1"
git push
```

## Standard Flow (Laptop -> Home1)
1. Make edits on laptop repo.
2. Push to GitHub.
3. Pull on Home1.

### PowerShell: Push from Laptop
```powershell
cd "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git"
git add .
git commit -m "Update from laptop"
git push
```

### PowerShell: Sync Back to Home1 (Pull Latest)
```powershell
cd "\\192.168.158.131\config\esphome"
git pull
```

### PowerShell: Pull to Home1
```powershell
cd "\\192.168.158.131\config\esphome"
git pull
```

### PowerShell: Deploy from Laptop to Home1 (No Git on Home1)
```powershell
robocopy "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git" "\\192.168.158.131\config\esphome" /MIR /COPY:DAT /DCOPY:DAT /R:2 /W:2 /XJ /XD ".git" ".esphome" "__pycache__" /XF "*.pyc" "*.log" "*.tmp" "secrets.yaml" "secrets.*.yaml"
```

### PowerShell: Deploy from Laptop to Home2 (No Git on Home2)
```powershell
robocopy "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git" "\\<HOME2-IP>\config\esphome" /MIR /COPY:DAT /DCOPY:DAT /R:2 /W:2 /XJ /XD ".git" ".esphome" "__pycache__" /XF "*.pyc" "*.log" "*.tmp" "secrets.yaml" "secrets.*.yaml"
```

## Home2 Sync (same pattern)
- Treat Home2 like Home1.
- Never edit Home1 and Home2 at the same time before syncing.

### PowerShell: Sync Home2 to Laptop
```powershell
Copy-Item -Recurse -Force "\\<HOME2-IP>\config\esphome\*" "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git\"
cd "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git"
git add .
git status -sb
```

### PowerShell: Sync Home2 to Laptop (Robocopy + Excludes)
```powershell
robocopy "\\<HOME2-IP>\config\esphome" "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git" /MIR /COPY:DAT /DCOPY:DAT /R:2 /W:2 /XJ /XD ".git" ".esphome" "__pycache__" /XF "*.pyc" "*.log" "*.tmp"
cd "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git"
git add .
git status -sb
```
Note: `/MIR` mirrors deletions. If you delete something in Home2, it will be deleted in the laptop repo too.

### PowerShell: Sync Home2 to Laptop (Robocopy Safe / No Deletes)
```powershell
robocopy "\\<HOME2-IP>\config\esphome" "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git" /E /COPY:DAT /DCOPY:DAT /R:2 /W:2 /XJ /XD ".git" ".esphome" "__pycache__" /XF "*.pyc" "*.log" "*.tmp"
cd "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git"
git add .
git status -sb
```

### PowerShell: Pull to Home2
```powershell
cd "\\<HOME2-IP>\config\esphome"
git pull
```

## Validation Checklist (before pushing)
```powershell
# Optional: validate a single config
esphome config sensecap-d1s.yaml

# Optional: compile
esphome compile sensecap-d1s.yaml
```

## Suggested Working Pattern (Daily)
1. Pull on laptop first (if you’ve been away).
2. Make changes in only one place.
3. Validate.
4. Sync to laptop repo.
5. Commit + push.
6. Pull on the other home(s).

## Quick Diff / Sanity Commands
```powershell
git status -sb
git diff --stat
git log --oneline -5
```

## Line Ending Noise (OneDrive + Windows)
If you keep seeing LF/CRLF warnings:
```powershell
git config --global core.autocrlf true
```

## Restore a File from GitHub (Laptop)
```powershell
git checkout -- path/to/file.yaml
```

## Restore a File from GitHub (Home1/Home2)
```powershell
cd "\\192.168.158.131\config\esphome"
git checkout -- path/to/file.yaml
```

## Process Flow (Text)
1. Edit in one place only.
2. Validate if needed.
3. Sync to laptop repo.
4. Commit + push.
5. Pull to the other homes.

## Flow Chart (Text)
Home1/Home2 edits
  -> Copy to Laptop repo
  -> Commit + Push to GitHub
  -> Pull from GitHub on other Home(s)

## Flow Chart (ASCII)
```text
            +-----------------------+
            |  Edit in ONE place    |
            |  (Home1/Home2/Laptop) |
            +-----------+-----------+
                        |
                        v
            +-----------------------+
            |  Validate (optional)  |
            |  esphome config/comp  |
            +-----------+-----------+
                        |
                        v
            +-----------------------+
            |  Sync to Laptop Repo  |
            |  (Copy-Item or git)   |
            +-----------+-----------+
                        |
                        v
            +-----------------------+
            |  git add/commit/push  |
            +-----------+-----------+
                        |
                        v
            +-----------------------+
            |  Pull on other Homes  |
            +-----------------------+

```

## Common Pitfalls
- Working in two places before syncing leads to conflicts. Always sync before changing another location.
- Nested `.git` folders (submodules) cause `m folder` in `git status`. Remove nested `.git` if you want everything tracked in one repo.
- `__pycache__/` and `.esphome/` showing up means `.gitignore` is missing or not applied. Remove cached files and re-add.
- OneDrive can flip line endings (LF/CRLF) and create noise. Decide on a setting and stick to it.
- `secrets.yaml` is ignored by git. Keep it synced manually per Home.
- If `git status -sb` shows unexpected changes, stop and inspect before pushing.

## Notes
- `secrets.yaml` is ignored by git. Keep secrets synced manually if needed.
- `.esphome/` and `__pycache__/` are ignored.
- If `git status -sb` shows changes you don't expect, stop and review before pushing.

## Future: One-Command Deploy Script (Placeholder)
Save as `deploy-home1.ps1` (edit paths if needed).
```powershell
# Deploy Laptop -> Home1, then (optionally) compile/upload from Home1
$repo = "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git"
$home1 = "\\192.168.158.131\config\esphome"

robocopy $repo $home1 /MIR /COPY:DAT /DCOPY:DAT /R:2 /W:2 /XJ /XD ".git" ".esphome" "__pycache__" /XF "*.pyc" "*.log" "*.tmp" "secrets.yaml" "secrets.*.yaml"

# Optional: run ESPHome from Home1 (requires esphome CLI available there)
# Push-Location $home1
# esphome compile sensecap-d1s.yaml
# esphome upload sensecap-d1s.yaml
# Pop-Location
```

## Manual GitHub Desktop: Promote `dev` to `main`
Use this when you want full manual control and no automated sync/merge.

1. Open GitHub Desktop.
2. Select your ESPHome repo.
3. Confirm current branch is `dev`.
4. Commit all tested changes on `dev`.
5. Click `Push origin` on `dev`.
6. Switch branch to `main`.
7. Click `Fetch origin` then `Pull origin` on `main`.
8. Go to `Branch` -> `Merge into current branch...`.
9. Choose `dev` and complete merge.
10. Review changed files in Desktop.
11. Commit merge (if prompted).
12. Click `Push origin` on `main`.

## Manual Tag After Stable Merge
GitHub Desktop is fine for branch merges, but tagging is most reliable with these manual commands:

```powershell
cd "C:\Users\bigba\OneDrive\Documents\GitHub\ESPHome-Git"
git checkout main
git pull origin main
git tag -a v2026.02.11-stable1 -m "Stable SenseCAP release"
git push origin v2026.02.11-stable1
```

## Quick Verify Before Promote
```powershell
git status -sb
git log --oneline --decorate -n 10
```

If `git status -sb` is not clean, stop and review before merging `dev` into `main`.
