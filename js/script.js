import { Field } from './Field.js';
import * as fs from 'fs';


function getDataFromFile(filename) {
    let data;
    try {
        data = fs.readFileSync(filename, 'utf8');
    } catch (err) {
        console.error(err);
        process.exit();
    }
    return data;
}

function getDataFromCsvConfig(filename) {
    let points = getDataFromFile(filename);
    try {
        points = points.split('\n')
            .filter((value) => value)
            .map((value) => {
                    return value.split(',').map((value) => parseInt(value));
                }
            );
    } catch (err) {
        console.error(err);
        process.exit();
    }
    return points;
}

function getDataFromJsonConfig(filename) {
    let config = getDataFromFile(filename);;
    try {
        config = JSON.parse(fs.readFileSync(filename, 'utf8'));
    } catch (err) {
        console.error(err);
        process.exit();
    }
    return config;
}

function getRandomPoints(width, height) {
    let randomPoints = [];
    for (let y = 0; y < height; y += 1) {
        randomPoints[y] = getRandomArray(width);
    }
    return randomPoints;
}

function getRandomArray(length) {
    let randomArray = new Array(length);
    for (let i = 0; i < length; i += 1) {
        randomArray[i] = Math.floor(Math.random() * 2);
    }
    return randomArray;
}

function getRandomWidth(appConfig) {
    return appConfig.min_width + Math.floor(Math.random() * (appConfig.max_width - appConfig.min_width));
}

function getRandomHeight(appConfig) {
    return appConfig.min_height + Math.floor(Math.random() * (appConfig.max_height - appConfig.min_height));
}

function main() {
    if (process.argv.length < 3) {
        console.error('usage: node script.js <random [width] [height]|csv_field_filename>');
        process.exit();
    }
    const initialStateType = process.argv[2];
    
    console.log(`Game field initial state provider is ${initialStateType}`);

    const appConfig = getDataFromJsonConfig('config.json');

    let points = [];
    if (initialStateType === 'random') {
        const width = process.argv[3] || getRandomWidth(appConfig);
        const height = process.argv[4] || getRandomHeight(appConfig);
        console.log(`Width ${width}`);
        console.log(`Height ${height}`);
        points = getRandomPoints(width, height);
    } else {
        try {
            if (fs.existsSync(initialStateType)) {
                points = getDataFromCsvConfig(initialStateType);
            } else {
                console.error('csv field file not found');
                process.exit();
            }
        } catch (err) {
            console.error(err);
            process.exit();
        }
    }

    const field = new Field(points, appConfig);
    field.play();
}

main();
