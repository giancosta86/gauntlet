# setup-elvish-context

Installs the **Elvish** shell and a set of core libraries.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/gauntlet/actions/setup-elvish-context@v1
```

## 💡 How it works

1. If the `elvish` command is **not** already available in the system, the requested `version` will be installed.

1. Ensures that the `github.com/giancosta86/aurora-github` library is a _symlink_ to the `core` directory in the **aurora-github** project.

1. If the `ethereal-version` input is set, such version of [Ethereal](https://github.com/giancosta86/ethereal) will be installed via the [install-elvish-packages](../install-elvish-packages/README.md) action.

1. If the `gauntlet-version` input is set, such version of [Gauntlet](../../README.md) will be installed via the [install-elvish-packages](https://github.com/giancosta86/epm-plus/blob/main/actions/install-elvish-packages/README.md) action.

1. If the `core-directory` input is set and points to an existing directory, create a _symlink_ to such a directory in a way that, in **Elvish** `use` declarations, `github.com/<full repository name>/<module path>` actually points to a module residing within such **core** directory tree.

## 📥 Inputs

|        Name        |    Type    |                      Description                      | Default value |
| :----------------: | :--------: | :---------------------------------------------------: | :-----------: |
|     `version`      | **string** |               Elvish version to install               |  **0.21.0**   |
| `ethereal-version` | **string** | Ethereal version to install - or empty string to skip |    **v1**     |
| `gauntlet-version` | **string** | Gauntlet version to install - or empty string to skip |    **v1**     |
|  `core-directory`  | **string** |    Directory containing the core for CI/CD actions    |   **core**    |

## 🌐 Further references

- [epm-plus](https://github.com/giancosta86/epm-plus)

- [Ethereal](https://github.com/giancosta86/ethereal)

- [Elvish](https://elv.sh/)

- [gauntlet](../../README.md)
