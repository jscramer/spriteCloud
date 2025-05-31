*** Settings ***
Documentation              Keywords that can be used during the checkout page
Library                    Collections
Library                    String
Library                    Browser
Library                    JSONLibrary
Resource                   generic.resource
Resource                   ../variables/checkout-page.resource


*** Variables ***
${PRODUCTS_FILE}    ${CURDIR}/../data/products.json


*** Keywords ***
Continue To Checkout Overview
    Click Element By Test Id                         test_id=${CONTINUE_BTN_TEST_ID}

Finish The Checkout
    Click Element By Test Id                         test_id=${FINISH_BTN_TEST_ID}

Fill In Customer Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill Text By Test Id    text=${first_name}        test_id=${FIRSTNAME_INP_TEST_ID}
    Fill Text By Test Id    text=${last_name}         test_id=${LASTNAME_INP_TEST_ID}
    Fill Text By Test Id    text=${postal_code}       test_id=${POSTALCODE_INP_TEST_ID}

Verify Total Price
    [Arguments]    @{index_list}
    VAR                     ${subtotal}               0
    ${products}=            Load Json From File       file_name=${PRODUCTS_FILE}
    FOR    ${index}    IN    @{index_list}
        ${item}=            Get From List             ${products}                   ${index}
        ${price}=           Get From Dictionary       ${item}                       price
        ${subtotal}=        Evaluate                  ${subtotal} + ${price}
    END
    _Verify Subtotal        subtotal=${subtotal}   
    ${total_price_f}=       _Get Total Price From Page
    ${total_price_calc}=    _Calculate Total Price    subtotal=${subtotal}
    Should Be Equal         first=${total_price_f}    second=${total_price_calc}

_Get Total Price From Page
    ${total_string}=        Get Text By Test Id       test_id=${TOTAL_TEST_ID}
    ${total_price}=         Fetch From Right          string=${total_string}        marker=$
    ${total_price_f}=       Evaluate                  float(${total_price})
    RETURN                  ${total_price_f} 

_Verify Subtotal
    [Arguments]    ${subtotal}
    ${subtotal_string}=     Get Text By Test Id       test_id=${SUBOTAL_TEST_ID}
    ${subtotal_price}=      Fetch From Right          string=${subtotal_string}     marker=$
    ${subtotal_price_f}=    Evaluate                  float(${subtotal_price})
    Should Be Equal         first=${subtotal}         second=${subtotal_price_f}    

_Calculate Total Price
    [Arguments]    ${subtotal}
    ${tax}=                 Evaluate    round(${subtotal} * ${TAX_AMOUNT},2)
    ${total}=               Evaluate    ${subtotal} + ${tax}
    RETURN                  ${total}

Verify Succesful Order
    Wait For Elements State    text=Thank you for your order!    visible
