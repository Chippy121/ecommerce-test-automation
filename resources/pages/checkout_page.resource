*** Settings ***
Documentation     Page object: checkout steps one (customer info), two (overview) and complete.
Library           Browser

*** Variables ***
${FIRST_NAME}         css=[data-test="firstName"]
${LAST_NAME}          css=[data-test="lastName"]
${POSTAL_CODE}        css=[data-test="postalCode"]
${CONTINUE_BUTTON}    css=[data-test="continue"]
${FINISH_BUTTON}      css=[data-test="finish"]
${ERROR_MESSAGE}      css=[data-test="error"]
${ITEM_TOTAL}         css=.summary_subtotal_label
${COMPLETE_HEADER}    css=.complete-header

*** Keywords ***
Enter Customer Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill Text    ${FIRST_NAME}    ${first_name}
    Fill Text    ${LAST_NAME}    ${last_name}
    Fill Text    ${POSTAL_CODE}    ${postal_code}
    Click    ${CONTINUE_BUTTON}

Item Total Should Be
    [Arguments]    ${amount}
    Get Text    ${ITEM_TOTAL}    ==    Item total: ${amount}

Finish Order
    Click    ${FINISH_BUTTON}

Order Should Be Complete
    Get Url    *=    checkout-complete.html
    Get Text    ${COMPLETE_HEADER}    ==    Thank you for your order!

Checkout Error Should Be
    [Arguments]    ${expected}
    Get Text    ${ERROR_MESSAGE}    ==    ${expected}
