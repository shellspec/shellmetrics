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
     1    1  putsn:35 shellmetrics
     1    1  putsn:39 shellmetrics
     4    2  putsn:34 shellmetrics
     9    2  count:46 shellmetrics
     2    1  is_comment_line:59 shellmetrics
     2    2  is_blank_line:64 shellmetrics
     3    1  repeat_string:68 shellmetrics
     3    2  array:74 shellmetrics
     2    1  array_is_empty:81 shellmetrics
     7    2  push_array:86 shellmetrics
    11    3  pop_array:97 shellmetrics
    11    3  shift_array:114 shellmetrics
     8    3  peel:131 shellmetrics
     7    3  pretty:144 shellmetrics
     2    1  process:157 shellmetrics
    67   28  parse:162 shellmetrics
    21    8  analyze:234 shellmetrics
    52    6  report:269 shellmetrics
     3    1  analyze:358 shellmetrics
     1    1  report:359 shellmetrics
     1    1  parse:362 shellmetrics
     1    1  peel:363 shellmetrics
    13    4  main:356 shellmetrics
     4    2  error:377 shellmetrics
     2    1  abort:386 shellmetrics
     1    1  unknown:391 shellmetrics
     1    1  required:392 shellmetrics
     1    1  param:393 shellmetrics
     1    1  params:394 shellmetrics
     2    1  params_:395 shellmetrics
    19   11  parse_options:397 shellmetrics
    48    2  <main> shellmetrics
------------------------------------------------------------------------------
 1 file(s), 33 function(s) analyzed. [bash 4.4.20(1)-release]

==============================================================================
 NLOC    NLOC  LLOC    LLOC    CCN Func File (lines:comment:blank)
total     avg total     avg    avg  cnt
------------------------------------------------------------------------------
  369   11.18   312    9.45   3.03   33 shellmetrics (429:3:57)
------------------------------------------------------------------------------

==============================================================================
 NLOC    NLOC  LLOC    LLOC    CCN Func File    lines comment   blank
total     avg total     avg    avg  cnt  cnt    total   total   total
------------------------------------------------------------------------------
  369   11.18   312    9.45   3.03   33    1        0       0       0
------------------------------------------------------------------------------
```
