*** Settings ***
Documentation        Keywords to be used by all API keywords
Library              RequestsLibrary
Resource             ../variables/environment.resource

*** Keywords ***
Validate response status
    [Arguments]    ${response}    ${status}
    Status Should Be    expected_status=${status}    response=${response}