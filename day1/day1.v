import os
import arrays { window }

fn fold(input []int) ?int {
	return arrays.sum(window(input, size: 2).map(int(it[1] - it[0] > 0)))
}

fn main() {
	input := os.read_lines('input.txt') ?.map(it.int())
	println('Part 1: ${fold(input)}')
	println('Part 2: ${fold(window(input, size: 3).map(fold(it) ?))}')
}
