# docker-dev

Note:

xvfb.py could be used to test gui applications headless, for example:
```
xvfb.py xeyes # or whatever GUI application
```

Ref:
https://chromium.googlesource.com/chromium/src/+/refs/tags/86.0.4198.2/testing/xvfb.py

development dependency for pre-commit and commitlint
```
pre-commit install
pre-commit install --hook-type commit-msg
npm install
```
