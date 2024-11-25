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

# ╔═╡ df80aeb7-8b77-4f87-b8b6-89eafe051e5c
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools, CommonMark, JSON
end

# ╔═╡ 18a748cf-1ca8-46ce-a764-feb73bfc4bd7
using Distributions, StatsBase, CSV, DataFrames

# ╔═╡ d282b7ab-de8b-4e8a-ae02-15340c27af7a
@htl("""
	<h1>Project 4 – Example</h1>
""")

# ╔═╡ 20ec53cd-19cc-4144-b39b-2ff49fe086bd
TableOfContents()

# ╔═╡ 8f9ea074-3659-4546-b9a9-67274476e5e1
md"""
###### My Name is: **The Modern Prometheus**
"""

# ╔═╡ 25903b7c-ef21-4e83-bd1a-5ea7684e445b
@htl("""
	<h5>These are the different packages being used for this project.</h5>
""")

# ╔═╡ 2f8f2ba9-a61b-445c-992d-5129c8c575d5
@htl("""
	<hr>
""")

# ╔═╡ 61d11b36-cf73-4360-ac02-9524f02e3e47
@htl("""
	<hr>
""")

# ╔═╡ ae5f4b20-3e21-4433-9e77-02f34dbd3ff1
# Answer the Questions
md"""

"""

# ╔═╡ c70bafad-599b-4413-881d-9578434225ca
@htl("""
	<hr>
""")

# ╔═╡ 88689c1e-a5c1-4408-84a9-a7da7d2e1a6a
md"""
This is not how you should load things. You should follow instructions. 📖
"""

# ╔═╡ e961841e-9d50-4f87-9571-a4889cb9e22c
My_Data_Frame = DataFrame(:"Some Measurement" => rand(Normal(10,5), 1000), :"Another Population Measurement" => rand(Normal(8, 7), 1000))

# ╔═╡ 37d9300c-0e29-4253-872a-35991b10f84c
@htl("""
	<hr>
""")

# ╔═╡ 92818b11-778b-4aa3-a7b5-a284e0d4a453
# Answer the Question
md"""

"""

# ╔═╡ da581905-3ec2-4dff-b2ea-7c6760b7bb25
# Define Column
My_Column = My_Data_Frame[!, "Some Measurement"]

# ╔═╡ fa890455-1e17-43af-a899-2de88b74ac26
# Define Tests:
begin
	# Test 1:
	My_First_Category_Data = filter(row -> (row."Another Population Measurement" < 2), My_Data_Frame)
	# Test 2:
	My_Second_Category_Data = filter(row -> ( 2 <= row."Another Population Measurement" < 5), My_Data_Frame)
	# Test 3:
	My_Third_Category_Data = filter(row -> (5 <= row."Another Population Measurement"), My_Data_Frame)
	# Test 4:
	# Oops, I chose bad tests!
	# More if Desired:
	
end;

# ╔═╡ e14c14f6-7905-4e3c-a964-d915ab6f7fd2
# Define Categories:
begin
	# Category 1:
	Category_1 = My_First_Category_Data[!, "Some Measurement"]
	# Category 2:
	Category_2 = My_Second_Category_Data[!, "Some Measurement"]
	# Category 3:
	Category_3 = My_Third_Category_Data[!, "Some Measurement"]
	# Category 4:
	# Yikes! I'm missing these!
	# More if Desired:
	
end;

# ╔═╡ 326304f6-02f1-4f23-a68b-53db32e76ecd
# Answer the Question
md"""
I should really rethink my choices!
"""

# ╔═╡ 4f6f635a-acf5-40e0-8b4a-62190c398f41
md"""
These don't seem great!
"""

# ╔═╡ 2bd40976-f43b-4b94-9c34-14a845a6a2e9
@htl("""
	<hr>
""")

# ╔═╡ 98208a9e-6ee8-4541-941f-6dfb6e695b54
X = Normal( mean( My_Column ), std( My_Column ) )

# ╔═╡ e955385c-a2de-4e0d-a795-0fb89205d4f0
# Answer the Questions
md"""
Whatever could this mean?
"""

# ╔═╡ 38d2de50-234b-48f3-9490-6ab28729e08d
@htl("""
	<hr>
""")

# ╔═╡ 6b02eef6-ce9b-4716-b40e-0c49033bc3f1
# Make your Category List
My_Categories = [ Category_1, Category_2, Category_3 ]

# ╔═╡ e6c404bb-9705-4776-b843-a52488585281
# Answer the Question
md"""
Even though the p-value is low, this doesn't seem great
"""

# ╔═╡ 8eeb6eb6-bd52-4d7e-8b6b-615120e761ea
@htl("""
	<hr>
""")

# ╔═╡ 7a64d8cc-1cc8-47e3-9412-ebe8e6ed40dd
@htl("""
	<h4>Probability Functions</h2>
	<h5>Hic Sunt Leones</h5>
""")

# ╔═╡ bcbc6fbc-da80-4e72-ab71-3f50cb0da9a8
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

# ╔═╡ 61f6e14a-3627-4e87-accd-10e6db8ab875
# ANOVA Histogram
ANOVA_histogram( My_Categories, bin_size=1 )

# ╔═╡ b34af5ff-6a22-4108-afc6-5911473b028b
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

# ╔═╡ b472ed34-7a0d-47f7-b6d0-755f79b3a51b
# ANOVA Table
ANOVA_table( My_Column, My_Categories )

# ╔═╡ b2dea5b1-67a0-4a97-b7c8-0bc465c492d6
@htl("""
	<h4>Chart Functions</h2>
	<h5>Hic Sunt Dracones</h5>
""")

# ╔═╡ 2003d77e-88b6-4154-ba6d-e61c492661bc
function box_plot(Data::AbstractVector{<:Real})
	local Box_UUID = "box-" * string(uuid1())

	local width_UUID = Box_UUID * "-width"
	local height_UUID = Box_UUID * "-height"
	local color_UUID = Box_UUID * "-color"
	local svg_UUID = Box_UUID * "-svg"
	local panel_UUID = Box_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = Box_UUID * "-body"
	local toggle_button_UUID = Box_UUID * "-toggle"
	local y_min_UUID = Box_UUID * "-y_min"
	local y_max_UUID = Box_UUID * "-y_max"

	return @htl("""
		<div id=$(Box_UUID)>
			<svg id=$(svg_UUID) width="300" height="400" viewBox="0 0 300 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Box Plot Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="300" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(color_UUID) style="color: hsla(132, 6%, 20%, 1);">Box Color: </label>
					<input type="color" id=$(color_UUID) value="#4682b4" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(y_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(y_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(y_max_UUID) style="margin: 10px; width: 80%;">
				</div>
			</div>
		</div>

		<script src="https://d3js.org/d3.v7.min.js"></script>

		<script>
			function drawBoxPlot() {
				let width = +document.getElementById($(width_UUID)).value;
				let height = +document.getElementById($(height_UUID)).value;
				let boxColor = document.getElementById($(color_UUID)).value;

				let y_min = document.getElementById($(y_min_UUID)).value;
				let y_max = document.getElementById($(y_max_UUID)).value;

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				const Data = $(Data).sort(d3.ascending);

				const q1 = d3.quantile(Data, 0.25);
				const median = d3.quantile(Data, 0.5);
				const q3 = d3.quantile(Data, 0.75);
				const iqr = q3 - q1;
				const min = Math.max(d3.min(Data), q1 - 1.5 * iqr);
				const max = Math.min(d3.max(Data), q3 + 1.5 * iqr);

				let xDomain = [0, 1];
				let yDomain = [Math.min(min, d3.min(Data)), Math.max(max, d3.max(Data))];

				if (y_min !== "") yDomain[0] = +y_min;
				if (y_max !== "") yDomain[1] = +y_max;

				let x = d3.scaleLinear()
					.domain(xDomain)
					.range([marginLeft, width - marginRight]);

				let y = d3.scaleLinear()
					.domain(yDomain)
					.range([height - marginBottom, marginTop]);

				let svg = d3.select('#' + $(svg_UUID));
				
				svg.selectAll("*").remove();
				
				svg.attr("width", width)
				   .attr("height", height)
				   .attr("viewBox", [0, 0, width, height])
				   .attr("style", "max-width: 100%; height: auto; background-color: white;");

				svg.append("rect")
					.attr("x", x(0.25))
					.attr("width", x(0.75) - x(0.25))
					.attr("y", y(q3))
					.attr("height", y(q1) - y(q3))
					.attr("fill", boxColor)
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", x(0.25))
					.attr("x2", x(0.75))
					.attr("y1", y(median))
					.attr("y2", y(median))
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", x(0.5))
					.attr("x2", x(0.5))
					.attr("y1", y(min))
					.attr("y2", y(q1))
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", x(0.5))
					.attr("x2", x(0.5))
					.attr("y1", y(max))
					.attr("y2", y(q3))
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", x(0.4))
					.attr("x2", x(0.6))
					.attr("y1", y(min))
					.attr("y2", y(min))
					.attr("stroke", "black");

				svg.append("line")
					.attr("x1", x(0.4))
					.attr("x2", x(0.6))
					.attr("y1", y(max))
					.attr("y2", y(max))
					.attr("stroke", "black");

				svg.append("g")
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(1).tickSizeOuter(0));

				svg.append("g")
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40));
			}

			drawBoxPlot();

			document.getElementById($(width_UUID)).addEventListener('input', drawBoxPlot);
			document.getElementById($(height_UUID)).addEventListener('input', drawBoxPlot);
			document.getElementById($(color_UUID)).addEventListener('input', drawBoxPlot);
			document.getElementById($(y_min_UUID)).addEventListener('input', drawBoxPlot);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawBoxPlot);

			dragElement(document.getElementById($(panel_UUID)));

			function dragElement(elmnt) {
				let pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
				if (document.getElementById($(panel_header_UUID))) {
					document.getElementById($(panel_header_UUID)).onmousedown = dragMouseDown;
				} else {
					elmnt.onmousedown = dragMouseDown;
				}

				function dragMouseDown(e) {
					e = e || window.event;
					e.preventDefault();
					pos3 = e.clientX;
					pos4 = e.clientY;
					document.onmouseup = closeDragElement;
					document.onmousemove = elementDrag;
				}

				function elementDrag(e) {
					e = e || window.event;
					e.preventDefault();
					pos1 = pos3 - e.clientX;
					pos2 = pos4 - e.clientY;
					pos3 = e.clientX;
					pos4 = e.clientY;
					elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
					elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
				}

				function closeDragElement() {
					document.onmouseup = null;
					document.onmousemove = null;
				}
			}

			let isPanelOpen = false;
			const panelBody = document.getElementById($(panel_body_UUID));
			const toggleButton = document.getElementById($(toggle_button_UUID));

			panelBody.style.height = "0px";
			panelBody.style.opacity = 0;
			toggleButton.innerHTML = '&#x25C0;';

			document.getElementById($(toggle_button_UUID)).addEventListener('click', function() {
				if (isPanelOpen) {
					panelBody.style.height = "0px";
					panelBody.style.opacity = 0;
					toggleButton.innerHTML = '&#x25C0;';
				} else {
					panelBody.style.height = "auto";
					panelBody.style.opacity = 1;
					toggleButton.innerHTML = '&#x25BC;';
				}

				isPanelOpen = !isPanelOpen;
			});
		</script>
	""")
end

# ╔═╡ 27119be8-c0c6-4ffa-b1d5-3a537d1c906e
function box_plot(Datas::AbstractVector{<:Real}...)
	local Box_UUID = "box-" * string(uuid1())

	local width_UUID = Box_UUID * "-width"
	local height_UUID = Box_UUID * "-height"
	local color_UUIDs = [Box_UUID * "-color-" * string(i) for i in 1:length(Datas)]
	local svg_UUID = Box_UUID * "-svg"
	local panel_UUID = Box_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = Box_UUID * "-body"
	local toggle_button_UUID = Box_UUID * "-toggle"
	local y_min_UUID = Box_UUID * "-y_min"
	local y_max_UUID = Box_UUID * "-y_max"

	local color_pickers_html = [@htl("""
		<br>
		<label style="color: hsla(132, 6%, 20%, 1);">Data Set $(i) Color: </label>
		<input type="color" id=$(color_UUIDs[i]) style="margin: 10px; width: 90%;">
	""") for i in 1:length(Datas)]

	return @htl("""
		<div id=$(Box_UUID)>
			<svg id=$(svg_UUID) width="500" height="400" viewBox="0 0 500 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Box Plots Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="500" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					$(color_pickers_html...)

					<br>

					<label for=$(y_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(y_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(y_max_UUID) style="margin: 10px; width: 80%;">
				</div>
			</div>
		</div>

		<script src="https://d3js.org/d3.v7.min.js"></script>

		<script>
			function drawBoxPlot() {
				let width = +document.getElementById($(width_UUID)).value;
				let height = +document.getElementById($(height_UUID)).value;

				let colors = [];
				let colorInterpolator = d3.interpolateRgbBasis(d3.schemeCategory10);
				for (let i = 0; i < $(length(Datas)); i++) {
					let colorPicker = document.getElementById($(color_UUIDs)[i]);
					if (!colorPicker.dataset.initialized) {
						let interpolatedColor = colorInterpolator(i / ($(length(Datas)) - 1));
						let rgbColor = /^rgb\\((\\d+),\\s*(\\d+),\\s*(\\d+)\\)\$/.exec(interpolatedColor);
						let hexColor = "#" + ((1 << 24) + (parseInt(rgbColor[1]) << 16) + (parseInt(rgbColor[2]) << 8) + parseInt(rgbColor[3])).toString(16).slice(1).toUpperCase();
						colorPicker.value = hexColor;
        				colorPicker.dataset.initialized = "true";
				    }
				    colors.push(colorPicker.value);
				}
	
				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;
				const boxWidth = (width - marginLeft - marginRight) / $(length(Datas));

				let y_min = document.getElementById($(y_min_UUID)).value;
				let y_max = document.getElementById($(y_max_UUID)).value;

				let svg = d3.select('#' + $(svg_UUID));
				svg.selectAll("*").remove();
				svg.attr("width", width)
				   .attr("height", height)
				   .attr("viewBox", [0, 0, width, height])
				   .attr("style", "max-width: 100%; height: auto; background-color: white;");

				let yDomain = [
					d3.min($(Datas), data => d3.min(data)),
					d3.max($(Datas), data => d3.max(data))
				];

				if (y_min !== "") yDomain[0] = +y_min;
				if (y_max !== "") yDomain[1] = +y_max;

				let y = d3.scaleLinear()
					.domain(yDomain)
					.range([height - marginBottom, marginTop]);

				for (let i = 0; i < $(length(Datas)); i++) {
					let Data = $(Datas)[i].sort(d3.ascending);

					const q1 = d3.quantile(Data, 0.25);
					const median = d3.quantile(Data, 0.5);
					const q3 = d3.quantile(Data, 0.75);
					const iqr = q3 - q1;
					const min = Math.max(d3.min(Data), q1 - 1.5 * iqr);
					const max = Math.min(d3.max(Data), q3 + 1.5 * iqr);

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
			}

			drawBoxPlot();

			document.getElementById($(width_UUID)).addEventListener('input', drawBoxPlot);
			document.getElementById($(height_UUID)).addEventListener('input', drawBoxPlot);
			for (let i = 0; i < $(length(Datas)); i++) {
				document.getElementById($(color_UUIDs)[i]).addEventListener('input', drawBoxPlot);
			}
			document.getElementById($(y_min_UUID)).addEventListener('input', drawBoxPlot);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawBoxPlot);

			dragElement(document.getElementById($(panel_UUID)));

			function dragElement(elmnt) {
				let pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
				if (document.getElementById($(panel_header_UUID))) {
					document.getElementById($(panel_header_UUID)).onmousedown = dragMouseDown;
				} else {
					elmnt.onmousedown = dragMouseDown;
				}

				function dragMouseDown(e) {
					e = e || window.event;
					e.preventDefault();
					pos3 = e.clientX;
					pos4 = e.clientY;
					document.onmouseup = closeDragElement;
					document.onmousemove = elementDrag;
				}

				function elementDrag(e) {
					e = e || window.event;
					e.preventDefault();
					pos1 = pos3 - e.clientX;
					pos2 = pos4 - e.clientY;
					pos3 = e.clientX;
					pos4 = e.clientY;
					elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
					elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
				}

				function closeDragElement() {
					document.onmouseup = null;
					document.onmousemove = null;
				}
			}

			let isPanelOpen = false;
			const panelBody = document.getElementById($(panel_body_UUID));
			const toggleButton = document.getElementById($(toggle_button_UUID));

			panelBody.style.height = "0px";
			panelBody.style.opacity = 0;
			toggleButton.innerHTML = '&#x25C0;';

			document.getElementById($(toggle_button_UUID)).addEventListener('click', function() {
				if (isPanelOpen) {
					panelBody.style.height = "0px";
					panelBody.style.opacity = 0;
					toggleButton.innerHTML = '&#x25C0;';
				} else {
					panelBody.style.height = "auto";
					panelBody.style.opacity = 1;
					toggleButton.innerHTML = '&#x25BC;';
				}

				isPanelOpen = !isPanelOpen;
			});
		</script>
	""")
end

# ╔═╡ d0e9afb4-280f-4799-92eb-804d673dd063
# Box Plot
box_plot( Category_1, Category_2, Category_3 ) # I'm missing some categories!

# ╔═╡ 619fd42a-81d9-42d9-804d-adc04f764384
function histogram(data::AbstractVector{<:Real}; bin_size=5)
	local plot_uuid = "Plot-"*string(uuid1())
	local x_min = min(data...)
	local x_max = max(data...)
	local x_vals = collect((x_min - 1):0.001:(x_max + 1))
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace = {
			  x: $(data),
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
			
			var data = [ trace ];

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

				colorway: ['steelblue']

			};
			
			Plotly.newPlot($(plot_uuid), data, layout, {modeBarButtonsToRemove: ['toImage'], displaylogo: false});
		</script>
	""")
end

# ╔═╡ 9ed78c68-ed7d-4c64-801a-74b7e362f952
function histogram(data::AbstractVector{<:Real}, X::UnivariateDistribution ; bin_size=5)
	local plot_uuid = "Plot-"*string(uuid1())
	local x_min = min(data...)
	local x_max = max(data...)
	local x_vals = collect((x_min - 1):0.001:(x_max + 1))
	local probs = pdf.(X, x_vals)
	@htl("""
		<div id=$(plot_uuid)></div>
		<script src="https://cdn.plot.ly/plotly-2.35.2.min.js" charset="utf-8"></script>
		<script>

			var trace1 = {
			  x: $(data),
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

# ╔═╡ 7eb94858-da3d-46f8-a36b-56d4a57d439c
# Plot the Histogram
histogram( My_Column, X )

# ╔═╡ 781dbde7-82d8-4442-82dd-f39eced2f350
@htl("""
	<hr>
""")

# ╔═╡ 18ca710f-4561-43e1-84b5-55909d981e66
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

# ╔═╡ 602d2646-2e7b-4841-9e1e-30fc584275e1
function chi_square(data::AbstractVector{<:Real}, X::UnivariateDistribution ; num_bins=30)
	local x_min = min(data...)
	local x_max = max(data...)
	local bin_size = ( x_max - x_min ) / num_bins
	local bins = [ ( x_min + (i-1) * bin_size , x_min + i * bin_size ) for i in 1:num_bins ]
	local data_counts = [ length( filter( x -> ab[1] ≤ x ≤ ab[2] , data ) ) for ab in bins ]
	local expected_counts = [length(data) * (cdf(X, ab[2]) - cdf(X, ab[1])) for ab in bins]

	local test_statistic = sum([(data_counts[i] - expected_counts[i])^2 / expected_counts[i] for i in 1:num_bins])

	return @htl("""
		<h5>There was a Test Statistic of $( isa(test_statistic, Number) ? round(test_statistic, digits=4) : "Infinity" ) with $(lmd("``p``"))–value of $(round(ccdf(X, test_statistic), sigdigits=4))</h5>
	""")
end

# ╔═╡ 7c28f7f5-3b3f-4281-9a97-ecc4f885fd50
# Compute the Test Statistic and p–Value
chi_square( My_Column, X )

# ╔═╡ 279fc358-71ce-491f-9ef8-3955af2a0f40
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
end;

# ╔═╡ 2b828c8b-d6f8-4433-b0dc-de37b03fe6ce
@htl("""
	$(stop_box("Remember to click **[ctrl]** + M to be able to enter text in a cell, and please hit **[shift]** + **[enter]** to save your work in a cell. You can also click **[ctrl]** + **[S]** to save all cells."))
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Foldable("Expand to see what the colors mean", @htl("""
			$(note_box("This is Background or Advice"))
			<br>
			$(go_box("This is a Question or Instruction"))
			<br>
			$(caution_box("This is a Description"))
			<br>
			$(stop_box("This is an Important Warning"))
		""")))
	</div>
""")

# ╔═╡ c3c39353-7aeb-425f-afc7-8e4f46907df8
note_box("The goal of this project is to use a real world dataset and apply the statistical knowledge that you have learned so far throughout the semester to interpret and tell a story about the data. Your goal is to try to describe the data and convince me that the conclusions you are making are true by backing up your arguments with data. For all of your answers, make sure to give full justification/reasoning.")

# ╔═╡ 537980b6-4394-40e8-a7b5-28ca177dd259
@htl("""
	$(go_box("Task 1 – Choosing", "Search for a dataset about which you are interested and download the **CSV** file for this dataset. You will be interpreting and making hypotheses about this dataset, so please make sure the dataset is interesting to you."))
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Foldable("Expand to see Recommended Sources for Finding Data", commonmark_parser("
Some sources are:
* [Data.gov](https://catalog.data.gov/dataset/?res_format=CSV)
* [Stats NZ](https://www.stats.govt.nz/large-datasets/csv-files-for-download/)
* [Kaggle](https://www.kaggle.com/datasets?fileType=csv&minUsabilityRating=10.00) — In order to download from here, you need to create an account
\n
Feel free to find a dataset from somewhere else, just make sure you know what the data means!
		")))
	</div>
	$(stop_box("
Some Requirements:
* Your dataset must have **at least** one hundred rows of data. Ideally, you should have a few thousand entries.
* In this project, you will be comparing different categories from your dataset. For this purpose, you must have a numeric column that you can break up into at least **four \"reasonable\"** demographic categories. For example, if your dataset is made up of information about every college in America, and you want to study the column that contains information about their average tuition price, you could break this up by state to look at how the price varies by states. You could also break this up by average SAT requirement between some thresholds, retention rate, or into any other \"reasonable\" categories.

"))
<br>
$(go_box("Explain why you are choosing this dataset, what the entries you plan to study mean, and what you might hope to learn from this data."))
""")

# ╔═╡ 3a219b5f-13f4-4644-a927-50a1111adba5
@htl("""
	$(go_box("Task 2 – Loading CSV", "Find your downloaded CSV file using the File Picker below. Depending on how large of a file it is, this may take a few minutes to load."))
	<br>
	<div style="margin: auto; width:80%;">
		$(@bindname My_CSV FilePicker([MIME("text/csv")]))
	</div>
	<br>
	$(go_box("Once loaded, run the following line to get your data into a Data Frame that Julia can work with."))
	<br>
	<div>
		$(Markdown.parse("""
		```julia
		My_Data_Frame = UInt8.(My_CSV["data"]) |> IOBuffer |> CSV.File |> DataFrame |> dropmissing
		```
		"""))
	</div>
	<br>
	$(stop_box("If you refresh the page or close out of Julia, you may see some errors and need to upload your CSV again to remind Julia what your data is."))
""")

# ╔═╡ 2662ef6d-341e-4b3e-ae47-0f696b78a3d6
@htl("""
	$(go_box("Task 3 – Loading Columns", "Explain what column you wish to study and into what categories you plan to break this up. Make sure to explain why you are interested in this column of data and why it is interesting to study."))
""")

# ╔═╡ 4b00ef53-7bbd-453c-99ce-282eba986e49
@htl("""
	$(go_box("First define the numeric column that you wish to study. You can do this using the following:"))
	<br>
	<div>
		$(Markdown.parse("""
		```julia
		My_Column = My_Data_Frame[!, #== Column's Name ==#]
		```
		"""))
	</div>
""")

# ╔═╡ 73596738-2f47-4c76-a95f-a79123ab9acf
@htl("""
	$(go_box("Define all of the categories that you wish to study. You can do this in two steps for each categories."))
	<br>
	<div>
		<h5>First Step:</h5>
		$(Markdown.parse("""
		```julia
		My_First_Category_Data = filter(row -> (#== Test for First Category Here ==#), My_Data_Frame)
		```
		"""))
	</div>
	<br>
	<div>
		<h5>Second Step:</h5>
		$(Markdown.parse("""
		```julia
		Category_1 = filter(x -> isa(x, Number), My_First_Category_Data[!, #== Column's Name ==#])
		```
		"""))
	</div>
	<br>
	$(go_box("Make sure to repeat these two steps for all of your categories (i.e., My_Second_Category_Data, Category_2, etc.). Your categories must combine to contain everything from your chosen column."))
""")

# ╔═╡ ecbbdfb4-7b42-4aa0-b9b2-439a8a1900af
go_box("Explain what conditions you are using to break up your data and why it is interesting to break them up this way. This means you should have some reason for wanting to compare these different group, it should not be completely arbitrary.")

# ╔═╡ bf1bdd71-4d12-4293-8448-d673f6919d45
@htl("""
	$(go_box("Plot a box–plot of your categories. If there is \"too much\" overlap, you won't have interesting results. Try to make these as separated as possible while still covering all of the data."))
	<br>
	<div>
		$(Markdown.parse("""
		```julia
		box_plot(Category_1, Category_2, Category_3, Category_4, #== Continue if Necessary ==#)
		```
		"""))
	</div>
""")

# ╔═╡ 5d5c4de2-b438-412e-b629-e43ade70f420
@htl("""
	$(go_box("Task 4 – Check for Normality", "Using a ``\\chi^2``–Test, check how close to normal your column of data is by:
* Plotting a Histogram and Normal Distribution
* Computing the ``p``–value for the ``\\chi^2``–Distribution
"))
""")

# ╔═╡ 00171511-5841-4ab1-b1b9-581558adaf04
@htl("""
	<div>
		<h5>Histogram:</h5>
		$(Markdown.parse("""
		```julia
		X = Normal( mean( My_Column ), std( My_Column ) )
		```
		"""))
		<br>
		$(Markdown.parse("""
		```julia
		histogram( My_Column, X )
		```
		"""))
	</div>
	<br>
	<div>
		<h5>Test Statistic</h5>
		$(Markdown.parse("""
		```julia
		chi_square( My_Column, X )
		```
		"""))
	</div>
	<br>
	$(go_box("Decide whether to reject or accept the Null Hypothesis:
```math  
H_0 : \\text{ The Data comes from a Normal Distribution }
```  
Using ``\\alpha = 0.05``. Make sure to interpret what this means in terms of your data. In particular, based off of your test statistic and ``p``–value, how close to Normal do you think your data is?"))
""")

# ╔═╡ 6344f10b-63f6-4452-b161-750dbbab0dbe
@htl("""
	$(go_box("Task 5 – ANOVA", "Are your categories a *\"good\"* decomposition of your data? Test this by performing an ANOVA calculation."))
	<br>
	<div>
		$(Markdown.parse("""
		```julia
		My_Categories = [ Category_1, Category_2, Category_3, Category_4, #== Continue if Necessary ==#]
		```
		"""))
	</div>
	<br>
	<div>
		$(Markdown.parse("""
		```julia
		ANOVA_histogram( My_Categories, bin_size= #== Choose a Width ==# )
		```
		"""))
	</div>
	<br>
	<div>
		$(Markdown.parse("""
		```julia
		ANOVA_table( My_Column, My_Categories )
		```
		"""))
	</div>
""")

# ╔═╡ 8398b85d-9530-4292-be53-54a9852e2e9b
go_box("Are your categories a *\"good\"* decomposition? Do they really explain why your data is distributed the way that it is? How could you make better categories? What extra information would you need to be better? What does this decomposition tell you about the real–world collection of data?")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
CSV = "~0.10.15"
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
project_hash = "e6b2f217e3d33dd11647d67355f52bd76691a190"

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

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "deddd8725e5e1cc49ee205a1964256043720a6c3"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.15"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "7eee164f122511d3e4e1ebadb7956939ea7e1c77"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.6"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "bce6804e5e6044c6daab27bb533d1295e4a2e759"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.6"

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

[[deps.FilePathsBase]]
deps = ["Compat", "Dates"]
git-tree-sha1 = "7878ff7172a8e6beedd1dea14bd27c3c6340d361"
uuid = "48062228-2e41-5def-b9a4-89aafe57970f"
version = "0.9.22"
weakdeps = ["Mmap", "Test"]

    [deps.FilePathsBase.extensions]
    FilePathsBaseMmapExt = "Mmap"
    FilePathsBaseTestExt = "Test"

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

[[deps.TranscodingStreams]]
git-tree-sha1 = "0c45878dcfdcfa8480052b6ab162cdd138781742"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.3"

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

[[deps.WeakRefStrings]]
deps = ["DataAPI", "InlineStrings", "Parsers"]
git-tree-sha1 = "b1be2855ed9ed8eac54e5caff2afcdb442d52c23"
uuid = "ea10d353-3f73-51f8-a26c-33c1cb351aa5"
version = "1.4.2"

[[deps.WorkerUtilities]]
git-tree-sha1 = "cd1659ba0d57b71a464a29e64dbc67cfe83d54e7"
uuid = "76eceee3-57b5-4d4a-8e66-0e911cebbf60"
version = "1.6.1"

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
# ╟─df80aeb7-8b77-4f87-b8b6-89eafe051e5c
# ╟─d282b7ab-de8b-4e8a-ae02-15340c27af7a
# ╟─20ec53cd-19cc-4144-b39b-2ff49fe086bd
# ╠═8f9ea074-3659-4546-b9a9-67274476e5e1
# ╟─2b828c8b-d6f8-4433-b0dc-de37b03fe6ce
# ╟─25903b7c-ef21-4e83-bd1a-5ea7684e445b
# ╠═18a748cf-1ca8-46ce-a764-feb73bfc4bd7
# ╟─2f8f2ba9-a61b-445c-992d-5129c8c575d5
# ╟─c3c39353-7aeb-425f-afc7-8e4f46907df8
# ╟─61d11b36-cf73-4360-ac02-9524f02e3e47
# ╟─537980b6-4394-40e8-a7b5-28ca177dd259
# ╠═ae5f4b20-3e21-4433-9e77-02f34dbd3ff1
# ╟─c70bafad-599b-4413-881d-9578434225ca
# ╟─3a219b5f-13f4-4644-a927-50a1111adba5
# ╠═88689c1e-a5c1-4408-84a9-a7da7d2e1a6a
# ╠═e961841e-9d50-4f87-9571-a4889cb9e22c
# ╟─37d9300c-0e29-4253-872a-35991b10f84c
# ╟─2662ef6d-341e-4b3e-ae47-0f696b78a3d6
# ╠═92818b11-778b-4aa3-a7b5-a284e0d4a453
# ╟─4b00ef53-7bbd-453c-99ce-282eba986e49
# ╠═da581905-3ec2-4dff-b2ea-7c6760b7bb25
# ╟─73596738-2f47-4c76-a95f-a79123ab9acf
# ╠═fa890455-1e17-43af-a899-2de88b74ac26
# ╠═e14c14f6-7905-4e3c-a964-d915ab6f7fd2
# ╟─ecbbdfb4-7b42-4aa0-b9b2-439a8a1900af
# ╠═326304f6-02f1-4f23-a68b-53db32e76ecd
# ╟─bf1bdd71-4d12-4293-8448-d673f6919d45
# ╠═d0e9afb4-280f-4799-92eb-804d673dd063
# ╠═4f6f635a-acf5-40e0-8b4a-62190c398f41
# ╟─2bd40976-f43b-4b94-9c34-14a845a6a2e9
# ╟─5d5c4de2-b438-412e-b629-e43ade70f420
# ╟─00171511-5841-4ab1-b1b9-581558adaf04
# ╠═98208a9e-6ee8-4541-941f-6dfb6e695b54
# ╠═7eb94858-da3d-46f8-a36b-56d4a57d439c
# ╠═7c28f7f5-3b3f-4281-9a97-ecc4f885fd50
# ╠═e955385c-a2de-4e0d-a795-0fb89205d4f0
# ╟─38d2de50-234b-48f3-9490-6ab28729e08d
# ╟─6344f10b-63f6-4452-b161-750dbbab0dbe
# ╠═6b02eef6-ce9b-4716-b40e-0c49033bc3f1
# ╠═61f6e14a-3627-4e87-accd-10e6db8ab875
# ╟─b472ed34-7a0d-47f7-b6d0-755f79b3a51b
# ╟─8398b85d-9530-4292-be53-54a9852e2e9b
# ╠═e6c404bb-9705-4776-b843-a52488585281
# ╟─8eeb6eb6-bd52-4d7e-8b6b-615120e761ea
# ╟─7a64d8cc-1cc8-47e3-9412-ebe8e6ed40dd
# ╟─602d2646-2e7b-4841-9e1e-30fc584275e1
# ╟─bcbc6fbc-da80-4e72-ab71-3f50cb0da9a8
# ╟─b34af5ff-6a22-4108-afc6-5911473b028b
# ╟─b2dea5b1-67a0-4a97-b7c8-0bc465c492d6
# ╟─2003d77e-88b6-4154-ba6d-e61c492661bc
# ╟─27119be8-c0c6-4ffa-b1d5-3a537d1c906e
# ╟─619fd42a-81d9-42d9-804d-adc04f764384
# ╟─9ed78c68-ed7d-4c64-801a-74b7e362f952
# ╟─781dbde7-82d8-4442-82dd-f39eced2f350
# ╟─279fc358-71ce-491f-9ef8-3955af2a0f40
# ╟─18ca710f-4561-43e1-84b5-55909d981e66
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
