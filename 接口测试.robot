*** Settings ***
Library           Selenium2Library
Library           RequestsLibrary
Library           collections
Library           OperatingSystem
Library           ExcellentLibrary
Library           HttpLibrary
Library           string
Library           JSONLibrary
Library           DatabaseLibrary

*** Variables ***
#${server}          http://sqwytst.wt.com:14352/smart_community_information
${server}          http://sqwy.wt.com:5130/smart_community_information_correct

*** Test Cases ***
post #post接口

    Open workbook    F:\\post.xlsx
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:E100  # 读取表中选定区域数据
    log many    ${data_sheet}
    connect to database    pymysql   test   root   123456   localhost   3306
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
        ${interfaceName}    set_variable    ${data_sheet[${x}][0]}
        ${url}    set_variable    ${data_sheet[${x}][1]}
        ${data}    set_variable    ${data_sheet[${x}][2]}
        ${status}    set_variable    ${data_sheet[${x}][3]}
        ${sql}       set_variable    ${data_sheet[${x}][4]}
        ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
        Create Session  url  ${server}    headers=${header}
        # 发送请求
        ${resp}   post on session  url   ${url}    data=${data}
        # 获取接口返回数据
        Log  ${resp.json}
        Should Be Equal As Strings    ${resp.status_code}    ${status}
        Should Be Equal As Strings    ${resp.json()['message']}    request successful
#        ${queryResults}        Query    ${sql}
#        Log many    ${queryResults}
    END
    close workbook

get #post接口

    Open workbook    F:\\get.xlsx
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:D100  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
        ${URL}    set_variable    ${data_sheet[${x}][1]}
        Log    ${URL}
        ${RESULT}    set_variable    ${data_sheet[${x}][2]}
        Log    ${RESULT}
        ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
        Log    ${DATA}
        Create Session  url  ${server}    headers=${header}
        # 发送请求
        ${resp}   get on session  url   ${URL}
        # 获取本次的相应数据
        Log  ${resp.json}
        Should Be Equal As Strings    ${resp.status_code}    ${RESULT}
        Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook
*** Keywords ***
Provided precondition
    Setup system under test