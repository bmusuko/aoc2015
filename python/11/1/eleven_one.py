def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines


def chr2num(char):
    return ord(char) - ord('a')

def num2chr(num):
    return chr(ord('a') + num)



def first_condition(chrs):
    is_suitable = False
    for i in range(len(chrs)-2):
        if chrs[i] + 1 == chrs[i+1] and chrs[i+1] + 1 == chrs[i+2]:
            is_suitable = True
            break
    return is_suitable

def second_condition(chrs):
    i = ord('i') - ord('a')
    o = ord('o') - ord('a')
    l = ord('l') - ord('a')
    for c in chrs:
        if c == i or c == o or c == l:
            return False
    return True


def third_condition(chrs):
    i = 0
    count = 0
    seen = set()
    while (i < len(chrs)-1):
        if (chrs[i] == chrs[i+1] and chrs[i] not in seen):
            seen.add(chrs[i])
            i += 2
            count += 1
            if count == 2:
                return True
        else:
            i += 1
    return False

def suitable(chrs):
    return first_condition(chrs) and second_condition(chrs) and third_condition(chrs)


def getNext(chrs):
    carry = True
    i = len(chrs)-1
    while carry and i >= 0:
        chrs[i] = (chrs[i] + 1) % 26
        carry = chrs[i] == 0
        i -= 1
    return chrs

def conv(password):
    chrs = list(map(chr2num, list(password)))
    return chrs

def reconstruct(chrs):
    password = list(map(num2chr, chrs))
    return "".join(password)

def solve(password):
    chrs = conv(password)
    
    while not suitable(chrs):
        chrs = getNext(chrs)

    return reconstruct(chrs)

def main():
    lines = open_file()
    for line in lines:
        print(solve(line))

if __name__ == "__main__":
    main()

# 458 too high
