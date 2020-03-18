# shellmetrics

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
  -p, --pretty          Format pretty with wrapper function(s)
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
     1    1  __:3 ./shellmetrics
     1    1  usage:9 ./shellmetrics
     1    1  putsn:33 ./shellmetrics
     1    1  putsn:37 ./shellmetrics
     4    2  putsn:32 ./shellmetrics
     6    2  count:44 ./shellmetrics
     3    1  repeat_string:54 ./shellmetrics
     3    2  array:60 ./shellmetrics
     2    1  array_is_empty:67 ./shellmetrics
     7    2  push_array:72 ./shellmetrics
    11    3  pop_array:83 ./shellmetrics
    11    3  shift_array:100 ./shellmetrics
     8    3  peel:117 ./shellmetrics
     7    3  pretty:130 ./shellmetrics
     2    1  process:143 ./shellmetrics
    57   23  parse:148 ./shellmetrics
    21    8  analyze:215 ./shellmetrics
    46    6  report:250 ./shellmetrics
     3    1  analyze:324 ./shellmetrics
     1    1  report:325 ./shellmetrics
     1    1  parse:328 ./shellmetrics
     1    1  peel:329 ./shellmetrics
    12    4  main:322 ./shellmetrics
     4    2  error:341 ./shellmetrics
     2    1  abort:350 ./shellmetrics
     1    1  unknown:355 ./shellmetrics
     1    1  required:356 ./shellmetrics
     1    1  param:357 ./shellmetrics
     1    1  params:358 ./shellmetrics
     2    1  params_:359 ./shellmetrics
    19   12  parse_options:361 ./shellmetrics
    45    2  <main> ./shellmetrics
------------------------------------------------------------------------------
 1 file(s), 32 function(s) analyzed. [bash 4.4.20(1)-release]

==============================================================================
  SLOC     LLOC      LLOC     CCN   Func   File
 total    total       avg     avg    cnt
------------------------------------------------------------------------------
   393      286      8.93    2.93     32   ./shellmetrics
------------------------------------------------------------------------------

==============================================================================
  SLOC     LLOC      LLOC     CCN   Func   File
 total    total       avg     avg    cnt    cnt
------------------------------------------------------------------------------
   393      286      8.93    2.93     32      1
------------------------------------------------------------------------------
```
