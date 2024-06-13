*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections

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
${API_DEVICE_URL}    https://random-data-api.com/api/device/random_device?size=2
${CUSTOMER_URL}    https://bwpool.azurewebsites.net/Customer
${LOCATION_URL}    https://bwpool.azurewebsites.net/Location

# Locators
${HOME}    //a[.='BWP nyilvántartó']
${CALENDAR}      //a[contains(.,'Naptár')]
${WORKS}    //a[contains(.,'Munkák')]
${CUSTOMER}    //a[contains(.,'Partnerek')]
${LOCATION}    //a[contains(.,'Telephelyek')]
${REMINDER}    //a[contains(.,'Emlékeztetők')]
${TOOL}    //a[contains(.,'Eszközök')]
${REPORT}    //a[contains(.,'Riportok')]

${ADD_BUTTON}    //div/button[@aria-label="Add"]
${SAVE_BUTTON}    //button[@class='e-control e-btn e-lib e-control e-btn e-lib e-primary e-flat']

${ADD_CUS_NAME_INPUT_FIELD}    //div/input[@id="name"]
${ADD_CUS_EMAIL_INPUT_FIELD}    //div/input[@id="email"]
${ADD_CUS_COMMENT_INPUT_FIELD}    //div/input[@id="comment"]

${ADD_LOC_PARTNER_INPUT_FIELD}    //input[@placeholder="Ügyfél"]
${ADD_LOC_CITY_INPUT_FIELD}    //input[@id="varos"]
${ADD_LOC_ZIP_CODE_INPUT_FIELD}    //input[@id="zip"]
${ADD_LOC_STR_INPUT_FIELD}    //input[@id="utca"]
${ADD_LOC_STR_NUM_INPUT_FIELD}    //input[@id="szam"]

# Other Variables
${BROWSER}    Chrome
${EXPECTED_TITLE}    BWP Index
${API_DATA}    None
${PARTNER_NAME}    None
${PARTNER_EMAIL}    None
${PARTNER_ID}    None
${CITY}    None
${ZIP_CODE}    None
${STREET_NAME}    None
${STR_NUM}    None
${API_DATA_DEVICE}    None
${MANUFACTURER_DEVICE}    None
${MODEL_DEVICE}    None
${PLATFORM_DEVICE}    None
${SERIAL_NUMBER_DEVICE}    None

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
    Wait Until Element Is Visible    ${CUSTOMER}    10s
    Click Element Safely    ${CUSTOMER}
    Location Should Be    ${CUSTOMER_URL}

Click Element Safely
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    20s
    ${element}=    Get WebElement    ${locator}
    Click Element    ${element}
     

Get Random Data From API (NO PROXY)
    ${api_response}    GET    ${API_URL}
    ${api_data_body}    Set Variable    ${api_response.json()}

    ${id}    Set Variable    ${api_data_body}[id]
    ${name}    Evaluate    $api_data_body['first_name'] + ' ' + $api_data_body['last_name']
    ${email}    Set Variable    ${api_data_body}[email]
    ${city}    Set Variable    ${api_data_body}[address][city]
    ${zip_code}    Set Variable    ${api_data_body}[address][zip_code]
    ${street_name}    Set Variable    ${api_data_body}[address][street_name]

    Set Suite Variable    ${API_DATA}    ${api_data_body}
    Set Suite Variable    ${PARTNER_NAME}    ${name}
    Set Suite Variable    ${PARTNER_EMAIL}    ${email}
    Set Suite Variable    ${PARTNER_ID}    ${id}
    Set Suite Variable    ${CITY}    ${city}
    Set Suite Variable    ${ZIP_CODE}    ${zip_code}
    Set Suite Variable    ${STREET_NAME}    ${street_name}

Create Partner Profile With API Data
    Click Element    ${ADD_BUTTON}
    Wait Until Element Is Visible    ${ADD_CUS_NAME_INPUT_FIELD}    10s
    Input Text    ${ADD_CUS_NAME_INPUT_FIELD}    ${PARTNER_NAME}
    Input Text    ${ADD_CUS_EMAIL_INPUT_FIELD}    ${PARTNER_EMAIL}
    Input Text    ${ADD_CUS_COMMENT_INPUT_FIELD}   ${PARTNER_ID}

Verify Partner Profile Created
    Click Element    ${SAVE_BUTTON}
    Wait Until Page Contains Element    //td[contains(text(), "${PARTNER_NAME}")]    10s
    Element Should Contain    //td[contains(text(), "${PARTNER_NAME}")]    ${PARTNER_NAME}
    Element Should Contain    //td[contains(text(), "${PARTNER_EMAIL}")]    ${PARTNER_EMAIL}
    Element Should Contain    //td[contains(text(), "${PARTNER_ID}")]    ${PARTNER_ID}

Navigate To Location Menu Element
    Click Element    ${LOCATION}
    Location Should Be    ${LOCATION_URL}

Create Location Profile With API Data
    Sleep    10
    Click Element    ${ADD_BUTTON}
    Wait Until Element Is Visible    ${ADD_LOC_PARTNER_INPUT_FIELD}    10s
    Input Text    ${ADD_LOC_PARTNER_INPUT_FIELD}    ${PARTNER_NAME}
    Input Text    ${ADD_LOC_CITY_INPUT_FIELD}    ${CITY}
    Input Text    ${ADD_LOC_ZIP_CODE_INPUT_FIELD}    ${ZIP_CODE}
    Input Text    ${ADD_LOC_STR_INPUT_FIELD}    ${STREET_NAME}
    Input Text    ${ADD_LOC_STR_NUM_INPUT_FIELD}    ${STR_NUM}

Verify Location Profile Created
    Click Element    ${SAVE_BUTTON}
    Wait Until Page Contains Element    //td[contains(text(), "${PARTNER_NAME}")]    10s
    Element Should Contain    //td[contains(text(), "${PARTNER_NAME}")]    ${PARTNER_NAME}
    Element Should Contain    //td[text()='${CITY}']    ${CITY}
    #Element Should Contain    //td[text()='${ZIP_CODE}']    ${ZIP_CODE}
    Element Should Contain    //a[contains(.,"${STREET_NAME}")]    ${STREET_NAME}

Extract Device Data
    [Arguments]    ${device_data}
    ${manufacturer}=    Get From Dictionary    ${device_data}    manufacturer
    ${model}=    Get From Dictionary    ${device_data}    model
    ${platform}=    Get From Dictionary    ${device_data}    platform
    ${serial_number}=    Get From Dictionary    ${device_data}    serial_number
    RETURN    ${manufacturer}    ${model}    ${platform}    ${serial_number}

Set Device Variables
    [Arguments]    ${index}    ${device_data}
    ${manufacturer}    ${model}    ${platform}    ${serial_number}=    Extract Device Data    ${device_data}
    Set Suite Variable    ${API_DATA_DEVICE_${index}}    ${device_data}
    Set Suite Variable    ${MANUFACTURER_DEVICE_${index}}    ${manufacturer}
    Set Suite Variable    ${MODEL_DEVICE_${index}}    ${model}
    Set Suite Variable    ${PLATFORM_DEVICE_${index}}    ${platform}
    Set Suite Variable    ${SERIAL_NUMBER_DEVICE_${index}}    ${serial_number}

Get Random Device Data From API (NO PROXY)
    ${api_response_device}=    GET    ${API_DEVICE_URL}
    ${api_data_body_device_list}=    Set Variable    ${api_response_device.json()}
    
    ${api_data_body_device_1}=    Get From List    ${api_data_body_device_list}    0
    Set Device Variables    1    ${api_data_body_device_1}

    ${api_data_body_device_2}=    Get From List    ${api_data_body_device_list}    1
    Set Device Variables    2    ${api_data_body_device_2}
