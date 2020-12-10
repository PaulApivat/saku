# source:

# list of length 3
list1 = ['stage 1', 'stage 2', 'stage 3', 'stage 4']


def all_perms(elements):
    if len(elements) <= 1:
        yield elements  # Only permutation possible = no permutation
    else:
        # Iteration over the first element in the result permutation:
        for (index, first_elmt) in enumerate(elements):
            other_elmts = elements[:index]+elements[index+1:]
            for permutation in all_perms(other_elmts):
                yield [first_elmt] + permutation


perm = all_perms(list1)
count = 0

for p in perm:
    count += 1
    print(p)
print(f"there are {count} permutations.")
