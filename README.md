# shellmetrics

**Project Status: alpha** (Not well tested).

Shellmetrics is Cyclomatic Complexity Analyzer for shell script.

## Requirements

Shellmetrics is written by shell script.
It works with **bash**, **mksh**, **yash** or **zsh**.

## Usage

```
Usage: shellmetrics [options] files...

  -s, --shell           The path of shell to use as parser [default: bash]
                          Supported shells: bash, mksh, yash, zsh
      --[no-]color      Enable / Disable color [default: enabled]
  -d, --debug           Display parsed data for debug instead of report
  -v, --version         Display the version
  -h, --help            You're looking at it
```

Metric values ​​vary slightly depending on the shell used.

## Example

Shellmetrics self metrics.

```console
$ shellmetrics ./shellmetrics
==============================================================================
  LLOC  CCN  Location
------------------------------------------------------------------------------
     1    1  usage:7 ./shellmetrics
     5    2  count:36 ./shellmetrics
     3    1  repeat_string:45 ./shellmetrics
     3    2  array:51 ./shellmetrics
     2    1  array_is_empty:58 ./shellmetrics
     7    2  push_array:63 ./shellmetrics
    11    3  pop_array:74 ./shellmetrics
    11    3  shift_array:91 ./shellmetrics
     8    3  peel:108 ./shellmetrics
     7    3  pretty:121 ./shellmetrics
     1    1  lex:134 ./shellmetrics
    46   25  parse:138 ./shellmetrics
    21    8  analyze:211 ./shellmetrics
    49    6  report:246 ./shellmetrics
     3    2  error:322 ./shellmetrics
     2    1  abort:330 ./shellmetrics
     1    1  unknown:335 ./shellmetrics
     1    1  required:336 ./shellmetrics
     1    1  param:337 ./shellmetrics
     1    1  params:338 ./shellmetrics
     2    1  params_:339 ./shellmetrics
    18   11  parse_options:341 ./shellmetrics
     7    2  <main> ./shellmetrics
------------------------------------------------------------------------------
 1 file(s), 23 function(s) analyzed. [bash 4.4.20(1)-release]

==============================================================================
  SLOC     LLOC      LLOC     CCN   Func   File
 total    total       avg     avg    cnt
------------------------------------------------------------------------------
   382      211      9.17    3.56     23   ./shellmetrics
------------------------------------------------------------------------------

==============================================================================
  SLOC     LLOC      LLOC     CCN   Func   File
 total    total       avg     avg    cnt    cnt
------------------------------------------------------------------------------
   382      211      9.17    3.56     23      1
------------------------------------------------------------------------------
```
