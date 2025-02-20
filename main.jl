
using HDF5
using Plots
using Base.Threads
using DSP
using CSV
using DataFrames 
include("functions.jl")

c = 3e8
nu0 = 1.0e12
dz = 5e-6
z_end = 10e-3
z = range(0, stop = z_end, length = 401)
z_cry = collect(z)
T = 300
N = 4e4
lambda0 = 10.6e-6
omega0 = 2 * pi * c / lambda0
omegaMAX = 2.5 * omega0
domega = omegaMAX / N
omega = (0:N-1) * domega
nTHz = nTHzo(2 * pi * nu0, T) 

file_path = raw"\\synology-fiz\illesg-volume\2d-calculations\gpu-test-ZnTe-80.0GW-wide.hdf5"

readH5 = h5open(file_path, "r") # read 

println("data in the file:", readH5)  # List datasets in the file
#close(readH5)

# Access specific datasets in terminal
# read(readH5["gamma"])   #or
# h5read(file_path, "/gamma")


FID = readH5
function geteffic(FID)
    En0 = sum(read(FID["/En"])[1, :])
    EnTHz = sum(read(FID["/EnTHz"]), dims=2)
   
    effic = EnTHz ./ En0
   
    effic = dropdims(effic, dims=2) * 100 * 4 * nTHzo(nu0 * 2 * pi, T) ./ (1 + nTHzo(nu0 * 2 * pi, T)) .^ 2
    return effic
   
  end
    
println(geteffic(FID))


x_axis = z_cry * 1e3
y_axis = geteffic(FID)

plot(
    x_axis, y_axis,
    xlabel="X-axis Label", ylabel="Y-axis Label",
    title="HDF5 Data Plot", legend=false
)

#Export data to CSV (optional)
export_data = DataFrame(x=x_axis, y=y_axis)
CSV.write("exported_data.csv", export_data)

println("Data exported to 'exported_data.csv'")
