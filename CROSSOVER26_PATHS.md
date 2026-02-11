# CrossOver 26 Path Baseline

This note captures the verified path differences between:

- host app: `/Applications/CrossOver.app` (CrossOver 26)
- bundled patch payload: `lib/CrossOver` (in this repository)

## Verified host app info

- Bundle ID: `com.codeweavers.CrossOver`
- Version: `26.0`
- Shared support root: `/Applications/CrossOver.app/Contents/SharedSupport/CrossOver`

## Key directory mapping

| Category | Bundled payload path | CrossOver 26 app path | Notes |
| --- | --- | --- | --- |
| GPTK root | `/lib64/apple_gpt` | `/lib64/apple_gptk` | Needs destination remap for v26 |
| DXVK | `/lib/wine/dxvk` and `/lib64/wine/dxvk` | `/lib/dxvk` | v26 moved DXVK out of `wine` |
| Wine tree | `/lib/wine/...` | `/lib/wine/...` | Still valid |
| Main config | `/etc/CrossOver.conf` | `/etc/CrossOver.conf` | Still valid |
| Metadata | `/share/crossover/bottle_data/crossover.inf` | `/share/crossover/bottle_data/crossover.inf` | Still valid |
| Hosted app | `/CrossOver-Hosted Application/wineserver` | `/CrossOver-Hosted Application/wineserver` | Still valid |

## Known compatibility hotspots

1. App version check currently uses a fixed prefix and must allow 26 only.
2. External resource copy/backup paths must target `apple_gptk` in the app.
3. Resource list contains one malformed relative path (`lib/wine/i386-windows/wineboot.exe` missing leading slash).
4. Backup list generation for external resources misses external root in path composition.
5. Some legacy files may not exist in v26 and should be handled as expected missing entries.
