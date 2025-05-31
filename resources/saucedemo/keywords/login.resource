*** Settings ***
Documentation                   This file contains keywords that can be used for the login page  
Library                         Browser
Resource                        generic.resource
Resource                        ../variables/login-page.resource
Resource                        ../variables/inventory-page.resource


*** Keywords ***
Fill In Credentials
    [Arguments]    ${username}    ${password}    
    ${username_input}=          Get Element By Test Id            test_id=${USERNAME_TEST_ID}
    ${password_input}=          Get Element By Test Id            test_id=${PASSWORD_TEST_ID}
    Fill Text                   selector=${username_input}        txt=${username}
    Fill Secret                 selector=${password_input}        secret=$password

Click On Login
    Click Element By Test Id    test_id=${LOGIN_BTN_TEST_ID}

Login With Known User
    Fill In Credentials         username=${USERNAME}              password=${PASSWORD}
    Click On Login

Login With Unknown User
    Fill In Credentials         username=unknown                  password=unknown
    Click On Login

Validate Failed Login Attempt
   _Validate Failed Login Attempt By Error Message
   _Validate Failed Login Attempt By Url
   _Validate Failed Login By Seeing The Login Form
   _Validate Failed Login By Not Seeing The Inventory
   
_Validate Failed Login Attempt By Error Message
    Wait For Elements State By Test Id                            test_id=${ERROR_TEST_ID}            state=visible
    ${element}=                 Get Element By Test Id            test_id=${ERROR_TEST_ID}
    ${error_text}=              Get Text                          selector=${element}
    Should Contain              container=${error_text}           item=${ERROR_MESSAGE}

_Validate Failed Login Attempt By Url    
    ${url}=    Get Url
    Should Be Equal            first=${url}                       second=${SAUCEDEMO_URL}

_Validate Failed Login By Seeing The Login Form
    Wait For Elements State By Test Id                            test_id=${USERNAME_TEST_ID}         state=visible 
    Wait For Elements State By Test Id                            test_id=${PASSWORD_TEST_ID}         state=visible  
    Wait For Elements State By Test Id                            test_id=${LOGIN_BTN_TEST_ID}        state=visible
 
 _Validate Failed Login By Not Seeing The Inventory
    Wait For Elements State By Test Id                            test_id=${INV_ITEM_NAME_TEST_ID}         state=detached
     