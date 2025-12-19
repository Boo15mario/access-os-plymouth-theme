# Access OS Plymouth Theme

Black-background Plymouth theme with a centered red ring spinner and a white progress bar, applied for boot, shutdown, and reboot.

## Requirements
- Plymouth installed and enabled.
- Root privileges (`sudo`) to install the theme and rebuild initramfs.

## Install
1) From the repo root, run:
```
sudo ./install.sh
```
This copies the theme to `/usr/share/plymouth/themes/access-os-boot`, overlays custom spinner frames (`access-os-boot/assets/`), and runs `plymouth-set-default-theme -R access-os-boot` to rebuild initramfs.

2) Reboot to see the theme.

## Verify Installation
- Check the theme is in initramfs:
```
sudo lsinitrd /boot/initramfs-$(uname -r).img | grep access-os-boot
```
- After boot or shutdown, inspect Plymouth logs for errors:
```
journalctl -b | grep -i plymouth
```

## Updating the Theme
- Edit assets or `access-os-boot/access-os-boot.plymouth` as needed.
- Re-run:
```
sudo ./install.sh
```
- Reboot to apply changes.

## Revert/Uninstall
- Switch back to a stock theme (e.g., spinner):
```
sudo plymouth-set-default-theme -R spinner
```
- Optionally remove installed files:
```
sudo rm -rf /usr/share/plymouth/themes/access-os-boot
```

## Notes
- The theme uses the `two-step` module only; no script plugin is required.
- Spinner frames are `animation-*.png` and `throbber-*.png` in `access-os-boot/assets/`; update both sets if you regenerate visuals.
