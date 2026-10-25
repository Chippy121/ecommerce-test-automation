*** Settings ***
Documentation     Page object: product list (inventory) and product detail pages.
Library           Browser
Library           Collections

*** Variables ***
${PAGE_TITLE}         css=.title
${ITEM_NAME}          css=.inventory_item_name
${ITEM_PRICE}         css=.inventory_item_price
${SORT_DROPDOWN}      css=[data-test="product-sort-container"]
${DETAIL_NAME}        css=.inventory_details_name
${CART_BADGE}         css=.shopping_cart_badge
${CART_LINK}          css=.shopping_cart_link

*** Keywords ***
Inventory Page Should Be Open
    Get Url    *=    inventory.html
    Get Text    ${PAGE_TITLE}    ==    Products

Sort Products By
    [Documentation]    Options: az, za, lohi (price low to high), hilo (price high to low).
    [Arguments]    ${option}
    Select Options By    ${SORT_DROPDOWN}    value    ${option}

Get Product Prices
    ${elements}=    Get Elements    ${ITEM_PRICE}
    ${prices}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        ${value}=    Convert To Number    ${text.replace('$', '')}
        Append To List    ${prices}    ${value}
    END
    RETURN    ${prices}

Get Product Names
    ${elements}=    Get Elements    ${ITEM_NAME}
    ${names}=    Create List
    FOR    ${element}    IN    @{elements}
        ${text}=    Get Text    ${element}
        Append To List    ${names}    ${text}
    END
    RETURN    ${names}

Prices Should Be Sorted Ascending
    ${prices}=    Get Product Prices
    ${expected}=    Copy List    ${prices}
    Sort List    ${expected}
    Lists Should Be Equal    ${prices}    ${expected}

Names Should Be Sorted Descending
    ${names}=    Get Product Names
    ${expected}=    Copy List    ${names}
    Sort List    ${expected}
    Reverse List    ${expected}
    Lists Should Be Equal    ${names}    ${expected}

Open Product Details
    [Arguments]    ${product_name}
    Click    ${ITEM_NAME} >> text="${product_name}"
    Get Text    ${DETAIL_NAME}    ==    ${product_name}

Add Product To Cart
    [Arguments]    ${slug}
    Click    css=[data-test="add-to-cart-${slug}"]

Remove Product From Inventory
    [Arguments]    ${slug}
    Click    css=[data-test="remove-${slug}"]

Cart Badge Should Show
    [Arguments]    ${count}
    Get Text    ${CART_BADGE}    ==    ${count}

Cart Badge Should Not Be Visible
    Get Element Count    ${CART_BADGE}    ==    0

Go To Cart
    Click    ${CART_LINK}
