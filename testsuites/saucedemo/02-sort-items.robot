*** Settings ***
Documentation    This file contains the second test case to code for the spriteCloud automation challenge: Write a test that sorts the items by name Z-A and validate that the sorting is correct.
Resource         ../../resources/saucedemo/keywords/allkeywords.resource


*** Test Cases ***
Sort Items By Name Z-A
    [Documentation]    Sort the products by name from Z-A and validate afterwards
    Login With Known User   
    Sort Products            sort_type=Name (Z to A)
    Validate Sorting         sort_type=Name (Z to A)

Sort Items By Name A-Z
    [Documentation]    Sort the products by name from A-Z and validate afterwards
    Login With Known User   
    Sort Products            sort_type=Name (A to Z)
    Validate Sorting         sort_type=Name (A to Z)
