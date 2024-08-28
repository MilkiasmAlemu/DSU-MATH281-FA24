### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 19db3176-2d51-499c-9d57-75398936ed65
begin
	using PlutoTeachingTools, PlutoUI, HypertextLiteral
	md"""# Homework 1
	#### Please enter your first and last names below:"""
end

# ╔═╡ 4b6945ae-ecd6-45bc-83fa-7f7d082a8ab1
using StatsBase

# ╔═╡ e34e4141-58e5-4e64-a942-dc1a005cc244
md"""
My Name is: 
"""

# ╔═╡ ea25b2a2-604d-4879-a1fb-7786dc69b4eb
danger(md"""
Remember to click **[ctrl] + M** to be able to enter text in a cell, and please hit **[shift]** + **[enter]** to save your work in a cell.
""")

# ╔═╡ c4bbb4e0-f42a-485d-a047-dfcf683ea5c3
TableOfContents(title="Homework Problems")

# ╔═╡ 1155eced-7345-4e33-ac3e-60e15214dab7
md"""
##### These are the different packages being used for this homework.
"""

# ╔═╡ 018ec3e5-9fff-4024-9b27-a0828b151164
@htl("<div>
<h2>Problem 1</h2>
<p>
For this problem, consider the situation of flipping a weighted coin where <b>Heads</b> happens 60% of the time and <b>Tails</b> the other 40%.
</p>
$(question_box(@htl("
<ul>
	<li>Create an array that simulates 1000 random flips of this coin.</li>
	<li>Count the number of heads and tails from your simulation.</li>
	<li>Calculate the theoretical value of flipping this coin 1000 times.</li>
	<li>Do the results of your simulation match up with the theoretical value? Do you find this suprising? Explain your answer for both questions.</li>
</ul>")))
</div>")

# ╔═╡ c1bb4bbd-395f-4bb1-99bd-ae80c7244ca1


# ╔═╡ 4caa03e5-25d3-4b52-9fda-5eb91ef91a4b


# ╔═╡ 672d7ca3-fd02-4c15-9fb8-f1a15db894bd


# ╔═╡ f05574f4-caff-4562-bfc0-4af5fe15a46b
md"""

"""

# ╔═╡ e1dd4520-fb69-43d4-8f7c-3dd173e530c1
Foldable("Hints for Problem 1",@htl("<p>Hint for Making a Function that returns <b>false</b> 40% of the Time and <b>true</b> 60% of the Time</p> $(hint(md"One way to do this is:
```julia
function f(x)
	return rand(1:10) > 4
end
```")) <p>Hint for Making an Array with 1000 Outputs of a Function</p> $(hint(md"Given a function f(x) that takes one input, one way to do this is:
```julia
a = f.(1:1000)
```")) <p>Hint for Finding Number of Occurrences in an Array</p> $(hint(md"If you have an array named $c$ and want to figure out how many times its different elements appear, then you can use:
```julia
countmap(c)
```
This returns a dictionary containing key-value pairs of the form **k ⇒ v** where **k** is an entry of $c$ and **v** is the number of times it appears."))"))

# ╔═╡ 07737e25-9bbb-420b-acca-754c951b78cf
@htl("<div>
<h2>Problem 2</h2>
<p>
For this problem, consider the situation of drawing a card from a standard deck of cards.
</p>
$(question_box(@htl("
<ul>
	<li>Create an array that simulates drawing one card from a deck 10000 times.</li>
	<li>Calculate the number of Aces (of any suit) drawn from your simulation.</li>
	<li>Calculate the theoretical value of drawing an Ace (of any suit) this many times.</li>
	<li>Do the results of your simulation match up with the theoretical value? Do you find this suprising? Explain your answer for both questions.</li>
</ul>")))
</div>")

# ╔═╡ 2510df56-cb20-45a2-a15f-2d2dd123b807


# ╔═╡ 90ab903e-d1b7-479d-8a0d-2802c3cbe180


# ╔═╡ c8fdf575-916d-4078-aacd-49fc277d88bd


# ╔═╡ 405dad4f-9e77-4b4b-8c7f-dbfbd7b4e730


# ╔═╡ f332c53c-8eae-4990-8b33-7fc54196b0ff
Foldable("Hints for Problem 2",@htl("<p>Hint for Simulating a Deck</p> $(hint(md"A standard deck has $52$ cards with four Aces. One possibility is to use the range $1:52$ and treat the first four numbers $1,2,3,4$ as the position of the Aces.")) <p>Hint for Picking Many Random Elements of an Array</p> $(hint(md"Given an array $a$, one way to pick $10000$ random elements of $a$ is:
```julia
b = rand(a, 10000)
```")) <p>Hint for Finding Number of Occurrences in an Array</p> $(hint(md"If you have an array named $c$ and want to figure out how many times its different elements appear, then you can use:
```julia
countmap(c)
```
This returns a dictionary containing key-value pairs of the form **k ⇒ v** where **k** is an entry of $c$ and **v** is the number of times it appears."))"))

# ╔═╡ c77ec250-4680-4f41-997b-368b737b0ad0
@htl("<div>
<h2>Problem 3</h2>
<p>
For this problem, consider a game where you roll two standard six-sided dice. You win the game if the sum of the two dice is 7 or 11.
</p>
$(question_box(@htl("
<ul>
	<li>Simulate playing the game 10000 times.</li>
	<li>Calculate the number of wins from your simulation.</li>
	<li>Calculate the theoretical probability of winning this game.</li>
	<li>Do the results of your simulation match up with the theoretical probability? Do you find this suprising? Explain your answer for both questions.</li>
</ul>")))
</div>")

# ╔═╡ 709e5c84-a6d0-44e3-9768-24e88ebfe9a9


# ╔═╡ 0b0ceff7-dbba-4cad-bb93-31b665db14ba


# ╔═╡ fd3c3d18-3daa-4f2c-b068-dd2067f53d43


# ╔═╡ 0e99cc13-ba89-48d0-8035-0ea5bedb7591


# ╔═╡ 4947538c-59c7-46b5-b1cd-2e45f8deecc5
Foldable("Hints for Problem 3",@htl("<p>Hint for Simulating 100 Dice Rolls</p> $(hint(md"One way to simulate rolling a die 10000 times is:
```julia
a = rand(1:6, 10000)
```")) <p>Hint for Adding Two Arrays</p> $(hint(md"If you have defined two arrays $a$ and $b$ of the same length, one way to add together their entries is:
```julia
a+b
```")) <p>Hint for Finding Number of Occurrences in an Array</p> $(hint(md"If you have an array named $c$ and want to figure out how many times its different elements appear, then you can use:
```julia
countmap(c)
```
This returns a dictionary containing key-value pairs of the form **k ⇒ v** where **k** is an entry of $c$ and **v** is the number of times it appears.")) <p>Hint for Finding the Theoretical Probability</p> $(hint(md"Consider actually rolling two dice. What are all of the different possibilities?")) <p>Another Hint for Finding the Theoretical Probability</p> $(hint(md"```julia
reshape([🎲₁ + 🎲₂ for 🎲₁ in 1:6 for 🎲₂ in 1:6],(6,6))
```"))"))

# ╔═╡ 65ee1276-c813-41a9-8a65-2048fab1950d
@htl("<div>
<h2>Bonus Problem</h2>
<p>
Consider a square with side length 2 centered at the origin with a circle of radius 1 in its center.
</p>
$(question_box(@htl("
<ul>
	<li>What are the areas of the square and the circle?</li>
	<li>Randomly generate the coordinates of 10000 points in this square.</li>
	<li>How many points appear inside of the circle?</li>
	<li>What can you say about the proportion of points within the circle to total points?</li>
	<li>Repeat the above with a rectangle of width 4 and height 2 in place of the square and an oval of width 4 and height 2 in place of the circle. What do you notice?
</ul>")))
</div>")

# ╔═╡ 20c420cc-dad0-48d6-92bb-02a1f04fd7fd
Foldable("Hints for Bonus Problem",@htl("<p>Getting Started</p> $(hint(md"Think about the Monte Carlo Simulation from Class")) <p>Formula of a Circle</p> $(hint(md"The formula for a circle is $x^2+y^2 \leq 1$ and its area is $\pi r^2$")) <p>Formula of an Ellipse</p> $(hint(md"The formula for an Ellipse of width $2a$ and height $2b$ is $\left(\frac{x}{a}\right)^2+\left(\frac{y}{b}\right)^2 \leq 1$ and its area is $\pi ab$"))"))

# ╔═╡ 86438843-07fd-4925-bdb6-c90f092f3f04


# ╔═╡ 0e33e9a1-dee8-4cb9-b2f7-80e6cb1eb625


# ╔═╡ 1842163c-537b-463f-8f20-721568d023df


# ╔═╡ 1fca3e37-194a-4a15-b658-3bf8253efd08


# ╔═╡ b92a4438-c8f9-4907-bc16-26cf620c597f


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
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
project_hash = "fa6bd7b60bc4b27c06884d1b8d014e153bf33435"

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
git-tree-sha1 = "7ae67d8567853d367e3463719356b8989e236069"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.34"

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
# ╟─19db3176-2d51-499c-9d57-75398936ed65
# ╠═e34e4141-58e5-4e64-a942-dc1a005cc244
# ╟─ea25b2a2-604d-4879-a1fb-7786dc69b4eb
# ╟─c4bbb4e0-f42a-485d-a047-dfcf683ea5c3
# ╟─1155eced-7345-4e33-ac3e-60e15214dab7
# ╠═4b6945ae-ecd6-45bc-83fa-7f7d082a8ab1
# ╟─018ec3e5-9fff-4024-9b27-a0828b151164
# ╠═c1bb4bbd-395f-4bb1-99bd-ae80c7244ca1
# ╠═4caa03e5-25d3-4b52-9fda-5eb91ef91a4b
# ╠═672d7ca3-fd02-4c15-9fb8-f1a15db894bd
# ╠═f05574f4-caff-4562-bfc0-4af5fe15a46b
# ╟─e1dd4520-fb69-43d4-8f7c-3dd173e530c1
# ╟─07737e25-9bbb-420b-acca-754c951b78cf
# ╠═2510df56-cb20-45a2-a15f-2d2dd123b807
# ╠═90ab903e-d1b7-479d-8a0d-2802c3cbe180
# ╠═c8fdf575-916d-4078-aacd-49fc277d88bd
# ╠═405dad4f-9e77-4b4b-8c7f-dbfbd7b4e730
# ╟─f332c53c-8eae-4990-8b33-7fc54196b0ff
# ╟─c77ec250-4680-4f41-997b-368b737b0ad0
# ╠═709e5c84-a6d0-44e3-9768-24e88ebfe9a9
# ╠═0b0ceff7-dbba-4cad-bb93-31b665db14ba
# ╠═fd3c3d18-3daa-4f2c-b068-dd2067f53d43
# ╠═0e99cc13-ba89-48d0-8035-0ea5bedb7591
# ╟─4947538c-59c7-46b5-b1cd-2e45f8deecc5
# ╟─65ee1276-c813-41a9-8a65-2048fab1950d
# ╟─20c420cc-dad0-48d6-92bb-02a1f04fd7fd
# ╠═86438843-07fd-4925-bdb6-c90f092f3f04
# ╠═0e33e9a1-dee8-4cb9-b2f7-80e6cb1eb625
# ╠═1842163c-537b-463f-8f20-721568d023df
# ╠═1fca3e37-194a-4a15-b658-3bf8253efd08
# ╠═b92a4438-c8f9-4907-bc16-26cf620c597f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
