### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 8da79c9e-642e-11ef-3c4f-07062909f6ea
begin
	using PlutoTeachingTools, PlutoUI, HypertextLiteral
	md"""# Julia Cheatsheet"""
end

# ╔═╡ 8b8ea932-ee09-4817-b87b-e41a5b2625ab
using Random, StatsBase

# ╔═╡ 6d5683e8-5ae2-4c55-bf9a-67749a08457a
TableOfContents()

# ╔═╡ c39fe7a1-883f-4daa-b3f9-1c0e53b2e0c5
md"""
###### This loads the tools you need for some of these functions
"""

# ╔═╡ f077da48-d147-451b-b809-e9a2c58e1c92


# ╔═╡ 60c02387-6d11-44dc-a84a-8413cfe0a4b2
md"""
## The Basics
"""

# ╔═╡ 0e4c88fb-c213-474b-b46d-c8c488c2445b
md"""
### Arithmetic
"""

# ╔═╡ 742e2cd5-90c0-4dc2-a9b6-f73295d926c0
tip(md"""
###### A lot of the syntax of Julia is mathematically based, so for instance, it supports the standard arithmetic operations $+,-,*,/$
""")

# ╔═╡ 4f73f495-ed41-45ac-a423-c9bd4cf49063
aside(md"""
```julia
2 + 3
2 - 3
2 * 3
2 / 3
2 // 3 #For a Fraction
```
""", v_offset=-70)

# ╔═╡ b83c6c9a-93ca-4f21-a6d3-b4bfced52743


# ╔═╡ cb1c3e30-355c-4aee-9c11-eb187d399a9a


# ╔═╡ 3636b0cf-a341-4d58-a2ab-978842f59ecd
md"""
### Variables
"""

# ╔═╡ 35140170-9600-475a-8874-8949e39b0531
tip(md"""
###### In the same way that you might write a variable in algebra, you can define variables using a **single** equal sign $=$.
""")

# ╔═╡ b9a9e517-30a0-42a0-8680-44d3632bec27
aside(md"""
```julia
x = 1
y = - pi
🤡 = y^2
#To get special characters, type \[tab] and search
```
""", v_offset=-75)

# ╔═╡ 2c30dcf7-52f0-4bcb-812f-3f3f081d749d


# ╔═╡ ec5d008b-34f6-45ef-a5da-aa1aec417bfa


# ╔═╡ 2f3b1afa-c253-4e12-a879-a6392321c5df
danger(md"###### If you try to assign a new value for a variable in Pluto in a different cell, it will give you an error. Instead, you need to have all definitions of a variable like this:
```julia
begin
	#Your code here
end
```
###### If you ever want to compute more than one thing in a single cell, you need to use a **begin end** block like this.")

# ╔═╡ 00c03d82-035e-4677-a08a-cd1e66b8fd82


# ╔═╡ 2f4f1ab4-6264-451a-86da-a7139b6f74df


# ╔═╡ c58d2c01-af18-4285-a178-9d0b6f6dcc20
md"""
### Strings
"""

# ╔═╡ ef4ccefe-a70e-40db-8af2-8257c486bfcc
tip(md"""
###### So far, we have seen **numeric** values, but we can also have data that contains **linguistic** values. To enter a sentence or word, we need to use \" \"
```julia
🌴 = "🥥 This is my sentence about coconuts! 🥥"
```
""")

# ╔═╡ 6441f371-758f-4d05-ac02-add85ff18d63


# ╔═╡ cf7d66c6-6315-40e3-ba69-233c141f8289


# ╔═╡ d3101d68-2ab2-4fec-adf1-6c5d4509179c
tip(md"""
###### If you just want to enter text into a cell and not have the computer interpret it, you can also hit **[ctrl] + M**.
""")

# ╔═╡ 71a8eef3-2bd9-43bb-b128-5d4126b2dc47


# ╔═╡ c3ad8e07-1c03-424e-ae5c-68eacaa729a7


# ╔═╡ 058d3c52-f89f-44fb-86f1-ed88eaf48579
md"""
### Logical Values
"""

# ╔═╡ 3cef9b02-e1b1-424d-ab97-c8c6faffd22c
tip(md"""
###### We often need to tell/ask the computer if something is true or false. We call **true** and **false** **Booleans**. Common logical operations are $>, <, >=, <=, !=, ==$ which ask if something is greater than, less than, greater than or equal to, less than or equal to, not equal, or equal. Note that we use $=$ to **set** equality and $==$ to **test** equality. You can also get ≥ (\geq), ≤ (\leq), and ≠ (\neq) from the special characters menu.
```julia
2 > 1
5 == 4
"Hello" ≠ "Bonjour"
```
""")

# ╔═╡ aeec97c0-ccba-4118-bcb1-c6f76f547adb


# ╔═╡ 3000ff16-09e7-40d4-8742-1a852372275e
md"""
## Arrays
"""

# ╔═╡ 457afe23-a273-4113-8300-6b8bc7922abb
md"""
### What is an Array?
"""

# ╔═╡ 8f9c6349-d688-4a59-ac2f-be9e12363b74
tip(md"""
###### Variables hold onto a **single** value. To store multiple values, we use an **array** also called a list or vector:
```julia
MyArray = [1.37, "Hello!", 🤡, 🌴, \"🌴\"]
```
""")

# ╔═╡ 02c3df1d-e79b-4367-a8ed-f55f123ebb4c


# ╔═╡ ae9a4032-7e0a-4718-91c8-c15c7184adf2


# ╔═╡ ac78833f-587c-4d62-a038-b3a842091a79
md"""
### Creating Arrays
"""

# ╔═╡ d953311c-9859-4456-b031-ff9a7c83170f
tip(md"""
###### Some special ways to create arrays that are commonly used:
```julia
5:10 #Creates the list [5,6,7,8,9,10]
1:2:9 #Creates the list [1,3,5,7,9]
FirstTenSquares = [i^2 for i in 1:10] #Known as list comprehension
```
""")

# ╔═╡ f9f7163c-7170-4a9d-b28f-fa90ddb0ceb2


# ╔═╡ 56dea08c-9192-426b-95a7-5adf2ddaad5e


# ╔═╡ b96a830d-7eda-4990-9bec-6db33ebcb927
md"""
### Getting Entries
"""

# ╔═╡ 5533d46b-ec04-4c88-a5e1-476ac4cb201f
tip(md"""
###### Some special ways to access array elements:
```julia
MyArray[1] #Gives the first element of MyArray, which is 1.37
MyArray[begin] #Does the same thing
MyArray[end] #Gives the last element of MyArray, which is \"🌴\"
MyArray[1:2:5] #Gives the first, third, and fifth element of MyArray
```
""")

# ╔═╡ af409840-c6cc-4baa-93c9-276afba3c602


# ╔═╡ 9b9ffb2e-9aef-4b35-babb-1077e7616a7f


# ╔═╡ 5b71307e-432c-43ee-9d03-94b3457da174
md"""
### Changing Elements
"""

# ╔═╡ 24b96596-ea05-4360-85c8-19d6b3c3870d
tip(md"""
###### If you want to, you can change elements of an array:
```julia
begin
	MySecondArray = [i+j for i in 1:3 for j in 1:2]
	println(MySecondArray) #Prints out MySecondArray
	MySecondArray[end] = 100 #This needs to be the same type
	println(MySecondArray) #Prints out the new MySecondArray
end
```
""")

# ╔═╡ 69737fdb-c30a-4368-bfd1-9fdb991518e1


# ╔═╡ db3734b1-2fee-4ee1-b468-6eaa2c422e44


# ╔═╡ 0b0f5c46-80c5-4156-a2e9-9e0b5a80cbd8
md"""
## Functions
"""

# ╔═╡ bc06789b-4220-41e2-a2b9-d1302c2b3d45
md"""
### Defining a Function
"""

# ╔═╡ eeae99ad-9654-445c-923e-128cdbfb63c3
tip(md"""
###### There are a few different ways to define functions:
```julia
function PrintAndCube2(x)
	println("Your input was ", x)
	return x^3
end
#This is useful for longer definitions
```
```julia
PrintAndCube2(x) = (println("Your input was ", x); x^3)
#Known as Assignment Form
```
```julia
PrintAndCube3 = (x -> (println("Your input was ", x); x^3))
#Known as an anonymous or lambda function
```
""")

# ╔═╡ 5f87d789-ba0c-469b-88d7-8c652c1921e7


# ╔═╡ 3c16c335-2c1c-4d94-b3dd-8ac5ad0f7904


# ╔═╡ 32a01289-4e09-4485-bec5-f9a9a2a1b40c
md"""
### Evaluating a Function
"""

# ╔═╡ 772399b0-6423-45c4-8344-d6fa42e534fb
tip(md"""
###### After defining a function, you can apply it to values or variables:
```julia
PrintAndCube2(🤡)
+(4, 5)
*("Hello, ", 🌴)
sqrt(x + y)
```
""")

# ╔═╡ a9aa3914-5f27-44a3-8252-0b2223be973a


# ╔═╡ a171371a-a22d-443e-9810-8a01dba3e08c


# ╔═╡ 7ff71761-3b31-4b4f-a2cc-8eeea22f0c62
tip(md"""
###### You can also apply the function to every element of an array by adding a . after the function name in what is called **broadcasting**:
```julia
PrintAndCube2.([1,2,3,5])
```
###### You can also use the **map** command to do the same thing:
```julia
map(PrintAndCube2, [1,2,3,5])
```
###### If you have a function that takes two inputs, like + and want to have an array as an input, you write the . **before** the function name:
```julia
[1,2,3,5] .> 2
```
""")

# ╔═╡ 3ac56f2a-7df7-486b-825f-d321bdb34cb8


# ╔═╡ 6ffa0a09-2d60-4477-b8a8-38d4e14901e3


# ╔═╡ 3f6d483b-854f-404c-ad1d-1768671dea97
tip(md"""
###### If you have a function which takes two inputs, like +, you can repeatedly apply the function to every element in your array by writing ... after the array in what is called the **splat operator**:
```julia
+([1,2,3,5]...)
```
""")

# ╔═╡ d8ffe4f9-1893-4169-80a2-cfba7895683a


# ╔═╡ ed042269-f72a-46cd-9ea4-2dbcee31e4a8


# ╔═╡ 8132ad82-748a-4f6c-af71-8a2cc303a5ed
tip(md"""
###### Some useful functions when working with array are **sort**, **filter**, and **countmap**, which sorts the array, filters out values where a function is true, and counts number of entries:
```julia
sort([2,5,3,4,11,3,2,8,4,3])
filter(x -> x ≥ 4, [2,5,3,4,11,3,2,8,4,3])
countmap([2,5,3,4,11,3,2,8,4,3])
```
""")

# ╔═╡ 80e774a9-fc4c-423b-aaef-8ceff4270d71


# ╔═╡ defa22ba-90b9-480d-8fa3-ebbb66ae7f80


# ╔═╡ 2a2b4633-9f67-40c3-b709-0cfb297b74e3
tip(md"""
###### If you ever want to see what a function is doing during evaluation, you can by using:
```julia
using PlutoTest
@test +(Squares.([1,3])...) == 10
```
###### This expects a true or false value after @test, but you don't need to use any logical operators if you don't want to.
""")

# ╔═╡ 360338bc-ca14-475d-b067-b99c33140001


# ╔═╡ bd72ddad-c184-4223-91e9-a06bf9049ba8


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
HypertextLiteral = "~0.9.5"
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.4"
manifest_format = "2.0"
project_hash = "31cf6c70bd1bb669550220dd59fc34e6b25e83ee"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "7eee164f122511d3e4e1ebadb7956939ea7e1c77"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.6"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.Compat]]
deps = ["TOML", "UUIDs"]
git-tree-sha1 = "8ae8d32e09f0dcf42a36b90d4e17f5dd2e4c4215"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.16.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "4b415b6cccb9ab61fec78a621572c82ac7fa5776"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.35"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.Latexify]]
deps = ["Format", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Requires"]
git-tree-sha1 = "ce5f5621cac23a86011836badfedf664a612cee4"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.5"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SparseArraysExt = "SparseArrays"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "a2d09619db4e765091ee5c6ffe8872849de0feea"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.28"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "1ce1834f9644a8f7c011eb0592b7fd6c42c90653"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.0.1"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "2fa9ee3e63fd3a4f7a9a4f4744a52f4856de82df"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.13"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.23+4"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoTeachingTools]]
deps = ["Downloads", "HypertextLiteral", "LaTeXStrings", "Latexify", "Markdown", "PlutoLinks", "PlutoUI", "Random"]
git-tree-sha1 = "5d9ab1a4faf25a62bb9d07ef0003396ac258ef1c"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.2.15"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "7b7850bb94f75762d567834d7e9802fc22d62f9c"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.5.18"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1ff449ad350c9c4cbc756624d6f8a8c3ef56d3ed"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.7.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "5cf7606d6cef84b543b483848d4ae08ad9832b21"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.3"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.2.1+1"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─8da79c9e-642e-11ef-3c4f-07062909f6ea
# ╟─6d5683e8-5ae2-4c55-bf9a-67749a08457a
# ╟─c39fe7a1-883f-4daa-b3f9-1c0e53b2e0c5
# ╠═8b8ea932-ee09-4817-b87b-e41a5b2625ab
# ╟─f077da48-d147-451b-b809-e9a2c58e1c92
# ╟─60c02387-6d11-44dc-a84a-8413cfe0a4b2
# ╟─0e4c88fb-c213-474b-b46d-c8c488c2445b
# ╟─742e2cd5-90c0-4dc2-a9b6-f73295d926c0
# ╟─4f73f495-ed41-45ac-a423-c9bd4cf49063
# ╠═b83c6c9a-93ca-4f21-a6d3-b4bfced52743
# ╟─cb1c3e30-355c-4aee-9c11-eb187d399a9a
# ╟─3636b0cf-a341-4d58-a2ab-978842f59ecd
# ╟─35140170-9600-475a-8874-8949e39b0531
# ╟─b9a9e517-30a0-42a0-8680-44d3632bec27
# ╠═2c30dcf7-52f0-4bcb-812f-3f3f081d749d
# ╟─ec5d008b-34f6-45ef-a5da-aa1aec417bfa
# ╟─2f3b1afa-c253-4e12-a879-a6392321c5df
# ╠═00c03d82-035e-4677-a08a-cd1e66b8fd82
# ╟─2f4f1ab4-6264-451a-86da-a7139b6f74df
# ╟─c58d2c01-af18-4285-a178-9d0b6f6dcc20
# ╟─ef4ccefe-a70e-40db-8af2-8257c486bfcc
# ╠═6441f371-758f-4d05-ac02-add85ff18d63
# ╟─cf7d66c6-6315-40e3-ba69-233c141f8289
# ╟─d3101d68-2ab2-4fec-adf1-6c5d4509179c
# ╠═71a8eef3-2bd9-43bb-b128-5d4126b2dc47
# ╟─c3ad8e07-1c03-424e-ae5c-68eacaa729a7
# ╟─058d3c52-f89f-44fb-86f1-ed88eaf48579
# ╟─3cef9b02-e1b1-424d-ab97-c8c6faffd22c
# ╠═aeec97c0-ccba-4118-bcb1-c6f76f547adb
# ╟─3000ff16-09e7-40d4-8742-1a852372275e
# ╟─457afe23-a273-4113-8300-6b8bc7922abb
# ╟─8f9c6349-d688-4a59-ac2f-be9e12363b74
# ╠═02c3df1d-e79b-4367-a8ed-f55f123ebb4c
# ╟─ae9a4032-7e0a-4718-91c8-c15c7184adf2
# ╟─ac78833f-587c-4d62-a038-b3a842091a79
# ╟─d953311c-9859-4456-b031-ff9a7c83170f
# ╠═f9f7163c-7170-4a9d-b28f-fa90ddb0ceb2
# ╟─56dea08c-9192-426b-95a7-5adf2ddaad5e
# ╟─b96a830d-7eda-4990-9bec-6db33ebcb927
# ╟─5533d46b-ec04-4c88-a5e1-476ac4cb201f
# ╠═af409840-c6cc-4baa-93c9-276afba3c602
# ╟─9b9ffb2e-9aef-4b35-babb-1077e7616a7f
# ╟─5b71307e-432c-43ee-9d03-94b3457da174
# ╟─24b96596-ea05-4360-85c8-19d6b3c3870d
# ╠═69737fdb-c30a-4368-bfd1-9fdb991518e1
# ╟─db3734b1-2fee-4ee1-b468-6eaa2c422e44
# ╟─0b0f5c46-80c5-4156-a2e9-9e0b5a80cbd8
# ╟─bc06789b-4220-41e2-a2b9-d1302c2b3d45
# ╟─eeae99ad-9654-445c-923e-128cdbfb63c3
# ╠═5f87d789-ba0c-469b-88d7-8c652c1921e7
# ╟─3c16c335-2c1c-4d94-b3dd-8ac5ad0f7904
# ╟─32a01289-4e09-4485-bec5-f9a9a2a1b40c
# ╟─772399b0-6423-45c4-8344-d6fa42e534fb
# ╠═a9aa3914-5f27-44a3-8252-0b2223be973a
# ╟─a171371a-a22d-443e-9810-8a01dba3e08c
# ╟─7ff71761-3b31-4b4f-a2cc-8eeea22f0c62
# ╠═3ac56f2a-7df7-486b-825f-d321bdb34cb8
# ╟─6ffa0a09-2d60-4477-b8a8-38d4e14901e3
# ╟─3f6d483b-854f-404c-ad1d-1768671dea97
# ╠═d8ffe4f9-1893-4169-80a2-cfba7895683a
# ╟─ed042269-f72a-46cd-9ea4-2dbcee31e4a8
# ╟─8132ad82-748a-4f6c-af71-8a2cc303a5ed
# ╠═80e774a9-fc4c-423b-aaef-8ceff4270d71
# ╟─defa22ba-90b9-480d-8fa3-ebbb66ae7f80
# ╟─2a2b4633-9f67-40c3-b709-0cfb297b74e3
# ╠═360338bc-ca14-475d-b067-b99c33140001
# ╟─bd72ddad-c184-4223-91e9-a06bf9049ba8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
