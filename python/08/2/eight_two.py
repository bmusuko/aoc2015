import numpy as np

def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines


def solve(original_line):
    original = len(original_line)

    count = 2 + original + original_line.count("\"") + original_line.count("\\")


    return count-original

def main():
    lines = open_file()
    total = 0
    for line in lines:
        total += solve(line)
        
    print(total)

if __name__ == "__main__":
    main()
