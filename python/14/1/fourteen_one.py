import json

def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines

def solve(line, time):
    words = line.split(' ')
    speed = int(words[3])
    streak = int(words[6])
    cooldown = int(words[-2])
    print(speed, streak, cooldown)

    total = 0
    isCooldown = False
    while time > 0:
        if not isCooldown:
            total += min(time, streak) * speed
            time -= min(time, streak)
            isCooldown = True
        else:
            time -= cooldown
            isCooldown = False

    return total



def main():
    lines = open_file()
    time = 2503
    lengths = []
    for line in lines:
        lengths += [solve(line, time)]
    print(max(lengths))

if __name__ == "__main__":
    main()
