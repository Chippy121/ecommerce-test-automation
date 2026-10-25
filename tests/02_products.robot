*** Settings ***
Documentation     Product list: sorting and product details.
Resource          ../resources/common.resource
Suite Setup       Open Shop
Suite Teardown    Close Shop
Test Setup        Start Logged In Session
Test Teardown     Close Session

*** Test Cases ***
Products Can Be Sorted By Price Low To High
    [Tags]    regression    products
    Sort Products By    lohi
    Prices Should Be Sorted Ascending

Products Can Be Sorted By Name Z To A
    [Tags]    regression    products
    Sort Products By    za
    Names Should Be Sorted Descending

Product Details Page Shows Selected Product
    [Tags]    smoke    products
    Open Product Details    ${BACKPACK}[name]
