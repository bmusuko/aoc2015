import json

def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines

def generatePermutation(arr):
    finalAns = []
    
    def recc(curr, left):
        if len(left) == 0:
            nonlocal finalAns
            finalAns += [curr]
            return

        for i in range(0, len(left)):
            recc(curr + [left[i]], left[:i] + left[i+1:])

    
    recc([], arr)
    return finalAns

def count(arrangement, rules):
    point = 0

    if arrangement[0] in rules:
        if arrangement[-1] in rules[arrangement[0]]:
            point += rules[arrangement[0]][arrangement[-1]]
        if arrangement[1] in rules[arrangement[0]]:
            point += rules[arrangement[0]][arrangement[1]]

    if arrangement[-1] in rules:
        if arrangement[-2] in rules[arrangement[-1]]:
            point += rules[arrangement[-1]][arrangement[-2]]
        if arrangement[0] in rules[arrangement[-1]]:
            point += rules[arrangement[-1]][arrangement[0]]

    for i in range(1,len(arrangement)-1):
        left = arrangement[i-1]
        mid = arrangement[i]
        right = arrangement[i+1]

        if mid in rules:
            if left in rules[mid]:
                point += rules[mid][left]
            if right in rules[mid]:
                point += rules[mid][right]

    return point


def solve(lines):
    persons = set()
    rules = {}
    for line in lines:
        words = line.split(' ')
        first = words[0]
        second = words[-1][:-1]
        
        persons.add(first)
        persons.add(second)

        point = int(words[3])
        if words[2] == "lose":
            point *= -1
        
        if first not in rules:
            rules[first] = {}

        rules[first][second] = point

    persons = list(persons)
    # print(rules)
    swappable = generatePermutation(persons[1:])

    point = 0
    for swap in swappable:
        arrangement = [persons[0]] + swap
        point = max(point, count(arrangement, rules))

    return point




def main():
    lines = open_file()
    print(solve(lines))

if __name__ == "__main__":
    main()
