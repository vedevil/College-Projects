#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Nov 24 09:51:51 2021

@author: ved
"""

import numpy
from PIL import Image





def main():
    img = Image.open("orgimg.tif").convert("L")
    #arr = numpy.array(img)
    # removed_noise = median_filter(arr, 3) 
    # print(removed_noise)
    #img = Image.fromarray(removed_noise)
    #img=img.convert('L')
    img.save("gray_scale_orgimg.png")
    img.show()


main()