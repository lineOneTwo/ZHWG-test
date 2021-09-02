*** Settings ***
Library           Selenium2Library
Library           RequestsLibrary
Library           collections
Library           OperatingSystem
Library           ExcellentLibrary
Library           HttpLibrary
Library           string
*** Variables ***

#${server}       http://sqwytst.wt.com:14352/smart_community_information/
${server}          http://sqwy.wt.com:5130/smart_community_information_correct

*** Test Cases ***
eventTypeInformation # 事件类型详情分析表

    Open workbook    F:\\test.xlsx
    ${column_count}	  get column count	#读取表格中列数
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:F7  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
#       ${emergencyTypeId}    set_variable    ${data_sheet[${x}][0]}   # 从第一列开始取值
#       Log    ${emergencyTypeId}
       ${startTime}    set_variable    ${data_sheet[${x}][4]}
       Log    ${startTime}
       ${endTime}    set_variable    ${data_sheet[${x}][5]}
       Log    ${endTime}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   orgPostId=531   startTime=${startTime}   endTime=${endTime}   disTreeCode=129
       Create Session  emergencyList  ${server}     headers=${header}
       # 发送请求
       ${resp}   post on session  emergencyList   /comprehensive/eventTypeInformation    ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
       # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook

eventType  #事件类型分析表
    Open workbook    F:\\test.xlsx
    ${column_count}	  get column count	#读取表格中列数
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:F7  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
#       ${emergencyTypeId}    set_variable    ${data_sheet[${x}][0]}   # 从第一列开始取值
#       Log    ${emergencyTypeId}
       ${startTime}    set_variable    ${data_sheet[${x}][4]}
       Log    ${startTime}
       ${endTime}    set_variable    ${data_sheet[${x}][5]}
       Log    ${endTime}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   orgPostId=531   startTime=${startTime}   endTime=${endTime}   disTreeCode=129
       Create Session  emergencyList  ${server}    headers=${header}
       # 发送请求
       ${resp}   post on session  emergencyList   /comprehensive/eventType    ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
       # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook

export  # 导出
    Open workbook    F:\\test.xlsx
    ${column_count}	  get column count	#读取表格中列数
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:F7  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
       ${startTime}    set_variable    ${data_sheet[${x}][4]}
       Log    ${startTime}
       ${endTime}    set_variable    ${data_sheet[${x}][5]}
       Log    ${endTime}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   orgPostId=531   startTime=${startTime}   endTime=${endTime}   disTreeCode=129
       Create Session  emergencyList  ${server}    headers=${header}
    # 发送请求
       ${resp}   post on session  emergencyList   /comprehensive/eventTypeInformation/export   ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
    # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
    END

*** Keywords ***
Provided precondition
    Setup system under test