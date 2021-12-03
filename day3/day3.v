import os
import math

fn main() {
	mut bytes := os.read_lines('input.txt') ?
	println('Part 1: ${part1(bytes)}')
	println('Part 2: ${part2(bytes)}')
}

fn get_bitmap(bytes []string) []bool {
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
	return bitmap
}

fn part1(bytes []string) int {
	columns := bytes[0].len
	bitmap := get_bitmap(bytes)
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

fn part2(bytes []string) string {
	mut rest := bytes.clone()
	for rest.len > 1 {
		bitmap := get_bitmap(rest)
		for i, bit in bitmap {
			// amount with 1 in pos
			ones := rest.map(it[i] == `1`).len
			zeros := rest.map(it[i] == `0`).len
			if ones == zeros {
				// oxygen generator rating
			} else {
				rest = rest.filter(it[i] == if bit { `1` } else { `0` })
			}
		}
	}
	return rest[0]
}
