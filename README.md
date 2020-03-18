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
     1    1  putsn:32 ./shellmetrics
     1    1  putsn:36 ./shellmetrics
     4    2  putsn:31 ./shellmetrics
     5    2  count:43 ./shellmetrics
     3    1  repeat_string:52 ./shellmetrics
     3    2  array:58 ./shellmetrics
     2    1  array_is_empty:65 ./shellmetrics
     7    2  push_array:70 ./shellmetrics
    11    3  pop_array:81 ./shellmetrics
    11    3  shift_array:98 ./shellmetrics
     8    3  peel:115 ./shellmetrics
     7    3  pretty:128 ./shellmetrics
     2    1  process:141 ./shellmetrics
     1    1  lex:146 ./shellmetrics
    57   23  parse:150 ./shellmetrics
    21    8  analyze:217 ./shellmetrics
    46    6  report:252 ./shellmetrics
     3    1  analyze:326 ./shellmetrics
     1    1  report:327 ./shellmetrics
     9    3  main:324 ./shellmetrics
     4    2  error:338 ./shellmetrics
     2    1  abort:347 ./shellmetrics
     1    1  unknown:352 ./shellmetrics
     1    1  required:353 ./shellmetrics
     1    1  param:354 ./shellmetrics
     1    1  params:355 ./shellmetrics
     2    1  params_:356 ./shellmetrics
    18   11  parse_options:358 ./shellmetrics
    46    2  <main> ./shellmetrics
------------------------------------------------------------------------------
 1 file(s), 31 function(s) analyzed. [bash 4.4.20(1)-release]

==============================================================================
  SLOC     LLOC      LLOC     CCN   Func   File
 total    total       avg     avg    cnt
------------------------------------------------------------------------------
   389      281      9.06    2.93     31   ./shellmetrics
------------------------------------------------------------------------------

==============================================================================
  SLOC     LLOC      LLOC     CCN   Func   File
 total    total       avg     avg    cnt    cnt
------------------------------------------------------------------------------
   389      281      9.06    2.93     31      1
------------------------------------------------------------------------------
```
