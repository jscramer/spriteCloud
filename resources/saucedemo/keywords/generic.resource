*** Settings ***
Documentation                Generic keywords that can be used in every other resource file   
Library                      Browser
Resource                     ../variables/environment.resource


*** Variables ***
${TEST_ID_ATTRIBUTE}    data-test


*** Keywords ***
Open Site
    [Arguments]    ${url}    ${new_browser}=Yes
    IF    $new_browser == "Yes"
        New Browser          browser=${BROWSER}    headless=${HEADLESS}       
    END
    New Page                 ${url}
    Set Viewport Size        1200    900
    Set Browser Timeout      10s

Click Element By Test Id
    [Arguments]    ${test_id}
    Click                    [${TEST_ID_ATTRIBUTE}="${test_id}"]

Fill Text By Test Id
    [Arguments]    ${text}    ${test_id}
    Fill Text                selector=[${TEST_ID_ATTRIBUTE}="${test_id}"]   txt=${text}

Select Option By Test Id
    [Arguments]    ${option}    ${test_id}    ${select_by}
    Select Options By        [${TEST_ID_ATTRIBUTE}="${test_id}"]    ${select_by}    ${option}

Get Text By Test Id
    [Arguments]    ${test_id}
    ${text}=    Get Text     selector=[${TEST_ID_ATTRIBUTE}="${test_id}"]
    RETURN                   ${text}

Get Element By Test Id
    [Arguments]    ${test_id}
    ${element}=              Get Element    selector=[${TEST_ID_ATTRIBUTE}="${test_id}"]
    RETURN                   ${element}

Get Elements By Test Id
    [Arguments]    ${test_id}
    ${elements}=              Get Elements    selector=[${TEST_ID_ATTRIBUTE}="${test_id}"]
    RETURN                    ${elements}

Wait For Elements State By Test Id
    [Arguments]    ${test_id}    ${state}
    Wait For Elements State   selector=[${TEST_ID_ATTRIBUTE}="${test_id}"]                         state=${state}

Generate Random Numbers In A List
    [Arguments]    ${min}     ${max}    ${amount}
    ${list}=    Evaluate     __import__('random').sample(range(${min}, ${max} + 1), ${amount})
    RETURN      ${list}
    