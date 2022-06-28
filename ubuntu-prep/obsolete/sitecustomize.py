# this will get imported soon after python starts
# see https://docs.python.org/3/library/site.html
# see `python3 -m site --user-site`

# print('in sitecustomize')

try:
    from devtools import debug
except ImportError:
    pass
else:
    __builtins__['debug'] = debug