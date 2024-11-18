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

# ╔═╡ 2ab35109-643c-4469-9457-94b626ede323
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools, CommonMark
end

# ╔═╡ 61818a99-2cdb-4cef-9350-26bcaf805529
using Distributions, StatsBase

# ╔═╡ fdd64ea1-8d9e-44ba-8f2e-d4c37b203e07
@htl("""
	<h1>Lecture 22</h1>
""")

# ╔═╡ e3e75c29-4b6e-40cf-bf89-2f7caa993e80
TableOfContents()

# ╔═╡ 63ebfd68-1ee8-4fd8-ab84-6910378951b0
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ 72fec931-efe2-4b7e-9079-d1e12d07a8ec
@htl("""
	<hr>
""")

# ╔═╡ b7a4836b-a844-471a-a0dd-fa503fea377e
@htl("""
	<h2>Statistical Power <span style="font-size:150%">💪</span></h2>
""")

# ╔═╡ 5bc98420-9d91-48d7-a173-617ce118fe59
@htl("""
	<h3>Power for Proportions</h2>
""")

# ╔═╡ 9a77ccf7-7ae6-44a0-a9a0-ac0ba6700fcd
@bindname n Slider(1:50, show_value=true, default=20)

# ╔═╡ 536e2822-8b96-4157-9545-6b1d441e65e8
@htl("""
<h5>
	Sample Size: n = $(n)
</h5>
""")

# ╔═╡ 4a3f694e-e392-4f7d-a7dd-67fc27470c21
@htl("""
<hr>
""")

# ╔═╡ eba3279b-c68c-4f04-bc57-f3b74d11329b
@bindname max_Y Slider(0:n, show_value=true, default=6)

# ╔═╡ 2bbf8285-163c-4c44-b883-f2fd9d810b43
@htl("""
<hr>
""")

# ╔═╡ c73412c1-4ad3-405a-81be-8622742950d9
@htl("""
	<h5>Actual Probability:</h5>
	$(@bindname p₀ Slider(0:0.01:0.49, show_value=true, default=0.25))
""")

# ╔═╡ a6a7cc8e-dd12-4c85-8744-a106871dbaca
α = cdf( Binomial( 20, 0.5 ) , max_Y )

# ╔═╡ 5c324854-82a7-49fc-be8e-bfbd8740a3f2
β = ccdf( Binomial( 20, p₀ ), max_Y )

# ╔═╡ 3c273326-a220-44b2-861f-9380cedfb99b
@htl("""
<hr>
""")

# ╔═╡ 3347b2da-a71a-4c3b-8c5b-a94e545424b7
begin
	local plot_uuid = "Plot-"*string(uuid1())
	local probs = collect(range(0,0.5, step=0.001))
	local powers = (x -> cdf( Binomial( 20, x ), max_Y )).(probs)
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace1 = {
			  x: $(probs),
			  y: $(powers),
			  type: 'scatter',
			  name: ''
			};
	
			var trace2 = {
			  x: [$(p₀)],
			  y: [$(1-β)],
			  type: 'scatter',
			  name: ''
			};
			
			var data = [trace1, trace2];

			var layout = {

				title: 'Statistical Power',
	
				xaxis: {
		
					title: 'p₀',
					range: [0, 0.55]
		
	        	},
	
				yaxis: {
		
					title: 'power',
					range: [0, 1.01]
		
	        	},
			
			    showlegend: false,

				colorway: ['steelblue', 'cornflowerblue']

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ d2f37016-0c4f-42d8-ae82-89ac75b6df75
@htl("""
	<hr>
	<h3>Power for Means</h2>
""")

# ╔═╡ a528d8c2-77fa-42bf-b866-ee4312d8d562
@bindname m Slider(1:50, show_value=true, default=25)

# ╔═╡ a591a1ad-3fd0-4995-b5a4-5cfa037d700b
@htl("""
<h5>
	Sample Size: m = $(m)
</h5>
""")

# ╔═╡ 0b3ecae7-a7b8-45ee-98f5-4d45d268b6c6
@htl("""
<hr>
""")

# ╔═╡ 38719571-5593-4722-846d-ce1d47dd4704
@bindname C Slider(61:70, show_value=true, default=62)

# ╔═╡ 95beff4d-7c67-46bd-a392-e9d4b3b2ec45
@htl("""
<hr>
""")

# ╔═╡ 592be977-37b0-4969-a7bd-a68c699604f1
@htl("""
	<h5>Actual Mean:</h5>
	$(@bindname μ₀ Slider(range(60, 70, step=0.1), show_value=true, default=65))
""")

# ╔═╡ ce0e08d1-0eca-4f65-ba9e-e35717966f20
α_μ = ccdf( Normal( 60, 10 / sqrt(m) ), C )

# ╔═╡ 039b1d5a-a1a8-4c47-8dc5-f3a56edf7d86
β_μ = cdf( Normal( μ₀ , 10 / sqrt(m) ), C )

# ╔═╡ 64a62793-8d3b-4762-b1d8-e0393ec56274
@htl("""
<hr>
""")

# ╔═╡ b0536a2b-432a-4a78-a4a3-857c57d74957
begin
	local plot_uuid = "Plot-"*string(uuid1())
	local means = collect(60:0.001:70)
	local powers = (x -> ccdf( Normal( x, 10 / sqrt(m) ) , C )).(means)
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>
			var trace1 = {
			  x: $(means),
			  y: $(powers),
			  type: 'scatter',
			  name: ''
			};

			var trace2 = {
			  x: [$(μ₀)],
			  y: [$(1-β_μ)],
			  type: 'scatter',
			  name: ''
			};
			
			var data = [trace1, trace2];

			var layout = {

				title: 'Statistical Power',
	
				xaxis: {
		
					title: 'μ₀',
					range: [59, 70]
		
	        	},
	
				yaxis: {
		
					title: 'power',
					range: [0, 1.01]
		
	        	},
			
			    showlegend: false,

				colorway: ['steelblue', 'cornflowerblue']

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ 51edc66d-3f3d-4135-912d-658877b3040d
@htl("""
	<hr>
""")

# ╔═╡ 85b64fea-21d6-4c34-b8be-ddb7027269e8
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
	
	function lhtl(str; text_color="var(--pluto-output-h-color);", latex_UUID="")
		if latex_UUID != ""
			return eval(:(@htl("""$(@htl($(str))) $(mdInlineLaTeXUUID($(text_color), $(latex_UUID)))""")))
		else
			return eval(:(@htl("""$(@htl($(str))) $(mdInlineLaTeX())""")))
		end
	end

	function lmd(str; text_color="var(--pluto-output-h-color);")
		local latex_UUID = "latex-"*string(uuid1())
		return lhtl("""$(eval(:(@LC($(str), $(latex_UUID)))))""", text_color=text_color, latex_UUID=latex_UUID)
	end
end;

# ╔═╡ 19f23cb8-450b-487a-87ab-942185c1ec15
@htl("""
<h5>
	Null Hypothesis : $(lmd("``p = \\frac{1}{2}``"))
</h5>
<h5>
	Alternative Hypothesis : $(lmd("``p &lt; \\frac{1}{2}``"))
</h5>
<hr>
""")

# ╔═╡ 72cfa760-7ec9-46be-98ce-56de79fab884
@htl("""
<h5>
	Critical Region: Number of Rights $(lmd("``\\leq $(max_Y)``"))
</h5>
""")

# ╔═╡ ae790c2a-432b-4b44-87b5-3cfbc7b3a3c5
@htl("""
<h5>
	Probabilities:
	<br>
	$(lmd("``\\qquad\\alpha = \\operatorname{Prob}(Y \\leq $(max_Y) \\ | \\ p = \\frac{1}{2}) = $(round(α, digits=4))``"))
	<br>
	$(lmd("``\\qquad\\beta = \\operatorname{Prob}($(max_Y + 1) \\leq Y \\leq $(20) \\ | \\ p = p_0 &lt; \\frac{1}{2}) = $(round(β, digits=4))``"))
</h5>
""")

# ╔═╡ 32645967-5c4f-464c-8047-859663558d3b
@htl("""
<h5>
	Statistical Power:
	<br>
	$(lmd("``\\qquad1-\\beta = \\operatorname{Prob}(0 \\leq Y \\leq $(max_Y) \\ | \\ p = p_0 &lt; \\frac{1}{2}) = $(round(1-β, digits=4))``"))
</h5>
""")

# ╔═╡ 56efd9f3-eb12-40c2-92d7-603c7881e88c
@htl("""
<h5>
	Null Hypothesis : $(lmd("``\\mu = 60``"))
</h5>
<h5>
	Alternative Hypothesis : $(lmd("``\\mu > 60``"))
</h5>
<hr>
""")

# ╔═╡ 40fe8e16-b9d2-4397-98ea-4a9ebe74bfbf
@htl("""
<h5>
	Critical Region: $(lmd("``\\overline{X} \\geq $(C)``"))
</h5>
""")

# ╔═╡ c5eb1335-6744-4345-b955-3e47b4660b8d
@htl("""
<h5>
	Probabilities:
	<br>
	$(lmd("``\\qquad\\alpha = \\operatorname{Prob}(\\overline{X} \\geq $(C) \\ | \\ \\mu = 60) = $(round(α_μ, digits=4))``"))
	<br>
	$(lmd("``\\qquad\\beta = \\operatorname{Prob}( \\overline{X} &lt; $(C) \\ | \\ \\mu = \\mu_0 > 60) = $(round(β_μ, digits=4))``"))
</h5>
""")

# ╔═╡ c7f13f9e-38c5-4469-8554-a8d3ab0af895
@htl("""
<h5>
	Statistical Power:
	<br>
	$(lmd("``\\qquad1-\\beta = \\operatorname{Prob}( \\overline{X} \\geq $(C) \\ | \\ \\mu = \\mu_0 > 60) = $(round(1-β_μ, digits=4))``"))
</h5>
""")

# ╔═╡ cbaa3088-45ab-48d3-be21-5873117b629d
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
	        title_html = @htl("<$("h"*string(title_size)) style='color: white; margin-left: 10px; margin-top: 10px;'>$(lmd(box.title_text; text_color="white"))</$("h"*string(title_size))>")
	    end

		local body_html = nothing
	    if box.html_body !== nothing
	        body_html = box.html_body
	    elseif box.body_text !== nothing
	        body_html = @htl("<h6 style='color: white;'>$(lmd(box.body_text; text_color="white"))</h6>")
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

	function note_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(title_text=title_text, body_text=body_text, title_size=title_size))
	end
	
	function go_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, title_text=title_text, body_text=body_text, title_size=title_size))
	end

	function caution_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=55.5, outer_box_saturation=64, outer_box_lightness=62.9, inner_box_hue=54.2, inner_box_saturation=47.7, inner_box_lightness=25.5, title_text=title_text, body_text=body_text, title_size=title_size))
	end

	function stop_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=7.3, outer_box_saturation=100, outer_box_lightness=69.2, inner_box_hue=7.9, inner_box_saturation=43.9, inner_box_lightness=27.3, title_text=title_text, body_text=body_text, title_size=title_size))
	end

	function black_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=30.0, outer_box_saturation=10.0, outer_box_lightness=15.0, inner_box_hue=30.0, inner_box_saturation=5.0, inner_box_lightness=5.0, title_text=title_text, body_text=body_text, title_size=title_size))
	end

	function note_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(body_text=text, title_size=title_size))
	end
	
	function go_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, body_text=text, title_size=title_size))
	end

	function caution_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=55.5, outer_box_saturation=64, outer_box_lightness=62.9, inner_box_hue=54.2, inner_box_saturation=47.7, inner_box_lightness=25.5, body_text=text, title_size=title_size))
	end

	function stop_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=7.3, outer_box_saturation=100, outer_box_lightness=69.2, inner_box_hue=7.9, inner_box_saturation=43.9, inner_box_lightness=27.3, body_text=text, title_size=title_size))
	end

	function black_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=30.0, outer_box_saturation=10.0, outer_box_lightness=25.0, inner_box_hue=30.0, inner_box_saturation=5.0, inner_box_lightness=15.0, body_text=text, title_size=title_size))
	end
end;

# ╔═╡ 49e37ef1-5a53-44f7-ae36-bac6620b202a
note_box("When a person is given a name tag, they put it on either their **right side** or **left side**. We wish to see which is more common. Let ``p`` be the percentage of people that place the tag on their right–hand side.")

# ╔═╡ 33df956a-1ac9-4a57-99ea-61e659fec6cb
note_box("Suppose ``X \\sim \\mathcal{N}(\\mu,100)`` is some unknown Normal Distribution. Through previous testing, we have the guess ``\\mu = 60`` which we wish to test against ``\\mu > 60``. For this purpose, we test with the critical region ``\\overline{X} \\geq 62``. What does this choice tell us?")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
CommonMark = "~0.8.15"
Distributions = "~0.25.113"
HypertextLiteral = "~0.9.5"
PlutoTeachingTools = "~0.3.1"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "ee4876fda3ed195f898aa7d3f56042e3f8e391c2"

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
git-tree-sha1 = "b1c2585431c382e3fe5805874bda6aea90a95de9"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.25"

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
git-tree-sha1 = "fc8504eca188aaae4345649ca6105806bc584b70"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.37"

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
git-tree-sha1 = "834aedb1369919a7b2026d7e04c2d49a311d26f4"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.6.3"

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
# ╟─2ab35109-643c-4469-9457-94b626ede323
# ╟─fdd64ea1-8d9e-44ba-8f2e-d4c37b203e07
# ╟─e3e75c29-4b6e-40cf-bf89-2f7caa993e80
# ╟─63ebfd68-1ee8-4fd8-ab84-6910378951b0
# ╠═61818a99-2cdb-4cef-9350-26bcaf805529
# ╟─72fec931-efe2-4b7e-9079-d1e12d07a8ec
# ╟─b7a4836b-a844-471a-a0dd-fa503fea377e
# ╟─5bc98420-9d91-48d7-a173-617ce118fe59
# ╟─49e37ef1-5a53-44f7-ae36-bac6620b202a
# ╟─19f23cb8-450b-487a-87ab-942185c1ec15
# ╟─536e2822-8b96-4157-9545-6b1d441e65e8
# ╟─9a77ccf7-7ae6-44a0-a9a0-ac0ba6700fcd
# ╟─4a3f694e-e392-4f7d-a7dd-67fc27470c21
# ╟─72cfa760-7ec9-46be-98ce-56de79fab884
# ╟─eba3279b-c68c-4f04-bc57-f3b74d11329b
# ╟─2bbf8285-163c-4c44-b883-f2fd9d810b43
# ╟─ae790c2a-432b-4b44-87b5-3cfbc7b3a3c5
# ╟─c73412c1-4ad3-405a-81be-8622742950d9
# ╠═a6a7cc8e-dd12-4c85-8744-a106871dbaca
# ╠═5c324854-82a7-49fc-be8e-bfbd8740a3f2
# ╟─3c273326-a220-44b2-861f-9380cedfb99b
# ╟─32645967-5c4f-464c-8047-859663558d3b
# ╟─3347b2da-a71a-4c3b-8c5b-a94e545424b7
# ╟─d2f37016-0c4f-42d8-ae82-89ac75b6df75
# ╟─33df956a-1ac9-4a57-99ea-61e659fec6cb
# ╟─56efd9f3-eb12-40c2-92d7-603c7881e88c
# ╟─a591a1ad-3fd0-4995-b5a4-5cfa037d700b
# ╟─a528d8c2-77fa-42bf-b866-ee4312d8d562
# ╟─0b3ecae7-a7b8-45ee-98f5-4d45d268b6c6
# ╟─40fe8e16-b9d2-4397-98ea-4a9ebe74bfbf
# ╟─38719571-5593-4722-846d-ce1d47dd4704
# ╟─95beff4d-7c67-46bd-a392-e9d4b3b2ec45
# ╟─c5eb1335-6744-4345-b955-3e47b4660b8d
# ╟─592be977-37b0-4969-a7bd-a68c699604f1
# ╠═ce0e08d1-0eca-4f65-ba9e-e35717966f20
# ╠═039b1d5a-a1a8-4c47-8dc5-f3a56edf7d86
# ╟─64a62793-8d3b-4762-b1d8-e0393ec56274
# ╟─c7f13f9e-38c5-4469-8554-a8d3ab0af895
# ╟─b0536a2b-432a-4a78-a4a3-857c57d74957
# ╟─51edc66d-3f3d-4135-912d-658877b3040d
# ╟─cbaa3088-45ab-48d3-be21-5873117b629d
# ╟─85b64fea-21d6-4c34-b8be-ddb7027269e8
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
