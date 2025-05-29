# Options
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
# Keybinds
## Tabs
config.bind('<Ctrl+Shift+Left>', 'tab-prev')
config.bind('<Ctrl+Shift+Right>', 'tab-next')
config.bind('<Ctrl+t>', 'cmd-set-text -s :open -t')
config.bind('<Ctrl+Shift+t>', 'open -t')
config.bind('<Ctrl+f>', 'cmd-set-text /')
## WASD
config.bind('w', 'scroll up')
config.bind('a', 'scroll left')
config.bind('s', 'scroll down')
config.bind('d', 'scroll right')
## Visual mode WASD
config.bind('w', 'move-to-prev-line', mode='caret')
config.bind('a', 'move-to-prev-char', mode='caret')
config.bind('s', 'move-to-next-line', mode='caret')
config.bind('d', 'move-to-next-char', mode='caret')
## Visual mode arrows
config.bind('Up', 'move-to-prev-line', mode='caret')
config.bind('Down', 'move-to-next-line', mode='caret')
config.bind('Left', 'move-to-prev-char', mode='caret')
config.bind('Right', 'move-to-next-char', mode='caret')
# Autoconfig
config.load_autoconfig(False)
