*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${ERROR_PAGE_LABEL} =  css:body section header h1
${ERROR_PAGE_MESSAGE} =  css:body section p

*** Keywords ***
Initialize Log In Error Page
    Element Should Be Visible  ${ERROR_PAGE_LABEL}
    Element Text Should Be  ${ERROR_PAGE_LABEL}  Login Failure

Log In Error Message Should Be Shown
    Element Should Be Visible  ${ERROR_PAGE_MESSAGE}
    element should contain  ${ERROR_PAGE_MESSAGE}  You provided incorrect login details