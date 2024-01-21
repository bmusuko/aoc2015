import json

def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines


def solve(obj):
    count = 0
    if type(obj) is dict:
        keys = obj.keys()
        for key in keys:
            if obj[key] == "red":
                return 0
            elif type(obj[key]) is int:
                count += obj[key]
            else:
                count += solve(obj[key])
    elif type(obj) is list:
        for val in obj:
            if type(val) is int:
                count += val
            else:
                count += solve(val)
    return count



def main():
    lines = open_file()
    for line in lines:
        obj = json.loads(line)
        print(solve(obj))

if __name__ == "__main__":
    main()

# 458 too high
