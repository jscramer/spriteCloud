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
    ${products}=               Load Json From File       file_name=${PRODUCTS_FILE} 
    ${item}=                   Get From List             ${products}                 ${index}
    ${test_id}=                Get From Dictionary       ${item}                     add_to_cart_id
    Click element by test id                             test_id=${test_id}

Add items to cart by index
    [Arguments]    @{index_list}     
    FOR    ${index}    IN    @{index_list}       
        Add item to cart by index                        index=${index}
    END    

Navigate to cart
    Click element by test id                             test_id=${CART_BTN_TEST_ID}

Sort products
    [Arguments]    ${sort_type}   
    Select option by test id    option=${sort_type}       select_by=text             test_id=${SORT_BTN_TEST_ID}

Validate sorting    
    [Arguments]    ${sort_type}
    IF    $sort_type == "Name (Z to A)"
        _Validate name sorting                           sort_type=${sort_type}
    ELSE IF    $sort_type == "Name (A to Z)"
        Log    tbi
    ELSE IF    $sort_type == "Price (low to high)"
        Log    tbi
    ELSE IF    $sort_type == "Price (high to low)"
        Log    tbi
    END
    
_Validate name sorting  
    [Arguments]    ${sort_type}  
    @{elements}=               Get elements by test id   test_id=${INV_ITEM_NAME_TEST_ID}
    ${product_names}=    	   Create List
    FOR    ${element}    IN    @{elements}
        ${product_name}        Get Text                   ${element}
        Append To List         ${product_names}           ${product_name}
        Log    ${product_name}
        Log    ${product_names}
    END
    ${sorted_list}=            Copy List                  list_=${product_names}
    Sort List                  list_=${sorted_list}
    IF    $sort_type == "Name (Z to A)"
        Reverse List               list_=${sorted_list}
    END   
    Should Be Equal            first=${product_names}     second=${sorted_list}
