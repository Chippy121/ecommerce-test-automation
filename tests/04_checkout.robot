*** Settings ***
Documentation     Checkout: end-to-end order flow and form validation.
Resource          ../resources/common.resource
Suite Setup       Open Shop
Suite Teardown    Close Shop
Test Setup        Start Logged In Session
Test Teardown     Close Session

*** Test Cases ***
Customer Can Complete An Order End To End
    [Tags]    smoke    checkout    e2e
    Add Product To Cart    ${BACKPACK}[slug]
    Go To Cart
    Proceed To Checkout
    Enter Customer Information    ${CUSTOMER}[first_name]    ${CUSTOMER}[last_name]    ${CUSTOMER}[postal_code]
    Item Total Should Be    ${BACKPACK}[price]
    Finish Order
    Order Should Be Complete

Checkout Requires Customer Information
    [Tags]    regression    checkout
    [Template]    Checkout Should Fail With Error
    ${EMPTY}                    ${CUSTOMER}[last_name]    ${CUSTOMER}[postal_code]    Error: First Name is required
    ${CUSTOMER}[first_name]    ${EMPTY}                  ${CUSTOMER}[postal_code]    Error: Last Name is required
    ${CUSTOMER}[first_name]    ${CUSTOMER}[last_name]    ${EMPTY}                    Error: Postal Code is required

*** Keywords ***
Checkout Should Fail With Error
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}    ${expected_error}
    Go To Cart
    Proceed To Checkout
    Enter Customer Information    ${first_name}    ${last_name}    ${postal_code}
    Checkout Error Should Be    ${expected_error}
