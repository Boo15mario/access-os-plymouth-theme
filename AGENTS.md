# Repository Guidelines

## Project Structure & Module Organization
- Root: `install.sh` installs the Plymouth theme to `/usr/share/plymouth/themes/access-bgrt` and rebuilds the initramfs.
- Theme: `access-bgrt/` holds `access-bgrt.plymouth` (two-step config), custom spinner assets in `access-bgrt/assets/` (animation-*/throbber-* ring frames), and any supporting files.
- System install path (after running install): `/usr/share/plymouth/themes/access-bgrt/` mirrors the theme directory; avoid editing live files directly—edit the repo and reinstall.

## Build, Test, and Development Commands
- `sudo ./install.sh` — copies assets/config to `/usr/share/plymouth/themes/access-bgrt` and runs `plymouth-set-default-theme -R access-bgrt` to rebuild initramfs.
- Optional check: `sudo lsinitrd /boot/initramfs-$(uname -r).img | grep access-bgrt` — verify assets/config landed in initramfs.
- Optional log check: `journalctl -b | grep -i plymouth` — inspect Plymouth messages after boot/shutdown.

## Coding Style & Naming Conventions
- Shell: `bash`, `set -euo pipefail`. Prefer clear, quoted vars and explicit paths.
- Assets: PNG files named `animation-####.png` and `throbber-####.png` (zero-padded) under `access-bgrt/assets/`.
- Colors: Hex ARGB in `.plymouth` (e.g., `0x000000` for black).

## Testing Guidelines
- No automated tests. Validate visually by rebooting and watching boot/shutdown/reboot screens.
- Confirm progress bar visibility on shutdown and reboot (UseProgressBar=true in `[shutdown]` and `[reboot]`).

## Commit & Pull Request Guidelines
- Use concise, descriptive commit messages (e.g., `Use ring spinner for shutdown`, `Set black background`).
- Include what changed, why, and any manual validation steps (e.g., “Rebooted; spinner visible on shutdown”).
- If updating assets, mention the files regenerated (e.g., `throbber-*.png`) and the intended visual result.

## Security & Configuration Tips
- Running `install.sh` requires sudo; inspect changes before running.
- Keep `plymouth-plugin-script` installed only if reintroducing script-based themes; current setup uses `two-step` only.
