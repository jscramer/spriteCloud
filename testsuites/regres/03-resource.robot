*** Settings ***
Documentation    Testcases for login operations. Containing the fifth testcase as listed in the spriteCloud automation assignment.
Resource    ../../resources/regres/keywords/allkeywords.resource


*** Test Cases ***
TC5-1 - Retrieve an unknown resource  
    ${response}=    Get resource by id              id=9999    unknown=Yes
    Validate unsuccessful resource retrieval        response=${response}
    Validate response time                          response=${response}     time=${MAX_RESPONSE_TIME}  

    
