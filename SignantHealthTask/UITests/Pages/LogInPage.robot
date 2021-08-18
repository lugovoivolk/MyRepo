*** Settings ***
Library  SeleniumLibrary
Resource  BasePage.robot

*** Variables ***
${LOG_IN_LABEL} =  css:body section header h1
${LOG_IN_FORM_USERNAME_LABEL} =  //section[@class="content"]/form/label[@for="username"]
${LOG_IN_FORM_USERNAME_EDIT} =  id:username
${LOG_IN_FORM_PASSWORD_LABEL} =  //section[@class="content"]/form/label[@for="password"]
${LOG_IN_FORM_PASSWORD_EDIT} =  id:password
${LOG_IN_BUTTON} =  //section[@class="content"]/form/input[@value="Log In" and @type="submit"]



*** Keywords ***
Open Log In Page
    Page Should Contain Link  ${LOG_IN_LINK}
    Click Link  ${LOG_IN_LINK}
    Wait Until Element Is Visible  ${LOG_IN_LABEL}
    Element Text Should Be  ${LOG_IN_LABEL}  Log In

Initialize Log In Page
    Element Should Be Visible  ${LOG_IN_LABEL}
    Element Text Should Be  ${LOG_IN_LABEL}  Log In
    Element Should Be Visible  ${LOG_IN_FORM_USERNAME_LABEL}
    Element Text Should Be  ${LOG_IN_FORM_USERNAME_LABEL}  Username
    Element Should Be Visible  ${LOG_IN_FORM_USERNAME_EDIT}
    Element Should Be Visible  ${LOG_IN_FORM_PASSWORD_LABEL}
    Element Text Should Be  ${LOG_IN_FORM_PASSWORD_LABEL}  Password
    Element Should Be Visible  ${LOG_IN_FORM_PASSWORD_EDIT}
    Check If Element Has Password Type  ${LOG_IN_FORM_PASSWORD_EDIT}
    Element Should Be Visible  ${LOG_IN_BUTTON}

Check Log In Page Required Elements
    Check If Element Is Not Required  ${LOG_IN_LABEL}
    Check If Element Is Not Required  ${LOG_IN_FORM_USERNAME_LABEL}
    Check If Element Is Required  ${LOG_IN_FORM_USERNAME_EDIT}
    Check If Element Is Not Required  ${LOG_IN_FORM_PASSWORD_LABEL}
    Check If Element Is Required  ${LOG_IN_FORM_PASSWORD_EDIT}

Input Login Username
    [Arguments]  ${username}
    Element Should Be Visible  ${LOG_IN_FORM_USERNAME_EDIT}
    Input Text  ${LOG_IN_FORM_USERNAME_EDIT}  ${username}

Input Login Password
    [Arguments]  ${password}
    Element Should Be Visible  ${LOG_IN_FORM_PASSWORD_EDIT}
    Input Text  ${LOG_IN_FORM_PASSWORD_EDIT}  ${password}

Click Log In Button
    Element Should Be Visible  ${LOG_IN_BUTTON}
    Click Button  ${LOG_IN_BUTTON}
    Wait Until Element Is Not Visible  ${LOG_IN_BUTTON}