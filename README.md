# Termux Setup

To rebuild your Termux setup, modify the [setup-configs.sh](./assets/setup-configs.sh) script as needed. Then, run the following command inside this folder:

```bash
# Almost all configurations are automatic, but some steps may require manual input.
bash build.sh --no-dbg
```

This script will:
- Update Termux packages
- Install necessary packages
- Set up:
  - Neovim (with all configurations)
  - Appearance
  - Font
  - Scripts folder
  - Git
  - And more
