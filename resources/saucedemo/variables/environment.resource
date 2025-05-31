*** Settings ***
Documentation           All environment variables for the saucedemo testsuite


*** Variables ***
${SAUCEDEMO_URL}    https://www.saucedemo.com/
${BROWSER}          firefox
${HEADLESS}         ${True}
${USERNAME}         %{USERNAME}
${PASSWORD}         %{PASSWORD}
