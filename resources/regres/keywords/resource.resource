*** Settings ***
Documentation        Keywords to use for resource functionalities
Library              RequestsLibrary
Library              JSONLibrary
Resource             ../variables/environment.resource


*** Variables ***
${LOGIN_SUCCESS_SCHEMA_LOC}    ${CURDIR}/../data/schemas/login/login_success_schema.json


*** Keywords ***
Get resource by id
    [Arguments]    ${id}    ${unknown}=No
    Create Session                 alias=reqres                      url=${REGRES_BASE_URL}    headers=${HEADERS}  
    IF    $unknown == 'Yes'
        ${response}=                   GET On Session                   alias=reqres              url=/resource/${id}    expected_status=404               
    ELSE
        ${response}=                   GET On Session                   alias=reqres              url=/resource/${id}               
    END              
    Return From Keyword            ${response}  
   

Validate unsuccessful resource retrieval
    [Arguments]    ${response} 
    Should Be Empty    ${response.json()}