# Code style

## Shell script

- Don't use quotes on RHS of variable assignment statement.
- Use `cmd <<< "str"` over `echo "str" | cmd`.
- Use curl over wget. Remember to use `-L` with curl to follow redirects.
- Pipe directly when possible e.g. `curl | tar -Jxvf -` or `curl | bash -`.
- Use `$''` over `''`, `$''` over `""` when possible, and `""` over unquoted when expanding.
- Use `apt` over `apt-get`, and `add-apt-repository` over `apt-add-repository`.
- Silence `pushd` and `popd` with `> /dev/null`.
- Run scripts with `set -Eeuxo pipefail` and `shopt -s nullglob`, where:
  - `-E` ensures ERR trap is fired when exiting due to `-e`.
  - `-e` exits when a command fails.
  - `-u` treats using unset variables as errors.
  - `-x` prints commands as they are run, with expanded arguments.
  - `-o pipefail` treats failures at any command of a pipeline as a failure of the entire pipeline, instead of just the last command.
  - `nullglob` means glob patterns that don't resolve to any files are expanded to nothing rather than remaining unexpanded.
- Use `$HOME` over `~`.
- Put all shell profile commands in `.zshenv`, not `.bashrc`, `.zshrc`, `.profile`, `.bash_profile`, or `.zprofile`.
