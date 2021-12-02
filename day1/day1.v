import os
import arrays { sum, window }

fn main() {
	input := os.read_lines('input.txt') ?.map(it.int())
	part1 := sum(window(input, size: 2).map(int(it[1] - it[0] > 0))) ?
	println('Part 1: $part1')
	windows := window(input, size: 3).map(sum(it) ?)
	part2 := sum(window(windows, size: 2).map(int(it[1] - it[0] > 0))) ?
	println('Part 2: $part2')
}
