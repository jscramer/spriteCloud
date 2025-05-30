*** Settings ***
Documentation    Testcases for login operations. Containing the second testcase as listed in the spriteCloud automation assignment.
Resource    ../../resources/reqres/keywords/allkeywords.resource


*** Test Cases ***
TC2 - Perform a successful login    
    ${response}=    Login with credentials         email=${EMAIL_API}               password=${PASSWORD_API}
    Validate response status                       response=${response}             status=200   
    Validate successful login against schema       response=${response}
    Validate response time                         response=${response}             time=${MAX_RESPONSE_TIME}  

TC5-2 - Login without password
    ${response}=    Login with credentials         email=${EMAIL_API} 
    Validate unsuccessful login against schema     response=${response}
    Validate response time                         response=${response}             time=${MAX_RESPONSE_TIME} 
