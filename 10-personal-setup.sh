#!/usr/bin/env bash
#--------------------------------------------------------------------------
#  Personal Settings
#--------------------------------------------------------------------------


HOMEDIR="${HOME}"
CODELAB="${HOME}/CodeLab"
DOTREPO="${HOME}/CodeLab/Dotfiles"
BASHDIR="${HOME}/CodeLab/BashRC"
MOZDIR="ee2kdll2.default"

# TESTING
# HOMEDIR="${HOME}/FAKEHOME"
# CODELAB="${HOME}/FAKEHOME/CodeLab"
# DOTREPO="${HOME}/CodeLab/Dotfiles"
# BASHDIR="${HOME}/CodeLab/BashRC"


#--------------------------------------------------------------------------

# Create home directories
HOMEDIRS=(
        'Archive'
        'Archive/Documents'
        'CodeLab'
        'Desktop'
        'Downloads'
        'Safeties'
        '.cache'
        '.config'
        '.fonts'
        '.local'
        '.local/share/applications'
        '.local/share/icons'
        '.local/share/themes'
        '.mozilla/firefox/ee2kdll2.default/chrome'
        '.vscode'
)

echo "Creating home directories"
echo
for name in "${HOMEDIRS[@]}"; do
    mkdir -p ${HOMEDIR}/${name}
done

#--------------------------------------------------------------------------

# Create .config subfolders
CFGDIRS=(
        'autostart'
        'Code'
        'Hyper'
        'nemo'
        'neofetch'
        'theme-override'
        'variety'
        'xfce4'
)

echo "Creating .config subfolders"
echo
for name in "${CFGDIRS[@]}"; do
    mkdir -p ${HOMEDIR}/.config/${name}
done

#--------------------------------------------------------------------------

# Backup the XFCE config folder in case mine isn't fully compatible

if [[ -d "${HOME}/.config/xfce4" ]]; then
    cp -a "${HOME}/.config/xfce4/." "${HOMEDIR}/Safeties/xfce4";
fi

#--------------------------------------------------------------------------

echo "Copying .config files"
echo

cp -a "${DOTREPO}/.config/autostart/." "${HOMEDIR}/.config/autostart/"
cp -a "${DOTREPO}/.config/Code/." "${HOMEDIR}/.config/Code/"
cp -a "${DOTREPO}/.config/Hyper/." "${HOMEDIR}/.config/Hyper/"
cp -a "${DOTREPO}/.config/neofetch/." "${HOMEDIR}/.config/neofetch/"
cp -a "${DOTREPO}/.config/nemo/." "${HOMEDIR}/.config/nemo/"
cp -a "${DOTREPO}/.config/theme-override/." "${HOMEDIR}/.config/theme-override/"
cp -a "${DOTREPO}/.config/variety/." "${HOMEDIR}/.config/variety/"
cp -a "${DOTREPO}/.config/xfce4/." "${HOMEDIR}/.config/xfce4/"

#--------------------------------------------------------------------------

echo "Copying application launchers: .local/share/applications"
echo
cp -a "${DOTREPO}/.local/share/applications/." "${HOMEDIR}/.local/share/applications/"

echo "Copying icons: .local/share/icons"
echo
cp -a "${DOTREPO}/.local/share/icons/." "${HOMEDIR}/.local/share/icons/"

echo "Copying themes: .local/share/themes"
echo
cp -a "${DOTREPO}/.local/share/themes/." "${HOMEDIR}/.local/share/themes/"

#--------------------------------------------------------------------------

echo "Copying VSCode settings"
echo
cp -a "${DOTREPO}/.vscode/." "${HOMEDIR}/.vscode/"

#--------------------------------------------------------------------------

echo "Copying Hyper terminal settings"
echo
cp -a "${DOTREPO}/.hyper_plugins/." "${HOMEDIR}/.hyper_plugins/"

#--------------------------------------------------------------------------

echo "Copying dotfiles"
echo
cp "${BASHDIR}/.bashrc" "${HOMEDIR}/.bashrc";
cp "${BASHDIR}/.bash_profile" "${HOMEDIR}/.bash_profile";
cp "${DOTREPO}/.conkyrc" "${HOMEDIR}/.conkyrc";
cp "${DOTREPO}/.conkyrc-owm" "${HOMEDIR}/.conkyrc-owm";
cp "${DOTREPO}/.hyper.js" "${HOMEDIR}/.hyper.js";

#--------------------------------------------------------------------------

echo "Copying Firefox CSS"
echo
cp -a "${DOTREPO}/.mozilla/firefox/${MOZDIR}/chrome/." "${HOMEDIR}/.mozilla/firefox/${MOZDIR}/chrome/"

#--------------------------------------------------------------------------

echo "Copying fonts"
echo
cp -a "${DOTREPO}/.fonts/." "${HOMEDIR}/.fonts/"

#--------------------------------------------------------------------------

# Run Hardcode Fixer

echo "Running Hardcode Fixer"
echo

cd ${CODELAB}/hardcode-fixer
chmod +x fix.sh
sudo ./fix.sh

echo
echo "Done!"
