*** Settings ***
Documentation        Keywords to use for user retrieval and modifications
Library              RequestsLibrary
Library              JSONLibrary
Resource             ../variables/environment.resource


*** Variables ***
${USER_SCHEMA_LOC}                     ${CURDIR}/../data/schemas/user/user_schema.json
${USER_PUT_SCHEMA_LOC}                 ${CURDIR}/../data/schemas/user/user_put.json


*** Keywords ***
Retrieve All Users
    [Arguments]    ${page}    ${per_page}
    Create Session                     alias=reqres                url=${REQRES_BASE_URL}             headers=${HEADERS}
    VAR                                &{params}                   page=${page}                        per_page=${per_page} 
    ${response}=                       GET On Session              alias=reqres                        url=/users               params=${params}
    RETURN                             ${response}
    
Get User By Id
    [Arguments]    ${id}    ${delay}=0
    Create Session                     alias=reqres                url=${REQRES_BASE_URL}             headers=${HEADERS}
    ${response}=                       GET On Session              alias=reqres                        url=/users/${id}?delay=${delay}
    RETURN                             ${response}    

Update User By Id
    [Arguments]    ${id}    ${email}=None    ${first_name}=None    ${last_name}=None    ${avatar}=None 
    Create Session                     alias=reqres                url=${REQRES_BASE_URL}              headers=${HEADERS}  
    VAR                                &{params}                   email=${email}                      first_name=${first_name}    last_name=${last_name}    avatar=${avatar}
    ${response}=                       PUT On Session              alias=reqres                        url=/users/${id}            data=${params}
    RETURN                             ${response}

Delete User By Id
    [Arguments]    ${id}
    Create Session                     alias=reqres                url=${REQRES_BASE_URL}              headers=${HEADERS} 
    ${response}=                       DELETE On Session              alias=reqres                        url=/users/${id}          
    RETURN                             ${response}

Validate Number Of Users Equal To Per Page
    [Arguments]    ${response}    ${per_page}
    Length Should Be                   ${response.json()}[data]    ${per_page}

Validate Multiple Users Against Schema
    [Arguments]    ${response}
    FOR    ${user}    IN    @{response.json()}[data]     
        Validate Json By Schema File    json_object=${user}        path_to_schema=${USER_SCHEMA_LOC}
    END
    
Validate User Against Schema
    [Arguments]    ${response}
    Validate Json By Schema File    json_object=${response.json()}[data]        path_to_schema=${USER_SCHEMA_LOC}

Validate Update User Against Schema
    [Arguments]    ${response}
    Validate Json By Schema File     json_object=${response.json()}        path_to_schema=${USER_PUT_SCHEMA_LOC} 

Validate User Deletion Response
    [Arguments]    ${response}
    IF    '${response.text}' != ''
        Fail    Expected empty response body but got: ${response.text}
    END   
