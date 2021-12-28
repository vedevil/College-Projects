#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 24 10:13:38 2021

@author: ved
"""


import numpy
from PIL import Image





def main():
    img = Image.open("mfr_mf.tif")
    #arr = numpy.array(img)
    # removed_noise = median_filter(arr, 3) 
    # print(removed_noise)
    #img = Image.fromarray(removed_noise)
    #img=img.convert('L')
    img.save("mfr_mf.png")
    img.show()


main()