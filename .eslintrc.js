module.exports = {
    "env": {
        "browser": true
    },
    "extends": [
        "p5js",
        "p5js/dom",
        "google"
    ],
    "globals": {
        "Atomics": "readonly",
        "SharedArrayBuffer": "readonly",
        "draw" : "writeable",
        "preload" : "writeable",
        "circle" :"writeable"
    },
    "parserOptions": {
        "ecmaVersion": 2018
    },
    "rules": {
        "semi": ["error", "always"],
        "require-jsdoc" : 0,
        "linebreak-style": ["error", "windows"]
    }
};