package com.gennadyterekhov.thegameoflife

class GameField(height: Int, width: Int) {

    init {
        val height = height
        val width = width
        var currentGeneration = Generation(height, width)
        var previousGeneration = Generation(height, width)

    }
    fun initialize() {
        println(" GameField initialize")
        
        return

        // var i = 0
        // while (i < this.height) {
    
        //     var j = 0
            
        //     this.currentGeneration.matrix.add(mutableListOf())
        //     this.previousGeneration.matrix.add(mutableListOf())

        //     while (j < width) {
    
        //         val randBool = Random.nextBoolean()
        //         this.currentGeneration.matrix[i].add(randBool)
        //         this.previousGeneration.matrix[i].add(randBool)
        //         j += 1
        //     }

            
        //     i += 1
        // }
    }

        // this.currentGeneration.initialize()
        // this.previousGeneration.initialize()
    
    fun printCurrentGeneration() {

        this.currentGeneration.print()
    }
}
