module Metadata

using Dates
using FlatBuffers; const FB = FlatBuffers

include("schema.jl")
include("message.jl")

# TODO have this give decent error messages
struct InvalidMetadataError <: Exception end

function juliatype(int::Int_)
    if int.is_signed
        if int.bitWidth == 8
            Int8
        elseif int.bitWidth == 16
            Int16
        elseif int.bitWidth == 32
            Int32
        elseif int.bitWidth == 64
            Int64
        elseif int.bitWidth == 128
            Int128
        else
            throw(InvalidMetadataError())
        end
    else
        if int.bitWidth == 8
            UInt8
        elseif int.bitWidth == 16
            UInt16
        elseif int.bitWidth == 32
            UInt32
        elseif int.bitWidth == 64
            UInt64
        elseif int.bitWidth == 128
            UInt128
        else
            throw(InvalidMetadataError())
        end
    end
end
function juliatype(fp::FloatingPoint)
    if fp.precision == HALF
        Float16
    elseif fp.precision == SINGLE
        Float32
    elseif fp.precision == DOUBLE
        Float64
    else
        throw(InvalidMetadataError())
    end
end


arrowtype(::Type{Int8}) = Int_(8, true)
arrowtype(::Type{Int16}) = Int_(16, true)
arrowtype(::Type{Int32}) = Int_(32, true)
arrowtype(::Type{Int64}) = Int_(64, true)
arrowtype(::Type{Int128}) = Int_(128, true)
arrowtype(::Type{UInt8}) = Int_(8, false)
arrowtype(::Type{UInt16}) = Int_(16, false)
arrowtype(::Type{UInt32}) = Int_(32, false)
arrowtype(::Type{UInt64}) = Int_(64, false)
arrowtype(::Type{UInt128}) = Int_(128, false)


export FB

end # module
