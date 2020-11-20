# Git

My default Git config files. 
Contains gitconfig and gitignore. 
Its got a few notable aliases, some of which have dependencies that will be in other dotfile directories.

- `sdiff` and `sdiffc` push diffs into a GUI, once its `bin` dir has been added to `$PATH`.
- `log-export` is nice for creating human readable commit dumps. Could be used to get caught up, assuming commit messages are actually useful.
- `fucking-obliterate` is a nasty function that I've only used to delete large binaries from repositories. Most notably when I was committing frameworks to iOS repositories.
    - `fucking-obliterate-recursive` does the same thing, but to directories.
- `assume`, `unassume`, and `assumed` are all aliases that can be used to create an ignore-changes entry to the index so that certain files aren't considered for changes. 
- `clean-ds` and `clean-orig` are just utility methods to use when `git clean` won't catch certain files because they're already ignored. 
- `branch-prune` deletes all branches that can have been merged into the current branch.
