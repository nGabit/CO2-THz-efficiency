# Access specific datasets in terminal
using Pkg
Pkg.add("HDF5")
using HDF5
# To read HDF4 file
a = h5open("ZnTe", "r")
file_path "ZnTe"
# To read the the values you want
read(readH5["gamma"])   #or
h5read(file_path, "/gamma")  
