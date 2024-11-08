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

# ╔═╡ b7bc8daf-8301-4275-b96b-9c8838a42f41
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools, CommonMark
end

# ╔═╡ 1a5c2227-e659-4a81-aff4-86e853a3dfea
using Distributions

# ╔═╡ 1c5a950a-8e0f-49a2-89a7-0253d4edfe6b
@htl("""
	<head>
		<script src="https://d3js.org/d3.v7.min.js"></script>
	</head>
	<h1>Julia Day 9</h1>
""")

# ╔═╡ 79588726-7038-49b0-ae15-8b6eedeab18b
TableOfContents()

# ╔═╡ 50634bd7-0569-4ce0-9d2c-c2482c1c6583
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ fd359561-c7b9-46e0-9390-af84b017407c
@htl("""
	<hr>
""")

# ╔═╡ 03b8ae8a-0a58-44b9-a103-2ad07abd2379
@htl("""
	<h2>Distribution–Free Confidence Intervals</h2>
""")

# ╔═╡ 111d00d9-f4ea-4e09-90a9-baff0e00a863
@bindname n Slider(range(1, 100, step=1), show_value=true, default=10)

# ╔═╡ e054bab2-96dd-4203-b3ab-fdfcf53f42ef
@bindname p Slider(range(0.01, 0.99, step=0.01), show_value=true, default=0.5)

# ╔═╡ f6fff796-4432-443b-bb4b-0b0b521ff4dd
@bindname i Slider(1:round(Int64, (n+1)*p, RoundDown), show_value=true, default=round(Int64, (n+1)*p, RoundDown))

# ╔═╡ edb0eac8-f204-4cc7-9244-dac0d8070cb5
@bindname j Slider(round(Int64, (n+1)*p, RoundUp):n, show_value=true, default=round(Int64, (n+1)*p, RoundUp))

# ╔═╡ 015c7320-62fc-413f-9f17-60adec3ca6d0
Prob = sum([pdf(Binomial(n,p), k) for k in i:j-1])

# ╔═╡ 367806eb-be1e-4df3-87c9-e1016ecbf217
begin
	X = Chisq(10)
	α_slider = @bindname α Slider(range(0.01, 1, step=0.01), show_value=true, default=0.05)
end;

# ╔═╡ d1c0e856-540d-4741-a9bc-6208598c43d2
sample = rand(X, n)

# ╔═╡ e0c49167-3eac-4fed-860e-429539d45f70
order_statistics = sort(sample)

# ╔═╡ 44cba621-9c5c-4fea-b3cd-0a45913ed7b5
Confidence_Interval = ( order_statistics[i], order_statistics[j] )

# ╔═╡ b577d70e-798f-4238-9e0d-7d22e6040a0e
sample_percentile = quantile(sample, p)

# ╔═╡ 220d5ece-ff94-47b0-bc46-6abc2b82bc3e
actual_percentile = quantile(X, p)

# ╔═╡ 8fd2ee9e-0ac3-4838-b061-c1c1b6d08fa3
order_statistics[i] < actual_percentile < order_statistics[j]

# ╔═╡ da903ad1-d1bb-4ea2-a6a3-fa3205f6cfdc
α_slider

# ╔═╡ d6946ede-b369-4c61-baa6-e270581dd07a
1-α

# ╔═╡ 9135a0ce-9d7d-4746-a8ca-2ec869ba08d0
@htl("""
	<hr>
""")

# ╔═╡ 2a88eb72-d67d-4bfd-ad68-afb1d6fda74e
@htl("""
	<h2>Distribution–Free Hypothesis Tests</h2>
""")

# ╔═╡ 6866cd69-6147-42bb-b903-922ad2ce122e
order_statistics[i] < sample_percentile < order_statistics[j]

# ╔═╡ 8fe3ca79-1c16-44c1-8244-83af66519f07
@htl("""
	<hr>
""")

# ╔═╡ 6ef27e5c-9123-48c6-a62a-55e8a131a8e3
@htl("""
	<h2>Hypothesis Tests and Confidence Intervals</h2>
""")

# ╔═╡ b69839d2-d439-4e2d-830c-0e06415e9c25
@htl("""
	<hr>
""")

# ╔═╡ 14c8f1ab-9c7f-4fc2-8210-c2c82b4bd2a1
#Some Helper Functions for LaTeX
begin
	commonmark_parser = CommonMark.Parser()
	enable!(commonmark_parser, MathRule())
	macro LC(str, latex_UUID)
		return @htl("""
					<div id=$(latex_UUID) class="LaTeXContainer" style="display:inline;">$(commonmark_parser(str))</div>
					""")
	end
	
	function mdInlineLaTeX()
		return @htl("""
					<script>
						const container = document.querySelector('.LaTeXContainer');
						
						const style = document.createElement('style');
						style.textContent = `
							.LaTeXContainer p {
								display: inline;
								margin: auto;
							}
							.LaTeXContainer ul {
								margin: auto;
							}
						`;
						
						container.appendChild(style);
					</script>
				""")
	end

	function mdInlineLaTeXUUID(text_color, latex_UUID)
		return @htl("""
					<script>
						const container = document.getElementById($(latex_UUID));
						container.style.color = $(text_color);
						
						const style = document.createElement('style');
						style.textContent = `
							.LaTeXContainer div.markdown p > span.tex {
								display:inline;
							}
	
							.LaTeXContainer div.markdown p {
								display:inline;
							}
							
							.LaTeXContainer div.markdown {
								display:inline;
							}
						`;
						
						container.appendChild(style);
					</script>
				""")
	end
	
	function lhtl(str; text_color="white", latex_UUID="")
		if latex_UUID != ""
			return eval(:(@htl("""$(@htl($(str))) $(mdInlineLaTeXUUID($(text_color), $(latex_UUID)))""")))
		else
			return eval(:(@htl("""$(@htl($(str))) $(mdInlineLaTeX())""")))
		end
	end

	function lmd(str; text_color="white")
		local latex_UUID = "latex-"*string(uuid1())
		return lhtl("""$(eval(:(@LC($(str), $(latex_UUID)))))""", text_color=text_color, latex_UUID=latex_UUID)
	end
end;

# ╔═╡ 8f0d9ea9-2101-4ea6-93ca-9d8452eb9556
#Some Helper Structures for Info Boxes
begin
	@kwdef struct InfoBox
	    outer_box_hue::Float64 = 215.0
		outer_box_saturation::Float64 = 50.0
		outer_box_lightness::Float64 = 50.0
		outer_box_alpha::Float64 = 1.0
		inner_box_hue::Float64 = 215.0
		inner_box_saturation::Float64 = 50.0
		inner_box_lightness::Float64 = 25.0
		inner_box_alpha::Float64 = 1.0
	    title_text::Union{Nothing, String} = nothing
	    title_size::Int = 3
	    html_title::Union{Nothing, HypertextLiteral.Result} = nothing
		body_text::Union{Nothing, String} = nothing
	    html_body::Union{Nothing, HypertextLiteral.Result} = nothing
	end
	
	function render_infobox(box::InfoBox)
	    local title_html = nothing
	    if box.html_title !== nothing
	        title_html = box.html_title
	    elseif box.title_text !== nothing
	        local title_size = box.title_size !== nothing ? box.title_size : 3
	        title_html = @htl("<$("h"*string(title_size)) style='color: white; margin-left: 10px; margin-top: 10px;'>$(box.title_text)</$("h"*string(title_size))>")
	    end

		local body_html = nothing
	    if box.html_body !== nothing
	        body_html = box.html_body
	    elseif box.body_text !== nothing
	        body_html = @htl("<h6 style='color: white;'>$(lmd(box.body_text))</h6>")
	    end
	
	    local exterior_color = "hsla($(box.outer_box_hue), $(box.outer_box_saturation)%, $(box.outer_box_lightness)%, $(box.outer_box_alpha))"
	    local interior_color = "hsla($(box.inner_box_hue), $(box.inner_box_saturation)%, $(box.inner_box_lightness)%, $(box.inner_box_alpha))"
	
	    return lhtl("""
	    <div style="margin: 0 auto; background-color: $(exterior_color); padding: 5px; border-radius: 10px; width: 80%;">
	        $(title_html !== nothing ? title_html : "")
	        <div style="background-color: $(interior_color); color: white; padding: 10px; border-radius: 5px;">
	            $(body_html)
	        </div>
	    </div>
	    """)
	end

	function note_box(title_text::String, body_text::String)
		return render_infobox(InfoBox(title_text=title_text, body_text=body_text))
	end
	
	function go_box(title_text::String, body_text::String)
		return render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, title_text=title_text, body_text=body_text))
	end

	function caution_box(title_text::String, body_text::String)
		return render_infobox(InfoBox(outer_box_hue=55.5, outer_box_saturation=64, outer_box_lightness=62.9, inner_box_hue=54.2, inner_box_saturation=47.7, inner_box_lightness=25.5, title_text=title_text, body_text=body_text))
	end

	function stop_box(title_text::String, body_text::String)
		return render_infobox(InfoBox(outer_box_hue=7.3, outer_box_saturation=100, outer_box_lightness=69.2, inner_box_hue=7.9, inner_box_saturation=43.9, inner_box_lightness=27.3, title_text=title_text, body_text=body_text))
	end

	function note_box(text::String)
		return render_infobox(InfoBox(body_text=text))
	end
	
	function go_box(text::String)
		return render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, body_text=text))
	end

	function caution_box(text::String)
		return render_infobox(InfoBox(outer_box_hue=55.5, outer_box_saturation=64, outer_box_lightness=62.9, inner_box_hue=54.2, inner_box_saturation=47.7, inner_box_lightness=25.5, body_text=text))
	end

	function stop_box(text::String)
		return render_infobox(InfoBox(outer_box_hue=7.3, outer_box_saturation=100, outer_box_lightness=69.2, inner_box_hue=7.9, inner_box_saturation=43.9, inner_box_lightness=27.3, body_text=text))
	end
end;

# ╔═╡ 9690612c-d6ec-4f1d-ad59-54df41159765
note_box("In order to form a confidence interval using the Central Limit Theorem, we had a few assumptions. Especially that the number of samples ``n`` was \"big enough\". Depending on how heavily skewed the population distribution is, ``n \\geq 30`` is a bare minimum in practice.  
Some things that we may ask:
* Can we get around these systematically in general?
* Can we find other statistical measures than just the mean?
* Does the Central Limit Theorem give the best confidence?
")

# ╔═╡ b2a25a20-5f71-44bd-a028-8c7b760ea6c3
note_box("For a random sample from some continuous distribution ``X``, we can form the **order statistics** meaning the sorted version of the sample:")

# ╔═╡ bbb7e9ee-4254-416a-b9e6-a3499a2aee11
note_box("A big idea about these statistics was that the sample percentiles ``\\tilde{\\pi}_p`` should be *\"close\"* to the population percentiles ``\\pi_p``. How close is *\"close\"*?")

# ╔═╡ 64c63774-d0e0-4609-b041-755776f75067
note_box("This is a job for confidence intervals!  
As a reminder, the ``p``–th percentile ``\\pi_p`` is the measurement of ``X`` that is larger than ``100p\\%`` of the total population measurements. So ``\\pi_{0.5}`` is the **median**, for example.  
For the sample measurements, this should mean that, of the ``n`` total measurements, about ``n \\cdot p`` of them will be less than ``\\pi_p``. In terms of the ordered version, this means we should expect the **first** ``n \\cdot p`` measurements to be less than this percentile. If we are a little bit more careful about this argument, we can say that the probabilities follow a **Binomial Distribution**.  
In particular:
```math
\\operatorname{Prob}\\left(Y_i \\leq \\pi_p &lt; Y_j \\right) \\approx \\sum_{i \\leq k &lt; j} f(k)
```
Where ``f(k) = \\binom{n}{k}p^k(1-p)^{n-k}`` is the probability mass function for the binomial distribution ``\\operatorname{Binomial}(n,p)``.  
If we find ``i &lt; (n+1)\\cdot p &lt; j`` so that this probability is approximately ``1-\\alpha``, then this will be approximately a ``100(1-\\alpha)\\%`` confidence interval for the percentile ``\\pi_p``.")

# ╔═╡ 308b10b3-74a7-4646-bb56-f0a153fed070
note_box("In the same situation as the above confidence interval, we could form the hypotheses:  
* ``H_0 : m = m_0``
* ``H_1 : m \\neq m_0``  

Where ``m`` is the median and ``m_0`` is some guess. If we take a sample and form a ``100(1-\\alpha)\\%`` confidence interval from above via the order statistics, we can **REJECT** the null hypothesis if ``m_0`` is **not** in this interval and **NOT REJECT** if it is. Similarly for any other percentile.")

# ╔═╡ ee5527d8-c9d9-4fa1-961e-60e88c0f34e6
note_box("For example, if our hypotheseses are:  
* ``H_0 : \\pi_p = \\tilde{\\pi}_p``
* ``H_1 : \\pi_p \\neq \\tilde{\\pi}_p``  

For the actual and sample percentiles, we have:")

# ╔═╡ 9d962950-2629-47fd-9b64-4dce0f1595ef
note_box("If this is **true**, we do not reject the null hypothesis and assume any difference between the actual and sample values are just due to random variation. If this were real life data collection, we wouldn't have the actual percentiles, making this sample statistic our *\"best guess\"* on where the population is. Otherwise, if it is **false** we reject and say that these are substantially different.")

# ╔═╡ e9bfbf0e-3006-4405-b366-1d35d042ed63
note_box("As was noted in the last section, Confidence Intervals and Hypothesis Tests are intimately related to one another. In order to see this, let:  
* ``X`` — be a population distribution
* ``a \\leq X \\leq b`` — be a ``100(1-\\alpha)\\%`` confidence interval for some statistical measure ``\\tau`` (this could be the mean, a proportion, a percentile, skewness, etc.)")

# ╔═╡ 41c8ba15-46e2-473f-95a0-ce9b7cd63c86
go_box("How could you construct a hypothesis test with **significance level** of ``\\alpha`` using this confidence interval? That is, the likelihood of a **Type I** error is ``100\\alpha\\%``.")

# ╔═╡ 0d08d41d-c208-4b39-b93e-df8754e63d20
note_box("In the other direction, suppose you have a hypothesis test for ``\\tau`` with significance level ``\\alpha``. More in particular:  
* ``H_0 : \\tau = \\tau_0``
* ``H_1 : \\tau \\neq \\tau_0``

After taking a test sample, we choose reject the null hypothesis if the absolute deviation ``| \\tau - \\tau_0 |`` is bigger than some fixed difference ``T``. The likelihood that the test is further away than a distance of ``T`` from ``\\tau_0`` is ``\\alpha`` by definition of the **significance level**.")

# ╔═╡ 984e4dcb-bf38-49a9-8edf-fc33314120aa
go_box("How could you construct a confidence interval with **confidence** of ``100(1-\\alpha)\\%`` using this hypothesis test? That is, the likelihood of the population statistic being within this interval is ``100(1-\\alpha)\\%``.")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
CommonMark = "~0.8.15"
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
project_hash = "4513929e0c73fce4a257b91df3d32b352e4ef222"

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

[[deps.CommonMark]]
deps = ["Crayons", "PrecompileTools"]
git-tree-sha1 = "3faae67b8899797592335832fccf4b3c80bb04fa"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.15"

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

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

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
# ╟─b7bc8daf-8301-4275-b96b-9c8838a42f41
# ╟─1c5a950a-8e0f-49a2-89a7-0253d4edfe6b
# ╟─79588726-7038-49b0-ae15-8b6eedeab18b
# ╟─50634bd7-0569-4ce0-9d2c-c2482c1c6583
# ╠═1a5c2227-e659-4a81-aff4-86e853a3dfea
# ╟─fd359561-c7b9-46e0-9390-af84b017407c
# ╟─03b8ae8a-0a58-44b9-a103-2ad07abd2379
# ╟─9690612c-d6ec-4f1d-ad59-54df41159765
# ╟─b2a25a20-5f71-44bd-a028-8c7b760ea6c3
# ╟─111d00d9-f4ea-4e09-90a9-baff0e00a863
# ╠═d1c0e856-540d-4741-a9bc-6208598c43d2
# ╠═e0c49167-3eac-4fed-860e-429539d45f70
# ╟─bbb7e9ee-4254-416a-b9e6-a3499a2aee11
# ╟─e054bab2-96dd-4203-b3ab-fdfcf53f42ef
# ╠═b577d70e-798f-4238-9e0d-7d22e6040a0e
# ╠═220d5ece-ff94-47b0-bc46-6abc2b82bc3e
# ╟─64c63774-d0e0-4609-b041-755776f75067
# ╟─da903ad1-d1bb-4ea2-a6a3-fa3205f6cfdc
# ╠═d6946ede-b369-4c61-baa6-e270581dd07a
# ╟─f6fff796-4432-443b-bb4b-0b0b521ff4dd
# ╟─edb0eac8-f204-4cc7-9244-dac0d8070cb5
# ╠═015c7320-62fc-413f-9f17-60adec3ca6d0
# ╠═44cba621-9c5c-4fea-b3cd-0a45913ed7b5
# ╠═8fd2ee9e-0ac3-4838-b061-c1c1b6d08fa3
# ╟─367806eb-be1e-4df3-87c9-e1016ecbf217
# ╟─9135a0ce-9d7d-4746-a8ca-2ec869ba08d0
# ╟─2a88eb72-d67d-4bfd-ad68-afb1d6fda74e
# ╟─308b10b3-74a7-4646-bb56-f0a153fed070
# ╟─ee5527d8-c9d9-4fa1-961e-60e88c0f34e6
# ╠═6866cd69-6147-42bb-b903-922ad2ce122e
# ╟─9d962950-2629-47fd-9b64-4dce0f1595ef
# ╟─8fe3ca79-1c16-44c1-8244-83af66519f07
# ╟─6ef27e5c-9123-48c6-a62a-55e8a131a8e3
# ╟─e9bfbf0e-3006-4405-b366-1d35d042ed63
# ╟─41c8ba15-46e2-473f-95a0-ce9b7cd63c86
# ╟─0d08d41d-c208-4b39-b93e-df8754e63d20
# ╟─984e4dcb-bf38-49a9-8edf-fc33314120aa
# ╟─b69839d2-d439-4e2d-830c-0e06415e9c25
# ╟─8f0d9ea9-2101-4ea6-93ca-9d8452eb9556
# ╟─14c8f1ab-9c7f-4fc2-8210-c2c82b4bd2a1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
