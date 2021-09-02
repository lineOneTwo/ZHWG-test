*** Settings ***
Library           Selenium2Library
Library           RequestsLibrary
Library           collections
Library           OperatingSystem
Library           ExcellentLibrary
Library           HttpLibrary
Library           string
Library           JSONLibrary

*** Variables ***
#${server}          http://sqwytst.wt.com:14352/smart_community_information
${server}          http://sqwy.wt.com:5130/smart_community_information_correct

*** Test Cases ***
post #post接口

    Open workbook    F:\\post.xlsx
    Switch sheet     Sheet2
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data     cell_range=A1:D2  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1     ${row_count}   # 从第二行开始取值
        ${url}    set_variable    ${data_sheet[${x}][1]}
        Log    ${url}
        ${data}    set_variable    ${data_sheet[${x}][2]}
        Log    ${data}
        ${status}    set_variable    ${data_sheet[${x}][3]}
        Log    ${status}
        ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
        Log    ${header}
        Create Session  url  ${server}    headers=${header}
        # 发送请求
        ${resp}   post on session  url   ${url}    data=${data}
        # 获取接口返回数据
        Log  ${resp.json}
        Should Be Equal As Strings    ${resp.status_code}    ${status}
        Should Be Equal As Strings    ${resp.json()['message']}    request successful
        ${applyId}      Get Value From Json    ${resp.json()['data']}    $..applyId
        Log  ${applyId}
    END
    close workbook

*** Keywords ***
Provided precondition
    Setup system under test