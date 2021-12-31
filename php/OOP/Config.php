<?php

class Config
{
    public const DEFAULT_FILENAME = __DIR__.'/../config.json';

    public $filename;

    private $config;

    public function __construct($filename = null)
    {
        $this->filename = $filename;
    }

    public function getConfig(string $configFilename): array
    {
        $jsonStr = file_get_contents($configFilename);
        $config = json_decode($jsonStr, true);
        if (null === $config) {
            echol('invalid json in config file');
            exit();
        }

        return $config;
    }

    public function get(string $varName)
    {
        if (array_key_exists($varName, $this->config)) {
            return $this->config[$varName];
        }

        return null;
    }

    public function validate(): void
    {
        if (null === $this->filename) {
            $this->filename = self::DEFAULT_FILENAME;
        }
        if (!file_exists($this->filename)) {
            echo 'config not found'.PHP_EOL;
            exit();
        }

        $fields = [
            'timeout',
            'height',
            'width',
            'alive',
            'dead',
        ];

        $jsonStr = file_get_contents($this->filename);
        $config = json_decode($jsonStr, true);
        if (null === $config) {
            echol('invalid json in config file');
            exit();
        }

        $this->config = $config;

        foreach ($fields as $field) {
            if (!array_key_exists($field, $this->config)) {
                echol('config error: field '.$field.' does not exist');
                exit();
            }
        }
    }
}
