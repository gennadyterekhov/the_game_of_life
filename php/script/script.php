<?php

function echol(string $line)
{
    echo $line.PHP_EOL;
}

function echoField(array $points, string $aliveStr, string $deadStr): void
{
    foreach ($points as $line) {
        foreach ($line as $point) {
            if ($point) {
                echo $aliveStr;
            } else {
                echo $deadStr;
            }
        }
        echo PHP_EOL;
    }
}

function populateFieldRandomly(int $width, int $height): array
{
    $points = [];

    for ($i = 0; $i < $height; ++$i) {
        $points[] = [];
        for ($j = 0; $j < $width; ++$j) {
            $points[$i][$j] = rand(0, 1);
        }
    }

    return $points;
}

function getNextGenPoints(array $points): array
{
    $nextGenPoints = [];
    foreach ($points as $i => $line) {
        $nextGenPoints[] = [];
        foreach ($line as $j => $point) {
            $nextGenPoints[$i][$j] = true === getNextGenPoint($points, $j, $i) ? 1 : 0;
        }
    }

    return $nextGenPoints;
}

function getNextGenPoint(array $points, int $x, int $y): bool
{
    $aliveNeighbours = countAliveNeighbours($points, $x, $y);
    $isAlive = 1 === $points[$y][$x];

    return ($isAlive && 2 === $aliveNeighbours) || (3 === $aliveNeighbours);
}

function countAliveNeighbours(array $points, int $x, int $y): int
{
    $aliveCount = 0;
    $startX = $x - 1;
    $startY = $y - 1;
    $endX = $x + 1;
    $endY = $y + 1;

    for ($i = $startY; $i <= $endY; ++$i) {
        for ($j = $startX; $j <= $endX; ++$j) {
            $samePoint = (($i === $y) && ($j === $x));
            if ((isPointInside($points, $j, $i)) && (!$samePoint)) {
                $aliveCount += $points[$i][$j];
            }
        }
    }

    return $aliveCount;
}

function isPointInside(array $points, int $x, int $y): bool
{
    $xOk = ($x >= 0) && ($x < count($points[0]));
    $yOk = ($y >= 0) && ($y < count($points));

    return $xOk && $yOk;
}

function play(array $config): void
{
    $points = populateFieldRandomly($config['width'], $config['height']);

    $i = 0;
    $iterationLimit = 1000;
    while ($i < $iterationLimit) {
        echol("> $i".PHP_EOL);

        echoField($points, $config['alive'], $config['dead']);

        $nextGenPoints = getNextGenPoints($points);
        $points = $nextGenPoints;
        ++$i;
        usleep($config['timeout'] * 1000);
        echo PHP_EOL.PHP_EOL.PHP_EOL;
    }
}

function getConfig(string $configFilename): array
{
    $jsonStr = file_get_contents($configFilename);
    $config = json_decode($jsonStr, true);
    if (null === $config) {
        echol('invalid json in config file');
        exit();
    }

    return $config;
}

function validateConfig(array $config): void
{
    $fields = [
        'timeout',
        'height',
        'width',
        'alive',
        'dead',
    ];

    foreach ($fields as $field) {
        if (!array_key_exists($field, $config)) {
            echol('config error: field '.$field.' does not exist');
            exit();
        }
    }
}

if (count($argv) > 1) {
    $configFilename = $argv[1];
} else {
    $configFilename = __DIR__.'/../config.json';
}
$config = getConfig($configFilename);
validateConfig($config);

play($config);
