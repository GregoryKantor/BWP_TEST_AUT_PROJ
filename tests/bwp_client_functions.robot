*** Settings ***
Resource    ../resources/common.resource
Test Setup    Test Setup
Test Teardown    Test Teardown

*** Test Cases ***
BWP Client Function Test
    Test Homepage Loaded

    Navigate To Customer Menu Element

    Get Random Data From API (NO PROXY)

    Create Partner Profile With API Data

    Verify Partner Profile Created

    Navigate To Location Menu Element

    Create Location Profile With API Data

    Verify Location Profile Created

    Get Random Device Data From API (NO PROXY)

    Navigate To Tool Menu Element

    Create Tool Profile With API Device Data    1

    Verify Tool Profile Created

    Create Tool Profile With API Device Data    2

    Verify Tool Profile Created

    Click On Excel Export Button And Verify Downloading

    Navigate To Location Menu Element

    Location Query With Searchbar Tool

    Get Location Info

    Verify Excel Matches Web Table

    Navigate To Tool Menu Element

    Search Last Created Tool

    Open Tool Profile Editor

    Activate Service Mode

    Navigate To Location Menu Element

    Scroll To The Last Added Partner

    Click On The Street URL And Verify Tool Info Page Loaded

    Verify Tool In Active Service Mode Removed From Partner Tool List On Location Info Page