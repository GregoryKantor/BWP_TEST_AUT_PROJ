# BWP Website Test Automation
This is a Robot Framework test automation project for the BWP nyilvántartó website (https://bwpool.azurewebsites.net). The project includes a test case covering various customer functionalities of the website.

## Prerequisites
- Python 3.x (Robot Framework is Python-based)
- Robot Framework (Installation: ```pip install robotframework```)
- Robot Framework SeleniumLibrary (Installation: ```pip install --upgrade robotframework-seleniumlibrary```)

## Installation
1. Clone the repository:
```
git clone https://github.com/GregoryKantor/BWP_TEST_AUT_PROJ
```

2. Navigate to the project directory:
```
cd BWP_TEST_AUT_PROJ
```

3. Install the required Python libraries:
```
pip install -r requirements.txt
```

## Running Tests
To run the entire test suite, use the following command:

```
robot -d ./results ./tests
```

This will execute all the test cases and generate a report and log files in the results directory.

You can also run specific test cases or suites by providing their respective paths. For example:
```
robot -d ./results ./tests/bwp_client_functions.robot
```

This will run only the test cases in the login_tests.robot file.

## Test Cases
The project includes the following test cases:

- bwp_client_functions.robot
