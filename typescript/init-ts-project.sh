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

log_value_of_variable() {
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
    echo 'ts-app'
  else
    echo $PASSED_ARGUMENT
  fi
}
APP_FOLDER=`set_app_folder`
log_value_of_variable $APP_FOLDER

log_action 'Get current working directory'
CURRENT_DIRECTORY=`pwd`
log_value_of_variable $CURRENT_DIRECTORY

log_action 'Set app working directory'
WORKING_DIRECTORY="$CURRENT_DIRECTORY/$APP_FOLDER"
log_value_of_variable $WORKING_DIRECTORY

log_action 'Create app working directory'
mkdir $WORKING_DIRECTORY
log_result

log_action 'Enter app working directory'
cd $WORKING_DIRECTORY
log_result

log_action 'Initialize project'
npm init -y
log_result

log_action 'Install typescript as dev dependency'
npm i -D typescript
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

log_action 'Install jest, the jest types and ts-jest as dev dependencies'
npm i -D jest @types/jest ts-jest
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
    '^.+.(ts|tsx)$': 'ts-jest'
  }
};" > jest.config.js
log_result

log_action 'Install ts-node as dev dependency'
npm i -D ts-node
log_result

log_action 'Install eslint, typescript eslint parser and plugin as dev dependencies'
npm i -D eslint @typescript-eslint/parser @typescript-eslint/eslint-plugin
log_result

log_action 'Create eslint config file'
touch .eslintrc
log_result

log_action 'Add eslint config to config file'
echo '{
  "parser": "@typescript-eslint/parser",
  "extends": [
    "plugin:@typescript-eslint/recommended",
    "prettier/@typescript-eslint",
    "plugin:prettier/recommended"
  ],
  "parserOptions": {
    "ecmaVersion": 2018,
    "sourceType": "module"
  },
  "rules": {}
}' > .eslintrc
log_result

log_action 'Install prettier and the eslint prettier config and plugin as dev dependencies'
npm i -D prettier eslint-config-prettier eslint-plugin-prettier
log_result

log_action 'Create prettier config file'
touch .prettierrc
log_result

log_action 'Add prettier config to config file'
echo '{
  "tabWidth": 2,
  "singleQuote": true,
  "trailingComma": "none"
}' > .prettierrc
log_result

log_action 'Create source code directory'
mkdir src
log_result

log_action 'Create sample typescript file'
touch src/index.ts
log_result

log_action 'Add sample code to typescript file'
echo "export const sayHello = (): string => {
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
npx jest
log_result

log_action 'Run typescript file'
npx ts-node src/index.ts
log_result