# bumped-terminal

![Last version](https://img.shields.io/github/tag/bumped/bumped-terminal.svg?style=flat-square)
[![Dependency status](http://img.shields.io/david/bumped/bumped-terminal.svg?style=flat-square)](https://david-dm.org/bumped/bumped-terminal)
[![Dev Dependencies Status](http://img.shields.io/david/dev/bumped/bumped-terminal.svg?style=flat-square)](https://david-dm.org/bumped/bumped-terminal#info=devDependencies)
[![NPM Status](http://img.shields.io/npm/dm/bumped-terminal.svg?style=flat-square)](https://www.npmjs.org/package/bumped-terminal)
[![Donate](https://img.shields.io/badge/donate-paypal-blue.svg?style=flat-square)](https://paypal.me/kikobeats)

> Executes whatever terminal command inside bumped as `prerelease` or `postrelease` action.

## Install

You don't need to install it! Bumped automatically resolve the plugins dependencies. However if you still want to do so must be globally accessible:

```bash
$ npm install -g bumped-terminal
```

## Configuration

Configure your `.bumpedrc` adding a entry for `bumped-terminal` as the follow example:

```cson
files: [
  "package.json"
  "bower.json"
]

plugins:
  postrelease:
    'Task description':
      plugin: 'bumped-terminal'
      command: 'your command'
```

The plugin provide you a serie of keywords for use in your commands as well:

* **$newVersion**: Alias for `bumped._version` (the current semver version).
* **$oldVersion**: Alias for `bumped._oldVersion` (the before semver version).


## Example

```cson
files: [
  "package.json"
  "bower.json"
]
plugins:
  postrelease:
    'Compile browser version':
      plugin: 'bumped-terminal'
      command: 'gulp'

    'Commit the new version':
      plugin: 'bumped-terminal'
      command: 'git add . && git commit -m "$newVersion releases"'

```

which produces the following output:

```bash
$ bumped release patch
success	: Releases version '0.1.4'.

plugin	: bumped-terminal: Compile browser version

[10:46:32] Requiring external module coffee-script/register
[10:46:34] Using gulpfile ~/Projects/errorifier/gulpfile.coffee
[10:46:34] Starting 'default'...
[10:46:34] Starting 'browserify'...
[10:46:34] Finished 'default' after 23 ms
[10:46:34] Finished 'browserify' after 182 ms

plugin	: bumped-terminal: Commit the new version

[master f9be5f3] 0.1.4 releases
 3 files changed, 3 insertions(+), 3 deletions(-)
```

## License

MIT © Bumped
