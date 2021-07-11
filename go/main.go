package main

import (
	"fmt"
	"math/rand"
	"time"
)

const AliveStr = "■ "
const DeadStr = "□ "

func boolToStr(value bool) string {
	if value == true {
		return AliveStr
	} else {
		return DeadStr
	}
}

type Field struct {
	Points [][]bool
	Height int
	Width  int
}

func randBool() bool {
	return rand.Float32() < 0.5
}

func generatePoints(height, width int) [][]bool {
	var points [][]bool
	for i := 0; i < height; i++ {
		var tempSlice []bool
		for j := 0; j < width; j++ {
			tempSlice = append(tempSlice, randBool())
		}
		points = append(points, tempSlice)
	}
	return points
}

func (field Field) play() {
	var prePreviousPoints [][]bool
	var continueCondition bool = true
	fmt.Println("play")
	for i := 0; continueCondition; i++ {
		fmt.Printf("iteration %v\n", i)
		if i%2 == 0 {
			prePreviousPoints = field.Points
		}

		field.show()
		field.Points = field.getNextGenPoints()
		fmt.Println()
		if field.stateNotChanged(prePreviousPoints) {
			continueCondition = false
			fmt.Println("Game field reached stasis or entered loop")
		}
		time.Sleep(300 * time.Millisecond)
	}
}

func (field Field) stateNotChanged(prevState [][]bool) bool {
	for i := 0; i < field.Height; i++ {
		for j := 0; j < field.Width; j++ {
			if prevState[i][j] != field.Points[i][j] {
				return false
			}
		}
	}
	return true
}

func (field Field) getNextGenPoints() [][]bool {
	var nextGenPoints [][]bool
	for i := 0; i < field.Height; i++ {
		var tempSlice []bool
		for j := 0; j < field.Width; j++ {
			tempSlice = append(tempSlice, field.genNextGenPoint(j, i))
		}
		nextGenPoints = append(nextGenPoints, tempSlice)
	}
	return nextGenPoints
}

func (field Field) show() {
	fmt.Println("show")
	for i := 0; i < field.Height; i++ {
		for j := 0; j < field.Width; j++ {
			fmt.Print(boolToStr(field.Points[i][j]))
		}
		fmt.Println()
	}
}

func (field Field) genNextGenPoint(x, y int) bool {
	var aliveNeighbours int = field.countAliveNeighbours(x, y)
	return ((field.Points[y][x] && (aliveNeighbours == 2)) || (aliveNeighbours == 3))
}

func (field Field) countAliveNeighbours(x, y int) int {
	var startX int = x - 1
	var startY int = y - 1
	var endX int = x + 1
	var endY int = y + 1
	var aliveCount int = 0
	for i := startY; i <= endY; i++ {
		for j := startX; j <= endX; j++ {
			if field.insideBounds(j, i) && (x != j) && (y != i) {
				if field.Points[i][j] {
					aliveCount++
				}
			}
		}
	}
	return aliveCount
}

func (field Field) insideBounds(x, y int) bool {
	if (x >= 0) && (x < field.Width) && (y >= 0) && (y < field.Height) {
		return true
	}
	return false
}

func main() {
	rand.Seed(time.Now().UnixNano())
	fmt.Println("the game of life")
	var HEIGHT int = 10
	var WIDTH int = 10

	var points [][]bool = generatePoints(HEIGHT, WIDTH)
	var field = Field{points, HEIGHT, WIDTH}

	field.play()

	fmt.Println("game over")
}
