*** Settings ***
Documentation    Testcases for user operations. Containing the first testcase as listed in the spriteCloud automation assignment.
Resource    ../../resources/regres/keywords/allkeywords.resource

*** Variables ***
${PER_PAGE}    5
${PAGE}        2

*** Test Cases ***
TC1 - Retrieve all users
    ${response}=    Retrieve all users            page=${PAGE}             per_page=${PER_PAGE}
    Validate number of users equal to per_page    response=${response}     per_page=${PER_PAGE}
    Validate users against schema                 response=${response}
    Validate response status                      response=${response}     status=200