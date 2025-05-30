*** Settings ***
Documentation    Testcases for user operations
Resource    ../../resources/regres/keywords/allkeywords.resource

*** Variables ***
${PER_PAGE}    5
${PAGE}        2

*** Test Cases ***
TC1 - Retrieve all users
    ${response_json}=    Retrieve all users       page=${PAGE}             per_page=${PER_PAGE}
    Validate number of users equal to per_page    json=${response_json}    per_page=${PER_PAGE}
    Validate users against schema                 json=${response_json} 