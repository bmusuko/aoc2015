import heapq

def open_file():
    filename = "../data/input.txt"
    lines = []
    with open(filename, 'r') as file:
        lines = [line.strip() for line in file.readlines()]

    return lines


def solve(cities, destination):
    queue = []
    for city in list(cities):
        queue.append((0, [city]))

    ans = []


    while (len(queue) > 0):
        cost, curr_cities = heapq.heappop(queue)
        if len(curr_cities) == len(cities):
            ans.append((cost, curr_cities))
            continue
        if not curr_cities[-1] in destination:
            # print((len(curr_cities), cost, curr_cities))
            continue

        next_cities = destination[curr_cities[-1]]
        for city in next_cities:
            if city[0] not in curr_cities:
                heapq.heappush(queue, (cost + city[1], curr_cities + [city[0]]))

    return ans[0]

def main():
    cities = set()
    destination = {}
    lines = open_file()
    for line in lines:
        words = line.split(" ")
        cities.add(words[0])
        cities.add(words[2])
        if words[0] in destination:
            destination[words[0]] += [(words[2], int(words[-1]))]
        else:
            destination[words[0]] = [(words[2], int(words[-1]))]

        if words[2] in destination:
            destination[words[2]] += [(words[0], int(words[-1]))]
        else:
            destination[words[2]] = [(words[0], int(words[-1]))]
        
    # print(destination)
    print(solve(cities,destination))

if __name__ == "__main__":
    main()

# 458 too high
