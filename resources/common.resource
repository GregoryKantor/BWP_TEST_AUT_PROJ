*** Settings ***
Library    SeleniumLibrary

*** Variables ***
# URLs
${HOMEPAGE_URL}    https://bwpool.azurewebsites.net/
${WORKS_URL}    https://bwpool.azurewebsites.net/Works
${CUSTOMER_URL}    https://bwpool.azurewebsites.net/Customer
${LOCATION_URL}    https://bwpool.azurewebsites.net/Location
${REMINDER_URL}    https://bwpool.azurewebsites.net/Reminder
${TOOL_URL}    https://bwpool.azurewebsites.net/Tool
${REPORT_URL}    https://bwpool.azurewebsites.net/Report

# Locators
${HOME_BUTTON}    //a[.='BWP nyilvántartó']
${CALENDAR_BUTTON}      //a[contains(.,'Naptár')]
${WORKS_BUTTON}    //a[contains(.,'Munkák')]
${CUSTOMER_BUTTON}    //a[contains(.,'Partnerek')]
${LOCATION_BUTTON}    //a[contains(.,'Telephelyek')]
${REMINDER_BUTTON}    //a[contains(.,'Emlékeztetők')]
${TOOL_BUTTON}    //a[contains(.,'Eszközök')]
${TOOL_BUTTON}    //a[contains(.,'Riportok')]

# Other Variables
${BROWSER}    Chrome

# Error messages


*** Keywords ***
Test Setup
    Open Browser    ${HOMEPAGE_URL}    ${BROWSER}
    Maximize Browser Window

Test Teardown
    Close All Browsers