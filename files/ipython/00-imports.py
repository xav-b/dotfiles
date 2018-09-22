# -*- coding: utf-8 -*-

"""Pre-load useful (built-in) modules into ipython."""


def echo(msg, level='INFO'):
    print('[ init ] {level} - {msg}'.format(level=level, msg=msg))


print('\n\n\t\t... custom code loading ...\n\n')


import logging

import datetime as dt  # noqa
echo('`logging` imported as `dt`')

from pprint import pprint as pp  # noqa
echo('`pprint` imported as `pp` (pretty printer)')

try:
    import better_exceptions  # noqa
    echo('module `better_exceptions` successfully hooked in the interpreter')
except ImportError:
    echo('`better_exceptions` import failed, moving on...', level='WARN')

try:
    import pandas as pd  # noqa
    echo('`pandas` imported as `pd`')
except ImportError:
    echo('`pandas` import failed, moving on...', level='WARN')


logger = logging.getLogger(__name__)
echo('logger ready as `logger`')


# TODO put in in 01-utils.py
def kk():
    echo('exporting `kk()` -> kill ipdb process')
    import os
    # http://stackoverflow.com/questions/32055062/exiting-python-debugger-ipdb
    os._exit(0)


print('\n\n\t\t... custom code done ...\n\n')
