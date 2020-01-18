## Prerequisites

Please install [Yarn](https://yarnpkg.com/en/)

## Not working

TSLint and Prettier do not currently work in VSCode. WebStorm picks up the linter and Prettier configuration files succesfully.

## Execute from command line

- Create a typescript project in your `current working directory` in a folder named `ts_app`:

```bash
curl -s https://raw.githubusercontent.com/ikatzarski/scripts/master/typescript/init-ts-project.sh | bash -s
```

- Create a typescript project in your `current working directory` in a folder with a name of your choice, e.g., `playground`:

```bash
curl -s https://raw.githubusercontent.com/ikatzarski/scripts/master/typescript/init-ts-project.sh | bash -s playground
```