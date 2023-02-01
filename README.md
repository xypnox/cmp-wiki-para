# cmp-vimwiki-tags

Nvim cmp source for Vimwiki para. 

```
[[these-kindof-links]]
```

## Setup

```lua
require'cmp'.setup {
  sources = {
    { name = 'vimwiki-para' }
  }
}
```

## Requirements

This plugin allows users to insert links from a vault directory that has a bunch of files with `name.md`.

This will allow user to insert links such as [[name]] inside any file.

Currently the only supported folder is:

```
{UserHome}/notes/vault
```

## To Add

- [ ] Link Navigation
- [ ] Backlinks [:?]
