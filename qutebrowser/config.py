#
# Sopa de Mamaco's Palette
#

p = [
  '#080808',
  '#0c0c0c',
  '#121212',
  '#1a1a1a',
  '#252525',
  '#383838',
  '#5a5a5a',
  '#959595',
  '#ff5b5b',
  '#bc8f05',
  '#54a900',
  '#00ad2b',
  '#00a7a7',
  '#6b90ff',
  '#ba74ff',
  '#fc4ad0',
]

#
# Colors
#

c.colors.completion.category.bg = p[1]
c.colors.completion.category.fg = p[7]
c.colors.completion.category.border.bottom = p[1]
c.colors.completion.category.border.top = p[1]
c.colors.completion.even.bg = p[0]
c.colors.completion.fg = [p[7], p[6], p[10]]
c.colors.completion.item.selected.bg = p[2]
c.colors.completion.item.selected.border.bottom = p[2]
c.colors.completion.item.selected.border.top = p[2]
c.colors.completion.item.selected.fg = p[7]
c.colors.completion.item.selected.match.fg = p[10]
c.colors.completion.match.fg = p[14]
c.colors.completion.odd.bg = p[0]
c.colors.completion.scrollbar.bg = p[0]
c.colors.completion.scrollbar.fg = p[4]

c.colors.contextmenu.disabled.bg = p[0]
c.colors.contextmenu.disabled.fg = p[6]
c.colors.contextmenu.menu.bg = p[0]
c.colors.contextmenu.menu.fg = p[7]
c.colors.contextmenu.selected.bg = p[1]
c.colors.contextmenu.selected.fg = p[7]

c.colors.downloads.bar.bg = p[0]
c.colors.downloads.start.fg = p[0]
c.colors.downloads.start.bg = p[10]
c.colors.downloads.stop.fg = p[0]
c.colors.downloads.stop.bg = p[11]
c.colors.downloads.error.fg = p[0]
c.colors.downloads.error.bg = p[8]

c.colors.hints.bg = p[14]
c.colors.hints.fg = p[0]
c.colors.hints.match.fg = p[6]

c.colors.keyhint.bg = p[0]
c.colors.keyhint.fg = p[7]
c.colors.keyhint.suffix.fg = p[10]

c.colors.messages.error.bg = p[8]
c.colors.messages.error.border = p[8]
c.colors.messages.error.fg = p[0]
c.colors.messages.info.bg = p[11]
c.colors.messages.info.border = p[11]
c.colors.messages.info.fg = p[0]
c.colors.messages.warning.bg = p[10]
c.colors.messages.warning.border = p[10]
c.colors.messages.warning.fg = p[0]

c.colors.prompts.bg = p[0]
c.colors.prompts.border = p[0]
c.colors.prompts.fg = p[7]
c.colors.prompts.selected.bg = p[1]

c.colors.statusbar.caret.bg = p[0]
c.colors.statusbar.caret.fg = p[7]
c.colors.statusbar.caret.selection.bg = p[0]
c.colors.statusbar.caret.selection.fg = p[7]
c.colors.statusbar.command.bg = p[0]
c.colors.statusbar.command.fg = p[7]
c.colors.statusbar.command.private.bg = p[0]
c.colors.statusbar.command.private.fg = p[7]
c.colors.statusbar.insert.bg = p[0]
c.colors.statusbar.insert.fg = p[7]
c.colors.statusbar.normal.bg = p[0]
c.colors.statusbar.normal.fg = p[7]
c.colors.statusbar.passthrough.bg = p[0]
c.colors.statusbar.passthrough.fg = p[7]
c.colors.statusbar.private.bg = p[0]
c.colors.statusbar.private.fg = p[6]
c.colors.statusbar.progress.bg = p[7]
c.colors.statusbar.url.error.fg = p[8]
c.colors.statusbar.url.fg = p[7]
c.colors.statusbar.url.hover.fg = p[14]
c.colors.statusbar.url.success.http.fg = p[7]
c.colors.statusbar.url.success.https.fg = p[11]
c.colors.statusbar.url.warn.fg = p[10]

c.colors.tabs.bar.bg = p[1]
c.colors.tabs.even.bg = p[0]
c.colors.tabs.even.fg = p[6]
c.colors.tabs.indicator.error = p[8]
c.colors.tabs.indicator.start = p[10]
c.colors.tabs.indicator.stop = p[11]
c.colors.tabs.odd.bg = p[0]
c.colors.tabs.odd.fg = p[6]
c.colors.tabs.pinned.even.bg = p[1]
c.colors.tabs.pinned.even.fg = p[6]
c.colors.tabs.pinned.odd.bg = p[1]
c.colors.tabs.pinned.odd.fg = p[6]
c.colors.tabs.pinned.selected.even.bg = p[0]
c.colors.tabs.pinned.selected.even.fg = p[7]
c.colors.tabs.pinned.selected.odd.bg = p[0]
c.colors.tabs.pinned.selected.odd.fg = p[7]
c.colors.tabs.selected.even.bg = p[0]
c.colors.tabs.selected.even.fg = p[7]
c.colors.tabs.selected.odd.bg = p[0]
c.colors.tabs.selected.odd.fg = p[7]

#
# Completion
#

c.completion.cmd_history_max_items = 128
c.completion.scrollbar.padding = 0
c.completion.scrollbar.width = 16
c.completion.shrink = True

#
# Downloads
#

c.downloads.location.directory = '~/dl'
c.downloads.location.prompt = False
c.downloads.location.remember = False
c.downloads.location.suggestion = 'filename'
c.downloads.position = 'bottom'
c.downloads.remove_finished = 0

#
# Hints
#

c.hints.border = '0px solid'
c.hints.radius = 0

#
# Misc
#

c.auto_save.session = True
c.fonts.default_family = 'Hack'
c.keyhint.radius = 0
c.prompt.radius = 0

#
# Tabs
#

c.tabs.new_position.unrelated = 'next'
c.tabs.padding = {'bottom': 0, 'left': 0, 'right': 0, 'top': 0}
c.tabs.position = 'left'
c.tabs.select_on_remove = 'last-used'
c.tabs.show = 'never'
c.tabs.show_switching_delay = 500
c.tabs.title.format = '{audio}{index} {current_title}'
c.tabs.width = 64

#
# URL
#

c.url.default_page = 'https://www.google.com'
c.url.searchengines = {
  'DEFAULT': 'https://google.com/search?q={}',
  'a': 'https://wiki.archlinux.org/index.php?search={}',
  'd': 'https://duckduckgo.com/?q={}',
  'g': 'https://www.google.com/search?q={}',
  'gh': 'https://github.com/search?q={}',
  'gt': 'https://translate.google.com/?text={}',
  'w': 'https://wikipedia.org/w/index.php?search={}',
  'y': 'https://www.youtube.com/results?search_query={}',
  'zu': 'http://gpo.zugaina.org/Search?search={}',
}
c.url.start_pages = 'https://www.google.com'

#
# Bottom
#

config.load_autoconfig(False)
