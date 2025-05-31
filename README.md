# spriteCloud
This project is made for the automation challenge from spriteCloud. In this readme you can find more information regarding the solution.

# The Challenge
The challenge consists of two parts: UI & API Testing.
For the UI testing the following test cases have to be coded, making use of the url https://www.saucedemo.com:
  1. Write a full checkout that contains, at least, two items. Validate the final price.
  2. Write a test that sorts the items by name Z-A and validate that the sorting is correct.
  3. Write a validation for a failed log in.

For the API testing the following test cases have to be coded, making use of the url https://reqres.in:
  1. Retrieve a list of users
  2. Perform a successful login
  3. Perform an update
  4. Perform a deletion
  5. Execute 2 negative scenarios of your choice
  6. Execute a parameterized delayed request (max 3 seconds) and evaluate how long the
  request takes.

# Test results
The direct result of the testcases can be found at the github page https://jscramer.github.io/spriteCloud/ . Here a dashboard is visible with all the test results. By clicking on the test name it is possible to open the log from Robot Framework for more detailed information.

# Folder structure key components
- **testsuites/** </br>
Contains the Robot Framework test suites. This is split by the folders reqres and saucedemo. Within the testsuites you can find the seperate testcases.
- **resources/** </br>
Contains the shared resource files. Within the resources/ folder there is a split for reqres and saucedemo followed by the three folders: data, keywords & variables. In the data folder you can expect values such a the products.json file which stores the products in the inventory of saucedemo. In the keywords folder all keywords can be found that can be used for the testcases. These keywords are the more technical implication of what is seen in the testcases, this to ensure that the testcase is as readable as possible. At last we have the variables folder, this will store constant variables such as base urls and references to environment variables.
- **.github/workflows/** </br>
In this folder you can find the main.yml file. This file is used to define the CI/CD automation for the project.
- **requirements.txt** </br>
This file will be used to define the Python dependencies for the project.

# Tools used
-  **Robot Framework (RF)** <br />
_(https://robotframework.org/)_
Robot Framework is an open source automation framework. All of the tests are written within this framework. The framework is extended with mostly the libraries _Browser_ and _RequestsLibrary_. The Browser library is used for the UI testing, whereas the RequestsLibrary is used for the API testing.
-  **Robotmetrics** <br />
_(https://github.com/mkorpela/pabot](https://github.com/adiralashiva8/robotframework-metrics)_ <br />
Robotmetrics is a tool that uses the output from the tests in Robot Framework and turns into into a custom HTML report. This report provides a dashboard view, offering detailed insights into thetest executions, including suite statistics, test case results, and keyword performance. Making everything easier to read than the standard report from RF.
-  **Pabot** <br />
_(https://github.com/mkorpela/pabot)_ <br />
Pabot is a parallel test runner for RF. This allows the executions of tests in parallel on a single machine by multiple processes. For this project the default split execution on suite level is used; thus the execution of the API tests and the UI tests are being run at the same time.
-  **Robocop** <br />
_(https://robocop.readthedocs.io/en/stable/)_ <br />
Robocop 🤖 is a tool that performs static code analysis and formatting of Robot Framework code.
It uses official Robot Framework parsing API to parse files and runs number of checks, looking for potential errors or violations to code quality standards (commonly referred as linting issues). It can also format code to ensure consistent code style.

# Pipeline
The pipeline found in the main.yml file is set-up in two jobs:
 - **Robot Tests**<br />
 The robot tests is the main part of the pipeline. During this part the following steps are being done in order:
   1. Retrieve secrets and put them in the environment variables.
   2. Install Python and all Python dependencies of the project.
   3. Run the Robot Framework tests with the use of pabot.
   4. Merge the test results of every pabot run.
   5. Create the robotmetrics html file and upload all results together as artifact.      
 - **GitHub page deployment** <br />
 Once the Robot Tests part is done it will go straight into the Github page deployment. This is a rather small job which downloads the artifact made in step 5 of Robot Tests and deploys it to the GitHub page of the repository.

# Data test id
In the generic.resource file for the UI tests I placed keywords that are making use of the test-id that is used on the saucedemo site. The Browser library that is used makes use of Playwright which can search for elements by test-id. Unfortunately the test-id attribute is not the same as the default and there is no way for the Browser library to change it unlike in Playwright. This led to making keywords that use the right data-test id.

# Assumptions
- The server of ingres accepts operations on their data, but it does not actually save the changes (deletions/updates/creations etc.). This makes it impossible to verify the update by comparing the data before and after the update.
