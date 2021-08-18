*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${LOGO_LINK} =  Demo app
${REGISTER_LINK} =  Register
${LOG_IN_LINK} =  Log In

*** Keywords ***
Check If Element Has Password Type
    [Arguments]  ${element}
    ${is_required} =  Get Element Attribute  ${element}  type
    Should Be Equal As Strings  "password"  "${is_required}"

Check If Element Is Required
    [Arguments]  ${element}
    ${is_required} =  Get Element Attribute  ${element}  required
    Should Be Equal As Strings  "true"  "${is_required}"

Check If Element Is Not Required
    [Arguments]  ${element}
    ${is_required} =  Get Element Attribute  ${element}  required
    Should Be Equal As Strings  "None"  "${is_required}"

Inititalize Navigation
    Page Should Contain Link  ${LOGO_LINK}
    Page Should Contain Link  ${REGISTER_LINK}
    Page Should Contain Link  ${LOG_IN_LINK}