<?php

require_once __DIR__.'/Point.php';
require_once __DIR__.'/Config.php';

class Field
{
    public $width;
    public $height;
    public $points;

    public function __construct(int $width, int $height)
    {
        $this->width = $width;
        $this->height = $height;
        $this->points = [];
    }

    public function populateRandomly()
    {
        for ($i = 0; $i < $this->height; ++$i) {
            $this->points[] = [];
            for ($j = 0; $j < $this->width; ++$j) {
                $randomValue = rand(0, 1);
                $this->points[$i][$j] = new Point($randomValue);
            }
        }
    }

    public function setPoints(array $newPoints)
    {
        $this->points = $newPoints;
    }

    public function getNextGenerationPoints()
    {
        $nextGenPoints = [];
        foreach ($this->points as $i => $line) {
            $nextGenPoints[] = [];
            foreach ($line as $j => $point) {
                $nextGenPoints[$i][$j] = new Point($this->getNextGenerationPoint($j, $i));
            }
        }

        return $nextGenPoints;
    }

    public function getNextGenerationPoint(int $x, int $y): bool
    {
        $aliveNeighbours = $this->countAliveNeighbours($x, $y);
        $isAlive = 1 === $this->points[$y][$x];

        return ($isAlive && 2 === $aliveNeighbours) || (3 === $aliveNeighbours);
    }

    public function countAliveNeighbours(int $x, int $y): int
    {
        $aliveCount = 0;
        $startX = $x - 1;
        $startY = $y - 1;
        $endX = $x + 1;
        $endY = $y + 1;

        for ($i = $startY; $i <= $endY; ++$i) {
            for ($j = $startX; $j <= $endX; ++$j) {
                $samePoint = (($i === $y) && ($j === $x));
                if (($this->isPointInside($j, $i)) && (!$samePoint)) {
                    $aliveCount += (int) $this->points[$i][$j]->isAlive;
                }
            }
        }

        return $aliveCount;
    }

    public function isPointInside(int $x, int $y): bool
    {
        $xOk = ($x >= 0) && ($x < count($this->points[0]));
        $yOk = ($y >= 0) && ($y < count($this->points));

        return $xOk && $yOk;
    }

    public function output(Config $config)
    {
        foreach ($this->points as $line) {
            foreach ($line as $point) {
                // echo $point;
                echo $point->toString($config);
            }
            echo PHP_EOL;
        }
    }
}
