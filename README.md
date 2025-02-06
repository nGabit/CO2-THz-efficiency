This code reads the HDF5 file and uses specific variables( Electric Fields) to calculate conversion efficiency for 2D Model in Julia.
Used crystal: ZnTe
# Access specific datasets in the terminal
using Pkg
Pkg.add("HDF5")
using HDF5
# To read HDF4 file
a = h5open("ZnTe", "r")
file_path "ZnTe"
# To read the values you want
read(readH5["gamma"])   #or
h5read(file_path, "/gamma")  
