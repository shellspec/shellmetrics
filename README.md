# shellmetrics

**Project Status: alpha** (Not well tested).

Shellmetrics is Cyclomatic Complexity Analyzer for shell script.

## Requirements

Shellmetrics is written by shell script. It works with **bash** or **zsh**.

## Usage

```
Usage: shellmetrics [options] files...

  -d, --debug
  -h, --help
  -v, --version
```

## Example

Shellmetrics self metrics.

```console
$ shellmetrics ./shellmetrics
======================================================================
  LLOC  CCN  Location
----------------------------------------------------------------------
     1    1  usage:7 ./shellmetrics
     5    2  count:22 ./shellmetrics
     3    1  repeat_string:31 ./shellmetrics
     3    2  array:37 ./shellmetrics
     2    1  array_is_empty:44 ./shellmetrics
     9    4  push_array:49 ./shellmetrics
    12    3  pop_array:63 ./shellmetrics
    12    3  shift_array:80 ./shellmetrics
     8    3  peel:97 ./shellmetrics
     7    3  pretty:110 ./shellmetrics
     1    1  lex:123 ./shellmetrics
    39   20  parse:127 ./shellmetrics
    20    8  analyze:192 ./shellmetrics
    42    6  report:226 ./shellmetrics
     2    1  abort:296 ./shellmetrics
     1    1  unknown:297 ./shellmetrics
     1    1  required:298 ./shellmetrics
     1    1  param:299 ./shellmetrics
     1    1  params:300 ./shellmetrics
     2    1  params_:301 ./shellmetrics
    14    8  parse_options:305 ./shellmetrics
     7    2  <main> ./shellmetrics
----------------------------------------------------------------------
1 file analyzed.

======================================================================
  SLOC     LLOC      LLOC     CCN   Func   File
 total    total       avg     avg    cnt
----------------------------------------------------------------------
   337      193      8.77    3.36     22   ./shellmetrics
----------------------------------------------------------------------

======================================================================
  SLOC     LLOC      LLOC     CCN   Func   File
 total    total       avg     avg    cnt    cnt
----------------------------------------------------------------------
   337      193      8.77    3.36     22      1
----------------------------------------------------------------------
```