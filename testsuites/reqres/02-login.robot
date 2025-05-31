*** Settings ***
Documentation    Testcases for login operations. Containing the second testcase as listed in the spriteCloud automation assignment.
Resource    ../../resources/reqres/keywords/allkeywords.resource


*** Test Cases ***
TC2 - Perform A Successful Login
    [Documentation]    Perform a login request with a known combination of e-mail/password. Validate afterwards.
    ${response}=    Login With Credentials         email=${EMAIL_API}               password=${PASSWORD_API}
    Validate Response Status                       response=${response}             status=200
    Validate Successful Login Against Schema       response=${response}
    Validate Response Time                         response=${response}             time=${MAX_RESPONSE_TIME} 

TC5-2 - Login Without Password
    [Documentation]    Perform a login request with a known email, but no password. Validate afterwards.
    ${response}=    Login With Credentials         email=${EMAIL_API}
    Validate Unsuccessful Login Against Schema     response=${response}
    Validate Response Time                         response=${response}             time=${MAX_RESPONSE_TIME}
