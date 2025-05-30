*** Settings ***
Documentation    Testcases for login operations. Containing the second testcase as listed in the spriteCloud automation assignment.
Resource    ../../resources/regres/keywords/allkeywords.resource


*** Test Cases ***
TC2 - Perform a successful login    
    ${response}=    Login with credentials         email=${EMAIL_API}               password=${PASSWORD_API}
    Validate response status                       response=${response}             status=200   
    Validate successful login against schema       response=${response}
