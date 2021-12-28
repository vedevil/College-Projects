import numpy
from PIL import Image


def median_filter(data, filter_size):
    temp = []
    indexer = filter_size // 2
    data_final = {"1":0,"2":0,"3":0,"4":0,"5":0,"6":0,"7":0,"8":0,"9":0}
    for i in range(indexer,len(data)-indexer):

        for j in range(indexer,len(data[0])-indexer):
            for y in range(-indexer,indexer+1):
                for z in range(-indexer,indexer+1):
                    temp.append(data[i+y][j+z])
            window_element=set(temp)
            l=len(window_element)
            data_final[str(l)]+=1
            temp=[]
    return data_final


def main():
    img = Image.open("orgimgmfr.tif").convert(
        "L")
    arr = numpy.array(img)
    drbarr = median_filter(arr, 3)
    total= sum(drbarr.values())
    for key in drbarr:
        drbarr[key]=(drbarr[key]*100)/total
    print(total)
    print(drbarr)
main()