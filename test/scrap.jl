using Arrow, BenchmarkTools, DataFrames, Tables
using Debugger

const FB = Arrow.FB
const Meta = Arrow.Meta
const A = Arrow

# NOTE: currently need `copycols=false` for lazily loaded dataframe

using Arrow: build

buf = read("data/basic_stream.dat")

t = Arrow.Table(buf)
df = DataFrame(t, copycols=false)

# collect columns for convenience
vs = [v.args[1] for v ∈ eachcol(df)]

c = Arrow.column(t, 3)
rb = c.batches[1]


