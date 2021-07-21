# JavaScript

JavaScript implementation

## how to run


1. Install dependencies  
    `npm install`
2. Make sure you have `config.json`
3. Run
    1. To generate random game field  
    `npm start random`  
    To generate random game field with custom height and width:  
    `npm start random 50 30`
    2. To get field from csv file  
    `npm start config.csv`


## Csv file format

Csv file format rules:
- alive cell is written `1`
- dead cell is written `0`
- delimeter is `,`
- no header
- no extra characters and whitespace


## Settings

In `config.json` you can set several options:
- height and width upper and lower bounds
- field output timeout
- strings to represent cells

