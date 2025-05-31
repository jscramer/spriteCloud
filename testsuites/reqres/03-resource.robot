*** Settings ***
Documentation    Testcases for login operations. Containing the fifth testcase as listed in the spriteCloud automation assignment.
Resource    ../../resources/reqres/keywords/allkeywords.resource


*** Test Cases ***
TC5-1 - Retrieve An Unknown Resource
    [Documentation]    Try and retrieve a resource with an unknown id
    ${response}=    Get Resource By Id              id=9999    unknown=Yes
    Validate Unsuccessful Resource Retrieval        response=${response}
    Validate Response Time                          response=${response}     time=${MAX_RESPONSE_TIME}
