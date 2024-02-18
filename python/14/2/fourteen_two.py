def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines



def solve(lines, time):
    contestant = []
    pos = []
    points = []
    for line in lines:
        words = line.split(' ')
        speed = int(words[3])
        streak = int(words[6])
        cooldown = int(words[-2])
        # 0. speed
        # 1. streak
        # 2. cooldown
        # 3. isRun
        # 4. currStreak
        # 5. currCooldown
        contestant += [(speed, streak, cooldown, True, 0, 0)] 
        pos += [0]
        points += [0]

    print(contestant)

    while time > 0:
        for i in range(len(contestant)):
            if contestant[i][3]:
                pos[i] += contestant[i][0]
                contestant[i] = (contestant[i][0], contestant[i][1], contestant[i][2], contestant[i][3], contestant[i][4] + 1, contestant[i][5])
                if contestant[i][4] == contestant[i][1]:
                    contestant[i] = (contestant[i][0], contestant[i][1], contestant[i][2], False, 0, contestant[i][5])
            else:
                contestant[i] = (contestant[i][0], contestant[i][1], contestant[i][2], contestant[i][3], contestant[i][4], contestant[i][5] + 1)
                if contestant[i][5] == contestant[i][2]:
                    contestant[i] = (contestant[i][0], contestant[i][1], contestant[i][2], True, contestant[i][4], 0)

        maxPos = max(pos)
        for i in range(len(contestant)):
            if pos[i] == maxPos:
                points[i] += 1
        


        time -= 1

    print(max(points))


def main():
    lines = open_file()
    time = 2503
    solve(lines, time)

if __name__ == "__main__":
    main()
