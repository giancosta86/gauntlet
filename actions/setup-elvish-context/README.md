# setup-elvish-context

Installs the **Elvish** shell.

## 🃏 Example

```yaml
steps:
  - uses: giancosta86/gauntlet/actions/setup-elvish-context@v1
```

## 💡 How it works

If the `elvish` command is **not** already available in the system, the requested `version` will be installed.

## 📥 Inputs

|   Name    |    Type    |        Description        | Default value |
| :-------: | :--------: | :-----------------------: | :-----------: |
| `version` | **string** | Elvish version to install |  **0.21.0**   |

## 🌐 Further references

- [Elvish](https://elv.sh/)

- [gauntlet](../../README.md)
