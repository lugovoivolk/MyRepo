*** Settings ***
Documentation  Testing User Registration Feature
Library  SeleniumLibrary
Library  ../Utilities/NameGenerator.py
Resource  ../Pages/DefaultPage.robot
Resource  ../Pages/BasePage.robot
Resource  ../Pages/RegisterPage.robot
Resource  ../Pages/LogInPage.robot
Resource  ../Pages/UserPage.robot
Resource  ../Pages/LogInErrorPage.robot
Variables  ../env_vars.py

Suite Setup  Start Browser
Suite Teardown  Close Browser

*** Test Cases ***
Test Default Page Appearance
    Inititalize Navigation
    Inititalize Default Page
Test Register Page Appearance
    Open Register Page
    Inititalize Navigation
    Initialize Register Page
    Check Register Page Required Elements
Test Log In Page Appearance
    Open Log In Page
    Inititalize Navigation
    Initialize Log In Page
    Check Log In Page Required Elements
Create User Information
    ${user_first_name} =  Get First Name
    ${user_last_name} =  Get Last Name
    ${username} =  Get Username  ${user_first_name}  ${user_last_name}
    ${user_password} =  Get Password
    ${user_phone_number} =  Get Phone Number
    Set Suite Variable  ${user_first_name}  ${user_first_name}
    Set Suite Variable  ${user_last_name}  ${user_last_name}
    Set Suite Variable  ${username}  ${username}
    Set Suite Variable  ${user_password}  ${user_password}
    Set Suite Variable  ${user_phone_number}  ${user_phone_number}
Test Register New User
    Open Register Page
    Input Username  ${username}
    Input First Name  ${user_first_name}
    Input Last Name  ${user_last_name}
    Input Username Password  ${user_password}
    Input Phone Number  ${user_phone_number}
    Click Register Button
Test Log In Registered User
    Open Log In Page
    Input Login Username  ${username}
    Input Login Password  ${user_password}
    Click Log In Button
Test User Personal Data
    Inititalize User Page
    Check Logged Username  ${username}
    Check Logged User First Name  ${user_first_name}
    Check Logged User Last Name  ${user_last_name}
    Check Logged User Phone  ${user_phone_number}
Test Log Out User
    Log Out User  ${username}
Test Register The Same User
    Open Register Page
    Input Username  ${username}
    Input First Name  ${user_first_name}
    Input Last Name  ${user_last_name}
    Input Username Password  ${user_password}
    Input Phone Number  ${user_phone_number}
    Click Register Button
    User Already Exists Alert Shown  ${username}
Test Not Registered User Log In
    Open Log In Page
    Input Login Username  ${user_password}
    Input Login Password  ${user_password}
    Click Log In Button
    Initialize Log In Error Page
    Log In Error Message Should Be Shown
Test Incorrect Password User Log In
    Open Log In Page
    Input Login Username  ${username}
    Input Login Password  ${username}
    Click Log In Button
    Initialize Log In Error Page
    Log In Error Message Should Be Shown
Test Return To Default Page
    Open Default Page
    Inititalize Default Page



*** Keywords ***
Start Browser
    Open Browser    ${LOGIN_URL}    ${BROWSER}
    Maximize Browser Window
