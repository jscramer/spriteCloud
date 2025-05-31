*** Settings ***
Documentation    Testcases for user operations. Containing the first testcase as listed in the spriteCloud automation assignment.
Resource    ../../resources/reqres/keywords/allkeywords.resource


*** Variables ***
${PER_PAGE}    5
${PAGE}        2
${USER_ID}     2


*** Test Cases ***
TC1 - Retrieve All Users
    [Documentation]    Perform a GET request to retrieve all users and validate afterwards.
    ${response}=    Retrieve All Users            page=${PAGE}             per_page=${PER_PAGE}
    Validate Number Of Users Equal To Per Page    response=${response}     per_page=${PER_PAGE}
    Validate Multiple Users Against Schema        response=${response}
    Validate Response Status                      response=${response}     status=200
    Validate Response Time                        response=${response}     time=${MAX_RESPONSE_TIME}

TC3 - Update An User 
    [Documentation]    Perform a PUT request to update an user and validate afterwards.
    ${response}=    Update User By Id             id=${USER_ID}            email=test@test.nl    first_name=Jordy    last_name=Test    avatar=https://reqres.in/img/faces/1-image.jpg
    Validate Response Status                      response=${response}     status=200
    Validate Update User Against Schema           response=${response}
    Validate Response Time                        response=${response}     time=${MAX_RESPONSE_TIME}   

TC4 - Delete An User
    [Documentation]    Perform a DELETE request to delete an user and validate afterwards.
    ${response}=    Delete User By Id             id=${USER_ID}
    Validate Response Status                      response=${response}     status=204
    Validate User Deletion Response               response=${response}
    Validate Response Time                        response=${response}     time=${MAX_RESPONSE_TIME}

TC6 - Retrieve User By Id With Delay
    [Documentation]    Perform a GET request to retrieve an user by id and validate afterwards. This is done 4 times with a delay from 0 to 3 seconds.
    FOR    ${delay}    IN RANGE    4
        ${response}=    Get User By Id            id=${USER_ID}            delay=${delay}
        Validate Response Status                  response=${response}     status=200
        Validate User Against Schema              response=${response}
        Validate Response Time                    response=${response}     time=${MAX_RESPONSE_TIME}+${delay}
    END  
