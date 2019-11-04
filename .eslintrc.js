module.exports = {
  env: {
    es6: true,
    browser: true
  },
  parserOptions: { ecmaVersion: 6 },
  extends: ['p5js', 'p5js/dom', 'google'],
  globals: {
    Atomics: 'readonly',
    SharedArrayBuffer: 'readonly',
    draw: 'writable',
    preload: 'writable',
    circle: 'writeable'
  },
  parserOptions: {
    ecmaVersion: 6
  },
  rules: {
    semi: ['error', 'always'],
    'require-jsdoc': 0,
    'linebreak-style': ['error', 'windows']
  }
};
