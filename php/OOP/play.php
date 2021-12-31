<?php

require_once __DIR__.'/Game.php';
require_once __DIR__.'/Field.php';
require_once __DIR__.'/Point.php';
require_once __DIR__.'/Config.php';

echo 'welcome'.PHP_EOL;

$config = new Config();
$config->validate();
$game = new Game($config);
$game->setRandomField();
$game->play();
