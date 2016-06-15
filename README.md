# Un-Unicode
This package builds a small executable that, given an input file and an output
destination, converts all unicode-characters to their TeX equivalents!

## Motivation
I often write notes and math in Markdown, and I use a bunch of unicode characters,
which work really well with MathJax. However, LaTeX is far from always happy
with these characters, and this has bitten me more than once! Therefore, I wrote
this small utility to help me out in converting my markdown to TeX.


## Building
`cabal install`
You might need to postfix `-f-systemencoding`. I had to, on Windows 7, to make
the `encoding` package work.

## Usage
`ununicode input_file output_file`