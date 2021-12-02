module main

import strconv { atoi }
import os

fn main() {
	input := os.read_lines('input.txt') ?.map(it.split(' '))
	println('Part 1: ${part1(input)}')
	println('Part 2: ${part2(input)}')
}

fn part1(input [][]string) int {
	mut depth, mut horizontal := 0, 0
	for line in input {
		value := atoi(line[1]) or { continue }
		match line[0] {
			'up' { depth -= value }
			'down' { depth += value }
			else { horizontal += value }
		}
	}
	return depth * horizontal
}

fn part2(input [][]string) int {
	mut depth, mut horizontal, mut aim := 0, 0, 0
	for line in input {
		value := atoi(line[1]) or { continue }
		match line[0] {
			'up' {
				aim -= value
			}
			'down' {
				aim += value
			}
			else {
				horizontal += value
				depth += aim * value
			}
		}
	}
	return depth * horizontal
}
