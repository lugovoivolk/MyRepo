*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${USER_PAGE_LABEL} =  css:body section header h1
${USER_LOGGED} =  //nav/ul/li[1]/span
${USER_LOG_OUT_LINK} =  Log Out
${USER_TABLE_USERNAME_LABEL} =  //section[@class="content"]/table/tbody/tr/td[@id="username"]/preceding-sibling::td
${USER_TABLE_USERNAME_VALUE} =  id:username
${USER_TABLE_FIRST_NAME_LABEL} =  //section[@class="content"]/table/tbody/tr/td[@id="firstname"]/preceding-sibling::td
${USER_TABLE_FIRST_NAME_VALUE} =  id:firstname
${USER_TABLE_LAST_NAME_LABEL} =  //section[@class="content"]/table/tbody/tr/td[@id="lastname"]/preceding-sibling::td
${USER_TABLE_LAST_NAME_VALUE} =  id:lastname
${USER_TABLE_PHONE_LABEL} =  //section[@class="content"]/table/tbody/tr/td[@id="phone"]/preceding-sibling::td
${USER_TABLE_PHONE_VALUE} =  id:phone

*** Keywords ***
Inititalize User Page
    Title Should Be  User Information - Demo App
    Element Text Should Be  ${USER_PAGE_LABEL}  User Information
    Element Should Be Visible  ${USER_TABLE_USERNAME_LABEL}
    Element Should Be Visible  ${USER_TABLE_USERNAME_VALUE}
    Element Should Be Visible  ${USER_TABLE_FIRST_NAME_LABEL}
    Element Should Be Visible  ${USER_TABLE_FIRST_NAME_VALUE}
    Element Should Be Visible  ${USER_TABLE_LAST_NAME_LABEL}
    Element Should Be Visible  ${USER_TABLE_LAST_NAME_VALUE}
    Element Should Be Visible  ${USER_TABLE_PHONE_LABEL}
    Element Should Be Visible  ${USER_LOGGED}

Check Logged Username
    [Arguments]  ${username}
    Element Text Should Be  ${USER_TABLE_USERNAME_VALUE}  ${username}

Check Logged User First Name
    [Arguments]  ${first_name}
    Element Text Should Be  ${USER_TABLE_FIRST_NAME_VALUE}  ${first_name}

Check Logged User Last Name
    [Arguments]  ${last_name}
    Element Text Should Be  ${USER_TABLE_LAST_NAME_VALUE}  ${last_name}

Check Logged User Phone
    [Arguments]  ${phone}
    Element Text Should Be  ${USER_TABLE_PHONE_VALUE}  ${phone}

Log Out User
    [Arguments]  ${username}
    Element Text Should Be  ${USER_LOGGED}  ${username}
    Click Link  ${USER_LOG_OUT_LINK}
    Page Should Not Contain  ${username}