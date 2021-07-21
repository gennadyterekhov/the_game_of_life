export class Field {
    constructor(points, config) {
        this.config = config;
        this.points = points;
        this.height = points.length;
        this.width = points[0].length;
        this.aliveStr = this.config.alive_string;
        this.deadStr = this.config.dead_string;
        this.timeout = this.config.timeout;
    }

    show() {
        for (let y = 0; y < this.height; y += 1) {
            let line = '';
            for (let x = 0; x < this.width; x += 1) {
                line += (this.points[y][x] === 1) ? this.aliveStr : this.deadStr;
            }
            console.log(line);
        }
    }

    play() {
        let iteration = 0;
        let prePreviousState = [];
        let refreshId = setInterval(() => {
            console.log(`\n============= ITERATION ${iteration} =============\n`);
            iteration += 1;
            if (iteration % 2 === 0) {
                prePreviousState = JSON.parse(JSON.stringify(this.points));
            }
            this.show();
            this.points = this.getMutatedPoints();

            if (JSON.stringify(prePreviousState) == JSON.stringify(this.points)) {
                console.log('Game field reached stasis or entered loop');
                clearInterval(refreshId);
            }
        }, this.timeout);
    }

    countAliveNeighbours(x, y) {
        let aliveCount = 0;
        const neighboursCoordinates = this.getNeighboursCoordinates(x, y);
        for (let i = 0; i < neighboursCoordinates.length; i += 1) {
            aliveCount += this.points[neighboursCoordinates[i][1]][neighboursCoordinates[i][0]];
        }
        return aliveCount;
    }

    getNeighboursCoordinates(targetX, targetY) {
        return [
            [targetX - 1, targetY],
            [targetX + 1, targetY],
            [targetX, targetY - 1],
            [targetX, targetY + 1],
            [targetX - 1, targetY - 1],
            [targetX - 1, targetY + 1],
            [targetX + 1, targetY - 1],
            [targetX + 1, targetY + 1]
        ].filter((value) => {
            const x = value[0];
            const y = value[1];
            const xOk = ((x >= 0) && (x < this.width));
            const yOk = ((y >= 0) && (y < this.height));
            return (xOk && yOk);
        });
    }

    getMutatedPoints() {
        let newPoints = JSON.parse(JSON.stringify(this.points));
        for (let y = 0; y < this.height; y += 1) {
            for (let x = 0; x < this.width; x += 1) {
                newPoints[y][x] = this.getMutatedPoint(x, y);
            }
        }
        return newPoints;
    }

    getMutatedPoint(x, y) {
        const aliveNeighbours = this.countAliveNeighbours(x, y);
        const alive = (this.points[y][x] === 1) ? true : false;
        return ((alive && (aliveNeighbours === 2)) || (aliveNeighbours === 3)) ? 1 : 0;
    }
}
