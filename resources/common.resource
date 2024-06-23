*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    excel_kw.py



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


# Locators
${HOME}    //a[.='BWP nyilvántartó']
${CALENDAR}      //a[contains(.,'Naptár')]
${WORKS}    //a[contains(.,'Munkák')]
${CUSTOMER}    //a[contains(.,'Partnerek')]
${LOCATION}    //a[contains(.,'Telephelyek')]
${REMINDER}    //a[contains(.,'Emlékeztetők')]
${TOOL}    //a[contains(.,'Eszközök')]
${REPORT}    //a[contains(.,'Riportok')]
${CUS_H}    //h4[.='Ügyfelek']
${LOC_H}    //h4[.='Telephelyek']
${TOOL_H}    //h4[.='Eszközök']
${LOC_INFO_H}    //h6[.='Telephely adatok']
${TOOL_INFO_H}    //h4[.='Eszköz']

${EXCEL_EXP_BUTTON}    //button[@aria-label="Excel Export"]
${ADD_BUTTON}      css=button[aria-label="Add"]
${SAVE_BUTTON}    //button[@class='e-control e-btn e-lib e-control e-btn e-lib e-primary e-flat']

${ADD_CUS_NAME_INPUT_FIELD}    //div/input[@id="name"]
${ADD_CUS_EMAIL_INPUT_FIELD}    //div/input[@id="email"]
${ADD_CUS_COMMENT_INPUT_FIELD}    //div/input[@id="comment"]

${ADD_LOC_PARTNER_INPUT_FIELD}    //input[@placeholder="Ügyfél"]
${ADD_LOC_CITY_INPUT_FIELD}    //input[@id="varos"]
${ADD_LOC_ZIP_CODE_INPUT_FIELD}    //input[@id="zip"]
${ADD_LOC_STR_INPUT_FIELD}    //input[@id="utca"]
${ADD_LOC_STR_NUM_INPUT_FIELD}    //input[@id="szam"]

${ADD_TOOL_NAME_INPUT_FIELD}    //div/input[@id="name"]
${ADD_TOOL_PART_INPUT_FIELD}    //input[@placeholder="Ügyfél"]
${ADD_TOOL_LOC_INPUT_FIELD}    //input[@placeholder="Telephely"]
${ADD_TOOL_DESC_INPUT_FIELD}    //textarea[@id='Desc']
${ADD_TOOL_COMM_INPUT_FIELD}    //textarea[@id='Comm']

${LOCATION_INFO_LINK_BY_HREF}    //a[starts-with(@href, 'LocationInfo/')]

${SEARCHBAR}    //input[@id='Grid_ToolbarSearchBox']
${START_SEARCH}    //span[@title='Search']
${EDIT_BUTTON}    //span[.='Edit']
${CH_BOX_SERVICE}    //span[@class='e-label']
${CH_BOX_SERVICE_ACTIVE}    //input[@class="e-control e-checkbox e-lib"]
${CH_BOX_SERVICE_AFTER_SAVING}    //td[@aria-label='True Column Header Szervíz']

${TABLE_LOCATOR}    //div[@id='toolList']

#Other Variables
${BROWSER}    Chrome
${EXPECTED_TITLE}    BWP Index
${DL_PATH}    C:\\Users\\H200323673\\Downloads
${CHROMEDRIVER_PATH}    C:\\ChromeDriver\\chromedriver.exe
${EXCEL_FILE}    Export*.xlsx

${PARTNER_NAME}
${PARTNER_EMAIL}
${PARTNER_ID}
${CITY}
${ZIP_CODE}
${STREET_NAME}
${STR_NUM}
${TOOL_NAME}
${TOOL_LOCATION}
${platform}
${serial_number}
${TOOL_ID}

# Error messages


*** Keywords ***
#Basic KWs
Test Setup
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}    executable_path=${CHROMEDRIVER_PATH}
    Maximize Browser Window

Test Teardown
    Close All Browsers

# Utility KWs
Navigate And Verify Page
    [Arguments]    ${menu_element}    ${url}    ${page_header}    ${timeout}=20s
    Click Element Safely    ${menu_element}
    Location Should Be    ${url}
    Wait Until Element Is Visible    ${page_header}    ${timeout}

Click Element Safely
    [Arguments]    ${locator}    ${retries}=5
    FOR    ${index}    IN RANGE    ${retries}
        Wait Until Element Is Visible    ${locator}    20s
        Wait Until Element Is Enabled    ${locator}    20s
        ${status}=    Run Keyword And Return Status    Click Element    ${locator}
        Run Keyword If    '${status}' == 'True'    Return From Keyword
        Log    Retry clicking the element, attempt: ${index + 1}
    END
    Fail    Failed to click the element after ${retries} attempts

Verify Element Contains Text
    [Arguments]    ${locator}    ${expected_text}
    Wait Until Element Is Visible    ${locator}    20s
    Wait Until Element Is Enabled    ${locator}    20s
    Element Should Contain    ${locator}    ${expected_text}

Handling Serial Number NoneType Data
    [Arguments]    ${serial_number}
    ${serial_number}=    Set Variable If    "${serial_number}" == "None"    ''    ${serial_number}
    [Return]    ${serial_number}

# Dynamic KWs
Extract Device Data
    [Arguments]    ${device_data}
    ${manufacturer}=    Get From Dictionary    ${device_data}    manufacturer
    ${model}=    Get From Dictionary    ${device_data}    model
    ${platform}=    Get From Dictionary    ${device_data}    platform
    ${serial_number}=    Get From Dictionary    ${device_data}    serial_number
    ${serial_number}=    Handling Serial Number NoneType Data    ${serial_number}

    RETURN    ${manufacturer}    ${model}    ${platform}    ${serial_number}

Set Device Variables
    [Arguments]    ${index}    ${device_data}
    ${manufacturer}    ${model}    ${platform}    ${serial_number}=    Extract Device Data    ${device_data}

    Set Suite Variable    ${API_DATA_DEVICE_${index}}    ${device_data}
    Set Suite Variable    ${MANUFACTURER_DEVICE_${index}}    ${manufacturer}
    Set Suite Variable    ${MODEL_DEVICE_${index}}    ${model}
    Set Suite Variable    ${PLATFORM_DEVICE_${index}}    ${platform}
    Set Suite Variable    ${SERIAL_NUMBER_DEVICE_${index}}    ${serial_number}

New File Should Appear
    [Arguments]    ${files_before}    ${directory}
    ${files_after}=    Count Files In Directory    ${directory}    ${EXCEL_FILE}
    Should Be True    ${files_after} > ${files_before}

Get Latest Downloaded File
    [Arguments]    ${DL_PATH}
    @{files}=    List Files In Directory    ${DL_PATH}    pattern=Export*.xlsx
    @{sorted_files}=    Evaluate    sorted(@{files}, key=lambda x: os.path.getmtime(os.path.join(r'${DL_PATH}', x)), reverse=True)    modules=os
    ${latest_file}=    Get From List    ${sorted_files}    0
    RETURN    ${DL_PATH}${/}${latest_file}

Read Table Data From Web And Get Tool ID
    [Arguments]    ${TABLE_LOCATOR}
    Wait Until Element Is Visible    ${TABLE_LOCATOR}
    ${rows}=    Get WebElements    ${TABLE_LOCATOR}//tbody/tr

    ${first_cell}=    Get Text    //h6[text()='Eszközök']/following::table//tbody/tr[2]/td[1]
    Set Suite Variable    ${TOOL_ID}    ${first_cell}
    
    @{web_data}=    Create List
    ${row_index}=    Set Variable    1

    FOR    ${row}    IN    @{rows}
        ${cells}=    Get WebElements    ${TABLE_LOCATOR}//tbody/tr[${row_index}]/td
        ${row_data}=    Create List
        FOR    ${cell}    IN    @{cells}
            ${text}=    Get Text    ${cell}
            Append To List    ${row_data}    ${text}
        END
        Append To List    ${web_data}    ${row_data}
        ${row_index}    Evaluate    ${row_index} + 1
    END
    RETURN    ${web_data}

Check If Item Present
    [Arguments]    ${item}    ${data_list}
    ${result}=    Evaluate    ${item} in ${data_list}
    RETURN    ${result}

#KWs in the Test Case
Test Homepage Loaded    
    Title Should Be    ${EXPECTED_TITLE}

Navigate To Customer Menu Element
    Navigate And Verify Page    ${CUSTOMER}    ${CUSTOMER_URL}    ${CUS_H}

Get Random Data From API (NO PROXY)
    ${api_response}    GET    ${API_URL}
    ${api_data_body}    Set Variable    ${api_response.json()}
    
    
    FOR    ${retry}    IN RANGE    3
        ${zip_code}    Set Variable    ${api_data_body}[address][zip_code]
        ${zip_code_starts_with_zero}=    Evaluate    str("${zip_code}").startswith("0")
        Exit For Loop If    ${zip_code_starts_with_zero} == False
        ${api_response}=    GET    ${API_URL}
        ${api_data_body}=    Set Variable    ${api_response.json()}
        Sleep    5s
    END

    ${zip_code}    Evaluate    ''.join(c for c in "${api_data_body}[address][zip_code]" if c.isdigit())
    ${id}    Set Variable    ${api_data_body}[id]
    ${name}    Evaluate    $api_data_body['first_name'] + ' ' + $api_data_body['last_name']
    ${email}    Set Variable    ${api_data_body}[email]
    ${city}    Set Variable    ${api_data_body}[address][city]
    ${street_name}    Set Variable    ${api_data_body}[address][street_name]

    Set Suite Variable    ${API_DATA}    ${api_data_body}
    Set Suite Variable    ${PARTNER_NAME}    ${name}
    Set Suite Variable    ${PARTNER_EMAIL}    ${email}
    Set Suite Variable    ${PARTNER_ID}    ${id}
    Set Suite Variable    ${CITY}    ${city}
    Set Suite Variable    ${ZIP_CODE}    ${zip_code}
    Set Suite Variable    ${STREET_NAME}    ${street_name}

Create Partner Profile With API Data
    Click Element Safely    ${ADD_BUTTON}
    Wait Until Element Is Visible    ${ADD_CUS_NAME_INPUT_FIELD}    20s
    Input Text    ${ADD_CUS_NAME_INPUT_FIELD}    ${PARTNER_NAME}
    Input Text    ${ADD_CUS_EMAIL_INPUT_FIELD}    ${PARTNER_EMAIL}
    Input Text    ${ADD_CUS_COMMENT_INPUT_FIELD}   ${PARTNER_ID}

Verify Partner Profile Created
    Click Element Safely    ${SAVE_BUTTON}
    Sleep    3s
    Wait Until Page Contains Element    //td[contains(text(), "${PARTNER_NAME}")]    20s
    Verify Element Contains Text    //td[contains(text(), "${PARTNER_NAME}")]    ${PARTNER_NAME}
    Verify Element Contains Text    //td[contains(text(), "${PARTNER_EMAIL}")]    ${PARTNER_EMAIL}
    Verify Element Contains Text    //td[contains(text(), "${PARTNER_ID}")]    ${PARTNER_ID}

Navigate To Location Menu Element
    Navigate And Verify Page    ${LOCATION}    ${LOCATION_URL}    ${LOC_H} 

Create Location Profile With API Data
    Click Element Safely    ${ADD_BUTTON}
    Wait Until Element Is Visible    ${ADD_LOC_PARTNER_INPUT_FIELD}    20s
    Input Text    ${ADD_LOC_PARTNER_INPUT_FIELD}    ${PARTNER_NAME}
    Input Text    ${ADD_LOC_CITY_INPUT_FIELD}    ${CITY}
    Input Text    ${ADD_LOC_ZIP_CODE_INPUT_FIELD}    ${ZIP_CODE}
    Input Text    ${ADD_LOC_STR_INPUT_FIELD}    ${STREET_NAME}
    Input Text    ${ADD_LOC_STR_NUM_INPUT_FIELD}    ${STR_NUM}

Verify Location Profile Created
    Click Element Safely    ${SAVE_BUTTON}
    Wait Until Page Contains Element    //td[contains(text(), "${PARTNER_NAME}")]    10s
    Verify Element Contains Text    //td[contains(text(), "${PARTNER_NAME}")]    ${PARTNER_NAME}
    Verify Element Contains Text    //td[text()='${CITY}']    ${CITY}
    Verify Element Contains Text    //td[contains(text(), '${ZIP_CODE}')]    ${ZIP_CODE}
    Verify Element Contains Text    //a[contains(.,"${STREET_NAME}")]    ${STREET_NAME}    

Get Random Device Data From API (NO PROXY)
    ${api_response_device}=    GET    ${API_DEVICE_URL}
    ${api_data_body_device_list}=    Set Variable    ${api_response_device.json()}
    
    ${api_data_body_device_1}=    Get From List    ${api_data_body_device_list}    0
    Set Device Variables    1    ${api_data_body_device_1}

    ${api_data_body_device_2}=    Get From List    ${api_data_body_device_list}    1
    Set Device Variables    2    ${api_data_body_device_2}

Navigate To Tool Menu Element
    Navigate And Verify Page    ${TOOL}    ${TOOL_URL}    ${TOOL_H}

Create Tool Profile With API Device Data
    [Arguments]    ${index}
    Click Element Safely    ${ADD_BUTTON}
    Wait Until Element Is Visible    ${ADD_TOOL_PART_INPUT_FIELD}    20s
    ${manufacturer}=    Get Variable Value    ${MANUFACTURER_DEVICE_${index}}
    ${model}=    Get Variable Value    ${MODEL_DEVICE_${index}}
    ${platform}=    Get Variable Value    ${PLATFORM_DEVICE_${index}}
    ${serial_number}=    Get Variable Value    ${SERIAL_NUMBER_DEVICE_${index}}
    ${serial_number}=    Get Variable Value    ${SERIAL_NUMBER_DEVICE_${index}}
    ${serial_number}=    Handling Serial Number NoneType Data    ${serial_number}

    ${TOOL_NAME}=    Catenate    ${manufacturer} ${model}
    ${TOOL_LOCATION}=    Catenate    ${zip_code} ${city}, ${street_name}

    Set Suite Variable    ${TOOL_NAME}
    Set Suite Variable    ${PARTNER_NAME}
    Set Suite Variable    ${TOOL_LOCATION}
    Set Suite Variable    ${platform}
    Set Suite Variable    ${serial_number}

    Input Text    ${ADD_TOOL_NAME_INPUT_FIELD}    ${TOOL_NAME}
    Sleep    1s
    Input Text    ${ADD_TOOL_PART_INPUT_FIELD}    ${PARTNER_NAME}
    Sleep    1s
    Input Text    ${ADD_TOOL_LOC_INPUT_FIELD}    ${TOOL_LOCATION}
    Sleep    1s
    Input Text    ${ADD_TOOL_DESC_INPUT_FIELD}    ${platform}
    Sleep    1s
    Input Text    ${ADD_TOOL_COMM_INPUT_FIELD}    ${serial_number}
    Sleep    1s

    Click Element Safely    ${SAVE_BUTTON}

Verify Tool Profile Created
    Verify Element Contains Text    //td[contains(text(), "${TOOL_NAME}")]    ${TOOL_NAME}
    Verify Element Contains Text    //td[contains(text(), "${PARTNER_NAME}")]    ${PARTNER_NAME}
    Verify Element Contains Text    //span[contains(.,"${TOOL_LOCATION}")]    ${TOOL_LOCATION}
    Verify Element Contains Text    //td[contains(text(), "${platform}")]   ${platform}
    Verify Element Contains Text    //td[contains(text(), "${serial_number}")]    ${serial_number}

Click On Excel Export Button And Verify Downloading
    ${files_before}=     Count Files In Directory  ${DL_PATH}    ${EXCEL_FILE}
    Sleep    3s
    Click Element Safely    ${EXCEL_EXP_BUTTON}
    Wait Until Keyword Succeeds    20s    1s    New File Should Appear    ${files_before}    ${DL_PATH}

Location Query With Searchbar Tool
    Click Element Safely    ${SEARCHBAR}
    Wait Until Element Is Visible    ${SEARCHBAR}
    Input Text    ${SEARCHBAR}    ${PARTNER_NAME}
    Click Element Safely    ${START_SEARCH}
    Sleep    2s
    Verify Element Contains Text    //td[@class='e-rowcell ' and contains(text(), '${PARTNER_NAME}')]    ${PARTNER_NAME}

Get Location Info
    Sleep    2s
    Click Element Safely    ${LOCATION_INFO_LINK_BY_HREF}
    Wait Until Element Is Visible    ${LOC_INFO_H}
    Verify Element Contains Text    //td[text()="${PARTNER_NAME}"]    ${PARTNER_NAME}

Verify Excel Matches Web Table
    ${newest_file}=    Get Latest Downloaded File    ${DL_PATH}
    ${excel_data}=    Read Excel File    ${newest_file}
    Set Suite Variable    ${excel_data}
    ${web_data}=    Read Table Data From Web And Get Tool ID    ${TABLE_LOCATOR}
    Set Suite Variable    ${web_data}

    FOR    ${web_item}    IN    @{web_data}
        ${is_present}=    Run Keyword And Return Status    Check If Item Present    ${web_item}    ${excel_data}
        Should Be True    ${is_present}    ${web_item} is not present in the excel data
    END

Search Last Created Tool
    Click Element Safely    ${SEARCHBAR}
    Wait Until Element Is Visible    ${SEARCHBAR}
    Input Text    ${SEARCHBAR}    ${TOOL_ID}
    Wait Until Page Contains    ${TOOL_ID}
    Click Element Safely    ${START_SEARCH}
    Verify Element Contains Text    //td[@class='e-rowcell ' and contains(text(), '${PARTNER_NAME}')]    ${PARTNER_NAME}
    Click Element Safely    //td[@class='e-rowcell ' and contains(text(), '${PARTNER_NAME}')]

Open Tool Profile Editor
    Sleep    3s
    Click Element Safely    ${EDIT_BUTTON}
    Verify Element Contains Text    ${TOOL_INFO_H}    Eszköz

Activate Service Mode
    FOR    ${retry_count}    IN RANGE    2
        Click Element Safely    ${CH_BOX_SERVICE}
        ${checkbox_status}=    Get Element Attribute    ${CH_BOX_SERVICE_ACTIVE}    checked
        Run Keyword If    '${checkbox_status}' == 'true'    Exit For Loop
        Sleep    2s
    END
    Should Be Equal    ${checkbox_status}    true
    Click Element Safely    ${SAVE_BUTTON}

Scroll To The Last Added Partner
    Click Element Safely    //td[contains(text(), "${PARTNER_NAME}")]

Click On The Street URL And Verify Tool Info Page Loaded
    ${LOCATION_INFO_LINK_BY_STR}    Set Variable    //div/div/a[@class='nav-link' and contains(., concat("${STREET_NAME}", ''))]
    Click Element Safely    ${LOCATION_INFO_LINK_BY_STR}
    Wait Until Element Is Visible    ${LOC_INFO_H}
    Verify Element Contains Text    ${LOC_INFO_H}    Telephely adatok

Verify Tool In Active Service Mode Removed From Partner Tool List On Location Info Page
    Page Should Not Contain    ${TOOL_NAME}