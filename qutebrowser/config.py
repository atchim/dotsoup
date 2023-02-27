from typing import TYPE_CHECKING, Any

import tomli

if TYPE_CHECKING:
  config = Any

config.load_autoconfig(False)
config.source('bindings.py')

def dict_attrs(obj, path=''):
  if isinstance(obj, dict):
    for k, v in obj.items():
      # WORKAROUND: For settings that requires a `dict` as value.
      if (
        path == 'tabs' and k == 'padding'
        or path == 'url' and k == 'searchengines'
      ):
        yield f'{path}.{k}', v
      else:
        yield from dict_attrs(v, f'{path}.{k}' if path else k)
  else:
    yield path, obj

def set_c():
  with open(config.configdir / 'c.toml', 'rb') as f:
    data = tomli.load(f)

  palette = data['colors'].pop('_palette')

  for k, v in dict_attrs(data):
    if k.startswith('colors.'):
      if isinstance(v, list):
        v = [palette[i] for i in v]
      else:
        v = palette[v]
    config.set(k, v)

set_c()
