using SnoopCompile

### Log the compiles
# This only needs to be run once (to generate "/tmp/fsa_compiles.csv")

SnoopCompile.@snoop "/tmp/fsa_compiles.csv" begin
    include(Pkg.dir("FixedSizeArrays", "test","runtests.jl"))
end

### Parse the compiles and generate precompilation scripts
# This can be run repeatedly to tweak the scripts

# IMPORTANT: we must have the module(s) defined for the parcelation
# step, otherwise we will get no precompiles for the FixedSizeArrays module
using FixedSizeArrays

data = SnoopCompile.read("/tmp/fsa_compiles.csv")

# Use these two lines if you want to create precompile functions for
# individual packages
pc, discards = SnoopCompile.parcel(data[end:-1:1,2])
SnoopCompile.write("/tmp/precompile", pc)
