import kotlin.random.*
//import com.sun.org.apache.xpath.internal.operations.Bool

val height = 10
val width = 10

var previousGeneration: MutableList<MutableList<Boolean>> = mutableListOf(mutableListOf())
var currentGeneration: MutableList<MutableList<Boolean>> = mutableListOf(mutableListOf())

fun main() {

    play()


}

fun play() {
    initializeMatrices()

    val limit = 5
    var i = 0
    while (i < limit) {

        println("generation $i")
        printCurrentGeneration()

        updateCurrentGeneration()

        updatePreviousGeneration()
        Thread.sleep(500)

        i += 1
    }
    println()
    println()

}

fun initializeMatrices() {

    var i = 0
    while (i < height) {

        var j = 0
        previousGeneration.add(mutableListOf())
        currentGeneration.add(mutableListOf())

        while (j < width) {

            val randBool = Random.nextBoolean()
            previousGeneration[i].add(randBool)
            currentGeneration[i].add(randBool)
            j += 1
        }

        i += 1
    }
}

fun printCurrentGeneration() {
    var i = 0
    while (i < height) {

        var j = 0

        while (j < width) {
            print(boolToStr(currentGeneration[i][j]))
            print(" ")
            j += 1
        }
        println()

        i += 1
    }
    println()

}

fun boolToStr(b: Boolean): String {
    return if (b) "+" else "-"
}

fun updateCurrentGeneration() {
// на основании пред поколения обновляю текущее


    var i = 0
    while (i < height) {

        var j = 0

        while (j < width) {

            val newPoint: Boolean = getUpdatedPoint(i, j)

//            println("new point $i $j -> $newPoint")
            currentGeneration[i][j] = newPoint

            j += 1
        }

        i += 1
    }

}

fun updatePreviousGeneration() {
//    previousGeneration = currentGeneration


    var i = 0
    while (i < height) {

        var j = 0

        while (j < width) {


            previousGeneration[i][j] = currentGeneration[i][j]

            j += 1
        }

        i += 1
    }

}

fun getUpdatedPoint(i: Int, j: Int): Boolean {
    val aliveNeighboursCount: Int = countAliveNeighbours(i, j)

//    println("aliveNeighboursCount debug for i: $i j: $j")
//    println(aliveNeighboursCount)

    return (
            (
                    (previousGeneration[i][j] == true) && (aliveNeighboursCount == 2)
            )
             || (aliveNeighboursCount == 3)
    )
}

fun countAliveNeighbours(i: Int, j: Int): Int {
    // всего 8 соседей
    var count = 0
    var neighbourIndexI = i - 1
    while (neighbourIndexI < i + 2) {
        var neighbourIndexJ = j - 1
        while (neighbourIndexJ < j + 2) {


            if (isValidPoint(neighbourIndexI, neighbourIndexJ) && notSame(neighbourIndexI, neighbourIndexJ, i, j)) {
                count += if (previousGeneration[neighbourIndexI][neighbourIndexJ]) 1 else 0
            }


            neighbourIndexJ += 1
        }
        neighbourIndexI += 1
    }
    return count
}

fun isValidPoint(i: Int, j: Int): Boolean {

    return (
            (i >= 0)
                    && (i < height)
                    && (j >= 0)
                    && (j < width)
            )
}

fun notSame(i: Int, j: Int, i2: Int, j2: Int): Boolean {

    return (
            (i != i2)
                    || (j != j2)
            )
}