/* .eslintrc.js */
const defaultEslint = require('@instructure/ui-eslint-config')
module.exports = Object.assign(
  {},
  defaultEslint,
  {
    extends: [
      ...defaultEslint.extends,
      "prettier"
    ],
    plugins: ["prettier"],
    rules: Object.assign(
      {},
      defaultEslint.rules,
      {
        'prettier/prettier': 'error',
        'notice/notice': [0],
        'no-case-declarations': [0],
        'no-undefined': [0],
        'semi': [0],
        'react/require-default-props': [0],
        'instructure-ui/no-relative-package-imports': [0]
      }
    )
  }
)
