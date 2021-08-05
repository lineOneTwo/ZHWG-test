*** Settings ***
Library           Selenium2Library
Library           RequestsLibrary
Library           collections
Library           OperatingSystem
Library           ExcellentLibrary
Library           HttpLibrary
Library           string
*** Variables ***

${server}       http://sqwytst.wt.com:14352/smart_community_information
#${server}          http://sqwy.wt.com:5130/smart_community_information_correct

*** Test Cases ***
eventAcceptance # 事件受理统计表

    Open workbook    F:\\test.xlsx
    ${column_count}	  get column count	#读取表格中列数
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:G7  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
#       ${emergencyTypeId}    set_variable    ${data_sheet[${x}][0]}   # 从第一列开始取值
#       Log    ${emergencyTypeId}
       ${startTime}    set_variable    ${data_sheet[${x}][4]}
       Log    ${startTime}
       ${endTime}    set_variable    ${data_sheet[${x}][5]}
       Log    ${endTime}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   orgPostId=531   startTime=${startTime}   endTime=${endTime}
       Create Session  emergencyList  ${server}     headers=${header}
       # 发送请求
       ${Y}
       FOR   ${Y}  IN RANGE     1  ${row_count}
            ${url}    set_variable    ${data_sheet[${Y}][6]}
            Log    ${endTime}
            ${resp}   post on session  emergencyList   /assessment/${url}    ${data}
            # 获取http请求状态码
            Log  ${resp.status_code}
            # 获取本次的相应数据
            Log  ${resp.json}
            Should Be Equal As Strings    ${resp.status_code}    200
            Should Be Equal As Strings    ${resp.json()['message']}    request successful
       END
    END
    close workbook


eventTypeAcceptance # 事件上报类型统计表

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
       ${data}    Create Dictionary   orgPostId=531   startTime=${startTime}   endTime=${endTime}
       Create Session  emergencyList  ${server}     headers=${header}
       # 发送请求
       ${resp}   post on session  emergencyList   /assessment/eventTypeAcceptance    ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
       # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook


gridStaffEmergencyAcceptanceRankingResp  # 网格员事件受理排名

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
       ${data}    Create Dictionary   orgPostId=531   startTime=${startTime}   endTime=${endTime}    page=1   count=10
       Create Session  emergencyList  ${server}     headers=${header}
       # 发送请求
       ${resp}   post on session  emergencyList   /page/assessment/gridStaffEmergencyAcceptanceRankingResp    ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
       # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook


inspection  # 网格员巡查统计表

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
       ${data}    Create Dictionary   orgPostId=531   startTime=${startTime}   endTime=${endTime}
       Create Session  emergencyList  ${server}     headers=${header}
       # 发送请求
       ${resp}   post on session  emergencyList   /assessment/inspection    ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
       # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook


inspectionRanking  # 网格员巡查排名

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
       ${data}    Create Dictionary   orgPostId=531   startTime=${startTime}   endTime=${endTime}    page=1   count=10
       Create Session  emergencyList  ${server}     headers=${header}
       # 发送请求
       ${resp}   post on session  emergencyList   /assessment/inspectionRanking    ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
       # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook


personnelVisit  # 人员回访率排名表

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
       ${data}    Create Dictionary   orgPostId=531   startTime=${startTime}   endTime=${endTime}
       Create Session  emergencyList  ${server}     headers=${header}
       # 发送请求
       ${resp}   post on session  emergencyList   /assessment/personnelVisit    ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
       # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook

*** Keywords ***
Provided precondition
    Setup system under test