*** Settings ***
Library           DatabaseLibrary

*** Test Cases ***
#Test title
#    [Tags]    DEBUG
#    Provided precondition
#    When action
#    Then check expectations
sql
    # explicitly specifies all db property values
    connect to database    pymysql   test   root   123456   localhost   3306
    ${queryResults}        Query    select * from test.table_text
    Log many    ${queryResults}

*** Keywords ***
Provided precondition
    Setup system under test