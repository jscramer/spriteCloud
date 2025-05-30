*** Settings ***
Documentation        Keywords to use for login functionalities
Library              RequestsLibrary
Library              JSONLibrary
Resource             ../variables/environment.resource


*** Variables ***
${LOGIN_SUCCESS_SCHEMA_LOC}    ${CURDIR}/../data/schemas/login/login_success_schema.json
${LOGIN_FAILED_SCHEMA_LOC}     ${CURDIR}/../data/schemas/login/login_failed_schema.json


*** Keywords ***
Login with credentials    
    [Arguments]    ${password}=${EMPTY}    ${username}=${EMPTY}   ${email}=${EMPTY}
    Create Session                 alias=reqres                      url=${REGRES_BASE_URL}    headers=${HEADERS}
    ${params}=                     Create Dictionary                 email=${email}            password=${password}   
    IF    $password == ''
        ${response}=                   POST On Session                   alias=reqres              url=/login                data=${params}     expected_status=400   
    ELSE
        ${response}=                   POST On Session                   alias=reqres              url=/login                data=${params}   
    END    
    Return From Keyword            ${response}  

Validate successful login against schema
    [Arguments]    ${response} 
    Validate Json By Schema File    json_object=${response.json()}   path_to_schema=${LOGIN_SUCCESS_SCHEMA_LOC}

Validate unsuccessful login against schema
    [Arguments]    ${response} 
    Validate Json By Schema File    json_object=${response.json()}   path_to_schema=${LOGIN_FAILED_SCHEMA_LOC}
