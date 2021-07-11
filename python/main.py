import json
from the_game_of_life import Field
if __name__ == "__main__":
    print('Game start.\n')

    config_file = open('config.json')
    config = json.loads(config_file.read())
    config_file.close()

    field = Field(config)
    field.play()
    print('Game over.\n')