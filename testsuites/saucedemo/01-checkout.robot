*** Settings ***
Documentation       This file contains the first test case to code for the spriteCloud automation challenge: Write a full checkout that contains, at least, two items. Validate the final price.

Resource            ../../resources/saucedemo/keywords/allkeywords.resource


*** Test Cases ***
Checkout With Atleast Two Items
    [Documentation]    Generate two random numbers to pick two random items from the product page and calculate the price     
    Login With Known User  
    # Get random indexes that determines which items to pick from the products list.
    # This way every test is a bit different. Max value is based on how many items there are.
    @{index_list}=    Generate Random Numbers In A List    min=0               max=5               amount=3
    Add Items To Cart By Index                             @{index_list}
    Navigate To Cart
    Verify Items In Cart By Index                          @{index_list}
    Navigate To Checkout
    Fill In Customer Information                           first_name=Jordy    last_name=Cramer    postal_code=1704AE
    Continue To Checkout Overview
    Verify Total Price                                     @{index_list}
    Finish The Checkout
    Verify Succesful Order
