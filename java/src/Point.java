public class Point {
    public boolean isAlive = false;

    public Point(boolean isAlive) {
        this.isAlive = isAlive;
    }

    public String toString() {
        return this.isAlive ? Game.aliveStr : Game.deadStr;
    }

    public int toInt() {
        return this.isAlive ? 1 : 0;
    }
}
