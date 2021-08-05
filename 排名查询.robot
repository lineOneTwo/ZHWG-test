*** Settings ***
Library           Selenium2Library
Library           RequestsLibrary
Library           collections
Library           OperatingSystem
Library           ExcellentLibrary
Library           HttpLibrary
Library           string
*** Variables ***

${server}       http://sqwytst.wt.com:14352/smart_community_information/
#${server}          http://sqwy.wt.com:5130/smart_community_information_correct

*** Test Cases ***
emergencyReport # 上报
    Open workbook    F:\\test.xlsx
    ${column_count}	  get column count	#读取表格中列数
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:E7  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
       ${emergencyTypeId}    set_variable    ${data_sheet[${x}][0]}   # 从第一列开始取值
       Log    ${emergencyTypeId}
       ${createBeginTime}    set_variable    ${data_sheet[${x}][1]}
       Log    ${createBeginTime}
       ${createEndTime}    set_variable    ${data_sheet[${x}][2]}
       Log    ${createEndTime}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   createBeginTime=${createBeginTime}    createEndTime=${createEndTime}   emergencyTypeId=${emergencyTypeId}   emergencyTypeQueryId=   queryId=129  queryIdType=   basicId=129
       Create Session  emergencyList  ${server}    headers=${header}
    # 发送请求
       ${resp}   post on session  emergencyList   /statisticalQuery/emergencyReport   ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
    # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook


emergencyReport # 办结
    Open workbook    F:\\test.xlsx
    ${column_count}	  get column count	#读取表格中列数
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:D7  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
       ${emergencyTypeId}    set_variable    ${data_sheet[${x}][0]}   # 从第一列开始取值
       Log    ${emergencyTypeId}
       ${createBeginTime}    set_variable    ${data_sheet[${x}][1]}
       Log    ${createBeginTime}
       ${createEndTime}    set_variable    ${data_sheet[${x}][2]}
       Log    ${createEndTime}
       ${emergencyTypeQueryId}    set_variable    ${data_sheet[1][3]}
       Log    ${emergencyTypeQueryId}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   createBeginTime=${createBeginTime}    createEndTime=${createEndTime}   emergencyTypeId=${emergencyTypeId}   emergencyTypeQueryId=${emergencyTypeQueryId}   queryId=129  queryIdType=   basicId=129
       Create Session  emergencyList  ${server}    headers=${header}
    # 发送请求
       ${resp}   post on session  emergencyList   /statisticalQuery/emergencyReport   ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
    # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook



rate  # 办结率
    Open workbook    F:\\test.xlsx
    ${column_count}	  get column count	#读取表格中列数
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:C7  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
       ${emergencyTypeId}    set_variable    ${data_sheet[${x}][0]}   # 从第一列开始取值
       Log    ${emergencyTypeId}
       ${createBeginTime}    set_variable    ${data_sheet[${x}][1]}
       Log    ${createBeginTime}
       ${createEndTime}    set_variable    ${data_sheet[${x}][2]}
       Log    ${createEndTime}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   createBeginTime=${createBeginTime}    createEndTime=${createEndTime}   emergencyTypeId=${emergencyTypeId}   emergencyTypeQueryId=   queryId=129  queryIdType=   basicId=129
       Create Session  emergencyList  ${server}    headers=${header}
    # 发送请求
       ${resp}   post on session  emergencyList   /statisticalQuery/emergencyCompletionRate   ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
    # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
       Should Be Equal As Strings    ${resp.json()['message']}    request successful
    END
    close workbook

excel  # 导出
    Open workbook    F:\\test.xlsx
    ${column_count}	  get column count	#读取表格中列数
    ${row_count}   get_row_count  #读取表格中行数
    ${data_sheet}   Read sheet data    cell_range=A1:E7  # 读取表中选定区域数据
    log many    ${data_sheet}
    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
       ${emergencyTypeId}    set_variable    ${data_sheet[${x}][0]}   # 从第一列开始取值
       Log    ${emergencyTypeId}
       ${createBeginTime}    set_variable    ${data_sheet[${x}][1]}
       Log    ${createBeginTime}
       ${createEndTime}    set_variable    ${data_sheet[${x}][2]}
       Log    ${createEndTime}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   createBeginTime=${createBeginTime}    createEndTime=${createEndTime}   emergencyTypeId=${emergencyTypeId}   emergencyTypeQueryId=   queryId=129  queryIdType=   basicId=129
       Create Session  emergencyList  ${server}    headers=${header}
    # 发送请求
       ${resp}   post on session  emergencyList   /statisticalQuery/excel/emergencyStatisticalReport   ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
    # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
    END


    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
       ${emergencyTypeId}    set_variable    ${data_sheet[${x}][0]}   # 从第一列开始取值
       Log    ${emergencyTypeId}
       ${createBeginTime}    set_variable    ${data_sheet[${x}][1]}
       Log    ${createBeginTime}
       ${createEndTime}    set_variable    ${data_sheet[${x}][2]}
       Log    ${createEndTime}
       ${emergencyTypeQueryId}    set_variable    ${data_sheet[1][3]}
       Log    ${emergencyTypeQueryId}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   createBeginTime=${createBeginTime}    createEndTime=${createEndTime}   emergencyTypeId=${emergencyTypeId}   emergencyTypeQueryId=${emergencyTypeQueryId}   queryId=129  queryIdType=   basicId=129
       Create Session  emergencyList  ${server}    headers=${header}
    # 发送请求
       ${resp}   post on session  emergencyList   /statisticalQuery/excel/emergencyStatisticalReport   ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
    # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
    END


    FOR    ${x}    IN RANGE     1   ${row_count}   # 从第二行开始取值
       ${emergencyTypeId}    set_variable    ${data_sheet[${x}][0]}   # 从第一列开始取值
       Log    ${emergencyTypeId}
       ${createBeginTime}    set_variable    ${data_sheet[${x}][1]}
       Log    ${createBeginTime}
       ${createEndTime}    set_variable    ${data_sheet[${x}][2]}
       Log    ${createEndTime}
       ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
       ${data}    Create Dictionary   createBeginTime=${createBeginTime}    createEndTime=${createEndTime}   emergencyTypeId=   emergencyTypeQueryId=   queryId=129  queryIdType=   basicId=129
       Create Session  emergencyList  ${server}    headers=${header}
    # 发送请求
       ${resp}   post on session  emergencyList   /statisticalQuery/excel/emergencyCompletionRate   ${data}
       # 获取http请求状态码
       Log  ${resp.status_code}
    # 获取本次的相应数据
       Log  ${resp.json}
       Should Be Equal As Strings    ${resp.status_code}    200
    END
    close workbook

*** Keywords ***
Provided precondition
    Setup system under test