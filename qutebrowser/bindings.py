from typing import Any, TYPE_CHECKING
if TYPE_CHECKING:
  config = Any

# Tab Switching
config.bind("<Ctrl+Tab>", "tab-focus stack-prev")
config.bind("<Ctrl+Shift+Tab>", "tab-focus stack-next")

# Zoom
config.unbind("+")
config.bind("z=", "zoom-in")
config.unbind("-")
config.bind("z-", "zoom-out")
config.unbind("=")
config.bind("zz", "zoom")

# Misc
config.bind('tt', 'set-cmd-text -s :tab-take')
