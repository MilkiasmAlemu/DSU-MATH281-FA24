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

# ╔═╡ 26533a58-9dec-4d39-8050-c3561217e92e
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools, CommonMark
end

# ╔═╡ e256dfb8-0238-4d30-92b5-2c788eb09cdc
using Distributions, StatsBase

# ╔═╡ 7693d58a-976f-4c93-a6ba-e2a824e8caab
@htl("""
	<h1>Lecture 23</h1>
""")

# ╔═╡ 4d9b48a9-1463-4f47-8d60-26be22034e51
TableOfContents()

# ╔═╡ ac03277d-ff81-4d1c-8e90-c9c8a0fd51c9
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ 0b757a75-833d-41f6-8b38-eebdc49ca97b
@htl("""
	<hr>
""")

# ╔═╡ ecbf5c38-4a40-47c4-94ba-725d4a2ab697
begin
	ν_slider = @bindname ν Slider(1:10, show_value=true, default=1)
	@htl("""
		<h5>Degrees of Freedom:</h5>
		<br>
		$(ν_slider)
	""")
end

# ╔═╡ 7f000d10-ad4e-42db-bb76-d13d90672574
χ² = Chisq(ν)

# ╔═╡ f6f4c6c7-5d56-42c9-9071-85d034b74408
[ mean(χ²), ν ]

# ╔═╡ af7dd861-6f45-4808-918f-2a943fe41b91
[ var(χ²), 2ν ]

# ╔═╡ b4cb1458-b768-4c1a-a1ac-f7ece3e2e1fb
[ skewness(χ²), sqrt(8 / ν) ]

# ╔═╡ 529943cb-d773-410b-a18c-33e4afb95aff
[ 3 + kurtosis(χ²), 3 + 12 / ν ]

# ╔═╡ 2500f285-8f94-4925-8050-79b71a731c2b
begin
	local plot_uuid = "Plot-"*string(uuid1())
	local x_vals = collect(range(-0.5,10.5, step=0.001))
	local prob_vals = (x -> pdf(χ², x)).(x_vals)
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace = {
			  x: $(x_vals),
			  y: $(prob_vals),
			  type: 'scatter',
			  name: ''
			};
			
			var data = [trace];

			var layout = {

				title: 'χ²–Distribution',

				width: 600,
	
  				height: 400,
	
				xaxis: {
		
					title: 'x',
					range: [-0.5, 10.5]
		
	        	},
	
				yaxis: {
		
					title: 'Probabilities',
					range: [0, 1]
		
	        	},
			
			    showlegend: false,

				colorway: ['steelblue']

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ a0ec3505-2324-45c9-b41c-c469ca873930
begin
	local plot_uuid = "Plot-"*string(uuid1())
	local n = 10000
	local X = Normal(0,1)
	local count_vals = [+([rand(X)^2 for j in 1:ν]...) for i in 1:n]
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace = {
			  x: $(count_vals),
			  type: 'histogram',
			  name: '',
			  autobinx: false,
			  histnorm: 'probability density',
			  xbins: {
			    end: 10,
			    size: 0.1,
			    start: 0
			  }
			};
			
			var data = [trace];

			var layout = {

				title: 'Sum of Squares of $(round(Int64, ν)) Normal Distributions',

				width: 600,
	
  				height: 400,
	
				xaxis: {
		
					title: 'x',
					range: [-0.5, 10.5]
		
	        	},
	
				yaxis: {
		
					title: 'Probabilities',
					range: [0, 1]
	        	},
			
			    showlegend: false,

				colorway: ['steelblue']

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ 64bba9b4-3d81-4f71-9423-edbd4bfd9854
ν_slider

# ╔═╡ 34ec66f7-b9aa-4481-91ec-bf64843c79bb
@htl("""
	<hr>
""")

# ╔═╡ 2c43d489-1c5b-4fa4-a894-037811488263
@htl("""
	<h5>Number of Trials</h5>
	<br>
	$(@bindname n Slider(100:10:1000, show_value=true, default=250))
""")

# ╔═╡ 09017b64-85df-4c40-9876-24b6233e721c
expected_counts = [n * 0.1 for i in 1:10]

# ╔═╡ 92b0f66f-6926-4a52-a440-fea2e1ca31c3
@bindname max_bias Slider(1:10, default=3)

# ╔═╡ b1fe3a16-9fdf-4de8-a97d-d27a1a3f6208
begin
	local freqs = [rand(1:max_bias) for i in 1:10]
	random_numbers = sample(1:10, Weights(freqs), n)
	α_slider = @bindname α Slider(0.01:0.01:1, show_value=true, default=0.05)
end;

# ╔═╡ cdd6dff5-1179-459e-855b-d0dded24874d
random_numbers

# ╔═╡ e67a41c4-732f-49e7-8509-377c08c17a29
observed_counts = sort(countmap(random_numbers))

# ╔═╡ 16c05677-f91a-44a9-bca6-7350db1129cf
test_statistic = sum([(observed_counts[i] - expected_counts[i])^2 / expected_counts[i] for i in 1:10])

# ╔═╡ af9cafa9-af04-4594-8d31-6c163cc66218
begin
	local plot_uuid = "Plot-"*string(uuid1())
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace1 = {
			  x: $(random_numbers),
			  type: 'histogram',
			  name: '',
			  autobinx: false,
			  histnorm: 'probability density',
			  xbins: {
			    end: 10.5,
			    size: 1,
			    start: 0.5
			  },
			  opacity: 0.75
			};

			var trace2 = {
			  x: $(collect(1:10)),
			  type: 'histogram',
			  name: '',
			  autobinx: false,
			  histnorm: 'probability density',
			  xbins: {
			    end: 10.5,
			    size: 1,
			    start: 0.5
			  },
			  opacity: 0.25
			};
			
			var data = [ trace1, trace2 ];

			var layout = {

				title: 'Random Numbers?',

				width: 600,
	
  				height: 400,
	
				xaxis: {
		
					title: 'Digit',
					range: [0, 11]
		
	        	},
	
				yaxis: {
		
					title: 'Probabilities',
					range: [0, 0.25]
	        	},
			
			    showlegend: false,

				barmode: 'overlay',

				colorway: ['steelblue', 'lightcoral']

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ 7f93ca8b-008f-40e5-90ae-df0e6b32be3b
α_slider

# ╔═╡ 7369c4a2-c93a-436a-a16b-2a987f70a463
threshold_value = quantile( Chisq( 10 - 1 ) , 1 - α)

# ╔═╡ 2d8155ab-a95f-4c08-992f-b574005f932c
@htl("""
	<hr>
""")

# ╔═╡ 41795e8a-1320-408e-9e9a-35bdc5556281
@htl("""
	<h3>Goodness of Fit Test</h2>
""")

# ╔═╡ 496d412b-122e-4e72-b648-12860a81bd4b
@htl("""
	<h5>Number of Trials</h5>
	<br>
	$(@bindname m Slider(100:10:1000, show_value=true, default=250))
""")

# ╔═╡ 996e2ab5-e555-4f77-9e91-7bf37a72696f
@bindname num_bins Slider(25:50, show_value=true, default=30)

# ╔═╡ e72ef7d5-7c12-4fb7-8878-b7fe115669e2
@bindname μ Slider(10:0.25:20, show_value=true, default=15)

# ╔═╡ bcb68765-d850-4874-8114-b59ec8a8b4dc
@bindname σ Slider(1:0.5:5, show_value=true, default=1)

# ╔═╡ 8f9b2611-378c-4575-aa73-26348dccfdcf
X_Normal = Normal( μ , σ )

# ╔═╡ 1c6f8f24-1cef-4b5d-9888-dcad9e0694b1
α_slider

# ╔═╡ eb3778f6-8262-411a-8695-d994511d56b6
threshold_value_normal = quantile( Chisq( num_bins - 1 ) , 1 - α)

# ╔═╡ f9141abc-a708-4105-81ad-55e0ff63e35a
begin
	local μ_observed = rand(10:20)
	local σ_observed = rand(1:5)
	X_observed = Normal(μ_observed, σ_observed)
	observed_values = rand(X_observed, m)
	x_min = min(observed_values...)
	x_max = max(observed_values...)
	bin_size = ( x_max - x_min ) / num_bins
	bins = [ ( x_min + (i-1) * bin_size , x_min + i * bin_size ) for i in 1:num_bins ]
	observed_value_counts = [ length( filter( x -> ab[1] ≤ x ≤ ab[2] , observed_values ) ) for ab in bins ]
end;

# ╔═╡ 740fe9ac-b87b-44c6-8733-b13feb4979b1
observed_values

# ╔═╡ d577050c-9cd6-4ea4-b2ea-8ce733712d2e
bins

# ╔═╡ 12fb69ea-413f-469d-9885-561acf94b6d1
observed_value_counts

# ╔═╡ 66d0222d-fd24-4671-9ef8-6325dc5eeaf9
begin
	local plot_uuid = "Plot-"*string(uuid1())
	local x_vals = collect((x_min - 1):0.001:(x_max + 1))
	local probs = pdf.(X_Normal, x_vals)
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace1 = {
			  x: $(observed_values),
			  type: 'histogram',
			  name: '',
			  autobinx: false,
			  histnorm: 'probability density',
			  xbins: {
			    end: $(x_max),
			    size: $(bin_size),
			    start: $(x_min)
			  },
			  opacity: 0.75
			};

			var trace2 = {
			  x: $(x_vals),
			  y: $(probs),
			  type: 'scatter',
			  name: '',
			  opacity: 1
			};
			
			var data = [ trace1 , trace2 ];

			var layout = {

				title: 'Distribution',

				width: 600,
	
  				height: 400,
	
				xaxis: {
		
					title: '',
					range: [$(x_min - 1), $(x_max + 1)]
		
	        	},
	
				yaxis: {
		
					title: 'Probabilities',
					range: [0, 1]
	        	},
			
			    showlegend: false,

				barmode: 'overlay',

				colorway: ['steelblue', 'lightcoral']

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ e592c9e7-7e0a-4642-80d5-269ff95e30c1
expected_value_counts = [m * (cdf(X_Normal, ab[2]) - cdf(X_Normal, ab[1])) for ab in bins]

# ╔═╡ ae15a6a2-0ed9-4ac1-83fa-a58d85b32e89
test_statistic_normal = sum([(observed_value_counts[i] - expected_value_counts[i])^2 / expected_value_counts[i] for i in 1:num_bins])

# ╔═╡ fbf5d464-227f-4e56-ad55-43fbe5a70ec7
@htl("""
	<hr>
""")

# ╔═╡ 48d7b3c8-c785-47b6-920e-5801b942614f
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

# ╔═╡ e5ec5492-232b-4ef5-a5db-9967e5d3bac7
@htl("""
	<h2>$(lmd("``\\chi^2``"))–Distribution</h2>
""")

# ╔═╡ f6393e66-ceaa-4d8d-bbc2-90d6da4cd35b
lmd("``\\chi^2($(ν)) \\sim `` "*(["``X_{$(i)}^2 +`` " for i in 1:(ν-1)]...)*" ``X_{$(ν)}^2``")

# ╔═╡ 8725a9f3-ab69-4990-9ae3-ec07da050a25
@htl("""
	<h2>$(lmd("``\\chi^2``")) Tests</h2>
""")

# ╔═╡ 074d6721-96e8-4865-8203-53899a9cfa42
@htl("""
	<h3>Pearson's $(lmd("``\\chi^2``"))–Test</h2>
""")

# ╔═╡ fc8d6230-1885-4dca-a355-1a84dc972067
@htl("""
	<h5>Since test $(lmd("`` = $(round(test_statistic; digits=2)) $((test_statistic < threshold_value) ? "&lt;" : "&gt;") $(round(threshold_value; digits=2)) = `` threshold")), we choose to $((test_statistic < threshold_value) ? @htl("<span style=\"color:green\">NOT REJECT</span>") : @htl("<span style=\"color:red\">REJECT</span>")) the Null Hypothesis.</h5>
	<br>
	<h5>The Numbers (probably) $((test_statistic < threshold_value) ? @htl("<span style=\"color:green\">ARE</span>") : @htl("<span style=\"color:red\">ARE NOT</span>")) Random</h5>
""")

# ╔═╡ 0423dbbf-a52c-4894-a5c2-5f46fdbc8f63
@htl("""
	<h5>Since test $(lmd("`` = $(round(test_statistic_normal; digits=2)) $((test_statistic_normal < threshold_value_normal) ? "&lt;" : "&gt;") $(round(threshold_value_normal; digits=2)) = `` threshold")), we choose to $((test_statistic_normal < threshold_value_normal) ? @htl("<span style=\"color:green\">NOT REJECT</span>") : @htl("<span style=\"color:red\">REJECT</span>")) the Null Hypothesis.</h5>
	<br>
	<h5>The Distribution (probably) $((test_statistic_normal < threshold_value_normal) ? @htl("<span style=\"color:green\">IS</span>") : @htl("<span style=\"color:red\">IS NOT</span>")) Accurate</h5>
""")

# ╔═╡ 5096775d-5486-4921-aed1-8acbacd6f3b7
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

# ╔═╡ 8ab1cfec-8e4c-4b87-9903-a3fa1a9ce509
note_box("Consider a situation where we want to check if a random number generator is **really** random. This machine gives us a *\"random\"* number from ``1`` to ``10``. Theoretically ``\\widehat{p}_1 = \\ldots = \\widehat{p}_{10} = \\frac{1}{10}``.  
  
Is the list of *\"random\"* numbers below actually random?")

# ╔═╡ cf23e0ca-eebc-472d-887f-5c54816de890
note_box("How can we actually tell if a hypothetical distribution fits some observed data?  
  
Suppose we have the observed data below and are pretty sure it comes from *some* Normal Distribution, but we don't know which.")

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
# ╟─26533a58-9dec-4d39-8050-c3561217e92e
# ╟─7693d58a-976f-4c93-a6ba-e2a824e8caab
# ╟─4d9b48a9-1463-4f47-8d60-26be22034e51
# ╟─ac03277d-ff81-4d1c-8e90-c9c8a0fd51c9
# ╠═e256dfb8-0238-4d30-92b5-2c788eb09cdc
# ╟─0b757a75-833d-41f6-8b38-eebdc49ca97b
# ╟─e5ec5492-232b-4ef5-a5db-9967e5d3bac7
# ╠═7f000d10-ad4e-42db-bb76-d13d90672574
# ╠═f6f4c6c7-5d56-42c9-9071-85d034b74408
# ╠═af7dd861-6f45-4808-918f-2a943fe41b91
# ╠═b4cb1458-b768-4c1a-a1ac-f7ece3e2e1fb
# ╠═529943cb-d773-410b-a18c-33e4afb95aff
# ╟─ecbf5c38-4a40-47c4-94ba-725d4a2ab697
# ╟─2500f285-8f94-4925-8050-79b71a731c2b
# ╟─a0ec3505-2324-45c9-b41c-c469ca873930
# ╟─64bba9b4-3d81-4f71-9423-edbd4bfd9854
# ╟─f6393e66-ceaa-4d8d-bbc2-90d6da4cd35b
# ╟─34ec66f7-b9aa-4481-91ec-bf64843c79bb
# ╟─8725a9f3-ab69-4990-9ae3-ec07da050a25
# ╟─074d6721-96e8-4865-8203-53899a9cfa42
# ╟─8ab1cfec-8e4c-4b87-9903-a3fa1a9ce509
# ╟─2c43d489-1c5b-4fa4-a894-037811488263
# ╠═cdd6dff5-1179-459e-855b-d0dded24874d
# ╠═e67a41c4-732f-49e7-8509-377c08c17a29
# ╟─af9cafa9-af04-4594-8d31-6c163cc66218
# ╠═09017b64-85df-4c40-9876-24b6233e721c
# ╠═16c05677-f91a-44a9-bca6-7350db1129cf
# ╟─7f93ca8b-008f-40e5-90ae-df0e6b32be3b
# ╠═7369c4a2-c93a-436a-a16b-2a987f70a463
# ╟─fc8d6230-1885-4dca-a355-1a84dc972067
# ╟─92b0f66f-6926-4a52-a440-fea2e1ca31c3
# ╟─b1fe3a16-9fdf-4de8-a97d-d27a1a3f6208
# ╟─2d8155ab-a95f-4c08-992f-b574005f932c
# ╟─41795e8a-1320-408e-9e9a-35bdc5556281
# ╟─cf23e0ca-eebc-472d-887f-5c54816de890
# ╟─496d412b-122e-4e72-b648-12860a81bd4b
# ╠═740fe9ac-b87b-44c6-8733-b13feb4979b1
# ╟─996e2ab5-e555-4f77-9e91-7bf37a72696f
# ╠═d577050c-9cd6-4ea4-b2ea-8ce733712d2e
# ╠═12fb69ea-413f-469d-9885-561acf94b6d1
# ╠═8f9b2611-378c-4575-aa73-26348dccfdcf
# ╟─e72ef7d5-7c12-4fb7-8878-b7fe115669e2
# ╟─bcb68765-d850-4874-8114-b59ec8a8b4dc
# ╟─66d0222d-fd24-4671-9ef8-6325dc5eeaf9
# ╠═e592c9e7-7e0a-4642-80d5-269ff95e30c1
# ╠═ae15a6a2-0ed9-4ac1-83fa-a58d85b32e89
# ╟─1c6f8f24-1cef-4b5d-9888-dcad9e0694b1
# ╠═eb3778f6-8262-411a-8695-d994511d56b6
# ╟─0423dbbf-a52c-4894-a5c2-5f46fdbc8f63
# ╟─f9141abc-a708-4105-81ad-55e0ff63e35a
# ╟─fbf5d464-227f-4e56-ad55-43fbe5a70ec7
# ╟─5096775d-5486-4921-aed1-8acbacd6f3b7
# ╟─48d7b3c8-c785-47b6-920e-5801b942614f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
