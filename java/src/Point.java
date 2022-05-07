public class Point {
    public boolean isAlive = false;
    public String aliveString = "■ ";
    public String deadString = "□ ";

    public Point(boolean isAlive) {
        this.isAlive = isAlive;
    }

    public String toString() {
        return this.isAlive ? this.aliveString : this.deadString;
    }

    public int toInt() {
        return this.isAlive ? 1 : 0;
    }
}
