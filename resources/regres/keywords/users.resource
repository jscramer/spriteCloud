*** Settings ***
Documentation        Keywords to use for user retrieval and modifications
Library              RequestsLibrary
Library              JSONLibrary
Resource             ../variables/environment.resource


*** Variables ***
${USER_SCHEMA_LOC}    ${CURDIR}/../data/schemas/user_schema.json


*** Keywords ***
Retrieve all users
    [Arguments]    ${page}    ${per_page}       
    Create Session    alias=reqres    url=${REGRES_BASE_URL}    headers={"x-api-key": "${API_KEY}"}
    ${params}=    Create Dictionary    page=${page}    per_page=${per_page} 
    ${response}=    GET On Session    alias=reqres    url=/users    params=${params}
    Status Should Be    200    ${response}
    Return From Keyword    ${response.json()}   
    
Validate number of users equal to per_page
    [Arguments]    ${json}    ${per_page}
    Length Should Be    ${json}[data]    ${per_page}

Validate users against schema
    [Arguments]    ${json} 
    FOR    ${user}    IN    @{json}[data]
        Validate Json By Schema File    json_object=${user}    path_to_schema=${USER_SCHEMA_LOC}
    END
    