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