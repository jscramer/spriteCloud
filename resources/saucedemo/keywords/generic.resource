*** Settings ***
Documentation                Generic keywords that can be used in every other resource file   
Library                      Browser
Resource                     ../variables/environment.resource

*** Variables ***
${test_id_attribute}    data-test


*** Keywords ***
Open saucedemo site
    [Arguments]    ${new_browser}=Yes
    IF    $new_browser == "Yes"
        New Browser          browser=${BROWSER}    headless=${HEADLESS}          
    END
    New Page                 ${SAUCEDEMO_URL}
    Set Viewport Size        1200    900
    Set Browser Timeout      10s  

Click element by test id
    [Arguments]    ${test_id}
    Click                    [${test_id_attribute}="${test_id}"]

Fill text by test id
    [Arguments]    ${text}    ${test_id}
    Fill Text                selector=[${test_id_attribute}="${test_id}"]   txt=${text}

Get text by test id
    [Arguments]    ${test_id}
    ${text}=    Get Text     selector=[${test_id_attribute}="${test_id}"]
    Return From Keyword      ${text}

Get element by test id
    [Arguments]    ${test_id}
    ${element}=              Get Element    selector=[${test_id_attribute}="${test_id}"]
    Return From Keyword      ${element}    

Generate random numbers in a list
    [Arguments]    ${min}     ${max}    ${amount}
    ${list}=    Evaluate     __import__('random').sample(range(${MIN}, ${MAX} + 1), ${amount})
    Return From Keyword      ${list}    