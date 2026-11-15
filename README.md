# switch-gh

Switches GitHub accounts for the `gh` CLI and for git. It keeps a list of
accounts in `~/.config/switch-gh/accounts.json` and flips the active one.
`gh` itself stores the credentials, one per account, so no tokens are
copied anywhere.

## Install

```bash
curl -fsSL https://raw.githubusercontent.com/nomaraba/switch-gh/main/setup.sh | sh
# or: wget -qO- https://raw.githubusercontent.com/nomaraba/switch-gh/main/setup.sh | sh
```

## Usage

```bash
switch-gh setup            # log in the first account and record it
switch-gh add              # log in another account and record it
switch-gh <username>       # switch gh and git to that account
switch-gh list             # show tracked accounts and the active one
switch-gh remove <user>    # forget an account (logs it out of gh)
switch-gh docs             # view this documentation
```

## Setup and add

Both run `gh auth login`, the standard interactive flow of the `gh`
CLI: pick GitHub.com, pick a protocol, authenticate in the browser.
When it finishes, `switch-gh` reads the account back with `gh api user`
and asks for the git `user.name` and `user.email` to use for commits.
The default email is the account's public email if it has one,
otherwise the noreply address GitHub provides.

Logging in a second account also makes it active, same as `gh` does.

## Switch

```bash
switch-gh <username>
```

Runs `gh auth switch` so `gh` commands use that account, then sets
`user.name` / `user.email` globally so commits carry that identity.
The git credential helper points at `gh`, so pushes also use the
active account's token.

A repository with its own `user.name` or `user.email` in `.git/config`
overrides the global identity. `switch-gh` warns when it sees that in
the current repo, because that is how commits end up with the wrong
author.

## Remove

Asks for confirmation (or takes `--yes`), runs `gh auth logout` for the
account, and drops it from the config. If it was the active one,
`switch-gh` switches to another tracked account.

## Notes

- `GH_TOKEN` or `GITHUB_TOKEN` set in the environment makes `gh` ignore
  stored accounts entirely. `switch-gh` refuses to switch while one is
  set, instead of switching silently.
- The config file holds usernames and git identities only, and can
  be edited by hand.
- Tokens live in `gh`'s own storage; `gh auth status` shows them.

## Files

| Path                               | Purpose                          |
| ---------------------------------- | -------------------------------- |
| `~/.config/switch-gh/accounts.json` | account list and active account |

## Author

Kasaki Nomaraba
<https://github.com/nomaraba>
