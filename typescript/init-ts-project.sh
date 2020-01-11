#!/bin/bash

log_action() {
    echo "===> [`date`] === $1"
}

log_result() {
    STATUS_CODE=$?
    if [ $STATUS_CODE -eq 0 ]
    then 
        echo "===> [`date`] === SUCCESS"
    else
        echo "===> [`date`] === FAIL (Status Code: $STATUS_CODE)"
    fi
}

log_variable_content() {
    if [ -z $1 ]
    then
        echo "===> [`date`] === FAIL (Variable is Empty)"
    else
        echo "===> [`date`] === SUCCESS ($1)"
    fi
}

log_action 'Set app folder'
PASSED_ARGUMENT=$1
set_app_folder() {
    if [ -z $PASSED_ARGUMENT ]
    then
        echo 'ts_app'
    else
        echo $PASSED_ARGUMENT
    fi
}
APP_FOLDER=`set_app_folder`
log_variable_content $APP_FOLDER

log_action 'Get current working directory'
CURRENT_DIRECTORY=`pwd`
log_variable_content $CURRENT_DIRECTORY

log_action 'Set app working directory'
WORKING_DIRECTORY="$CURRENT_DIRECTORY/$APP_FOLDER"
log_variable_content $WORKING_DIRECTORY

log_action 'Create app working directory'
mkdir $WORKING_DIRECTORY
log_result

log_action 'Enter app working directory'
cd $WORKING_DIRECTORY
log_result

log_action 'Initialize yarn project'
yarn init -y
log_result

log_action 'Add typescript as dev dependency'
yarn add typescript --dev
log_result

log_action 'Create typescript config file'
touch tsconfig.json
log_result

log_action 'Add typescript config to config file'
echo '{
    "compilerOptions": {
        "target": "es5",
        "module": "commonjs",
        "sourceMap": true,
        "outDir": "dist",
        "strict": true,
        "esModuleInterop": true,
        "forceConsistentCasingInFileNames": true
    }
}' > tsconfig.json
log_result

log_action 'Add jest, the jest types and ts-jest as dev dependencies'
yarn add jest @types/jest ts-jest --dev
log_result

log_action 'Create jest config file'
touch jest.config.js
log_result

log_action 'Add jest config to config file'
echo "module.exports = {
    roots: ['<rootDir>/src'],
    testMatch: [
        '**/__tests__/**/*.+(ts|tsx|js)',
        '**/?(*.)+(spec|test).+(ts|tsx|js)'
    ],
    transform: {
        '^.+\\.(ts|tsx)$': 'ts-jest'
    }
};" > jest.config.js
log_result

log_action 'Add ts-node as dev dependency'
yarn add ts-node --dev
log_result

log_action 'Add tslint as dev dependency'
yarn add tslint --dev
log_result

log_action 'Create tslint config file'
touch tslint.json
log_result

log_action 'Add tslint config to config file'
echo '{
    "defaultSeverity": "error",
    "extends": ["tslint:recommended"],
    "jsRules": {},
    "rules": {
        "quotemark": [true, "single", "avoid-escape", "avoid-template"],
        "no-console": [false]
    },
    "rulesDirectory": []
}' > tslint.json
log_result

log_action 'Add prettier as dev dependency'
yarn add prettier --dev
log_result


log_action 'Create prettier config file'
touch .prettierrc
log_result

log_action 'Add prettier config to config file'
echo '{
    "tabWidth": 4,
    "singleQuote": true
}' > .prettierrc
log_result

log_action 'Create source code directory'
mkdir src
log_result

log_action 'Create sample typescript file'
touch src/index.ts
log_result

log_action 'Add sample code to typescript file'
echo "export const sayHello = () => {
    return 'hello';
};

console.log('hello');" > src/index.ts
log_result

log_action 'Create sample typescript test file'
echo "import { sayHello } from './index';

describe('sayHello', () => {
    test('should return hello', () => {
        expect(sayHello()).toBe('hello');
    });
});" > src/index.test.ts
log_result

log_action 'Run jest tests'
yarn jest
log_result

log_action 'Run typescript file'
yarn ts-node src/index.ts
log_result