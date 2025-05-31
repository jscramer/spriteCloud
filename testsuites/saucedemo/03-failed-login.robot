*** Settings ***
Documentation       This file contains the third test case to code for the spriteCloud automation challenge: Write a validation for a failed log in.

Resource            ../../resources/saucedemo/keywords/allkeywords.resource


*** Test Cases ***
Failed Login Validation
    [Documentation]    Try to login with an unknown user and validate that the login attempt was unsuccesful
    Login With Unknown User
    Validate Failed Login Attempt
