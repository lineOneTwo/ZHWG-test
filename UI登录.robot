*** Settings ***
Library           Selenium2Library

*** Test Cases ***
test01
    [Documentation]    测试淘宝
    Open Browser    https://login.taobao.com/member/login.jhtml    chrome
#    Click Element    xpath=//*[@id="J_Quick2Static"]
    Sleep    1
    Input Text    xpath=//*[@id="fm-login-id"]    123
    Input Text    xpath=//*[@id="fm-login-password"]    123
    ${title_1}    Get Title
    Click Button     xpath=//*[@id="login-form"]/div[4]/button
    Sleep     2
    ${title_2}    Get Title
    should not contain    ${title_2}    ${title_1}
    Close browser