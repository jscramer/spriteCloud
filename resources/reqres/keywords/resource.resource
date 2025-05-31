*** Settings ***
Documentation        Keywords to use for resource functionalities
Library              RequestsLibrary
Library              JSONLibrary
Resource             ../variables/environment.resource


*** Variables ***
${LOGIN_SUCCESS_SCHEMA_LOC}    ${CURDIR}/../data/schemas/login/login_success_schema.json


*** Keywords ***
Get Resource By Id
    [Arguments]    ${id}    ${unknown}=No
    Create Session                 alias=reqres                     url=${REQRES_BASE_URL}    headers=${HEADERS}
    IF    $unknown == 'Yes'
        ${response}=               GET On Session                   alias=reqres              url=/resource/${id}    expected_status=404           
    ELSE
        ${response}=               GET On Session                   alias=reqres              url=/resource/${id}       
    END              
    RETURN                         ${response}   

Validate Unsuccessful Resource Retrieval
    [Arguments]    ${response}
    Should Be Empty    ${response.json()}
    