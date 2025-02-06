
using HDF5
using Plots

file_path = raw"\\synology-fiz\illesg-volume\2d-calculations\gpu-test-ZnTe-50GW-0.5ps-wide.hdf5"
readH5 = h5open(file_path, "r") # read 
println("data in the file:", readH5)  # List datasets in the file
#close(readH5)

FID = readH5
function geteffic(FID)
    En0 = sum(read(FID["/En"])[1, :])
    EnTHz = sum(read(FID["/EnTHz"]), dims=2)
    effic = EnTHz ./ En0
    #effic = dropdims(effic, dims=2) * 100 * 4 * nTHzo(1.5e12 * 2 * pi, 300, 4) ./ (1 + nTHzo(1.5e12 * 2 * pi, 300, 4)) .^ 2
    return effic
   
  end
    
println(geteffic(FID))
