*** Settings ***
Documentation     Login: valid login and data-driven negative cases.
Resource          ../resources/common.resource
Suite Setup       Open Shop
Suite Teardown    Close Shop
Test Setup        Start Fresh Session
Test Teardown     Close Session

*** Test Cases ***
Standard User Can Log In
    [Tags]    smoke    login
    Login As    ${STANDARD_USER}    ${PASSWORD}
    Inventory Page Should Be Open

Invalid Login Shows Correct Error
    [Tags]    regression    login
    [Template]    Login Should Fail With Error
    ${LOCKED_OUT_USER}    ${PASSWORD}       Epic sadface: Sorry, this user has been locked out.
    ${STANDARD_USER}      wrong_password    Epic sadface: Username and password do not match any user in this service
    ${EMPTY}              ${PASSWORD}       Epic sadface: Username is required
    ${STANDARD_USER}      ${EMPTY}          Epic sadface: Password is required

*** Keywords ***
Login Should Fail With Error
    [Arguments]    ${username}    ${password}    ${expected_error}
    Login As    ${username}    ${password}
    Login Error Should Be    ${expected_error}
    Reload
