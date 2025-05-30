*** Settings ***
Library                    Browser
Library                    JSONLibrary
Library                    Collections
Library                    String
Resource                   generic.resource
Resource                   ../variables/checkout-page.resource


*** Variables ***
${PRODUCTS_FILE}    ${CURDIR}/../data/products.json


*** Keywords ***
Continue to checkout overview
    Click element by test id                         test_id=${CONTINUE_BTN_TEST_ID}

Finish the checkout
    Click element by test id                         test_id=${FINISH_BTN_TEST_ID}   

Fill in customer information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill text by test id    text=${first_name}        test_id=${FIRSTNAME_INP_TEST_ID}
    Fill text by test id    text=${last_name}         test_id=${LASTNAME_INP_TEST_ID}
    Fill text by test id    text=${postal_code}       test_id=${POSTALCODE_INP_TEST_ID}

Verify total price
    [Arguments]    @{index_list}    
    ${subtotal}=            Set Variable    0
    ${products}=            Load Json From File       file_name=${PRODUCTS_FILE}  
     FOR    ${index}    IN    @{index_list}
        ${item}=            Get From List             ${products}                   ${index}
        ${price}=           Get From Dictionary       ${item}                       price 
        ${subtotal}=        Evaluate                  ${subtotal} + ${price}
    END
    _Verify subtotal        subtotal=${subtotal}
    ${total_string}=        Get text by test id       test_id=${TOTAL_TEST_ID}
    ${total_price}=         Fetch From Right          string=${total_string}        marker=$
    ${total_price_f}=       Evaluate                  float(${total_price})
    ${total_price_calc}=    _Calculate total price    subtotal=${subtotal}
    Should Be Equal         first=${total_price_f}    second=${total_price_calc}


_Verify subtotal    
    [Arguments]    ${subtotal}
    ${subtotal_string}=     Get text by test id       test_id=${SUBOTAL_TEST_ID}
    ${subtotal_price}=      Fetch From Right          string=${subtotal_string}     marker=$
    ${subtotal_price_f}=    Evaluate                  float(${subtotal_price})
    Should Be Equal         first=${subtotal}         second=${subtotal_price_f}
    

_Calculate total price
    [Arguments]    ${subtotal}
    ${tax}=                 Evaluate    round(${subtotal} * ${TAX_AMOUNT},2)
    ${total}=               Evaluate    ${subtotal} + ${tax}
    Return From Keyword     ${total}

Verify succesful order
    Wait For Elements State    text=Thank you for your order!    visible