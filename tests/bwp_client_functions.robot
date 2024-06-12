*** Settings ***
Resource    ../resources/common.resource
Test Setup    Test Setup
Test Teardown    Test Teardown

*** Test Cases ***
BWP Client Function Test
    Test Homepage Loaded

    Navigate To Partner Menu Element

    Get Random Data From API (NO PROXY)

    Create Partner Profile With API Data