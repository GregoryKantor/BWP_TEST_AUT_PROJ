*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary

*** Variables ***
# URLs
${HOMEPAGE_URL}    https://bwpool.azurewebsites.net/
${WORKS_URL}    https://bwpool.azurewebsites.net/Works
${CUSTOMER_URL}    https://bwpool.azurewebsites.net/Customer
${LOCATION_URL}    https://bwpool.azurewebsites.net/Location
${REMINDER_URL}    https://bwpool.azurewebsites.net/Reminder
${TOOL_URL}    https://bwpool.azurewebsites.net/Tool
${REPORT_URL}    https://bwpool.azurewebsites.net/Report
${PROXY}  http://idebproxy01.itsh.itsh-internal.hu:3128
${API_URL}  https://random-data-api.com/api/users/random_user

# Locators
${HOME}    //a[.='BWP nyilvántartó']
${CALENDAR}      //a[contains(.,'Naptár')]
${WORKS}    //a[contains(.,'Munkák')]
${CUSTOMER}    //a[contains(.,'Partnerek')]
${LOCATION}    //a[contains(.,'Telephelyek')]
${REMINDER}    //a[contains(.,'Emlékeztetők')]
${TOOL}    //a[contains(.,'Eszközök')]
${REPORT}    //a[contains(.,'Riportok')]
${ADD_CUS_BUTTON}    //div/button[@aria-label="Add"]
${ADD_CUS_NAME_INPUT_FIELD}    //div/input[@id="name"]
${ADD_CUS_EMAIL_INPUT_FIELD}    //div/input[@id="email"]
${ADD_CUS_COMMENT_INPUT_FIELD}    //div/input[@id="comment"]
${ADD_CUS_SAVE_BUTTON}    //button[@class='e-control e-btn e-lib e-control e-btn e-lib e-primary e-flat']
${CUSTOMER_LIST_NAME_CELL}    //td[contains(text(), "${PARTNER_NAME}")]   

# Other Variables
${BROWSER}    Chrome
${EXPECTED_TITLE}    BWP Index
${API_DATA}    None
${PARTNER_NAME}    None
${PARTNER_EMAIL}    None
${PARTNER_ID}    None

# Error messages


*** Keywords ***
Test Setup
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window

Test Teardown
    Close All Browsers
    
Test Homepage Loaded    
    Title Should Be    ${EXPECTED_TITLE}

Navigate To Partner Menu Element
    Wait Until Element Is Visible    ${CUSTOMER}    5s
    Click Element    ${CUSTOMER}

Get Random Data From API (NO PROXY)
    ${api_response}    GET    ${API_URL}

    ${api_data_body}    Set Variable    ${api_response.json()}
    Log    ${api_data_body}

    ${id}    Set Variable    ${api_data_body}[id]
    Log    ${id}
    
    ${name}    Evaluate    $api_data_body['first_name'] + ' ' + $api_data_body['last_name']
    Log    ${name}

    ${email}    Set Variable    ${api_data_body}[email]
    Log    ${email}

    Set Suite Variable    ${API_DATA}    ${api_data_body}
    Set Suite Variable    ${PARTNER_NAME}    ${name}
    Set Suite Variable    ${PARTNER_EMAIL}    ${email}
    Set Suite Variable    ${PARTNER_ID}    ${id}

Create Partner Profile With API Data

    Click Element    ${CUSTOMER}
    Click Element    ${ADD_CUS_BUTTON}
    Wait Until Element Is Visible    ${ADD_CUS_NAME_INPUT_FIELD}    2s
    Input Text    ${ADD_CUS_NAME_INPUT_FIELD}    ${PARTNER_NAME}
    Input Text    ${ADD_CUS_EMAIL_INPUT_FIELD}    ${PARTNER_EMAIL}
    Input Text    ${ADD_CUS_COMMENT_INPUT_FIELD}   ${PARTNER_ID}

Verify Partner Profile Created
    Click Element    ${ADD_CUS_SAVE_BUTTON}
    Wait Until Page Contains Element    //td[contains(text(), "${PARTNER_NAME}")]    2s
    Element Should Contain    //td[contains(text(), "${PARTNER_NAME}")]    ${PARTNER_NAME}
    Element Should Contain    //td[contains(text(), "${PARTNER_EMAIL}")]    ${PARTNER_EMAIL}