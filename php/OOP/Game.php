<?php

require_once __DIR__.'/Field.php';
require_once __DIR__.'/Config.php';

class Game
{
    public function __construct(Config $config, Field $field = null)
    {
        $this->field = $field;
        $this->config = $config;
    }

    public function setRandomField()
    {
        $this->field = new Field($this->config->get('width'), $this->config->get('height'));
        $this->field->populateRandomly();
    }

    public function play()
    {
        $i = 0;
        while (true) {
            echo "> $i".PHP_EOL.PHP_EOL;
            $this->field->output($this->config);

            $nextGenPoints = $this->field->getNextGenerationPoints();
            $this->field->setPoints($nextGenPoints);
            ++$i;
            usleep($this->config->get('timeout') * 1000);
            echo PHP_EOL.PHP_EOL.PHP_EOL;
        }
    }
}
