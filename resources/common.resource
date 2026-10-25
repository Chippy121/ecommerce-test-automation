*** Settings ***
Documentation     Shared setup, teardown and browser settings used by every suite.
Library           Browser    timeout=10s    run_on_failure=Take Screenshot
Library           Collections
Variables         ../variables/test_data.py
Resource          pages/login_page.resource
Resource          pages/inventory_page.resource
Resource          pages/cart_page.resource
Resource          pages/checkout_page.resource

*** Variables ***
${BROWSER}        chromium
${HEADLESS}       ${TRUE}

*** Keywords ***
Open Shop
    [Documentation]    Starts one browser per suite. Each test gets a fresh context (clean cookies and cart).
    New Browser    ${BROWSER}    headless=${HEADLESS}

Start Fresh Session
    New Context    viewport={'width': 1280, 'height': 800}
    New Page    ${BASE_URL}

Start Logged In Session
    Start Fresh Session
    Login As    ${STANDARD_USER}    ${PASSWORD}
    Inventory Page Should Be Open

Close Session
    Close Context

Close Shop
    Close Browser    ALL
