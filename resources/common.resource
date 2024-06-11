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

# Other Variables
${BROWSER}    Chrome
${EXPECTED_TITLE}    BWP Index
${name}   
${id}    
${email}    

# Error messages


*** Keywords ***
Test Setup
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window

Test Teardown
    Close All Browsers