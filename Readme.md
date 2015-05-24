# Vim Ticard

Work with trello cards from vim.

## Requirements

- [Ticard](https://github.com/dgsuarez/ticard)
- [Pandoc](http://pandoc.org/) (Optional)

## Usage

- `:Ticard pull URL` will download the contents of the Trello card in URL into
a new buffer
- `:Ticard push` will push the changes in the current buffer to Trello

## Options

If `pandoc` is found, it will be used to make sure that the markdown in the
buffer is correctly interpreted by Trello (i.e. it'll unwrap lines since
Trello's markdown doesn't respect the spec for new lines). As a side effect
all the document is then presented as processed by pandoc. If you want to
disable this simply `let g:ticard_pandoc_disabled = 1`


