*** Settings ***
Documentation        Keywords to be used by all API keywords
Library              RequestsLibrary
Resource             ../variables/environment.resource

*** Keywords ***
Validate response status
    [Arguments]    ${response}    ${status}
    Status Should Be                  expected_status=${status}                response=${response}

Validate response time
    [Arguments]    ${response}    ${time}
    ${time_float}=    Evaluate        float(${time})
    ${response_time}=    Evaluate     float(${response.elapsed.total_seconds()})
    Should Be True                    ${response_time} < ${time_float}