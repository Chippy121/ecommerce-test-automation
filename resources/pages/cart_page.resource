*** Settings ***
Documentation     Page object: shopping cart.
Library           Browser

*** Variables ***
${CART_ITEM}          css=.cart_item
${CART_ITEM_NAME}     css=.cart_item .inventory_item_name
${CHECKOUT_BUTTON}    css=[data-test="checkout"]

*** Keywords ***
Cart Should Contain Items
    [Arguments]    ${count}
    Get Url    *=    cart.html
    Get Element Count    ${CART_ITEM}    ==    ${count}

Cart Should Contain Product
    [Arguments]    ${product_name}
    Get Element Count    ${CART_ITEM_NAME} >> text="${product_name}"    ==    1

Remove Product From Cart
    [Arguments]    ${slug}
    Click    css=[data-test="remove-${slug}"]

Proceed To Checkout
    Click    ${CHECKOUT_BUTTON}
