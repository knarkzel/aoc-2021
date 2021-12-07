import os
import math
import math.util { iabs }
import arrays { max, sum }

fn main() {
	input := os.read_file('input.txt') ?.split(',').map(it.int())
	println('Part 1: ${part1(input) ?}')
	println('Part 2: ${part2(input) ?}')
}

fn fuel(input []int, handler fn (int, int) int) ?int {
	mut smallest := math.max_i32
	for i in 0 .. max(input) ? {
		fuels := input.map(handler(it, i))
		total := sum(fuels) ?
		if total < smallest {
			smallest = total
		}
	}
	return smallest
}

fn part1(input []int) ?int {
	return fuel(input, fn (it int, i int) int {
		return iabs(it - i)
	})
}

fn part2(input []int) ?int {
	return fuel(input, fn (it int, i int) int {
		return fuel_rate(iabs(it - i))
	})
}

fn fuel_rate(end int) int {
	mut sum := 0
	for i in 1 .. end + 1 {
		sum += i
	}
	return sum
}
