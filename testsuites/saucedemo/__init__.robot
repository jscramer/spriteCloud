*** Settings ***
Documentation       This init file will be run before every single file within the same folder. This allows some repetitive task to be just written once.
Resource            ../../resources/saucedemo/keywords/generic.resource

Test Setup          Open Site              url=${SAUCEDEMO_URL}    new_browser=Yes
Test Teardown       Run Keywords           Delete All Cookies      Close Browser
