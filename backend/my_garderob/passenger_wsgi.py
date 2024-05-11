import sys, os

INTERP = os.path.expanduser("/home/users/j/j06249824/my_garderob/venv/bin/python3")

if sys.executable != INTERP: os.execl(INTERP, INTERP, *sys.argv)

from my_garderob.wsgi import application
