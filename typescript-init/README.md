## Prerequisites

#### Node

I am using [Node Version Manager](https://github.com/nvm-sh/nvm) and the latest LTS

#### ESLint on VSCode

Install [ESLint Extension](https://marketplace.visualstudio.com/items?itemName=dbaeumer.vscode-eslint)

## Execute from command line

Create a typescript project in your `current working directory` in a folder named `ts_app`:

```bash
curl -s https://raw.githubusercontent.com/ikatzarski/scripts/master/typescript-init/init-ts-project.sh | bash -s
```

Create a typescript project in your `current working directory` in a folder with a name of your choice, e.g., `playground`:

```bash
curl -s https://raw.githubusercontent.com/ikatzarski/scripts/master/typescript-init/init-ts-project.sh | bash -s playground
```

## Run index.ts file

```bash
npm start
```

## Run specific .ts file

```bash
npx ts-node src/index.ts
```

## Run all tests

```bash
npm test
```
