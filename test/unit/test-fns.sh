#!/bin/zsh
# -*- shell-script -*-

# Test _Dbg_is_function
test_is_function()
{
    _Dbg_is_function 
    assertFalse 'No function given; is_function should report false' $? 

    typeset fn
    fn=$(declare -f function_test >/dev/null 2>&1)
    [[ -n "$fn" ]] && unset -f function_test
    _Dbg_is_function function_test
    assertFalse 'function_test should not be defined' $? 

    typeset -i function_test=1
    _Dbg_is_function function_test
    assertFalse 'test_function should still not be defined' "$?"

    function_test() { :; }
    _Dbg_is_function function_test
    assertTrue 'test_function should now be defined' "$?"

    function another_function_test { :; }
    _Dbg_is_function another_function_test "$?"

    _function_test() { :; }
    _Dbg_is_function _function_test
    assertFalse 'fn _function_test is system fn; is_function should report false' $? 

    _Dbg_is_function _function_test 1 
    assertTrue 'fn _function_test is system fn which we want; should report true' $? 
}

# Test _Dbg_set_dol_q
test_set_q()
{
    _Dbg_set_dol_q 1 
    assertFalse '$? should have been set to 1==false' $? 
    _Dbg_set_dol_q 0 
    assertTrue '$? should have been set to 0==true' $? 
#     # Test without giving a parameter
#     local _Ddg_debugged_exit_code=0
#     _Dbg_set_dol_q 
#     assertTrue '$? should be set true via _Dbg_debugged_exit_code' $? 
#     _Ddg_debugged_exit_code=1
#     _Dbg_set_dol_q
#     assertFalse '$? should be set false via _Dbg_debugged_exit_code' $? 
}

# Test _Dbg_split
test_split()
{
    typeset -a words
    _Dbg_split 'foo.c:5' ':'
    assertEquals 'foo.c' ${split_result[1]}
    assertEquals '5' ${split_result[2]}
}

typeset src_dir=${src_dir:-'../../'}
. $src_dir/lib/fns.inc

# load shunit2
set -o shwordsplit
SHUNIT_PARENT=$0

. ./shunit2

