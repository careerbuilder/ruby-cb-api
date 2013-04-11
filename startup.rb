## This file is loaded by irb -r
## So, setup any necessary configuration variables / executables here

## Remove previous gem installation
`rm -rf pkg/`

## Install local source code as gem
`rake install`

require 'Cb'
Cb.configuration.dev_key = "WDHH6P96RQD9FSDCZ0G7"

## more configuration options to follow...