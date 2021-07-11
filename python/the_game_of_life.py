import time
import random
import json


class Field:
    def __init__(self, config):
        self.config = config
        self.height = config['height']
        self.width = config['width']
        self.alive_str = config['alive']
        self.dead_str = config['dead']
        self.points = self.generate_points()
        self.next_gen_points = []
        self.pre_prev_points = []

    def play(self):
        i = 0
        iteration_limit = 5000
        while i < iteration_limit:
            print(f'\n\niteration {i}\n')
            if (i % 2 == 0):
                self.pre_prev_points = json.loads(json.dumps(self.points))
            self.show()
            next_gen_json_str = json.dumps(self.generate_next_gen_points())
            self.points = json.loads(next_gen_json_str)

            if (self.pre_prev_points == self.points):
                print('\nGame field reached statis or entered loop.\n')
                return
            time.sleep(self.config['timeout'] / 1000)
            i += 1
        print('The iteration limit is reached.\n')


    def bool_to_str(self, value):
        if (value == True):
            return self.alive_str
        return self.dead_str


    def show(self):
        for line in self.points:
            print(' '.join([self.bool_to_str(x) for x in line]))


    def generate_points(self):
        points = []
        for i in range(self.height):
            line = [bool(random.randint(0, 1)) for x in range(self.width)]
            points.append(line)
        return points

    def generate_next_gen_points(self):
        next_gen_points = []
        for y in range(self.height):
            line = [self.generate_next_gen_point(x, y) for x in range(self.width)]
            next_gen_points.append(line)
        return next_gen_points

    def generate_next_gen_point(self, x, y):
        alive_neighbours = self.count_alive_neighbours(x, y)
        return ((self.points[y][x] and alive_neighbours == 2) or (alive_neighbours == 3))

    def count_alive_neighbours(self, target_x, target_y):
        alive_count = 0
        start_x = target_x - 1
        start_y = target_y - 1
        end_x = target_x + 1
        end_y = target_y + 1
        for y in range(start_y, end_y + 1):
            for x in range(start_x, end_x + 1):
                same_point = ((target_x == x) and (target_y == y))
                if (self.is_point_inside(x, y) and not same_point):
                    alive_count += int(self.points[y][x])
        return alive_count

    def is_point_inside(self, x, y):
        x_ok = (x >= 0) and (x < self.width)
        y_ok = (y >= 0) and (y < self.height)
        return x_ok and y_ok