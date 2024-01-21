def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines


def looksandsay(pattern):
    curr = pattern[0]
    count = 1
    new_pattern = ""
    for i in range(1, len(pattern)):
        if pattern[i] == curr:
            count += 1
        else:
            new_pattern += str(count) + curr
            curr = pattern[i]
            count = 1
    new_pattern += str(count) + curr
    return new_pattern


def solve(line):
    curr = line
    for i in range(50):
        curr = looksandsay(curr)
    return curr


def main():
    lines = open_file()
    for line in lines:
        print(len(solve(line)))

if __name__ == "__main__":
    main()