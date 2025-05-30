*** Settings ***
Documentation                   This file contains keywords that can be used for the login page  
Library                         Browser
Resource                        generic.resource
Resource                        ../variables/login-page.resource
Resource                        ../variables/inventory-page.resource


*** Keywords ***
Fill in credentials
    [Arguments]    ${username}    ${password}    
    ${username_input}=          Get element by test id            test_id=${USERNAME_TEST_ID}    
    ${password_input}=          Get element by test id            test_id=${PASSWORD_TEST_ID}
    Fill Text                   selector=${username_input}        txt=${username}
    Fill Secret                 selector=${password_input}        secret=$password

Click on login
    Click element by test id    test_id=${LOGIN_BTN_TEST_ID}


Login with known user
    Fill in credentials         username=${USERNAME}              password=${PASSWORD}
    Click on login

Login with unknown user
    Fill in credentials         username=unknown                  password=unknown
    Click on login

Validate failed login attempt
   _Validate failed login attempt by error message
   _Validate failed login attempt by url
   _Validate failed login by seeing the login form
   _Validate failed login by not seeing the inventory
   

_Validate failed login attempt by error message
    Wait for elements state by test id                            test_id=${ERROR_TEST_ID}            state=visible    
    ${element}=                 Get element by test id            test_id=${ERROR_TEST_ID}
    ${error_text}=              Get Text                          selector=${element}
    Should Contain              container=${error_text}           item=${ERROR_MESSAGE}

_Validate failed login attempt by url
    ${url}=    Get Url
    Should Be Equal            first=${url}                       second=${SAUCEDEMO_URL}

_Validate failed login by seeing the login form
    Wait for elements state by test id                            test_id=${USERNAME_TEST_ID}         state=visible   
    Wait for elements state by test id                            test_id=${PASSWORD_TEST_ID}         state=visible    
    Wait for elements state by test id                            test_id=${LOGIN_BTN_TEST_ID}        state=visible     
 
 _Validate failed login by not seeing the inventory
    Wait for elements state by test id                            test_id=${INV_ITEM_NAME_TEST_ID}         state=detached   
     