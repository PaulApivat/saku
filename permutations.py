# coding: utf-8

# list of length 6
list1 = ['get started', 'user input', 'show jobposts',
         'go to setting', 'set mode', 'contact employer']


def permutations(iterable, r=None):
    """Find all possible order of a list of elements"""
    # permutations('ABCD',2)--> AB AC AD BA BC BD CA CB CD DA DB DC
    # permutations(range(3))--> 012 021 102 120 201 210
    pool = tuple(iterable)
    n = len(pool)
    r = n if r is None else r
    if r > n:
        return
    indices = list(range(n))
    cycles = list(range(n, n-r, -1))
    yield tuple(pool[i] for i in indices[:r])
    while n:
        for i in reversed(range(r)):
            cycles[i] -= 1
            if cycles[i] == 0:
                indices[i:] = indices[i+1:] + indices[i:i+1]
                cycles[i] = n - i
            else:
                j = cycles[i]
                indices[i], indices[-j] = indices[-j], indices[i]
                yield tuple(pool[i] for i in indices[:r])
                break
        else:
            return


#permutations(list1, 6)

perm = permutations(list1, 6)
count = 0

for p in perm:
    count += 1
    print(p)
print("there are:", count, "permutations.")