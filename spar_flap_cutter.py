# -*- coding: utf-8 -*-
"""
Created on Wed Oct 12 16:35:39 2022

@author: austi
"""
from matplotlib import pyplot
import math
flap_location = 0 #%chord
flap_deflection = 0 #deg
spar1_location = 30 #%chord
spar2_location = 30+1/3*(100) #%chord
chord = 9 #any length units
spar1_OD = 0.2 #same as chord
spar2_OD = 0.2 #same as chord

spar1_r = spar1_OD/chord/2
spar2_r = spar2_OD/chord/2
flap_loc = flap_location/100
flap_rads = flap_deflection*math.pi/180
spar1_loc = spar1_location/100
spar2_loc = spar2_location/100
resolution = 16
coords = []
x_list = []
y_list = []
flap_coords = []
spar1_coords = []
spar2_coords = []
filename = input("Input airfoil path: ")
file = open(filename,"r")
#Get coordinates from .dat file
for line in file:
    coord = line.split()
    coords.append([float(number) for number in coord])
file.close()
flap_included = False
#find y-values at locations of interest along the upper surface
prev_x = 1
prev_y = 0
for line in coords:
    x = line[0]
    y = line[1]
    if x <= flap_loc and prev_x > flap_loc:
        flap_index = coords.index([x,y])
        flap_y1 = prev_y + (y-prev_y)/(x-prev_x)*(flap_loc-prev_x)
    if x <= spar1_loc and prev_x > spar1_loc:
        spar1_y1 = prev_y + (y-prev_y)/(x-prev_x)*(spar1_loc-prev_x)
    if x <= spar2_loc and prev_x > spar2_loc:
        spar2_y1 = prev_y + (y-prev_y)/(x-prev_x)*(spar2_loc-prev_x)
    prev_x = x
    prev_y = y
#insert the only upper-surface feature
coords.insert(flap_index,[flap_loc,flap_y1])

#find the y-value, index of the flap at the lower surface
coords.reverse()

prev_x = 1
prev_y = 0  
for line in coords:
    x = line[0]
    y = line[1]
    if x <= flap_loc and prev_x > flap_loc:
        flap_index = coords.index([x,y])
        flap_y2 = prev_y + (y-prev_y)/(x-prev_x)*(flap_loc-prev_x)
    
    prev_x = x
    prev_y = y
flap_r = flap_y1-flap_y2
prev_x = 1
prev_y = 0
#insert flap features

# for i in range(resolution+1):
#     flap_x_coord = flap_loc - flap_r*math.sin(2*flap_rads*i/resolution)
#     flap_y_coord = flap_y1 - flap_r*math.cos(2*flap_rads*i/resolution)
#     flap_coords.append([flap_x_coord,flap_y_coord])
# flap_return_coords = flap_coords[:(len(flap_coords)//2)]
# flap_return_coords.reverse()
# flap_coords.append([flap_loc,flap_y1])
# flap_coords.append([flap_loc-flap_r*math.sin(flap_rads),
#                     flap_y1-flap_r*math.cos(flap_rads)])
# flap_coords.extend(flap_return_coords)
# for coord in flap_coords:
#     coords.insert(flap_index,coord)
    
#insert secondary spar from the lower surface
prev_x = 1
prev_y = 0  
for line in coords:
    x = line[0]
    y = line[1]
    
    if x <= spar2_loc and prev_x > spar2_loc:
        spar2_index = coords.index([x,y])
        spar2_y2 = prev_y + (y-prev_y)/(x-prev_x)*(spar2_loc-prev_x)
        spar2_y = (spar2_y1 + spar2_y2)/2
        for i in range(resolution+1):
            spar2_x_coord = spar2_loc + spar2_r*math.sin(2*math.pi*i/resolution)
            spar2_y_coord = spar2_y - spar2_r*math.cos(2*math.pi*i/resolution)
            spar2_coords.append([spar2_x_coord,spar2_y_coord])
    prev_x = x
    prev_y = y

coords.insert(spar2_index,[spar2_loc,spar2_y2])
for coord in spar2_coords:
    coords.insert(spar2_index,coord)
coords.insert(spar2_index,[spar2_loc,spar2_y2])

#insert first spar from the lower surface
prev_x = 1
prev_y = 0 
for line in coords:
    x = line[0]
    y = line[1]
     
    if x <= spar1_loc and prev_x > spar1_loc:
            spar1_index = coords.index([x,y])
            spar1_y2 = prev_y + (y-prev_y)/(x-prev_x)*(spar1_loc-prev_x)
            spar1_y = (spar1_y1 + spar1_y2)/2
            for i in range(resolution+1):
                spar1_x_coord = spar1_loc + spar1_r*math.sin(2*math.pi*i/resolution)
                spar1_y_coord = spar1_y - spar1_r*math.cos(2*math.pi*i/resolution)
                spar1_coords.append([spar1_x_coord,spar1_y_coord])
    prev_x = x
    prev_y = y

coords.insert(spar1_index,[spar1_loc,spar1_y2])
for coord in spar1_coords:
    coords.insert(spar1_index,coord)
coords.insert(spar1_index,[spar1_loc,spar1_y2])
coords.reverse()
for line in coords:
    x = line[0]
    y = line[1]
    x_list.append(x)
    y_list.append(y)
    
# out_file = open(filename[1:-5] + "_flap.dat", "w")
# for line in coords:
#     out_file.write("{:.5f}".format(line[0])+" "+"{:.5f}".format(line[1]) + "\n")
# out_file.close()
pyplot.plot(x_list,y_list)
pyplot.axis('equal')
pyplot.show()


        
                
            
