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

fn part2(bytes []string) []string {
	return oxygen_rating(bytes)
}

fn oxygen_rating(bytes []string) []string {
	mut bit := 0
	mut valid := bytes.clone()
	for valid.len > 2 {
		bitmap := get_bitmap(valid)
		valid = valid.filter(it[bit] == if bitmap[bit] { `1` } else { `0` })
		bit += 1
	}
	return valid
}
