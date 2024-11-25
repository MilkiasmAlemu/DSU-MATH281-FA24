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

# ╔═╡ d463796d-aa22-4db6-8208-3134a25f3225
#Packages for Formatting
begin
	using JSON, UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools, CommonMark
end

# ╔═╡ eb8d5af0-aaef-11ef-273f-97eb2367b462
using Random, StatsBase, Distributions, DataFrames

# ╔═╡ bb366d90-5e52-4538-be1e-8ac2658796dd
@htl("""
	<h1>Lecture 24</h1>
""")

# ╔═╡ 435cef37-7d42-414c-b3cc-b75bbfe9aaac
TableOfContents()

# ╔═╡ 830c3960-bd4f-4d49-b82c-ca6f45039ac8
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ 33131771-f9c0-4b87-ac09-972c0527bbae
@htl("""
	<hr>
""")

# ╔═╡ 6ae543d8-8d2b-4e25-8e32-dce715c55956
@htl("""
	<h2>F–Distribution</h2>
""")

# ╔═╡ 0152995b-a85e-4889-93df-f70b250b18c5
@bindname ν₁ Slider(1:10, show_value=true)

# ╔═╡ 940bb398-8e67-445e-984d-86449e37dd25
@bindname ν₂ Slider(1:10, show_value=true)

# ╔═╡ a12b6eba-34f8-4303-a167-144ce2475d6f
F = FDist( ν₁, ν₂ )

# ╔═╡ b6706521-984d-4a27-8dc6-ca965c49dcfd
begin
	local plot_uuid = "Plot-"*string(uuid1())
	local x_vals = collect(range(-0.5,10.5, step=0.001))
	local prob_vals = (x -> pdf(F, x)).(x_vals)
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

				title: 'F–Distribution',

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

# ╔═╡ 76a9ba66-5de4-46b2-b1a4-78047bef193c
@htl("""
	<hr>
""")

# ╔═╡ ac652a13-e412-4ae0-84a7-40daea338fea
@htl("""
	<h2>One–Factor ANOVA</h2>
""")

# ╔═╡ 796a1a9f-51cd-4bee-9c39-a64d910a5ff7
@htl("""
	<h3>Dogs in a Dog Show</h3>
""")

# ╔═╡ 2a737489-4e7d-45fa-aac2-ff952556c62d
@htl("""
	<hr>
""")

# ╔═╡ 424ee484-a2a4-4064-a203-e828baa92c64
@htl("""
	<h3>Categories Based on Hair and Age</h3>
""")

# ╔═╡ 3a4ccb0d-a015-442f-bf2e-2cf15ff98b71
@htl("""
	<hr>
""")

# ╔═╡ 8e86d94e-babf-4918-ba5c-28e940d1476c
@htl("""
	<h3>Categories Based on Athleticism and Breed Type</h3>
""")

# ╔═╡ ea1a3dba-7123-4574-ab1a-4da2c69d77bd
@htl("""
	<hr>
""")

# ╔═╡ b3b69c2e-cb53-40e1-86aa-c2b7fd5c3573
@htl("""
	<h3>Categories by Breed</h3>
""")

# ╔═╡ 1f458adc-5ca3-43e2-9d48-7f220e408306
begin
	n = 10000
	
	local possible_breeds = ["Chihuahua", "French Bulldog", "Dachshund", "Bulldog", "Australian Shepherd", "Poodle", "Boxer", "Golden Retriever", "Labrador Retriever", "Bernese Mountain Dog", "Doberman", "Rottweiler", "Newfoundland", "St. Bernard"]
	local breed_means = [5, 15, 25, 45, 55, 60, 65, 75, 85, 95, 105, 120, 130, 140]
	local working_breed = [false, false, false, false, false, false, false, false, false, true, true, true, true, true]
	local short_hair = [false, true, false, true, false, false, true, false, true, false, true, true, false, false]
	
	local weights = []
	local breeds = []
	local athletes = []
	local working = []
	local hair = []
	local age = []
	for i in 1:n
		local breed = floor(Int64, (3 * rand(1:15) + rand(Truncated(Normal(7.5, 10), 1, 15))) / 4)
		if breed > 14
			breed = 14
		end
		push!(breeds, possible_breeds[breed])
		local weight = round(Int64, rand(Truncated(Normal(breed_means[breed], 3.5), breed_means[breed] - 5, breed_means[breed] + 5)))
		push!(weights, weight)
		push!(working, working_breed[breed] ? "Working" : "Pet")
		push!(athletes, (weight + rand() - 0.5 < breed_means[breed]) ? "Athletic" : "Not Athletic")
		push!(hair, short_hair[breed] ? "Short Hair" : "Long Hair")
		push!(age, ( rand() < 0.6 ) ? "Young" : "Old")
	end

	dog_data = DataFrame("Weight (in lbs)" => weights, "Age Group" => age, "Hair Group" => hair, "Working Group / Pet Group" => working, "Exercise Level" => athletes, "Breed" => breeds)
end;

# ╔═╡ 5b0f5631-b8e6-4113-8abb-143730bcac7a
dog_data

# ╔═╡ ddd45378-7167-4513-b33c-95dac56580eb
begin
	local plot_uuid = "Plot-"*string(uuid1())
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace = {
			  x: $(dog_data[!, "Weight (in lbs)"]),
			  type: 'histogram',
			  name: 'Weights',
			  autobinx: false,
			  xbins: {
			    end: 150,
			    size: 4,
			    start: 0
			  },
			  opacity: 0.75
			};
			
			var data = [ trace ];

			var layout = {

				title: 'Dog Weights',

				width: 600,
	
  				height: 400,
	
				xaxis: {
		
					title: 'Weights',
					range: [0, 150]
		
	        	},
	
				yaxis: {
		
					title: 'Frequencies'
	        	},
			
			    showlegend: true,

				barmode: 'overlay',

				colorway: ['steelblue']

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ da02db52-0e05-424e-b0fc-b04960250eed
weights = dog_data[!, "Weight (in lbs)"]

# ╔═╡ a6cc0d61-783f-472d-b1f7-1db7168e92da
average_weight = mean( weights )

# ╔═╡ 7913ad51-bf6e-4cbb-bee6-c20f05e4cde2
short_young = filter( row -> ( row."Hair Group" == "Short Hair" ) && ( row."Age Group" == "Young" ), dog_data);

# ╔═╡ e07bf622-e92b-4880-8fa2-b7b24305502a
short_old = filter( row -> ( row."Hair Group" == "Short Hair" ) && ( row."Age Group" == "Old"), dog_data );

# ╔═╡ fc1342b4-26dd-4797-a99e-a49f1345866e
long_young = filter( row -> ( row."Hair Group" == "Long Hair" ) && ( row."Age Group" == "Young"), dog_data );

# ╔═╡ f94ce0e5-85ec-4dc7-b7c3-a2f1efd6adec
long_old = filter( row -> ( row."Hair Group" == "Long Hair" ) && ( row."Age Group" == "Old"), dog_data );

# ╔═╡ 025e7763-1382-48f8-a6c0-996da7147b5d
begin
	local plot_uuid = "Plot-"*string(uuid1())
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace1 = {
			  x: $(short_young[!, "Weight (in lbs)"]),
			  type: 'histogram',
			  name: 'Short and Young',
			  autobinx: false,
			  xbins: {
			    end: 150,
			    size: 4,
			    start: 0
			  },
			  opacity: 0.75
			};

			var trace2 = {
			  x: $(short_old[!, "Weight (in lbs)"]),
			  type: 'histogram',
			  name: 'Short and Old',
			  autobinx: false,
			  xbins: {
			    end: 150,
			    size: 4,
			    start: 0
			  },
			  opacity: 0.75
			};

			var trace3 = {
			  x: $(long_young[!, "Weight (in lbs)"]),
			  type: 'histogram',
			  name: 'Long and Young',
			  autobinx: false,
			  xbins: {
			    end: 150,
			    size: 4,
			    start: 0
			  },
			  opacity: 0.75
			};

			var trace4 = {
			  x: $(long_old[!, "Weight (in lbs)"]),
			  type: 'histogram',
			  name: 'Long and Old',
			  autobinx: false,
			  xbins: {
			    end: 150,
			    size: 4,
			    start: 0
			  },
			  opacity: 0.75
			};
			
			var data = [ trace1, trace2, trace3, trace4 ];

			var layout = {

				title: 'Dog Weights',

				width: 600,
	
  				height: 400,
	
				xaxis: {
		
					title: 'Weights',
					range: [0, 150]
		
	        	},
	
				yaxis: {
		
					title: 'Frequencies'
	        	},
			
			    showlegend: true,

				barmode: 'stack',

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ b23b9ca9-d791-435d-9965-3ee739f9e306
age_hair_categories = [
	short_young[!, "Weight (in lbs)"],
	short_old[!, "Weight (in lbs)"],
	long_young[!, "Weight (in lbs)"],
	long_old[!, "Weight (in lbs)"]
]

# ╔═╡ a485c11a-cf12-4842-a4b0-faa82e8987ac
mean.( age_hair_categories )

# ╔═╡ 41f78090-bb77-438d-8d2a-3aa0777eacb7
std.( age_hair_categories )

# ╔═╡ e58ec3bd-ef45-4aa9-8cb3-6d81e7b11874
athletic_pet = filter( row -> ( row."Exercise Level" == "Athletic" ) && ( row."Working Group / Pet Group" == "Pet"), dog_data );

# ╔═╡ b12fe9c6-204d-4d66-94b9-80637f180688
athletic_working = filter( row -> ( row."Exercise Level" == "Athletic" ) && ( row."Working Group / Pet Group" == "Working"), dog_data );

# ╔═╡ 20e6eb9d-d021-412c-9c92-f561c326c82d
not_athletic_pet = filter( row -> ( row."Exercise Level" == "Not Athletic" ) && ( row."Working Group / Pet Group" == "Pet"), dog_data );

# ╔═╡ bd741d8a-3002-48c1-9466-62163cd3b4c3
not_athletic_working = filter( row -> ( row."Exercise Level" == "Not Athletic" ) && ( row."Working Group / Pet Group" == "Working"), dog_data );

# ╔═╡ 2eb56818-50ed-49af-b22e-08b46d81255c
begin
	local plot_uuid = "Plot-"*string(uuid1())
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace1 = {
			  x: $(athletic_pet[!, "Weight (in lbs)"]),
			  type: 'histogram',
			  name: 'Athletic and Pet',
			  autobinx: false,
			  xbins: {
			    end: 150,
			    size: 6,
			    start: 0
			  },
			  opacity: 0.75
			};

			var trace2 = {
			  x: $(athletic_working[!, "Weight (in lbs)"]),
			  type: 'histogram',
			  name: 'Athletic and Working',
			  autobinx: false,
			  xbins: {
			    end: 150,
			    size: 6,
			    start: 0
			  },
			  opacity: 0.75
			};

			var trace3 = {
			  x: $(not_athletic_pet[!, "Weight (in lbs)"]),
			  type: 'histogram',
			  name: 'Not Athletic and Pet',
			  autobinx: false,
			  xbins: {
			    end: 150,
			    size: 6,
			    start: 0
			  },
			  opacity: 0.75
			};

			var trace4 = {
			  x: $(not_athletic_working[!, "Weight (in lbs)"]),
			  type: 'histogram',
			  name: 'Not Athletic and Working',
			  autobinx: false,
			  xbins: {
			    end: 150,
			    size: 6,
			    start: 0
			  },
			  opacity: 0.75
			};
			
			var data = [ trace3, trace1, trace4, trace2 ];

			var layout = {

				title: 'Dog Weights',

				width: 600,
	
  				height: 400,
	
				xaxis: {
		
					title: 'Weights',
					range: [0, 150]
		
	        	},
	
				yaxis: {
		
					title: 'Frequencies'
	        	},
			
			    showlegend: true,

				barmode: 'stack',

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ 66e6a943-d640-49dc-bfc4-8e772e7fd5c7
athletic_categories = [
	athletic_pet[!, "Weight (in lbs)"],
	athletic_working[!, "Weight (in lbs)"],
	not_athletic_pet[!, "Weight (in lbs)"],
	not_athletic_working[!, "Weight (in lbs)"]
]

# ╔═╡ 012e06bd-6039-4957-807c-6d7719b1e8d8
mean.( athletic_categories )

# ╔═╡ 73f6056e-a69d-461c-80ac-3ccf5e0bae89
std.( athletic_categories )

# ╔═╡ 2a804215-31d6-44f9-96a1-fbed7f20542b
begin
	chihuahua_data = filter( row -> ( row."Breed" == "Chihuahua" ), dog_data )
	golden_data = filter( row -> ( row."Breed" == "Golden Retriever" ), dog_data )
	french_data = filter( row -> ( row."Breed" == "French Bulldog" ), dog_data )
	poodle_data = filter( row -> ( row."Breed" == "Poodle" ), dog_data )
	labrador_data = filter( row -> ( row."Breed" == "Labrador Retriever" ), dog_data )
	bulldog_data = filter( row -> ( row."Breed" == "Bulldog" ), dog_data )
	rottweiler_data = filter( row -> ( row."Breed" == "Rottweiler" ), dog_data )
	australian_data = filter( row -> ( row."Breed" == "Australian Shepherd" ), dog_data )
	dachshund_data = filter( row -> ( row."Breed" == "Dachshund" ), dog_data )
	bernese_data = filter( row -> ( row."Breed" == "Bernese Mountain Dog" ), dog_data )
	boxer_data = filter( row -> ( row."Breed" == "Boxer" ), dog_data )
	bernard_data = filter( row -> ( row."Breed" == "St. Bernard" ), dog_data )
	newfoundland_data = filter( row -> ( row."Breed" == "Newfoundland" ), dog_data )
	doberman_data = filter( row -> ( row."Breed" == "Doberman" ), dog_data )
end;

# ╔═╡ be662def-1b9b-4bd4-ba39-2d902f1c5149
begin
	chihuahua_weight = chihuahua_data[!, "Weight (in lbs)"]
	golden_weight = golden_data[!, "Weight (in lbs)"]
	french_weight = french_data[!, "Weight (in lbs)"]
	poodle_weight = poodle_data[!, "Weight (in lbs)"]
	labrador_weight = labrador_data[!, "Weight (in lbs)"]
	bulldog_weight = bulldog_data[!, "Weight (in lbs)"]
	rottweiler_weight = rottweiler_data[!, "Weight (in lbs)"]
	australian_weight = australian_data[!, "Weight (in lbs)"]
	dachshund_weight = dachshund_data[!, "Weight (in lbs)"]
	bernese_weight = bernese_data[!, "Weight (in lbs)"]
	boxer_weight = boxer_data[!, "Weight (in lbs)"]
	bernard_weight = bernard_data[!, "Weight (in lbs)"]
	newfoundland_weight = newfoundland_data[!, "Weight (in lbs)"]
	doberman_weight = doberman_data[!, "Weight (in lbs)"]
end;

# ╔═╡ d03830ab-1438-4065-b20e-e5d98b47d13f
breed_categories = [ chihuahua_weight, golden_weight, french_weight, poodle_weight, labrador_weight, bulldog_weight, rottweiler_weight, australian_weight, dachshund_weight, bernese_weight, boxer_weight, bernard_weight, newfoundland_weight, doberman_weight ];

# ╔═╡ 554fc2a6-a03d-4b5f-9300-10feae688e95
mean.( breed_categories )

# ╔═╡ 77ffc2cb-3b22-4c2d-b875-e592995365be
std.( breed_categories )

# ╔═╡ 6b2acc48-ddb3-435f-bf0b-c4e87842da5d
function ANOVA_histogram( categories; bin_size=5 )
	local plot_uuid = "Plot-"*string(uuid1())
	local data = [ Dict(
		"x" => categories[i],
		"type" => "histogram",
            "name" => "Category "*string(i),
            "autobinx" => false,
            "xbins" => Dict("size" => bin_size),
            "opacity" => 0.75
        ) for i in length(categories):-1:1 ]
	local json_data = JSON.json(data)
	
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>
			
			var data = JSON.parse($(json_data));

			var layout = {

				title: 'ANOVA Histogram',

				width: 600,
	
  				height: 400,
	
				xaxis: {
		
					title: 'Measurements',
					//range: [0, 150]
		
	        	},
	
				yaxis: {
		
					title: 'Frequencies'
	        	},
			
			    showlegend: true,

				barmode: 'stack',

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ 17ae511b-f7d5-45ce-9d33-e139c0d6faaa
ANOVA_histogram( breed_categories; bin_size = 1 )

# ╔═╡ 80e277ea-6b9f-474f-a2b5-61e404b16c52
function ANOVA_table( data, input_categories )
	local table_uuid = "Table-"*string(uuid1())
	local categories = filter( x -> !isempty(x), input_categories )
	
	local category_means = mean.( categories )
	local overall_mean = mean( data )

	local SST = sum( [ length( categories[i] ) * ( category_means[i] - overall_mean )^2 for i in 1:length( categories ) ] )
	local SSE = sum( [ sum( ( categories[i] .- category_means[i] ) .^ 2 ) for i in 1:length( categories ) ] )
	local SSTO = sum( ( data .- overall_mean ) .^ 2 )

	local ν₁ = length( categories ) - 1
	local ν₂ = length( data ) - ν₁ - 1
	local ν = ν₁ + ν₂

	local MST = SST / ν₁
	local MSE = SSE / ν₂

	local F = MST / MSE

	local p_val = ccdf( FDist( ν₁, ν₂ ) , F )

	return @htl("""
		<div id=$(table_uuid) style="align-content: center;"></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>
			let values = [
			      ['Category', 'Error', 'Total'],
			      [$(round( SST , digits = 2 )), $(round( SSE , digits = 2 )), $(round( SSTO , digits = 2 ))],
			      [$(ν₁), $(ν₂), $(ν)],
			      [$(round( MST , digits = 2 )), $(round( MSE , digits = 2 )), ''],
			      [$(round( F , digits = 4 )), '', ''],
				  [$(round( p_val , sigdigits = 4 )), '', '']
				]
			
			let data = [{
			  type: 'table',
			  header: {
			    values: [
				  ["<b>Source</b>"], ["<b>Sum of Squares (SS)</b>"], ["<b>Degrees of Freedom</b>"], ["<b>Mean Square (MS)</b>"], ["<b>F–Ratio</b>"], ["<b>p–Value</b>"]
				],
			    align: ["left", "center"],
			    line: {width: 1, color: 'black'},
			    fill: {color: "cornflowerblue"},
			    font: {family: "Arial", size: 13, color: "white"}
			  },
			  cells: {
			    values: values,
			    align: ["left", "center"],
			    line: {color: "black", width: 1},
			    fill: {color: ["lightcyan", "white"]},
			    font: {family: "Arial", size: 12, color: "black"}
			  }
			}];

			var layout = {

				width: 640,
	
  				height: 110,

				margin: {
			      l: 0,
			      r: 0,
			      b: 0,
			      t: 0,
			      pad: 0
			    }
			};
			
			Plotly.newPlot($(table_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ 5dfcb8cd-e76f-40f8-829f-5abe703dc208
ANOVA_table( weights , age_hair_categories )

# ╔═╡ 2a4efb94-6154-41db-85d4-800fa59cebdd
ANOVA_table( weights , athletic_categories )

# ╔═╡ 733cb431-baba-4775-b288-e70e59a3481a
ANOVA_table( weights, breed_categories )

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
CommonMark = "~0.8.15"
DataFrames = "~1.7.0"
Distributions = "~0.25.113"
HypertextLiteral = "~0.9.5"
JSON = "~0.21.4"
PlutoTeachingTools = "~0.3.1"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "bca52bcb6b74c65d21972f3a164d261cc7ac231d"

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

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "fb61b4812c49343d7ef0b533ba982c46021938a6"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.7.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "1d0a14036acb104d9e89698bd408f63ab58cdc82"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.20"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

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

[[deps.InlineStrings]]
git-tree-sha1 = "45521d31238e87ee9f9732561bfee12d4eebd52d"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.2"

    [deps.InlineStrings.extensions]
    ArrowTypesExt = "ArrowTypes"
    ParsersExt = "Parsers"

    [deps.InlineStrings.weakdeps]
    ArrowTypes = "31f734f8-188a-4ce0-8406-c8a06bd891cd"
    Parsers = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

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
git-tree-sha1 = "10da5154188682e5c0726823c2b5125957ec3778"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.38"

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
git-tree-sha1 = "688d6d9e098109051ae33d126fcfc88c4ce4a021"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.1.0"

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

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "36d8b4b899628fb92c2749eb488d884a926614d3"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.3"

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

[[deps.PrettyTables]]
deps = ["Crayons", "LaTeXStrings", "Markdown", "PrecompileTools", "Printf", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "1101cd475833706e4d0e7b122218257178f48f34"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.4.0"

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
git-tree-sha1 = "470f48c9c4ea2170fd4d0f8eb5118327aada22f5"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.6.4"

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

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "d0553ce4031a081cc42387a9b9c8441b7d99f32d"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.7"

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

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a6b1675a536c5ad1a60e5a5153e1fee12eb146e3"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.4.0"

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

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "OrderedCollections", "TableTraits"]
git-tree-sha1 = "598cd7c1f68d1e205689b1c2fe65a9f85846f297"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.12.0"

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
# ╟─d463796d-aa22-4db6-8208-3134a25f3225
# ╟─bb366d90-5e52-4538-be1e-8ac2658796dd
# ╟─435cef37-7d42-414c-b3cc-b75bbfe9aaac
# ╟─830c3960-bd4f-4d49-b82c-ca6f45039ac8
# ╠═eb8d5af0-aaef-11ef-273f-97eb2367b462
# ╟─33131771-f9c0-4b87-ac09-972c0527bbae
# ╟─6ae543d8-8d2b-4e25-8e32-dce715c55956
# ╟─0152995b-a85e-4889-93df-f70b250b18c5
# ╟─940bb398-8e67-445e-984d-86449e37dd25
# ╟─a12b6eba-34f8-4303-a167-144ce2475d6f
# ╟─b6706521-984d-4a27-8dc6-ca965c49dcfd
# ╟─76a9ba66-5de4-46b2-b1a4-78047bef193c
# ╟─ac652a13-e412-4ae0-84a7-40daea338fea
# ╟─796a1a9f-51cd-4bee-9c39-a64d910a5ff7
# ╠═5b0f5631-b8e6-4113-8abb-143730bcac7a
# ╟─ddd45378-7167-4513-b33c-95dac56580eb
# ╠═da02db52-0e05-424e-b0fc-b04960250eed
# ╠═a6cc0d61-783f-472d-b1f7-1db7168e92da
# ╟─2a737489-4e7d-45fa-aac2-ff952556c62d
# ╟─424ee484-a2a4-4064-a203-e828baa92c64
# ╠═7913ad51-bf6e-4cbb-bee6-c20f05e4cde2
# ╠═e07bf622-e92b-4880-8fa2-b7b24305502a
# ╠═fc1342b4-26dd-4797-a99e-a49f1345866e
# ╠═f94ce0e5-85ec-4dc7-b7c3-a2f1efd6adec
# ╟─025e7763-1382-48f8-a6c0-996da7147b5d
# ╠═b23b9ca9-d791-435d-9965-3ee739f9e306
# ╠═5dfcb8cd-e76f-40f8-829f-5abe703dc208
# ╠═a485c11a-cf12-4842-a4b0-faa82e8987ac
# ╠═41f78090-bb77-438d-8d2a-3aa0777eacb7
# ╟─3a4ccb0d-a015-442f-bf2e-2cf15ff98b71
# ╟─8e86d94e-babf-4918-ba5c-28e940d1476c
# ╠═e58ec3bd-ef45-4aa9-8cb3-6d81e7b11874
# ╠═b12fe9c6-204d-4d66-94b9-80637f180688
# ╠═20e6eb9d-d021-412c-9c92-f561c326c82d
# ╠═bd741d8a-3002-48c1-9466-62163cd3b4c3
# ╟─2eb56818-50ed-49af-b22e-08b46d81255c
# ╠═66e6a943-d640-49dc-bfc4-8e772e7fd5c7
# ╠═2a4efb94-6154-41db-85d4-800fa59cebdd
# ╠═012e06bd-6039-4957-807c-6d7719b1e8d8
# ╠═73f6056e-a69d-461c-80ac-3ccf5e0bae89
# ╟─ea1a3dba-7123-4574-ab1a-4da2c69d77bd
# ╟─b3b69c2e-cb53-40e1-86aa-c2b7fd5c3573
# ╠═2a804215-31d6-44f9-96a1-fbed7f20542b
# ╠═be662def-1b9b-4bd4-ba39-2d902f1c5149
# ╠═d03830ab-1438-4065-b20e-e5d98b47d13f
# ╠═17ae511b-f7d5-45ce-9d33-e139c0d6faaa
# ╠═733cb431-baba-4775-b288-e70e59a3481a
# ╠═554fc2a6-a03d-4b5f-9300-10feae688e95
# ╠═77ffc2cb-3b22-4c2d-b875-e592995365be
# ╟─1f458adc-5ca3-43e2-9d48-7f220e408306
# ╟─6b2acc48-ddb3-435f-bf0b-c4e87842da5d
# ╟─80e277ea-6b9f-474f-a2b5-61e404b16c52
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
