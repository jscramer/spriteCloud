*** Settings ***
Documentation    This file contains the second test case to code for the spriteCloud automation challenge: Write a test that sorts the items by name Z-A and validate that the sorting is correct.
Resource         ../../resources/saucedemo/keywords/allkeywords.resource


*** Test Cases ***
Sort items by name Z-A
    Login with known user   
    Sort products            sort_type=Name (Z to A)
    Validate sorting         sort_type=Name (Z to A)

Sort items by name A-Z
    Login with known user   
    Sort products            sort_type=Name (A to Z)
    Validate sorting         sort_type=Name (A to Z)