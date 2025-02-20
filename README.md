The codes in main file are used for the next purposes:
1. Reading HDF5 file;
2. Calculation of an  efficiency from imported data;
3. export data;
4. plot graphs.
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
