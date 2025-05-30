*** Settings ***
Documentation      Resource file to contains the keywords used when one the cart page
Library            Browser
Library            JSONLibrary
Library            Collections
Resource           generic.resource
Resource           ../variables/cart-page.resource


*** Variables ***
${PRODUCTS_FILE}    ${CURDIR}/../data/products.json


*** Keywords ***
Navigate to checkout
    Click element by test id                      test_id=${CHECKOUT_BTN_TEST_ID}

Verify item in cart with quantity
    [Arguments]    ${name}    ${expected_quantity}
    ${found}=                 Set Variable        ${False}
    @{items_in_cart}=         Get Elements        .cart_item
    FOR    ${item}    IN    @{items_in_cart}
        ${item_name}=         Get Text    ${item} >> .inventory_item_name       
         IF    '${item_name}' == '${name}'
            ${quantity}=      Get Text    ${item} >> .cart_quantity
            Should Be Equal   first=${quantity}    second=${expected_quantity}
            ${found}=         Set Variable         True
            Exit For Loop
        END
    END
    IF    ${found} == ${False}
        Fail    Item '${name}' is not in the cart
    END
    

Verify items in cart by index
    [Arguments]    @{index_list}  
    ${products}=    Load Json From File              file_name=${PRODUCTS_FILE}     
    FOR    ${index}    IN    @{index_list}
        ${item}=            Get From List            ${products}                  ${index}
        ${name}=            Get From Dictionary      ${item}                      name   
        Verify item in cart with quantity            name=${name}                 expected_quantity=1
    END    