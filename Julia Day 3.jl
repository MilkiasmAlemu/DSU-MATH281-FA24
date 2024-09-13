### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 3bfca640-7115-11ef-2aa3-2b863ea52cc6
#Packages for Formatting
begin
	using HypertextLiteral, PlutoUI, PlutoTeachingTools
end

# ╔═╡ 014c1045-34bf-4503-9fa1-f1fc60e13aa1
using Random

# ╔═╡ 065af227-f920-40cf-8c59-e2e2d8e45d03
@htl("""
	<h1>Random Variable Lab</h1>
""")

# ╔═╡ 3b49d2d5-7470-49a5-b777-6659f7d50e70
TableOfContents()

# ╔═╡ 0865f9e8-533c-47bd-999c-cdb4647d3bb8
@htl("""
<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ b1f2f1a9-f62d-4042-8122-4abdbebe6c3a
@htl("""
	<hr>
""")

# ╔═╡ ee7417f2-900f-4b49-945a-d20eca2a19f4
@htl("""
	<h2>Properties of Expected Values</h2>
""")

# ╔═╡ 945e88df-508e-454b-b8fa-590a318bc953
aside("This says we want (up to) 10 random numbers between 1 and 25 and are getting rid of any extra copies so that they are unique numbers",v_offset=10)

# ╔═╡ bd5cd07c-cd61-4f65-89f4-9c34851ff5fb
X = unique(rand(1:25, 10))

# ╔═╡ f10e049c-06b1-4a2f-a78e-f754aff57b0a
aside("Here we are saying how many outcomes from our sample space hit each of these labels",v_offset=30)

# ╔═╡ 1d8c2b73-63dd-483a-9b93-793d7700a64c
Frequencies = [rand(1:10) for x in X]

# ╔═╡ 57a406ba-37e6-4c24-808d-9322543cd578
aside("This is dividing the frequencies by the total number of elements in our sample space",v_offset=30)

# ╔═╡ a0e3d3c8-778f-495a-b263-7dff65ca7a6b
Prob = Frequencies / sum(Frequencies)

# ╔═╡ 64361f31-982c-4d7a-94fd-3a44dd83725c
f_1(X) = 10

# ╔═╡ 3e5f0f5a-3789-4fbe-af29-0ce59889e291
sum([f_1(X[i]) * Prob[i] for i in 1:length(X)])

# ╔═╡ 463bd3e8-bbfc-49db-acc7-7be2dd811c5d
@htl("""
<hr>
""")

# ╔═╡ 4ca68b00-a6db-45e4-812b-fa358294df65
f_2(X) = X^2

# ╔═╡ 83b3f718-f10d-4879-a40b-39ad6953d557
f_3(X) = 1 - 50 * X

# ╔═╡ b590c390-35e1-41f2-a1dd-39c4a771ea94
ExpectedValueoff2 = sum([f_2(X[i]) * Prob[i] for i in 1:length(X)])

# ╔═╡ f24d77ee-896d-4fb6-a10b-900f4b8593f5
ExpectedValueoff3 = sum([f_3(X[i]) * Prob[i] for i in 1:length(X)])

# ╔═╡ 19517af9-99bc-47a7-9903-4fbfc2bf4526
ExpectedValueofSum = sum([(f_2(X[i]) + f_3(X[i])) * Prob[i] for i in 1:length(X)])

# ╔═╡ 5ec1fdc1-e78c-44ca-9a17-d4c9200ec5c6
SumofExpectedValues = ExpectedValueoff2 + ExpectedValueoff3

# ╔═╡ e3cdec79-60ec-4cbf-ac46-0c1b110f028b
@htl("""
	<hr>
""")

# ╔═╡ 35f8c98f-a0b1-45aa-b7ae-102db47a69af
ExpectedValueofProduct = sum([(f_2(X[i]) * f_3(X[i])) * Prob[i] for i in 1:length(X)])

# ╔═╡ 1e7ecc07-0499-4970-959b-8c63c4b8a293
ProductofExpectedValues = ExpectedValueoff2 * ExpectedValueoff3

# ╔═╡ 492b87ae-5770-462e-a307-09d4c6571071
@htl("""
	<hr>
""")

# ╔═╡ 2dc39b68-7d17-4838-80e4-6ce5b49d5b24
@htl("""
	<hr>
""")

# ╔═╡ fb5768dc-d16d-4416-9ef6-260f2571278a
@htl("""
	<hr>
""")

# ╔═╡ 8a6c0bd4-02c4-4d7f-b382-f6fe2fe75d76
@htl("""
	<h2>Infinite Labels</h2>
""")

# ╔═╡ 302b4faf-092b-4c15-98d1-1c30f8ccad86
@htl("""
	<h4> Power: i = $(@bind i Slider(0:7, default=0, show_value=true))</h6>
""")

# ╔═╡ 67687858-6951-463b-9845-65f7345e51dd
@htl("""
	<h4> Number of Labels: N = $(@bind N Slider(1:100, default=1, show_value=true))</h6>
""")

# ╔═╡ a4509a08-9b5a-4a78-b8a3-6737d9f9bd43
ProbPower(n) = (1/2)^n

# ╔═╡ cf2fd5f0-a6cf-4d72-b74d-7d079ee64ade
fi(x) = x^i

# ╔═╡ ec066aed-5725-478b-b38b-1b1cd135509d
sum([fi(n) * ProbPower(n) for n in 1:N])

# ╔═╡ caada24d-c98d-4998-990b-d56198a93189
#Some Helper Functions for LaTeX
begin
	macro LC(str)
		return @htl("""
					<div class="LaTeXContainer" style="display:inline;">$(Markdown.parse(str))</div>
					""")
	end
	
	function mdInlineLaTeX()
		return @htl("""
					<script>
						const container = document.querySelector('.LaTeXContainer');
						
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
	
	function lhtl(str)
		return eval(:(@htl("""$(@htl($(str))) $(mdInlineLaTeX())""")))
	end

	function lmd(str)
		return lhtl("""$(eval(:(@LC($(str)))))""")
	end
end;

# ╔═╡ 5075af1b-f0d2-45e3-957a-438fe515fdc1
#Some Helper Function for Info Boxes
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
	    title_html = nothing
	    if box.html_title !== nothing
	        title_html = box.html_title
	    elseif box.title_text !== nothing
	        title_size = box.title_size !== nothing ? box.title_size : 3
	        title_html = @htl("<$("h"*string(title_size)) style='color: white; margin-left: 10px; margin-top: 10px;'>$(box.title_text)</$("h"*string(title_size))>")
	    end

		body_html = nothing
	    if box.html_body !== nothing
	        body_html = box.html_body
	    elseif box.body_text !== nothing
	        body_html = @htl("<h6 style='color: white;'>$(lmd(box.body_text))</h6>")
	    end
	
	    exterior_color = "hsla($(box.outer_box_hue), $(box.outer_box_saturation)%, $(box.outer_box_lightness)%, $(box.outer_box_alpha))"
	    interior_color = "hsla($(box.inner_box_hue), $(box.inner_box_saturation)%, $(box.inner_box_lightness)%, $(box.inner_box_alpha))"
	
	    lhtl("""
	    <div style="margin: 0 auto; background-color: $(exterior_color); padding: 5px; border-radius: 10px; width: 80%;">
	        $(title_html !== nothing ? title_html : "")
	        <div style="background-color: $(interior_color); color: white; padding: 10px; border-radius: 5px;">
	            $(body_html)
	        </div>
	    </div>
	    """)
	end
end;

# ╔═╡ 10e44432-3eb6-4fd0-9b5e-460fdbe41862
render_infobox(InfoBox(outer_box_saturation=0, outer_box_lightness=25,inner_box_saturation=0, inner_box_lightness=20, body_text="The **Expected Value** of a function ``f(X)`` on the labels of a random variable is given by: \n```math\n\\text{E}[f(X)]=\\sum_{x}f(x)\\cdot\\operatorname{Prob}(X=x)\n```\n This is shorthand for adding up the values over all labels. If the labels are ``\\{x_1,x_2,\\ldots,x_n\\}``, then the expected value is:\n```math\nf(x_1)\\cdot\\operatorname{Prob}(X=x_1)+\\ldots+f(x_n)\\cdot\\operatorname{Prob}(X=x_n)\n```\n For each of the following situations, try to convince yourself why the expected values are given by their listed values. Examples are given by the arrays below which you can pretend came from some sample space."))

# ╔═╡ 46f3e311-8097-4ac7-871e-03b177d3a2b4
render_infobox(InfoBox(title_text="Expected Value of a Constant", body_text="Given a constant function, ``f_1(x) = c``, the expected value is constant: \n```math\n\\text{E}[f_1(X)]=c\n```"))

# ╔═╡ 6a1cbeec-937f-4704-b918-109620305f04
render_infobox(InfoBox(title_text="Expected Value of a Sum", body_text="Given two functions, ``f_2(x), f_3(x)``, the expected value is additive: \n```math\n\\text{E}[f_2(X)+f_3(X)]=\\text{E}[f_2(X)]+\\text{E}[f_3(X)]\n```"))

# ╔═╡ a1d0e167-8034-492f-8e66-a31fa0e9aa66
render_infobox(InfoBox(title_text="Expected Value of a Product", body_text="Given two functions, ``f_2(x), f_3(x)``, the expected value is **not** multiplicative: \n```math\n\\text{E}[f_2(X)\\cdot f_3(X)]\\neq\\text{E}[f_2(X)]\\cdot\\text{E}[f_3(X)]\n```"))

# ╔═╡ 3438012a-b862-400a-932c-2dd45eedb8f6
render_infobox(InfoBox(title_text="Another Expression for Expected Value", body_text="Given a random variable with labels ``1,2,3,4,\\ldots``, the expected value can be computed in two ways \n```math\n\\text{E}[X]=1\\cdot\\operatorname{Prob}(X=1)+2\\cdot\\operatorname{Prob}(X=2)+\\ldots\n```\n or in terms of the cumulative distribution function as \n```math\n\\text{E}[X]=\\operatorname{Prob}(X>1)+\\operatorname{Prob}(X>2)+\\operatorname{Prob}(X>3)+\\ldots\n```"))

# ╔═╡ 06f7b836-db5d-4445-8ecb-6ac46448b23d
render_infobox(InfoBox(title_text="Probability of a Group of Labels", body_text="Suppose we do not care about *all* labels, but only the labels of our random variable ``X`` which are part of some group of labels ``S``. What is the probability that if we run a sample once, we get a label which is in ``S``?\\

Write ``\\large\\mathbb{1}_S`` as the name of a function with ``\\large\\mathbb{1}_S(x) = 1`` if the label is in ``S`` and ``\\large\\mathbb{1}_S(x) = 0`` if the label is **not** in ``S``. This function is called the **indicator function** of ``S``, because it indicates whether or not the label ``x`` is in ``S``.\\

\n```math\n\\text{E}\\left[{\\large\\mathbb{1}_S}(X)\\right]=\\operatorname{Prob}(X\\text{ is in }S)\n```"))

# ╔═╡ 20ff0e54-761a-4fc9-a3fa-39517a9bc7dc
render_infobox(InfoBox(body_text="Consider an experiment where you are flipping a coin and stop flipping once you get a heads. Choose a random variable which is labeled by the number of flips that it took to get a heads. In this situation, the probability is given by:\\\n
```math\n
	\\operatorname{Prob}(X=n) = \\frac{1}{2^n}\n
```
Why is this true?\\
Something that we might want to consider is the expected value of power functions; that is, what is ``\\operatorname{E}\\left[X^k\\right]``?
"))

# ╔═╡ cde0d901-a8e9-4fdb-bfbc-f2448e67a7ac
render_infobox(InfoBox(html_body=@htl("""
<ul style="margin: 0;">
	<li><h6>What do you notice about the different expected values?</h6>
 	<li><h6>Do you find anything suprising about any of these values?</h6>
 	<li><h6>Do you find anything suprising about any of these values?</h6>
	<li><h6>What do these numbers mean in the context of flipping the coin?</h6>
 	<li><h6>Does it seem like $(lmd("``\\text{E}\\left[X^i\\right]``")) is growing faster or slower than $(lmd("``\\text{E}\\left[X\\right]^i``"))</h6>
</ul>
""")))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[compat]
HypertextLiteral = "~0.9.5"
PlutoTeachingTools = "~0.2.15"
PlutoUI = "~0.7.60"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "ee7dcd003fb0a6462d60527750a3910caef94026"

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

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

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

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

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
version = "5.11.0+0"

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
# ╟─3bfca640-7115-11ef-2aa3-2b863ea52cc6
# ╠═065af227-f920-40cf-8c59-e2e2d8e45d03
# ╟─3b49d2d5-7470-49a5-b777-6659f7d50e70
# ╟─0865f9e8-533c-47bd-999c-cdb4647d3bb8
# ╠═014c1045-34bf-4503-9fa1-f1fc60e13aa1
# ╟─b1f2f1a9-f62d-4042-8122-4abdbebe6c3a
# ╟─ee7417f2-900f-4b49-945a-d20eca2a19f4
# ╟─10e44432-3eb6-4fd0-9b5e-460fdbe41862
# ╟─945e88df-508e-454b-b8fa-590a318bc953
# ╠═bd5cd07c-cd61-4f65-89f4-9c34851ff5fb
# ╟─f10e049c-06b1-4a2f-a78e-f754aff57b0a
# ╠═1d8c2b73-63dd-483a-9b93-793d7700a64c
# ╟─57a406ba-37e6-4c24-808d-9322543cd578
# ╟─a0e3d3c8-778f-495a-b263-7dff65ca7a6b
# ╟─46f3e311-8097-4ac7-871e-03b177d3a2b4
# ╠═64361f31-982c-4d7a-94fd-3a44dd83725c
# ╠═3e5f0f5a-3789-4fbe-af29-0ce59889e291
# ╟─463bd3e8-bbfc-49db-acc7-7be2dd811c5d
# ╟─6a1cbeec-937f-4704-b918-109620305f04
# ╠═4ca68b00-a6db-45e4-812b-fa358294df65
# ╠═83b3f718-f10d-4879-a40b-39ad6953d557
# ╠═b590c390-35e1-41f2-a1dd-39c4a771ea94
# ╠═f24d77ee-896d-4fb6-a10b-900f4b8593f5
# ╠═19517af9-99bc-47a7-9903-4fbfc2bf4526
# ╠═5ec1fdc1-e78c-44ca-9a17-d4c9200ec5c6
# ╟─e3cdec79-60ec-4cbf-ac46-0c1b110f028b
# ╟─a1d0e167-8034-492f-8e66-a31fa0e9aa66
# ╠═35f8c98f-a0b1-45aa-b7ae-102db47a69af
# ╠═1e7ecc07-0499-4970-959b-8c63c4b8a293
# ╟─492b87ae-5770-462e-a307-09d4c6571071
# ╟─3438012a-b862-400a-932c-2dd45eedb8f6
# ╟─2dc39b68-7d17-4838-80e4-6ce5b49d5b24
# ╟─06f7b836-db5d-4445-8ecb-6ac46448b23d
# ╟─fb5768dc-d16d-4416-9ef6-260f2571278a
# ╟─8a6c0bd4-02c4-4d7f-b382-f6fe2fe75d76
# ╟─20ff0e54-761a-4fc9-a3fa-39517a9bc7dc
# ╟─302b4faf-092b-4c15-98d1-1c30f8ccad86
# ╟─67687858-6951-463b-9845-65f7345e51dd
# ╠═a4509a08-9b5a-4a78-b8a3-6737d9f9bd43
# ╠═cf2fd5f0-a6cf-4d72-b74d-7d079ee64ade
# ╠═ec066aed-5725-478b-b38b-1b1cd135509d
# ╟─cde0d901-a8e9-4fdb-bfbc-f2448e67a7ac
# ╟─5075af1b-f0d2-45e3-957a-438fe515fdc1
# ╟─caada24d-c98d-4998-990b-d56198a93189
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
