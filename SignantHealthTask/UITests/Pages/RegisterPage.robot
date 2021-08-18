*** Settings ***
Library  SeleniumLibrary
Resource  BasePage.robot

*** Variables ***
${REGISTER_LABEL} =  css:body section header h1
${REGISTER_FORM_USERNAME_LABEL} =  //section[@class="content"]/form/label[@for="username"]
${REGISTER_FORM_USERNAME_EDIT} =  id:username
${REGISTER_FORM_PASSWORD_LABEL} =  //section[@class="content"]/form/label[@for="password"]
${REGISTER_FORM_PASSWORD_EDIT} =  id:password
${REGISTER_FORM_FIRST_NAME_LABEL} =  //section[@class="content"]/form/label[@for="firstname"]
${REGISTER_FORM_FIRST_NAME_EDIT} =  id:firstname
${REGISTER_FORM_LAST_NAME_LABEL} =  //section[@class="content"]/form/label[@for="lastname"]
${REGISTER_FORM_LAST_NAME_EDIT} =  id:lastname
${REGISTER_FORM_PHONE_LABEL} =  //section[@class="content"]/form/label[@for="phone"]
${REGISTER_FORM_PHONE_EDIT} =  id:phone
${REGISTER_BUTTON} =  //section[@class="content"]/form/input[@value="Register" and @type="submit"]
${REGISTER_USER_ALREADY_EXIST_ALERT} =  //section[@class="content"]/div[@class="flash"]

*** Keywords ***
Open Register Page
    Page Should Contain Link  ${REGISTER_LINK}
    Click Link  ${REGISTER_LINK}
    Wait Until Element Is Visible  ${REGISTER_LABEL}
    Element Text Should Be  ${REGISTER_LABEL}  Register

Initialize Register Page
    Element Should Be Visible  ${REGISTER_LABEL}
    Element Text Should Be  ${REGISTER_LABEL}  Register
    Element Should Be Visible  ${REGISTER_FORM_USERNAME_LABEL}
    Element Text Should Be  ${REGISTER_FORM_USERNAME_LABEL}  Username
    Element Should Be Visible  ${REGISTER_FORM_USERNAME_EDIT}
    Element Should Be Visible  ${REGISTER_FORM_PASSWORD_LABEL}
    Element Text Should Be  ${REGISTER_FORM_PASSWORD_LABEL}  Password
    Element Should Be Visible  ${REGISTER_FORM_PASSWORD_EDIT}
    Check If Element Has Password Type  ${REGISTER_FORM_PASSWORD_EDIT}
    Element Should Be Visible  ${REGISTER_FORM_FIRST_NAME_LABEL}
    Element Text Should Be  ${REGISTER_FORM_FIRST_NAME_LABEL}  First name
    Element Should Be Visible  ${REGISTER_FORM_FIRST_NAME_EDIT}
    Element Should Be Visible  ${REGISTER_FORM_LAST_NAME_LABEL}
    Element Text Should Be  ${REGISTER_FORM_LAST_NAME_LABEL}  Family Name
    Element Should Be Visible  ${REGISTER_FORM_LAST_NAME_EDIT}
    Element Should Be Visible  ${REGISTER_FORM_PHONE_LABEL}
    Element Text Should Be  ${REGISTER_FORM_PHONE_LABEL}  Phone number
    Element Should Be Visible  ${REGISTER_FORM_PHONE_EDIT}
    Element Should Be Visible  ${REGISTER_BUTTON}

Check Register Page Required Elements
    Check If Element Is Not Required  ${REGISTER_LABEL}
    Check If Element Is Not Required  ${REGISTER_FORM_USERNAME_LABEL}
    Check If Element Is Required  ${REGISTER_FORM_USERNAME_EDIT}
    Check If Element Is Not Required  ${REGISTER_FORM_PASSWORD_LABEL}
    Check If Element Is Required  ${REGISTER_FORM_PASSWORD_EDIT}
    Check If Element Is Not Required  ${REGISTER_FORM_FIRST_NAME_LABEL}
    Check If Element Is Required  ${REGISTER_FORM_FIRST_NAME_EDIT}
    Check If Element Is Not Required  ${REGISTER_FORM_LAST_NAME_LABEL}
    Check If Element Is Required  ${REGISTER_FORM_LAST_NAME_EDIT}
    Check If Element Is Not Required  ${REGISTER_FORM_PHONE_LABEL}
    Check If Element Is Required  ${REGISTER_FORM_PHONE_EDIT}

Input Username
    [Arguments]  ${username}
    Element Should Be Visible  ${REGISTER_FORM_USERNAME_EDIT}
    Input Text  ${REGISTER_FORM_USERNAME_EDIT}  ${username}

Input First Name
    [Arguments]  ${first_name}
    Element Should Be Visible  ${REGISTER_FORM_FIRST_NAME_EDIT}
    Input Text  ${REGISTER_FORM_FIRST_NAME_EDIT}  ${first_name}

Input Last Name
    [Arguments]  ${last_name}
    Element Should Be Visible  ${REGISTER_FORM_LAST_NAME_EDIT}
    Input Text  ${REGISTER_FORM_LAST_NAME_EDIT}  ${last_name}

Input Username Password
    [Arguments]  ${password}
    Element Should Be Visible  ${REGISTER_FORM_PASSWORD_EDIT}
    Input Text  ${REGISTER_FORM_PASSWORD_EDIT}  ${password}

Input Phone Number
    [Arguments]  ${phone_number}
    Element Should Be Visible  ${REGISTER_FORM_PHONE_EDIT}
    Input Text  ${REGISTER_FORM_PHONE_EDIT}  ${phone_number}

Click Register Button
    Element Should Be Visible  ${REGISTER_BUTTON}
    Element Should Be Enabled  ${REGISTER_BUTTON}
    Click Button  ${REGISTER_BUTTON}
    ${is_alert_seen} =  run keyword and return status  Element Should Be Visible  ${REGISTER_USER_ALREADY_EXIST_ALERT}
    IF  ${is_alert_seen}
        Initialize Register Page
    ELSE
        Wait Until Element Is Not Visible  ${REGISTER_BUTTON}
    END

User Already Exists Alert Shown
    [Arguments]  ${user}
    Element Should Be Visible  ${REGISTER_USER_ALREADY_EXIST_ALERT}
    Element Text Should Be  ${REGISTER_USER_ALREADY_EXIST_ALERT}  User ${user} is already registered.