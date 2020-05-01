# shellcheck shell=sh disable=SC2016,SC2034

Include ./shellmetrics

Describe "proxy()"
  bar() { echo "bar"; }
  It "proxies function"
    When call proxy foo bar
    The result of "foo()" should eq "bar"
  End
End

Describe "mark()"
  Parameters
    "foo()"             "foo_L$MARK()"
    "foo ()"            "foo_L$MARK ()"
    "function foo"      "function foo_L$MARK"
    "function foo()"    "function foo_L$MARK()"
    "nofunction foo"    "nofunction foo"
    "echo function foo" "echo function foo"
    "echo;function foo" "echo;function foo_L$MARK"
    "a=()"              "a=()"
    "<()"               "<()"
    ">()"               ">()"
    "@()"               "@()"
    "!()"               "!()"
    "*()"               "*()"
    "?()"               "?()"
    "+()"               "+()"
    " ()"               " ()"
    "echo; ()"          "echo; ()"
    "echo | ()"         "echo | ()"
    "echo & ()"         "echo & ()"
    "f()();function g"  "f_L$MARK()();function g_L$MARK"
  End

  _mark() { echo "$1" | mark "$MARK"; }

  It "marks tag for line number"
    When call _mark "$1"
    The output should eq "$2"
  End
End

Describe "putsn()"
  It "puts string"
    When call putsn "test"
    The output should eq "test"
  End

  Context "when shell is mksh"
    Before ': "${KSH_VERSION:=MIRBSD}"'
    print() { echo "print command:" "$@"; }

    It "puts string using print command"
      When call putsn "test"
      The output should eq "print command: -r -- test"
    End
  End
End

Describe "count()"
  Data
  #|line1 # comment
  #|
  #|# comment
  #|        line2
  #|
  #|  line3
  #|  # comment
  #|line4    word
  #|
  #|line5
  End
  BeforeCall 'INDENT="  "'
  It "counts lines and max indent"
    When call count lines comment_lines blank_lines max_indent
    The variable lines should eq 10
    The variable comment_lines should eq 2
    The variable blank_lines should eq 3
    The variable max_indent should eq 4
  End
End

Describe "is_comment_line()"
  Parameters
    "# comment"           success
    "   # comment"        success
    " $TAB  # comment"    success
    "    "                failure
    "  code # comment  "  failure
  End

  It "detects comment line ($1)"
    When call is_comment_line "$1"
    The status should be "$2"
  End
End

Describe "is_blank_line()"
  Parameters
    ""          success
    " "         success
    "$TAB"      success
    " code "    failure
  End

  It "detects blank line ($1)"
    When call is_blank_line "$1"
    The status should be "$2"
  End
End

Describe "repeat_string()"
  Before var=""
  It "repeats string"
    When call repeat_string var 3 "abc"
    The variable var should eq "abcabcabc"
  End
End

Describe "array"
  Describe "array()"
    It "initializes array"
      When call array st1 st2
      The variable st1_array should eq 0-0
      The variable st2_array should eq 0-0
    End
  End

  Describe "push_array()"
    Before setup
    Context 'when array is empty'
      setup() {
        array st1 st2
        st1="test'" st2='test"'
      }

      It "pushes to array"
        When call push_array st1 st2
        The variable st1_array_0 should eq "test'"
        The variable st1_array_last should eq "test'"
        The variable st2_array_0 should eq 'test"'
        The variable st2_array_last should eq 'test"'
      End
    End

    Context 'when array is not empty'
      setup() {
        array st1 st2
        st1=1 st2=2
        push_array st1 st2
        st1=3 st2=4
      }

      It "pushes to array"
        When call push_array st1 st2
        The variable st1_array_0 should eq 1
        The variable st1_array_1 should eq 3
        The variable st1_array_last should eq 3
        The variable st2_array_0 should eq 2
        The variable st2_array_1 should eq 4
        The variable st2_array_last should eq 4
      End
    End
  End

  Describe "pop_array()"
    Before setup

    Context "when one variable arrayed"
      setup() {
        array st1 st2
        st1="test'" st2='test"'
        push_array st1 st2
        st1="1" st2="2"
      }

      It "pops from array"
        When call pop_array st1 st2
        The variable st1 should eq "test'"
        The variable st1_array_last should be undefined
        The variable st2 should eq 'test"'
        The variable st2_array_last should be undefined
      End
    End

    Context "when two variable arrayed"
      setup() {
        array st1 st2

        st1="test'" st2='test"'
        push_array st1 st2

        st1="test2'" st2='test2"'
        push_array st1 st2

        st1="1" st2="2"
      }

      It "pops from array"
        When call pop_array st1 st2
        The variable st1 should eq "test2'"
        The variable st1_array_last should eq "test'"
        The variable st2 should eq 'test2"'
        The variable st2_array_last should eq 'test"'
      End
    End
  End

  Describe "shift_array()"
    Before setup

    Context "when one variable arrayed"
      setup() {
        array st1 st2
        st1="test'" st2='test"'
        push_array st1 st2
        st1="1" st2="2"
      }

      It "shifts from array"
        When call shift_array st1 st2
        The variable st1 should eq "test'"
        The variable st1_array_last should be undefined
        The variable st2 should eq 'test"'
        The variable st2_array_last should be undefined
      End
    End

    Context "when two variable arrayed"
      setup() {
        array st1 st2

        st1="test'" st2='test"'
        push_array st1 st2

        st1="test2'" st2='test2"'
        push_array st1 st2

        st1="1" st2="2"
      }

      It "shifts from array"
        When call shift_array st1 st2
        The variable st1 should eq "test'"
        The variable st1_array_last should eq "test2'"
        The variable st2 should eq 'test"'
        The variable st2_array_last should eq 'test2"'
      End
    End
  End
End

Describe "is_empty_file()"
  Context "when file is empty"
    Data:expand
      #|#!/bin/sh
      #|  #
      #|$TAB#
    End

    It "checks file is empty"
      When call is_empty_file
      The status should be success
    End
  End

  Context "when file is not empty"
    Data:expand
      #|#!/bin/sh
      #|  #
      #|$TAB#
      #| :
    End

    It "checks file is not empty"
      When call is_empty_file
      The status should be failure
    End
  End
End

Describe "peel()"
  Context "when bash format"
    Data
      #|func()
      #|{
      #|  func()
      #|  {
      #|    line
      #|  }
      #|}
    End

    It "peels wrapper functions"
      When call peel 2
      The output should eq "    line"
    End
  End

  Context "when zsh format"
    Data
      #|func() {
      #|  func() {
      #|    line
      #|  }
      #|}
    End

    It "peels wrapper functions"
      When call peel 2
      The output should eq "    line"
    End
  End
End

Describe "analyze()"
  _analyze() { process 10 | analyze "$@" ; }

  Example
    Data
      #|foo
      #|bar
    End

    When call _analyze file
    The line 2 of output should eq "2 1 <main> file"
  End

  Example
    Data
      #|if cond; then
      #|  :
      #|elif cond; then
      #|  :
      #|else
      #|  :
      #|fi
    End

    When call _analyze file
    The line 2 of output should eq "5 3 <main> file"
  End

  Example
    Data
      #|for i; do
      #|  :
      #|  :
      #|done
    End

    When call _analyze file
    The line 2 of output should eq "3 2 <main> file"
  End

  Example
    Data
      #|while code; do
      #|  :
      #|  :
      #|done
    End

    When call _analyze file
    The line 2 of output should eq "3 2 <main> file"
  End

  Example
    Data
      #|case $var in
      #|  a) : ;;
      #|  b) ;;
      #|esac
    End

    When call _analyze file
    The line 2 of output should eq "2 3 <main> file"
  End

  Example
    Data
      #|case $var in
      #|  a) : ;;
      #|  b) ;;
      #|  *) ;;
      #|esac
    End

    When call _analyze file
    The line 2 of output should eq "2 3 <main> file"
  End

  Example
    Data
      #|case $var in
      #|  a) : ;;
      #|  b) ;;
      #|  *) : ;;
      #|esac
    End

    When call _analyze file
    The line 2 of output should eq "3 3 <main> file"
  End

  Example
    Data
      #|cat <<HERE
      #|for i; do
      #|  :
      #|done
      #|HERE
    End

    When call _analyze file
    The line 2 of output should eq "1 1 <main> file"
  End

  Example
    Data
      #|:
      #|foo() {
      #|    if cond; then :; fi
      #|    if cond; then :; fi
      #|    bar() {
      #|        if cond; then :; fi
      #|    }
      #|    if cond; then :; fi
      #|}
      #|:
    End

    When call _analyze file
    The line 2 of output should eq "2 2 bar:5 file"
    The line 3 of output should eq "7 4 foo:2 file"
    The line 4 of output should eq "3 1 <main> file"
  End
End

Describe "default_report()"
  Data
    #|0 0 <begin> script1.sh|123:1:2
    #|1 7 func1:10 script1.sh
    #|2 11 func2:20 script1.sh
    #|3 13 func3:30 script1.sh
    #|0 0 <end> script1.sh|123:1:2
    #|0 0 <begin> script2.sh|456:10:20
    #|4 17 func4:40 script2.sh
    #|5 19 func5:50 script2.sh
    #|6 23 func6:60 script2.sh
    #|7 29 func7:70 script2.sh
    #|8 31 func8:80 script2.sh
    #|0 0 <end> script2.sh|456:10:20
  End

  result() {
    %text
    #|==============================================================================
    #|  LLOC  CCN  Location
    #|------------------------------------------------------------------------------
    #|     1    7  func1:10 script1.sh
    #|     2   11  func2:20 script1.sh
    #|     3   13  func3:30 script1.sh
    #|     4   17  func4:40 script2.sh
    #|     5   19  func5:50 script2.sh
    #|     6   23  func6:60 script2.sh
    #|     7   29  func7:70 script2.sh
    #|     8   31  func8:80 script2.sh
    #|------------------------------------------------------------------------------
    #| 2 file(s), 8 function(s) analyzed. [shell-version]
    #|
    #|==============================================================================
    #| NLOC    NLOC  LLOC    LLOC    CCN Func File (lines:comment:blank)
    #|total     avg total     avg    avg  cnt
    #|------------------------------------------------------------------------------
    #|  120   40.00     6    2.00  10.33    3 script1.sh (123:1:2)
    #|  426   85.20    30    6.00  23.80    5 script2.sh (456:10:20)
    #|------------------------------------------------------------------------------
    #|
    #|==============================================================================
    #| NLOC    NLOC  LLOC    LLOC    CCN Func File    lines comment   blank
    #|total     avg total     avg    avg  cnt  cnt    total   total   total
    #|------------------------------------------------------------------------------
    #|  546   68.25    36    4.50  18.75    8    2      579      11      22
    #|------------------------------------------------------------------------------
  }

  BeforeCall "SHELL_VERSION=shell-version"

  Example
    When call default_report
    The output should eq "$(result)"
  End
End

Describe "csv_report()"
  Data
    #|0 0 <begin> script1.sh|123:1:2
    #|1 7 func1:10 script1.sh
    #|2 11 func2:20 script1.sh
    #|3 13 func3:30 script1.sh
    #|0 0 <end> script1.sh|123:1:2
    #|0 0 <begin> script2.sh|456:10:20
    #|4 17 func4:40 script2.sh
    #|5 19 func5:50 script2.sh
    #|6 23 func6:60 script2.sh
    #|7 29 func7:70 script2.sh
    #|8 31 func8:80 script2.sh
    #|0 0 <end> script2.sh|456:10:20
  End

  result() {
    %text
    #|file,func,lineno,lloc,ccn,lines,comment,blank
    #|"script1.sh","<begin>",0,0,0,123,1,2
    #|"script1.sh","func1",10,1,7,0,0,0
    #|"script1.sh","func2",20,2,11,0,0,0
    #|"script1.sh","func3",30,3,13,0,0,0
    #|"script1.sh","<end>",0,0,0,123,1,2
    #|"script2.sh","<begin>",0,0,0,456,10,20
    #|"script2.sh","func4",40,4,17,0,0,0
    #|"script2.sh","func5",50,5,19,0,0,0
    #|"script2.sh","func6",60,6,23,0,0,0
    #|"script2.sh","func7",70,7,29,0,0,0
    #|"script2.sh","func8",80,8,31,0,0,0
    #|"script2.sh","<end>",0,0,0,456,10,20
  }

  Example
    When call csv_report
    The output should eq "$(result)"
  End
End

Describe "init_mode()"
  default_report() { echo "default_report"; }
  csv_report() { echo "csv_report"; }
  title() { echo "title"; }
  cat() { echo "cat $#"; }

  It "initializes as default mode"
    When call init_mode "default"
    The result of "report()" should eq "default_report"
  End

  It "initializes as csv mode"
    When call init_mode "csv"
    The result of "report()" should eq "csv_report"
  End

  It "initializes as debug mode"
    When call init_mode "debug"
    The result of "analyze()" should eq "title"
    The result of "report()" should eq "cat 0"
  End

  It "initializes as pretty mode"
    When call init_mode "pretty"
    The result of "analyze()" should eq "title"
    The result of "report()" should eq "cat 0"
    The result of "parse()" should eq "cat 0"
    The result of "peel()" should eq "cat 0"
  End
End

Describe "main()"
  It "parsers --shell"
    When call main debug spec/dummy.sh
    The line 1 of output should eq '[spec/dummy.sh]'
    The line 2 of output should start with '  0|*  |'
    The line 2 of output should include 'echo ok'
  End
End

Describe "parse_options()"
  It "parsers --shell"
    BeforeCall SH=''
    When call parse_options --shell sh
    The variable SH should eq sh
  End

  It "parsers --color"
    BeforeCall COLOR=''
    When call parse_options --color
    The variable COLOR should eq 1
  End

  It "parsers --color"
    BeforeCall COLOR=1
    When call parse_options --no-color
    The variable COLOR should eq ''
  End

  It "parsers --csv"
    BeforeCall MODE=''
    When call parse_options --csv
    The variable MODE should eq "csv"
  End

  It "parsers --pretty"
    BeforeCall MODE=''
    When call parse_options --pretty
    The variable MODE should eq "pretty"
  End

  It "parsers --debug"
    BeforeCall MODE=''
    When call parse_options --debug
    The variable MODE should eq "debug"
  End

  It "parsers operands"
    _parse_options() {
      parse_options --color a -- -b
      eval "set -- $PARAMS"
      echo "$@"
    }
    When call _parse_options --color a -- -b
    The output should eq "a -b"
  End
End

Describe "./shellmetrics"
  Describe "--shell"
    It "outputs version"
      When run script ./shellmetrics --shell spec/fake-shell.sh
      The output should eq "fake-shell"
    End

    It "outputs error when specified not shell"
      When run script ./shellmetrics --shell /bin/echo
      The error should eq "It seems not a shell."
      The status should be failure
    End

    It "outputs error when specified path not found"
      When run script ./shellmetrics --shell /shellmetrics/no-such-a-file
      The error should eq "'/shellmetrics/no-such-a-file' not found."
      The status should be failure
    End
  End

  Describe "--version"
    It "outputs version"
      When run script ./shellmetrics --version
      The output should eq "$VERSION"
    End
  End

  Describe "--help"
    It "outputs usage"
      When run script ./shellmetrics --help
      The output should include "Usage"
    End
  End

  Describe "--unknown"
    It "outputs error"
      When run script ./shellmetrics --unknown
      The error should include "Unrecognized option '--unknown'"
      The status should be failure
    End

    It "outputs error with color"
      When run script ./shellmetrics --color --unknown
      The error should include "Unrecognized option '--unknown'"
      The status should be failure
    End
  End

  Describe "main"
    Intercept main

    Context "when unsupported shell"
      __main__() {
        main() { echo "ran main"; }
      }

      It "runs main function"
        When run source ./shellmetrics --shell -
        The output should eq "ran main"
      End
    End

    Context "when unsupported shell"
      __main__() {
        main() { echo "ran main"; }
        SHELL_VERSION=''
      }

      It "outputs error"
        When run source ./shellmetrics --shell -
        The error should eq "Unsupported shell."
        The status should be failure
      End
    End
  End
End
