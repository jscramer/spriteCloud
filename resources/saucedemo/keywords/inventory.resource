*** Settings ***
Documentation       Resource file containing all Keywords to use for the inventory page
Library             Collections
Library             JSONLibrary
Library             Browser
Resource            generic.resource
Resource            ../variables/inventory-page.resource


*** Variables ***
${PRODUCTS_FILE}    ${CURDIR}/../data/products.json


*** Keywords ***
Add Item To Cart By Index
    [Arguments]    ${index} 
    ${products}=               Load Json From File       file_name=${PRODUCTS_FILE}
    ${item}=                   Get From List             ${products}                 ${index}
    ${test_id}=                Get From Dictionary       ${item}                     add_to_cart_id
    Click Element By Test Id                             test_id=${test_id}

Add Items To Cart By Index
    [Arguments]    @{index_list}
    FOR    ${index}    IN    @{index_list}
        Add Item To Cart By Index                        index=${index}
    END

Navigate To Cart
    Click Element By Test Id                             test_id=${CART_BTN_TEST_ID}

Sort Products
    [Arguments]    ${sort_type}
    Select Option By Test Id    option=${sort_type}       select_by=text             test_id=${SORT_BTN_TEST_ID}

Validate Sorting    
    [Arguments]    ${sort_type}
    IF    $sort_type == "Name (Z to A)"
        _Validate Name Sorting                           sort_type=${sort_type}
    ELSE IF    $sort_type == "Name (A to Z)"
        Log    tbi
    ELSE IF    $sort_type == "Price (low to high)"
        Log    tbi
    ELSE IF    $sort_type == "Price (high to low)"
        Log    tbi
    END
    
_Validate Name Sorting  
    [Arguments]    ${sort_type}  
    @{elements}=               Get Elements By Test Id   test_id=${INV_ITEM_NAME_TEST_ID}
    VAR                        @{product_names}           ${EMPTY}
    FOR    ${element}    IN    @{elements}
        ${product_name}=       Get Text                   ${element}
        Append To List         ${product_names}           ${product_name}       
    END
    ${sorted_list}=            Copy List                  list_=${product_names}
    Sort List                  list_=${sorted_list}
    IF    $sort_type == "Name (Z to A)"
        Reverse List               list_=${sorted_list}
    END
    Should Be Equal            first=${product_names}     second=${sorted_list}
