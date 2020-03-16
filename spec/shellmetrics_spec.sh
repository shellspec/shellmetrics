Include ./shellmetrics

Describe "count()"
  Data
  #|line1
  #|        line2
  #|  line3
  #|line4    word
  End

  It "counts lines and max indent"
    When call count lines max_indent
    The variable lines should eq 4
    The variable max_indent should eq 8
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
        The value "$st1_array_0" should eq "test'"
        The value "$st1_array_last" should eq "test'"
        The value "$st2_array_0" should eq 'test"'
        The value "$st2_array_last" should eq 'test"'
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

    Describe "when value is specified"
      setup() {
        array st1 st2
        st1=1 st2=2
      }
      It "pushes to array specified value"
        When call push_array st1:"test'" st2:'test"'
        The value "$st1_array_0" should eq "test'"
        The value "$st2_array_0" should eq 'test"'
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
        The value "$st1" should eq "test'"
        The variable st1_array_last should be undefined
        The value "$st2" should eq 'test"'
        The variable st2_array_last should be undefined
      End
    End

    Describe "when variable is specified"
      setup() {
        array st1 st2
        st1="test'" st2='test"'
        push_array st1 st2
        st1="1" st2="2"
      }

      It "pops from array to variable"
        When call pop_array st1:v1 st2:
        The variable v1 should eq "test'"
        The variable st1_array_last should be undefined
        The variable st2_array_last should be undefined
        The value "$st1" should eq 1
        The value "$st2" should eq 2
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
        The value "$st1" should eq "test2'"
        The variable st1_array_last should eq "test'"
        The value "$st2" should eq 'test2"'
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
        The value "$st1" should eq "test'"
        The variable st1_array_last should be undefined
        The value "$st2" should eq 'test"'
        The variable st2_array_last should be undefined
      End
    End

    Describe "when variable is specified"
      setup() {
        array st1 st2
        st1="test'" st2='test"'
        push_array st1 st2
        st1="1" st2="2"
      }

      It "shifts from array to variable"
        When call shift_array st1:v1 st2:
        The variable v1 should eq "test'"
        The variable st1_array_last should be undefined
        The variable st2_array_last should be undefined
        The value "$st1" should eq 1
        The value "$st2" should eq 2
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
        The value "$st1" should eq "test'"
        The variable st1_array_last should eq "test2'"
        The value "$st2" should eq 'test"'
        The variable st2_array_last should eq 'test2"'
      End
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
