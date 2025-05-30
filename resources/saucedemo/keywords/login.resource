*** Settings ***
Documentation                   This file contains keywords that can be used for the login page  
Library                         Browser
Resource                        generic.resource
Resource                        ../variables/login-page.resource


*** Keywords ***
Fill in credentials
    [Arguments]    ${username}    ${password}    
    ${username_input}=          Get element by test id    test_id=${USERNAME_TEST_ID}    
    ${password_input}=          Get element by test id    test_id=${PASSWORD_TEST_ID}
    Fill Text                   selector=${username_input}        txt=${username}
    Fill Secret                 selector=${password_input}        secret=$password

Click on login
    Click element by test id    test_id=${LOGIN_BTN_TEST_ID}


Login with known user
    Fill in credentials         username=${USERNAME}             password=${PASSWORD}
    Click on login

Login with unknown user
    Fill in credentials         username=unknown                 password=unknown
    Click on login