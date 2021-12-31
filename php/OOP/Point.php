<?php

require_once __DIR__.'/Config.php';

class Point
{
    public $isAlive;

    public function __construct(bool $isAlive)
    {
        $this->isAlive = $isAlive;
    }

    public function toString(Config $config): string
    {
        return ($this->isAlive) ? $config->get('alive') : $config->get('dead');
    }
}
