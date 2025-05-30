*** Settings ***
Documentation        Keywords to use for user retrieval and modifications
Library              RequestsLibrary
Library              JSONLibrary
Resource             ../variables/environment.resource


*** Variables ***
${USER_SCHEMA_LOC}                     ${CURDIR}/../data/schemas/user/user_schema.json
${USER_PUT_SCHEMA_LOC}                 ${CURDIR}/../data/schemas/user/user_put.json

*** Keywords ***
Retrieve all users
    [Arguments]    ${page}    ${per_page}       
    Create Session                     alias=reqres                url=${REGRES_BASE_URL}             headers=${HEADERS}
    ${params}=                         Create Dictionary           page=${page}                        per_page=${per_page} 
    ${response}=                       GET On Session              alias=reqres                        url=/users               params=${params}   
    Return From Keyword                ${response}   
    
Get user by id
    [Arguments]    ${id}
    Create Session                     alias=reqres                url=${REGRES_BASE_URL}             headers=${HEADERS}       
    ${response}=                       GET On Session              alias=reqres                        url=/users/${id}
    Return From Keyword                ${response}     

Update user by id
    [Arguments]    ${id}    ${email}=None    ${first_name}=None    ${last_name}=None    ${avatar}=None  
    Create Session                     alias=reqres                url=${REGRES_BASE_URL}              headers=${HEADERS}  
    ${params}=                         Create Dictionary           email=${email}                      first_name=${first_name}    last_name=${last_name}    avatar=${avatar} 
    ${response}=                       PUT On Session              alias=reqres                        url=/users/${id}            data=${params}
    Return From Keyword                ${response}

Delete user by id
    [Arguments]    ${id}
    Create Session                     alias=reqres                url=${REGRES_BASE_URL}              headers=${HEADERS}    
    ${response}=                       DELETE On Session              alias=reqres                        url=/users/${id}            
    Return From Keyword                ${response}

Validate number of users equal to per_page
    [Arguments]    ${response}    ${per_page}
    Length Should Be                   ${response.json()}[data]    ${per_page}

Validate users against schema
    [Arguments]    ${response} 
    FOR    ${user}    IN    @{response.json()}[data]
        Validate Json By Schema File    json_object=${user}        path_to_schema=${USER_SCHEMA_LOC}
    END
    
Validate update user against schema
    [Arguments]    ${response}     
    Validate Json By Schema File     json_object=${response.json()}        path_to_schema=${USER_PUT_SCHEMA_LOC}
   

Validate user deletion response
    [Arguments]    ${response}   
    IF    '${response.text}' != ''
        Fail    Expected empty response body but got: ${response.text}
    END   