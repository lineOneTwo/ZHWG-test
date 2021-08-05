*** Settings ***
Library  RequestsLibrary

*** Variables ***
${host}         sqwytst.wt.com:14352
${server}          http://${host}/smart_community_information

*** Test Cases ***
emergencyList-post #事件列表接口

    ${header}  Create Dictionary   Content-Type=application/x-www-form-urlencoded
    ${data}    Create Dictionary   userAcceptance=0  userId=201  pageNum=1  count=10  startDate=   endDate=   emergencyStatus=   emergencyTypeOneId=  emergencyTypeTwoId=  orgId=100  orgSubsetCode=  emergencyTitle=  ifThisOrg=
    Create Session  emergencyList  http://sqwytst.wt.com:14352/smart_community_information    headers=${header}
    # 发送请求
    ${resp}   post on session  emergencyList   /search/emergency/1/10    ${data}
    # 获取http请求状态码
    Log  ${resp.status_code}
    # 获取本次的相应数据
    Log  ${resp.json}
    Should Be Equal As Strings    ${resp.status_code}    200
    Should Be Equal As Strings    ${resp.json()['message']}    request successful


*** Keywords ***
Provided precondition
    Setup system under test