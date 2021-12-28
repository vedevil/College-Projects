import numpy as np
import random
def getneighbours(adjacency_matrix,req):
    n=[]
    for i in range(len(adjacency_matrix)):
        if adjacency_matrix[req][i]==1:
            n.append(i)
    return n
def fralgorithm(no_of_cells,no_of_subbands,adjacency_matrix,overlapping_matrix):
    subbands_assigned=[]
    for i in range(no_of_cells):
        subbands_assigned.append(-1)
    subbands_available=list(range(1,no_of_subbands+1))
    for i in range(no_of_cells):
        if i<no_of_subbands:
            subbands_assigned[i]=random.choice(subbands_available[0:no_of_subbands-i])
        else:
            subbands_assigned[i]=random.choice(subbands_available)
        subbands_available.remove(subbands_assigned[i])
        subbands_available.append(subbands_assigned[i])
        
        # subbands_assigned[i]=subbands_available.pop(0)
        # subbands_available.append(subbands_assigned[i])
        # subbands_available.append(subbands_assigned[i])
        neighbours=getneighbours(adjacency_matrix,i)
        for n in neighbours:
            length_available=len(subbands_assigned)
            j=0
            while subbands_assigned[n] == subbands_assigned[i] and j<length_available:
                subbands_assigned[i]=random.choice(subbands_available)
                # subbands_assigned[i]=subbands_available.pop(0)
                # subbands_available.append(subbands_assigned[i])
                j+=1
    for i in range(5):
        for cell in range(no_of_cells):
            overlap_dictionary={} #storing overlap area of all neighbours
            neighbours=getneighbours(adjacency_matrix,cell)
            subbands_assigned_to_neighbours=[]
            for n in neighbours:
                subbands_assigned_to_neighbours.append(subbands_assigned[n]) # getting subbams asigned to its neighbours
                overlap_dictionary[n]=overlapping_matrix[cell][n]#overlap with all adjacent cells that are present to givencelss 
            if subbands_assigned[cell] in subbands_assigned_to_neighbours:
                subbands_assigned[cell]=subbands_assigned[min(overlap_dictionary,key=overlap_dictionary.get)]#subband assigned as least overlapping one 
    return subbands_assigned
am=np.zeros((27,27))
om=np.zeros((27,27))
with open("overlap_matrix.txt") as f:
    for i in range(27):
        s=f.readline().split()
        for j in range(len(s)):
            om[i][j]=s[j]
print(om)
for i in range(27):
    for j in range(27):
        if om[i][j]>0:
            am[i][j]=1
print(am)
ans=fralgorithm(27, 14, am, om)
print(ans)