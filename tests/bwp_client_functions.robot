*** Settings ***
Resource    ../resources/common.resource
Test Setup    Test Setup
Test Teardown    Test Teardown

*** Test Cases ***
1. The Application and Homepage Loaded
    Title Should Be    ${EXPECTED_TITLE}

2. Navigate To The Partner Menu
    Click Element    ${CUSTOMER}

3-4. Get Random Data From API And Create With Them A Partner
    ${api_response}    GET    ${API_URL}

    ${api_data_body}    Set Variable    ${api_response.json()}
    Log    ${api_data_body}

    ${id}    Set Variable    ${api_data_body}[id]
    Log    ${id}
    
    ${name}    Evaluate    $api_data_body['first_name'] + ' ' + $api_data_body['last_name']
    Log    ${name}

    ${email}    Set Variable    ${api_data_body}[email]
    Log    ${email}

    Click Element    ${CUSTOMER}
    Wait Until Element Is Visible    ${ADD_CUS_BUTTON}    2s
    Click Element    ${ADD_CUS_BUTTON}
    Wait Until Element Is Visible    ${ADD_CUS_NAME_INPUT_FIELD}    2s
    Input Text    ${ADD_CUS_NAME_INPUT_FIELD}    ${name}
    Input Text    ${ADD_CUS_EMAIL_INPUT_FIELD}    ${email}
    Input Text    ${ADD_CUS_COMMENT_INPUT_FIELD}   ${id}
    Click Element    ${ADD_CUS_SAVE_BUTTON}