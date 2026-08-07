# setup-elvish-action

Sets up the environment for a GitHub action written in Elvish.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/gauntlet/actions/setup-elvish-action@v1
```

## 💡 How it works

1. Call [setup-elvish-context](../setup-elvish-context/README.md), to ensure that **Elvish** is installed.

1. If the `ethereal-version` input is set, such version of [Ethereal](https://github.com/giancosta86/ethereal) will be installed via the [install-elvish-packages](https://github.com/giancosta86/epm-plus/blob/main/actions/install-elvish-packages/README.md) action.

1. If the `gauntlet-version` input is set, such version of [Gauntlet](../../README.md) will be installed via the [install-elvish-packages](https://github.com/giancosta86/epm-plus/blob/main/actions/install-elvish-packages/README.md) action.

1. If the `core-package` input is set, the `core-directory` input must point to an existing directory - and a **symlink** will be created to it in a way that, in **Elvish**, `use <core-package>/<module path>` will actually load a module residing within the directory tree.

   For example, a composite action invoking this action with:

   ```yaml
   core-package: github.com/giancosta86/example
   core-directory: ${{ github.action_path }}/......../my-core
   ```

   can access a **my-module.elv** module in its **my-core** directory via:

   ```elvish
   use github.com/giancosta86/example/my-module
   ```

## 📥 Inputs

|        Name        |    Type    |                      Description                      | Default value |
| :----------------: | :--------: | :---------------------------------------------------: | :-----------: |
|  `elvish-version`  | **string** |               Elvish version to install               |  **0.21.0**   |
| `ethereal-version` | **string** | Ethereal version to install - or empty string to skip |    **v1**     |
| `gauntlet-version` | **string** | Gauntlet version to install - or empty string to skip |    **v1**     |
|   `core-package`   | **string** | Elvish package referencing the core for CI/CD actions |               |
|  `core-directory`  | **string** |    Directory containing the core for CI/CD actions    |               |

## 🌐 Further references

- [setup-elvish-context](../setup-elvish-context/README.md)

- [epm-plus](https://github.com/giancosta86/epm-plus)

- [Ethereal](https://github.com/giancosta86/ethereal)

- [Elvish](https://elv.sh/)

- [gauntlet](../../README.md)
