import numpy as np

def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines

def get_val(key, map):
    if key in map:
        return np.uint16(map[key])
    if key.isdigit():
        return np.uint16(key)
    return None

def gen_val(x, y, operation):
    if operation == "AND":
        return np.bitwise_and(x, y)
    elif operation == "OR":
        return np.bitwise_or(x, y)
    elif operation == "LSHIFT":
        return np.left_shift(x, y)
    elif operation == "RSHIFT":
        return np.right_shift(x, y)

def solve(line, map):
    words = line.split(" ")
    if len(words) == 5:
        x = get_val(words[0], map)
        y = get_val(words[2], map)
        if x == None or y == None:
            return -1
        operation = words[1]
        target = words[4]
        new_val = gen_val(x, y, operation)
        map[target] = new_val
    elif len(words) == 4:
        x = get_val(words[1], map)
        if x == None:
            return -1        
        target = words[3]
        new_val = np.bitwise_not(x)
        map[target] = new_val
    elif len(words) == 3:
        x = get_val(words[0], map)
        if x == None:
            return -1        
        target = words[2]
        map[target] = x

def main():
    char_to_int = {}
    lines = open_file()
    while True:
        for line in lines:
            solve(line, char_to_int)
        if "a" in char_to_int:
            break

    print(char_to_int["a"])

if __name__ == "__main__":
    main()
