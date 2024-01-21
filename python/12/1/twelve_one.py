import re

def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines

def toInt(str):
    return int(str)

def solve(line):
    nums = re.findall(r'[-]?\d+', line)
    return sum(map(toInt, nums))

def main():
    lines = open_file()
    for line in lines:
        print(solve(line))

if __name__ == "__main__":
    main()

# 458 too high
