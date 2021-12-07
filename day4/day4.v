import os
import arrays

struct Board {
	numbers [][]int
}

fn parse_boards(input []string) []Board {
	numbers := input.map(it.split_any(' \n').filter(it.len > 0).map(it.int()))
	return numbers.map(Board{arrays.chunk(it, 5)})
}

fn (b Board) is_winning(marks []int) bool {
	// horizontally
	for row in b.numbers {
		if row.all(it in marks) {
			return true
		}
	}
	// vertically
	for i in 0 .. 5 {
		if b.numbers.all(it[i] in marks) {
			return true
		}
	}
	return false
}

fn main() {
	input := os.read_file('input.txt') ?.split('\n\n')
	marks := input[0].split(',').map(it.int())
	boards := parse_boards(input[1..])
	println('Part 1: ${part1(boards, marks) ?}')
	println('Part 2: ${part2(boards, marks) ?}')
}

fn part1(boards []Board, marks []int) ?int {
	for i in 1 .. marks.len {
		for board in boards {
			if board.is_winning(marks[..i]) {
				unmarked := arrays.flatten(board.numbers).filter(it in marks[i..])
				sum := arrays.sum(unmarked) ?
				called := marks[i - 1]
				return sum * called
			}
		}
	}
	return none
}

fn part2(boards []Board, marks []int) ?int {
	for i in 1 .. marks.len {
		if boards.all(it.is_winning(marks[..i + 1])) {
			for board in boards {
				if !board.is_winning(marks[..i]) {
					unmarked := arrays.flatten(board.numbers).filter(it in marks[i + 1..])
					sum := arrays.sum(unmarked) ?
					called := marks[i]
					return sum * called
				}
			}
		}
	}
	return none
}
