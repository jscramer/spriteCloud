*** Settings ***
Documentation      Resource file to contains the keywords used when one the cart page
Library            Collections
Library            Browser
Library            JSONLibrary
Resource           generic.resource
Resource           ../variables/cart-page.resource


*** Variables ***
${PRODUCTS_FILE}    ${CURDIR}/../data/products.json


*** Keywords ***
Navigate To Checkout
    Click Element By Test Id                      test_id=${CHECKOUT_BTN_TEST_ID}

Verify Item In Cart With Quantity
    [Arguments]    ${name}    ${expected_quantity}
    VAR                       ${found}            ${False}
    @{items_in_cart}=         Get Elements        .cart_item
    FOR    ${item}    IN    @{items_in_cart}
        ${item_name}=         Get Text    ${item} >> .inventory_item_name    
        IF    '${item_name}' == '${name}'
            ${quantity}=      Get Text    ${item} >> .cart_quantity
            Should Be Equal   first=${quantity}    second=${expected_quantity}
            VAR               ${found}             True
            BREAK
        END
    END
    IF    not ${found}    Fail    Item '${name}' is not in the cart    

Verify Items In Cart By Index
    [Arguments]    @{index_list}
    ${products}=    Load Json From File              file_name=${PRODUCTS_FILE}    
    FOR    ${index}    IN    @{index_list}
        ${item}=            Get From List            ${products}                  ${index}
        ${name}=            Get From Dictionary      ${item}                      name
        Verify Item In Cart With Quantity            name=${name}                 expected_quantity=1
    END    
