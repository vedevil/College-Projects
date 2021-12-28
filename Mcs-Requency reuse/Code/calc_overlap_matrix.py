import numpy as np
import math
from scipy.optimize import brentq

def intersection_area(d, R, r):
    """Return the area of intersection of two circles.

    The circles have radii R and r, and their centres are separated by d.

    """

    if d <= abs(R-r):
        # One circle is entirely enclosed in the other.
        return np.pi * min(R, r)**2
    if d >= r + R:
        # The circles don't overlap at all.
        return 0

    r2, R2, d2 = r**2, R**2, d**2
    alpha = np.arccos((d2 + r2 - R2) / (2*d*r))
    beta = np.arccos((d2 + R2 - r2) / (2*d*R))
    return ( r2 * alpha + R2 * beta -
             0.5 * (r2 * np.sin(2*alpha) + R2 * np.sin(2*beta))
           )

# def findcentreofintersection(A, R, r):
#     """
#     Find the distance between the centres of two circles giving overlap area A.

#     """

#     # A cannot be larger than the area of the smallest circle!
#     if A > np.pi * min(r, R)**2:
#         raise ValueError("Intersection area can't be larger than the area"
#                          " of the smallest circle")
#     if A == 0:
#         # If the circles don't overlap, place them next to each other
#         return R+r

#     if A < 0:
#         raise ValueError('Negative intersection area')

#     def f(d, A, R, r):
#         return intersection_area(d, R, r) - A

#     a, b = abs(R-r), R+r
#     d = brentq(f, a, b, args=(A, R, r))
#     return d

# adj=np.zeros((27,27))
# with open("adjacency_matrix.txt") as f:
#     for i in range(27):
#         s=f.readline().split()
#         for j in range(len(s)):
#             adj[i][j]=s[j]
coor=np.zeros((27,2))
with open("node_coordinates.txt") as f:
    for i in range(27):
        s=f.readline().split()
        for j in range(len(s)):
            coor[i][j]=s[j]
info=np.zeros((27,4))
a = 6378
e=0
for i in range(27):
    lat=math.radians(coor[i][0])
    long=math.radians(coor[i][1])
    r=a/(math.sqrt(1-e*math.pow(math.sin(lat), 2)))
    radius=40
    x=r*math.cos(lat)*math.cos(long)
    y=r*math.cos(lat)*math.sin(long)
    info[i][0]=x
    info[i][1]=y
    info[i][2]=radius
    info[i][3]=math.pi*radius*radius
overlap_matrix=np.zeros((27,27))
for i in range(27):
    for j in range(27):
        if i!=j:
            x1=info[i][0]
            y1=info[i][1]
            x2=info[j][0]
            y2=info[j][1]
            d=math.sqrt(math.pow(x1-x2, 2)+math.pow(y1-y2, 2))
            overlap=intersection_area(d, info[i][2], info[j][2])
            overlap_matrix[i][j]=(overlap/info[i][3])*100

with open('overlap_matrix.txt', 'w') as testfile:
    for row in overlap_matrix:
        testfile.write('\t'.join([str(a) for a in row]) + '\n')
print(overlap_matrix)