*** Settings ***
Documentation     Page object: login page.
Library           Browser

*** Variables ***
${USERNAME_FIELD}     id=user-name
${PASSWORD_FIELD}     id=password
${LOGIN_BUTTON}       id=login-button
${ERROR_MESSAGE}      css=[data-test="error"]

*** Keywords ***
Login As
    [Arguments]    ${username}    ${password}
    Fill Text    ${USERNAME_FIELD}    ${username}
    Fill Secret    ${PASSWORD_FIELD}    $password
    Click    ${LOGIN_BUTTON}

Login Error Should Be
    [Arguments]    ${expected}
    Get Text    ${ERROR_MESSAGE}    ==    ${expected}
