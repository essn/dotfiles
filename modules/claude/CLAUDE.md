# Global Claude Preferences

## Style

- Be concise. Skip preamble and filler.
- Don't add comments, docstrings, or type annotations to code you didn't change.
- Prefer simple, direct solutions over abstractions.
- Ask before making structural changes that go beyond the stated task.

## Shell

`rm` is shimmed to `rimraf` via mise. It prompts interactively and dies with `ERR_USE_AFTER_CLOSE` in non-interactive shells — use `/bin/rm`.

## Commits

Write commit messages as a human developer would — describe what the code change does, not how you produced it.
