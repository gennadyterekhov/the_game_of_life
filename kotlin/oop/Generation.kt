package com.gennadyterekhov.thegameoflife

class Generation(height: Int, width: Int) {

    init {
        val height = height
        val width = width
        var matrix: MutableList<MutableList<Boolean>> = mutableListOf()
    }

    fun initialize() {
        println("generation initialize")
        

        var i = 0
        while (i < this.height) {
    
            var j = 0
            
            this.matrix.add(mutableListOf())
            while (j < width) {
    
                val randBool = Random.nextBoolean()
                this.matrix[i].add(randBool)
                j += 1
            }

            
            i += 1
        }
    }
    fun print() {
        var i = 0
        while (i < this.height) {
    
            var j = 0
            
            while (j < width) {
    
                val randBool = Random.nextBoolean()
                print(this.currentGeneration.matrix[i][j])
                j += 1
            }
            println()

            
            i += 1
        }
    }
}
