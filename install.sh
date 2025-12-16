#!/usr/bin/env bash
set -euo pipefail

# Install the Access OS BGRT theme and set it as default.

theme_name="access-bgrt"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
src_dir="${script_dir}/${theme_name}"
dst_dir="/usr/share/plymouth/themes/${theme_name}"
assets_dst="${dst_dir}/assets"
spinner_src="/usr/share/plymouth/themes/spinner"

if [[ ! -d "${src_dir}" ]]; then
  echo "Theme sources not found at ${src_dir}" >&2
  exit 1
fi

sudo mkdir -p "${assets_dst}"

# Copy neutral spinner assets, then swap the watermark to the firmware logo if available.
sudo cp -a "${spinner_src}/." "${assets_dst}/"
sudo rm -f "${assets_dst}/watermark.png"
# Override spinner frames with our custom circle animation.
sudo cp -a "${src_dir}/assets/." "${assets_dst}/"

sudo install -m 644 "${src_dir}/${theme_name}.plymouth" "${dst_dir}/${theme_name}.plymouth"
sudo plymouth-set-default-theme -R "${theme_name}"

echo "Installed ${theme_name} to ${dst_dir} with firmware logo watermark and set as default."
