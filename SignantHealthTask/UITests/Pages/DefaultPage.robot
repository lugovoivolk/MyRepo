*** Settings ***
Library  SeleniumLibrary
Resource  BasePage.robot

*** Variables ***
${DEFAULT_PAGE_LABEL} =  css:body section header h1

*** Keywords ***
Inititalize Default Page
    Element Should Be Visible  ${DEFAULT_PAGE_LABEL}

Open Default Page
    Page Should Contain Link  ${LOGO_LINK}
    Click Link  ${LOGO_LINK}
    Wait Until Element Is Visible  ${DEFAULT_PAGE_LABEL}
    Title Should Be  index page - Demo App
    Element Text Should Be  ${DEFAULT_PAGE_LABEL}  index page
