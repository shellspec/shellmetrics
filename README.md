# ShellMetrics

ShellMetrics is Cyclomatic Complexity Analyzer for shell script.

[![Travis CI](https://img.shields.io/travis/com/shellspec/shellmetrics/master.svg?label=TravisCI&style=flat-square)](https://travis-ci.com/shellspec/shellmetrics)
[![Coveralls](https://img.shields.io/coveralls/github/shellspec/shellmetrics.svg?label=Coveralls&style=flat-square)](https://coveralls.io/github/shellspec/shellmetrics?branch=master)

## Requirements

ShellMetrics is written by shell script.
One of the following shells is required: `bash`, `mksh`, `yash`, `zsh`

## Installation

```sh
curl -fsSL https://git.io/shellmetrics > ~/bin/shellmetrics
chmod +x ~/bin/shellmetrics
```

or

```sh
wget https://git.io/shellmetrics -O ~/bin/shellmetrics
chmod +x ~/bin/shellmetrics
```

## Usage

```
Usage: shellmetrics [options] files...

  -s, --shell           The path of shell to use as parser [default: bash]
                          Supported shells: bash, mksh, yash, zsh
      --[no-]color      Enable / Disable color [default: enabled]
      --csv             Generate CSV output
  -p, --pretty          Format pretty with wrapper function(s)
  -d, --debug           Display parsed data for debug instead of report
  -v, --version         Display the version
  -h, --help            You're looking at it
```

Metric values vary slightly depending on the shell used.

## Example

ShellMetrics self metrics.

- NLOC - Non-comment Lines of Code
- LLOC - Logical Lines of Code
- CCN - Cyclomatic Complexity number

```console
$ shellmetrics ./shellmetrics
==============================================================================
  LLOC  CCN  Location
------------------------------------------------------------------------------
     1    1  usage:9 shellmetrics
     1    1  proxy:35 shellmetrics
     1    1  putsn:40 shellmetrics
     1    1  putsn:44 shellmetrics
     4    2  putsn:39 shellmetrics
     9    2  count:51 shellmetrics
     2    1  is_comment_line:64 shellmetrics
     2    2  is_blank_line:69 shellmetrics
     3    1  repeat_string:73 shellmetrics
     3    2  array:79 shellmetrics
     2    1  array_is_empty:86 shellmetrics
     7    2  push_array:91 shellmetrics
    11    3  pop_array:102 shellmetrics
    11    3  shift_array:119 shellmetrics
     8    3  peel:136 shellmetrics
     7    3  pretty:149 shellmetrics
     2    1  process:162 shellmetrics
    65   27  parse:167 shellmetrics
    21    8  analyze:238 shellmetrics
    56    6  default_report:274 shellmetrics
    10    4  csv_report:372 shellmetrics
     3    1  title:389 shellmetrics
     9    5  init_mode:395 shellmetrics
     9    2  main:412 shellmetrics
     4    2  error:426 shellmetrics
     2    1  abort:435 shellmetrics
     1    1  unknown:440 shellmetrics
     1    1  required:441 shellmetrics
     1    1  param:442 shellmetrics
     1    1  params:443 shellmetrics
     2    1  params_:444 shellmetrics
    20   12  parse_options:446 shellmetrics
    52    2  <main> shellmetrics
------------------------------------------------------------------------------
 1 file(s), 33 function(s) analyzed. [bash 4.4.20(1)-release]

==============================================================================
 NLOC    NLOC  LLOC    LLOC    CCN Func File (lines:comment:blank)
total     avg total     avg    avg  cnt
------------------------------------------------------------------------------
  412   12.48   332   10.06   3.18   33 shellmetrics (479:5:62)
------------------------------------------------------------------------------

==============================================================================
 NLOC    NLOC  LLOC    LLOC    CCN Func File    lines comment   blank
total     avg total     avg    avg  cnt  cnt    total   total   total
------------------------------------------------------------------------------
  412   12.48   332   10.06   3.18   33    1      479       5      62
------------------------------------------------------------------------------
```
