# config.nu
#
# Installed by:
# version = "0.102.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

# set standard editor
$env.config.buffer_editor = "code"

# remove welcome message
$env.config.show_banner = false

# aliases (windows)

alias update = pwsh -command "scoop list | foreach { scoop update $_.Name }"
alias install = scoop install
alias remove = scoop uninstall
alias list = scoop list
alias ff = fastfetch
