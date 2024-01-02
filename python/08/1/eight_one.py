import numpy as np

def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines


def solve(original_line):
    original = len(original_line)

    line = original_line[1:-1]
    count = 0
    is_backlash_before = False
    i = 0
    while (i < len(line)):
        if line[i] == "\\" and is_backlash_before:
            count += 1
            i += 1
            is_backlash_before = False
        elif line[i] == "\\" and not is_backlash_before:
            is_backlash_before = True
            i += 1
        elif line[i] == "x" and is_backlash_before:
            count += 1
            i += 3
            is_backlash_before = False
        else:
            count += 1
            i += 1
            is_backlash_before = False



    return original - count

def main():
    lines = open_file()
    total = 0
    for line in lines:
        total += solve(line)
        
    print(total)

if __name__ == "__main__":
    main()
