# Options
c.auto_save.session = True
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
c.editor.command = ["kitty", "nvim", "{file}"];
c.statusbar.show = "in-mode"
c.tabs.show = "multiple"
# Keybinds
## Tabs
config.bind('<Ctrl+Shift+Left>', 'tab-prev')
config.bind('<Ctrl+Shift+Right>', 'tab-next')
config.bind('<Ctrl+t>', 'cmd-set-text -s :open -t')
config.bind('<Ctrl+Shift+t>', 'open -t')
config.bind('<Ctrl+f>', 'cmd-set-text /')
config.bind('a', 'mode-enter insert')
config.bind('U', 'back')
## Visual mode arrows
config.bind('Up', 'move-to-prev-line', mode='caret')
config.bind('Down', 'move-to-next-line', mode='caret')
config.bind('Left', 'move-to-prev-char', mode='caret')
config.bind('Right', 'move-to-next-char', mode='caret')
# Autoconfig
config.load_autoconfig(False)
