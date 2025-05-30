*** Settings ***
Documentation    Testcases for user operations. Containing the first testcase as listed in the spriteCloud automation assignment.
Resource    ../../resources/regres/keywords/allkeywords.resource

*** Variables ***
${PER_PAGE}    5
${PAGE}        2
${USER_ID}     2


*** Test Cases ***
TC1 - Retrieve all users
    ${response}=    Retrieve all users            page=${PAGE}             per_page=${PER_PAGE}
    Validate number of users equal to per_page    response=${response}     per_page=${PER_PAGE}
    Validate users against schema                 response=${response}
    Validate response status                      response=${response}     status=200
    Validate response time                        response=${response}     time=${MAX_RESPONSE_TIME}   

TC3 - Update an user    
    ${response}=    Update user by id             id=1                     email=test@test.nl    first_name=Jordy    last_name=Test    avatar=https://reqres.in/img/faces/1-image.jpg
    Validate response status                      response=${response}     status=200
    Validate update user against schema           response=${response}
    Validate response time                        response=${response}     time=${MAX_RESPONSE_TIME}      

TC4 - Delete an user
    ${response}=    Delete user by id             id=1   
    Validate response status                      response=${response}     status=204
    Validate user deletion response               response=${response}
    Validate response time                        response=${response}     time=${MAX_RESPONSE_TIME}  