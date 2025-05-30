*** Settings ***
Documentation    This file contains the third test case to code for the spriteCloud automation challenge: Write a validation for a failed log in.
Resource         ../../resources/saucedemo/keywords/allkeywords.resource


*** Test Cases ***
Failed login validation
    Login with unknown user
    Validate failed login attempt

