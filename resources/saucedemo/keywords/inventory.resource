*** Settings ***
Documentation       Resource file containing all Keywords to use for the inventory page   
Library             Browser
Library             JSONLibrary
Library             Collections
Resource            generic.resource
Resource            ../variables/inventory-page.resource


*** Variables ***
${PRODUCTS_FILE}    ${CURDIR}/../data/products.json


*** Keywords ***
Add item to cart by index
    [Arguments]    ${index}   
    ${products}=    Load Json From File     file_name=${PRODUCTS_FILE} 
    ${item}=        Get From List           ${products}                 ${index}
    ${test_id}=     Get From Dictionary     ${item}                     add_to_cart_id
    Click element by test id                test_id=${test_id}

Add items to cart by index
    [Arguments]    @{index_list}     
    FOR    ${index}    IN    @{index_list}       
        Add item to cart by index           index=${index}
    END    

Navigate to cart
    Click element by test id                test_id=${CART_BTN_TEST_ID}
    