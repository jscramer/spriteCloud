*** Settings ***
Documentation       This file contains the first test case to code for the spriteCloud automation challenge: Write a full checkout that contains, at least, two items. Validate the final price.

Resource            ../../resources/saucedemo/keywords/allkeywords.resource


*** Test Cases ***
Checkout with atleast two items
    Login with known user
    # Get random indexes that determines which items to pick from the products list.
    # This way every test is a bit different. Max value is based on how many items there are.
    @{index_list}=    Generate random numbers in a list    min=0               max=5               amount=3
    Add items to cart by index                             @{index_list}
    Navigate to cart
    Verify items in cart by index                          @{index_list}
    Navigate to checkout
    Fill in customer information                           first_name=Jordy    last_name=Cramer    postal_code=1704AE
    Continue to checkout overview
    Verify total price                                     @{index_list}
    Finish the checkout
    Verify succesful order
