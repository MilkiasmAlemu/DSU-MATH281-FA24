### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ 022ce81e-3229-49c7-b821-44df7cdee98d
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools
end

# ╔═╡ 03f0893c-1b15-4bd2-8d75-9480f16facf6
using Distributions

# ╔═╡ 9553dd0f-7675-46ed-a018-505af6e943d9
@htl("""
	<head>
		<script src="https://d3js.org/d3.v7.min.js"></script>
	</head>
	<h1>Lecture 19</h1>
""")

# ╔═╡ de380171-4790-4d4e-a915-e6ab74956d65
TableOfContents()

# ╔═╡ 61d992ce-c56e-46bc-b8ec-fb9a44f296c1
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ 6338fa4f-f380-457c-bd94-a4ae02d13b81
@htl("""
	<hr>
""")

# ╔═╡ bd8291ae-4cfb-4e0f-a4b2-acfbbb0bb02d
@htl("""
	<h2>(Composite) Hypothesis Testing</h2>
""")

# ╔═╡ 5f42a94a-b8d7-4225-9db7-272468cd52c1
μ₀ = 60

# ╔═╡ 876fde63-3649-4ef1-bcc8-b7a6c63b3dea
@htl("""
<h5>
	Null Hypothesis : μ = $(μ₀)
</h5>
""")

# ╔═╡ 721d8d87-ad56-4ad2-988a-f2e4b17de066
@htl("""
<h5>
	Number of Samples
</h5>
""")

# ╔═╡ fdfdaeac-cae2-48ab-b174-6b0541b7408a
@bindname n Slider(1:100, default=52, show_value=true)

# ╔═╡ bb93b1e9-949a-427d-96fd-c370891f6cc2
@htl("""
<h5>
	Significance Level
</h5>
""")

# ╔═╡ c8ae07c7-e04f-496c-8785-739e05a434d2
@htl("""
<h5>
	p–value
</h5>
""")

# ╔═╡ d62adda9-3979-4596-8798-da9e64e567c5
begin
	α_Slider = @bindname α Slider(range(0.01, 1, step=0.01), default = 0.05, show_value=true)
	μ = 63
	X_composite = Normal(μ, 10)
	@htl("""
		<hr>
	""")
end

# ╔═╡ 7d2b521b-b525-4012-87c4-9b33786c0785
mean_sampled = mean(rand(X_composite, n))

# ╔═╡ e0d422b3-863d-4079-8dc3-268f9b03936d
@htl("""
<h5>
	Alternative Hypothesis : μ > $(round(mean_sampled; digits=2))
</h5>
""")

# ╔═╡ 655340bf-4ff0-46bc-b5b8-57492d33834a
begin
	local Bar_UUID = "bar-" * string(uuid1())
	local svg_UUID = Bar_UUID * "-svg"

	local width_UUID = Bar_UUID * "-width"
	local height_UUID = Bar_UUID * "-height"

	local x_min = 55
	local x_max = 65
	local y_max = 0.3

	local X_mean = Normal(μ₀, 10 / sqrt(n))
	local resolution = 1000
	local x_vals_0 = range(x_min, mean_sampled, length=resolution)
	local x_vals_1 = range(mean_sampled, x_max, length=resolution)
	local x_vals = range(x_min, x_max, length=resolution)
	local pdf_vals_0 = pdf.(X_mean, x_vals_0)
	local pdf_vals_1 = pdf.(X_mean, x_vals_1)
	local pdf_vals = pdf.(X_mean, x_vals)

	@htl("""
		<script src="https://d3js.org/d3.v7.min.js"></script>
		<div id=$(Bar_UUID)>
			<svg id=$(svg_UUID) width="400" height="400" viewBox="0 0 400 400" style="max-width: 100%; height: auto; background-color: white;"></svg>
		</div>

		<script>
			drawPDF();
	
			function drawPDF() {
				const width = 400;
				const height = 400;

				const xMin = $(x_min);
				const xMax = $(x_max);
				const yMax = $(y_max);
				const xVals0 = $(x_vals_0);
				const xVals1 = $(x_vals_1);
				const xVals = $(x_vals);
				const pdfVals0 = $(pdf_vals_0);
				const pdfVals1 = $(pdf_vals_1);
				const pdfVals = $(pdf_vals);

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				const xDomain = [xMin, xMax];
				const yDomain = [0, yMax];

				let x = d3.scaleLinear()
					.domain(xDomain)
					.range([marginLeft, width - marginRight]);

				let y = d3.scaleLinear()
					.domain(yDomain)
					.range([height - marginBottom, marginTop]);

				let svg = d3.select('#' + $(svg_UUID));

				svg.selectAll(".pdf").remove();

				svg.append("g")
					.classed("pdf", true)
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0));

				svg.append("g")
					.classed("pdf", true)
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40))
					.call((g) => g.select(".domain").remove());

				svg.append("g")
					.classed("pdf", true)
					.append("path")
					.datum(pdfVals1)
					.attr("fill", "lightskyblue")
					.attr("stroke", "none")
					.attr("stroke-width", 0)
					.attr("fill-opacity", 0.75)
					.attr("d", d3.area()
						.x((d, i) => x(xVals1[i]))
						.y0(y(0))
						.y1((d) => y(d)));

				svg.append("g")
					.classed("pdf", true)
					.append("path")
					.datum(pdfVals)
					.attr("fill", "none")
					.attr("stroke", "steelblue")
					.attr("stroke-width", 4)
					.attr("opacity", 0.75)
					.attr("d", d3.line()
						.x((d, i) => x(xVals[i]))
						.y((d) => y(d)));
			}
		</script>
	""")
end

# ╔═╡ e43d728d-3d43-4607-beb8-a94b7fae695d
p_value = 1 - cdf(Normal(μ₀, 10 / sqrt(n)), mean_sampled)

# ╔═╡ 050e7145-f208-43df-b5e1-d230648d93a1
α_Slider

# ╔═╡ 30b8583a-df32-46e0-88a2-38abb1c0b862
@htl("""
	<h5>With α = $(α), we should 
	$((p_value < α) ? @htl("""<p style="display: inline; color: red;">REJECT</p>""") : @htl("""<p style="display: inline; color: green;">NOT REJECT</p>"""))
	 the Null Hypothesis</h5>
""")

# ╔═╡ 8251c132-ef35-4b79-a252-fe8dcf3aa1ed
@htl("""
	<h2>Testing Two Means</h2>
""")

# ╔═╡ af9ddb60-89cf-413f-bae7-117b603b141e
@htl("""
<h5>
	Null Hypothesis : μₓ = μᵧ
</h5>
""")

# ╔═╡ c257b7ea-9eae-4a27-add9-df33646bae56
@htl("""
<h5>
	Alternative Hypothesis : μₓ > μᵧ
</h5>
""")

# ╔═╡ 459a0ec9-d8a8-4ba7-ac4f-7b9f7dd5b83b
@htl("""
<h5>
	Number of Samples
</h5>
""")

# ╔═╡ a21d67ad-ac04-4e08-a8c9-37806332c7df
@bindname n₁ Slider(1:100, default=50, show_value=true)

# ╔═╡ 440a3ca0-561c-473b-8c59-8fab07089304
@bindname n₂ Slider(1:100, default=40, show_value=true)

# ╔═╡ ca95e043-9d99-4513-a788-18f7a8ae6fcc
@htl("""
<h5>
	Significance Level
</h5>
""")

# ╔═╡ c1b35794-a2f6-4145-803b-ee84fd6e9642
α_Slider

# ╔═╡ 1060d266-21e7-426b-837b-ea08e879c551
@htl("""
<h5>
	Z–score
</h5>
""")

# ╔═╡ 865844f0-3d5a-4f56-9f3c-3583e18d29d6
z =  quantile(Normal(0,1), 1 - α)

# ╔═╡ d0a871e6-983b-4f3e-b2f1-40e7b2551348
@htl("""
<h5>
	Critical Region: Z ≥ $(round(z, digits=2))
</h5>
""")

# ╔═╡ 9c1beb57-f847-4b54-a73c-4e405da854fd
@htl("""
	<h5>With α = $(α), we should 
	$((p_value ≥ α) ? @htl("""<p style="display: inline; color: red;">REJECT</p>""") : @htl("""<p style="display: inline; color: green;">NOT REJECT</p>"""))
	 the Null Hypothesis</h5>
""")

# ╔═╡ edc55ed6-bab4-44a0-8ff7-ecf65b08fca6
begin
	μ_X = 6.9
	μ_Y = 6.7
	σ_X = 0.15
	σ_Y = 0.1
	X = Normal(μ_X, σ_X)
	Y = Normal(μ_Y, σ_Y)
	@htl("""
		<hr>
	""")
end

# ╔═╡ d7867bf9-3f0b-4cca-8d66-90e1146cd2c3
X_sample = rand(X, n₁)

# ╔═╡ 04533b45-9fe1-4dbe-b169-c441abdb7875
test_X = mean(X_sample)

# ╔═╡ 6855cc0f-1397-479e-bb9b-fc1412b7e892
var_X = var(X_sample)

# ╔═╡ 49eb182b-4d2f-4028-8ac7-4a9f38dcac50
Y_sample = rand(Y, n₂)

# ╔═╡ 241231d7-20db-4c1a-833f-45e34ee9780e
test_Y = mean(Y_sample)

# ╔═╡ 3ec50b4d-cd82-49f1-9d63-0ce92bcef964
var_Y = var(Y_sample)

# ╔═╡ d1cc0f41-bfa3-4ee6-9b55-3925b1084284
Z = (test_X - test_Y) / sqrt(var_X / n₁ + var_Y / n₂)

# ╔═╡ df7376ff-79b8-4248-b795-dfc90d72dd2f
begin
	local Box_UUID = "box-" * string(uuid1())
	local svg_UUID = Box_UUID * "-svg"

	local y_min = min(minimum(X_sample), minimum(Y_sample))
	local y_max = max(maximum(X_sample), maximum(Y_sample))

	@htl("""
		<div id=$(Box_UUID)>
			<svg id=$(svg_UUID) width="500" height="400" viewBox="0 0 500 400" style="max-width: 100%; height: auto; background-color: white;"></svg>
		</div>

		<script src="https://d3js.org/d3.v7.min.js"></script>
		<script>
			const width = 500;
			const height = 400;
			const marginTop = 10;
			const marginRight = 10;
			const marginBottom = 30;
			const marginLeft = 25;
			const boxWidth = (width - marginLeft - marginRight) / 2;

			const y_min = $(y_min);
			const y_max = $(y_max);

			let svg = d3.select('#' + $(svg_UUID));
			svg.selectAll("*").remove();
			svg.attr("width", width)
			   .attr("height", height)
			   .attr("viewBox", [0, 0, width, height])
			   .attr("style", "max-width: 100%; height: auto; background-color: white;");

			const yDomain = [ y_min, y_max ];

			let y = d3.scaleLinear()
				.domain(yDomain)
				.range([height - marginBottom, marginTop]);

			let datas = [$(X_sample), $(Y_sample)];
			let colors = ["lightskyblue", "lightcoral"];

			for (let i = 0; i < 2; i++) {
				let data = datas[i].sort(d3.ascending);

				const q1 = d3.quantile(data, 0.25);
				const median = d3.quantile(data, 0.5);
				const q3 = d3.quantile(data, 0.75);
				const iqr = q3 - q1;
				const min = Math.max(d3.min(data), q1 - 1.5 * iqr);
				const max = Math.min(d3.max(data), q3 + 1.5 * iqr);

				let xPos = marginLeft + i * boxWidth;

				svg.append("rect")
					.attr("x", xPos + boxWidth * 0.25)
					.attr("width", boxWidth * 0.5)
					.attr("y", y(q3))
					.attr("height", y(q1) - y(q3))
					.attr("fill", colors[i])
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", xPos + boxWidth * 0.25)
					.attr("x2", xPos + boxWidth * 0.75)
					.attr("y1", y(median))
					.attr("y2", y(median))
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", xPos + boxWidth * 0.5)
					.attr("x2", xPos + boxWidth * 0.5)
					.attr("y1", y(min))
					.attr("y2", y(q1))
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", xPos + boxWidth * 0.5)
					.attr("x2", xPos + boxWidth * 0.5)
					.attr("y1", y(max))
					.attr("y2", y(q3))
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", xPos + boxWidth * 0.4)
					.attr("x2", xPos + boxWidth * 0.6)
					.attr("y1", y(min))
					.attr("y2", y(min))
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", xPos + boxWidth * 0.4)
					.attr("x2", xPos + boxWidth * 0.6)
					.attr("y1", y(max))
					.attr("y2", y(max))
					.attr("stroke", "black");
			}

			svg.append("g")
				.attr("transform", "translate(" + marginLeft + ",0)")
				.call(d3.axisLeft(y).ticks(height / 40));
		</script>
	""")
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
Distributions = "~0.25.113"
HypertextLiteral = "~0.9.5"
PlutoTeachingTools = "~0.3.1"
PlutoUI = "~0.7.60"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "79b541b448d2cf848b613749d1219b893fc7676d"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

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
version = "1.11.0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "3101c32aab536e7a27b1763c0797dba151b899ad"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.113"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"
    DistributionsTestExt = "Test"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"
    Test = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

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
version = "1.11.0"

[[deps.FillArrays]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "6a70198746448456524cb442b8af316927ff3e1a"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.13.0"
weakdeps = ["PDMats", "SparseArrays", "Statistics"]

    [deps.FillArrays.extensions]
    FillArraysPDMatsExt = "PDMats"
    FillArraysSparseArraysExt = "SparseArrays"
    FillArraysStatisticsExt = "Statistics"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "7c4195be1649ae622304031ed46a2f4df989f1eb"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.24"

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
version = "1.11.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "be3dc50a92e5a386872a493a10050136d4703f9b"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.6.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "2984284a8abcfcc4784d95a9e2ea4e352dd8ede7"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.36"

[[deps.LaTeXStrings]]
git-tree-sha1 = "dda21b8cbd6a6c40d9d02a73230f9d70fed6918c"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.4.0"

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
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

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
version = "1.11.0"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "260dc274c1bc2cb839e758588c63d9c8b5e639d1"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.0.5"

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
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "949347156c25054de2db3b166c52ac4728cbad65"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.31"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

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
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoLinks", "PlutoUI"]
git-tree-sha1 = "8252b5de1f81dc103eb0293523ddf917695adea1"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.3.1"

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
version = "1.11.0"

[[deps.PtrArrays]]
git-tree-sha1 = "77a42d78b6a92df47ab37e177b2deac405e1c88f"
uuid = "43287f4e-b6f4-7ad1-bb20-aadabca52c3d"
version = "1.2.1"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "cda3b045cf9ef07a08ad46731f5a3165e56cf3da"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.11.1"

    [deps.QuadGK.extensions]
    QuadGKEnzymeExt = "Enzyme"

    [deps.QuadGK.weakdeps]
    Enzyme = "7da242da-08ed-463a-9acd-ee780be4f1d9"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

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
git-tree-sha1 = "7f4228017b83c66bd6aa4fddeb170ce487e53bc7"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.6.2"

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "852bd0f55565a9e973fcfee83a84413270224dc4"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.8.0"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "58cdd8fb2201a6267e1db87ff148dd6c1dbd8ad8"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.5.1+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.11.0"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "2f5d4697f21388cbe1ff299430dd169ef97d7e14"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.4.0"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"
weakdeps = ["SparseArrays"]

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

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

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "b423576adc27097764a90e163157bcfc9acf0f46"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.2"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "7.7.0+0"

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
version = "1.11.0"

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
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─022ce81e-3229-49c7-b821-44df7cdee98d
# ╟─9553dd0f-7675-46ed-a018-505af6e943d9
# ╟─de380171-4790-4d4e-a915-e6ab74956d65
# ╟─61d992ce-c56e-46bc-b8ec-fb9a44f296c1
# ╠═03f0893c-1b15-4bd2-8d75-9480f16facf6
# ╟─6338fa4f-f380-457c-bd94-a4ae02d13b81
# ╟─bd8291ae-4cfb-4e0f-a4b2-acfbbb0bb02d
# ╟─876fde63-3649-4ef1-bcc8-b7a6c63b3dea
# ╠═5f42a94a-b8d7-4225-9db7-272468cd52c1
# ╟─721d8d87-ad56-4ad2-988a-f2e4b17de066
# ╟─fdfdaeac-cae2-48ab-b174-6b0541b7408a
# ╟─e0d422b3-863d-4079-8dc3-268f9b03936d
# ╠═7d2b521b-b525-4012-87c4-9b33786c0785
# ╟─655340bf-4ff0-46bc-b5b8-57492d33834a
# ╟─bb93b1e9-949a-427d-96fd-c370891f6cc2
# ╟─050e7145-f208-43df-b5e1-d230648d93a1
# ╟─c8ae07c7-e04f-496c-8785-739e05a434d2
# ╠═e43d728d-3d43-4607-beb8-a94b7fae695d
# ╟─30b8583a-df32-46e0-88a2-38abb1c0b862
# ╟─d62adda9-3979-4596-8798-da9e64e567c5
# ╟─8251c132-ef35-4b79-a252-fe8dcf3aa1ed
# ╟─af9ddb60-89cf-413f-bae7-117b603b141e
# ╟─c257b7ea-9eae-4a27-add9-df33646bae56
# ╟─459a0ec9-d8a8-4ba7-ac4f-7b9f7dd5b83b
# ╟─a21d67ad-ac04-4e08-a8c9-37806332c7df
# ╟─440a3ca0-561c-473b-8c59-8fab07089304
# ╠═d7867bf9-3f0b-4cca-8d66-90e1146cd2c3
# ╠═04533b45-9fe1-4dbe-b169-c441abdb7875
# ╠═6855cc0f-1397-479e-bb9b-fc1412b7e892
# ╠═49eb182b-4d2f-4028-8ac7-4a9f38dcac50
# ╠═241231d7-20db-4c1a-833f-45e34ee9780e
# ╠═3ec50b4d-cd82-49f1-9d63-0ce92bcef964
# ╟─df7376ff-79b8-4248-b795-dfc90d72dd2f
# ╟─ca95e043-9d99-4513-a788-18f7a8ae6fcc
# ╟─c1b35794-a2f6-4145-803b-ee84fd6e9642
# ╟─1060d266-21e7-426b-837b-ea08e879c551
# ╠═865844f0-3d5a-4f56-9f3c-3583e18d29d6
# ╟─d0a871e6-983b-4f3e-b2f1-40e7b2551348
# ╠═d1cc0f41-bfa3-4ee6-9b55-3925b1084284
# ╟─9c1beb57-f847-4b54-a73c-4e405da854fd
# ╟─edc55ed6-bab4-44a0-8ff7-ecf65b08fca6
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
