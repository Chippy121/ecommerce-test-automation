*** Settings ***
Documentation     Shopping cart: add, remove and badge count.
Resource          ../resources/common.resource
Suite Setup       Open Shop
Suite Teardown    Close Shop
Test Setup        Start Logged In Session
Test Teardown     Close Session

*** Test Cases ***
Adding Products Updates Cart Badge And Cart
    [Tags]    smoke    cart
    Add Product To Cart    ${BACKPACK}[slug]
    Add Product To Cart    ${BIKE_LIGHT}[slug]
    Cart Badge Should Show    2
    Go To Cart
    Cart Should Contain Items    2
    Cart Should Contain Product    ${BACKPACK}[name]
    Cart Should Contain Product    ${BIKE_LIGHT}[name]

Removing Product From Cart Updates Badge
    [Tags]    regression    cart
    Add Product To Cart    ${BACKPACK}[slug]
    Add Product To Cart    ${BIKE_LIGHT}[slug]
    Go To Cart
    Remove Product From Cart    ${BIKE_LIGHT}[slug]
    Cart Should Contain Items    1
    Cart Badge Should Show    1

Removing Last Product Hides Cart Badge
    [Tags]    regression    cart
    Add Product To Cart    ${BACKPACK}[slug]
    Remove Product From Inventory    ${BACKPACK}[slug]
    Cart Badge Should Not Be Visible
