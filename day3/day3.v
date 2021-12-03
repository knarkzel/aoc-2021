import os
import math

fn main() {
	mut bytes := os.read_lines('input.txt') ?
	rows := bytes.len
	columns := bytes[0].len
	mut common := map[int]int{}
	for bits in bytes {
		for i, bit in bits {
			if bit == `1` {
				common[i] += 1
			}
		}
	}
	mut bitmap := []bool{}
	for i in 0 .. columns {
		bitmap << common[i] >= rows / 2
	}
	println('Part 1: ${part1(bitmap, columns)}')
	println('Part 2: ${part2(bytes, bitmap)}')
}

fn part1(bitmap []bool, columns int) int {
	mut gamma_rate, mut epsilon_rate := 0, 0
	for i, bit in bitmap {
		if bit {
			gamma_rate += int(math.powi(2, columns - i - 1))
		} else {
			epsilon_rate += int(math.powi(2, columns - i - 1))
		}
	}
	return gamma_rate * epsilon_rate
}

fn part2(bytes []string, bitmap []bool) []string {
	mut rest := bytes.clone()
	for i, bit in bitmap {
		rest = rest.filter(it[i] == if bit { `1` } else { `0` })
	}
	return rest
}
