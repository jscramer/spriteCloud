*** Settings ***
Documentation           All environment variables for the reqres testsuite


*** Variables ***
${REQRES_BASE_URL}      https://reqres.in/api
${API_KEY}              %{API_KEY}
${EMAIL_API}            %{EMAIL_API}
${PASSWORD_API}         %{PASSWORD_API}
${HEADERS}              {"x-api-key": "${API_KEY}"}
${MAX_RESPONSE_TIME}    1.0
