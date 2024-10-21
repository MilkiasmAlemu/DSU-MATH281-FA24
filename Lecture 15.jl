### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# ╔═╡ c76a0f7d-df83-42d3-ba39-ba95dcd9f0a2
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools
end

# ╔═╡ f1b21760-8f54-11ef-2065-c56eed7e1189
using LsqFit, Random, RDatasets

# ╔═╡ da245bc3-faa2-4c12-85f2-02384289091c
@htl("""
	<head>
		<script src="https://d3js.org/d3.v7.min.js"></script>
	</head>
	<h1>Lecture 15</h1>
""")

# ╔═╡ 7f888dc9-fb10-400e-8aea-84dc3ef13468
TableOfContents()

# ╔═╡ 9a91db02-de9b-46ba-8acf-87fdfad98d44
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ a96dc249-4e2b-4747-b516-83ef4e0539eb
@htl("""
	<hr>
""")

# ╔═╡ e1cd5309-4db3-4baf-a633-16e7b57f3694
@htl("""
	<h2>Gravity</h2>
""")

# ╔═╡ 253ebaec-c7e0-4a43-906e-ec2c035b2e95
quadratic_model(t, p) = @. p[1] * t^2 + p[2] * t + p[3]

# ╔═╡ 1dd00b2a-4c4d-4609-ba08-a4ff77629761
gravity_guess_parameters = [-1.0, 2.0, 125.0]

# ╔═╡ 9ec13a48-7e19-415b-91e2-d436546ccede
begin
	drop_times = [collect(0.0:5.0) for i in 1:10]
	drop_time_data = vcat(drop_times...)
	distances = (trial -> trial .|> t -> (-1/2)*9.812*t^2+125 - t * rand(0:0.01:1) |> x -> x > 0 ? x : 0).(drop_times)
	distances_data = vcat(distances...)
	grouped_gravity = collect(zip(drop_times, distances))
end;

# ╔═╡ d07bf30b-56c1-4814-8042-16b7d32a2617
drop_times

# ╔═╡ 68ead0ca-42c5-4321-9553-3857ee3115c0
drop_time_data

# ╔═╡ 4b4d442c-96ea-4350-9c0e-b7c7769bc62b
distances

# ╔═╡ bf1f78ba-a424-4eff-9f40-10ad932b9189
distances_data

# ╔═╡ e8363773-a141-4edc-a8e2-e0b1ac4e8833
grouped_gravity

# ╔═╡ 4ace9406-3135-4cbb-9da9-152cc7b1b09a
gravity_fit = curve_fit(quadratic_model, drop_time_data, distances_data, gravity_guess_parameters)

# ╔═╡ 78b1cb39-8f93-405a-9a88-3e6115353777
gravity_function(t) = quadratic_model(t, gravity_fit.param)

# ╔═╡ dd6be3a4-8879-424a-959c-6fc5539e7235
@htl("""
	<hr>
""")

# ╔═╡ edbfcf6f-8212-4e16-b8d0-80fe96adfb39
@htl("""
	<h2>Exponential Decay</h2>
""")

# ╔═╡ ba109fdf-8d88-421f-b15d-79e831cd5ca9
exponential_model(t, p) = @. p[1] * (1 / 2)^(t / p[2])

# ╔═╡ cad65584-c7f9-4180-a58d-f0507c36f9c1
decay_guess_parameters = [1000.0, 1.0]

# ╔═╡ ab79c49f-44c8-4bb6-899b-7557fc2c7f2f
begin
	measure_times = [[j + rand() for j in 0:50] for i in 1:10]
	measure_time_data = vcat(measure_times...)
	masses = (trial -> trial .|> t -> 1000 * (1/2)^(t / 25) - sqrt(t) * rand(0:0.1:4) |> x -> x > 0 ? x : 0).(measure_times)
	mass_data = vcat(masses...)
	grouped_decay = collect(zip(measure_times, masses))
end;

# ╔═╡ 2931226d-92dc-4314-aee0-a96acc31c93e
measure_times

# ╔═╡ ebb22cac-7000-4a22-b780-bafec8d30c42
measure_time_data

# ╔═╡ 921b4fe1-c09d-4906-bed0-c160e49d5b10
masses

# ╔═╡ a093dac7-796b-4fdd-bd0e-bdfed87bae2d
mass_data

# ╔═╡ d4eba482-702f-4139-b520-9cb236736e2d
grouped_decay

# ╔═╡ 9e6387c4-c09a-4883-8118-54a570afdc2a
decay_fit = curve_fit(exponential_model, measure_time_data, mass_data, decay_guess_parameters)

# ╔═╡ 03d973c1-a8e2-4647-8155-13b2a95b2325
decay_function(t) = exponential_model(t, decay_fit.param)

# ╔═╡ dacecec4-c143-4c4d-bfde-4bd9ff3f46d9
@htl("""
	<hr>
""")

# ╔═╡ 732f0417-e87b-4609-9c26-88b13273bea2
@htl("""
	<h2>Heights and Weights</h2>
""")

# ╔═╡ e96096e4-5be2-4f18-88db-afa5a1d6632e
linear_model(t, p) = @. p[1] * t + p[2]

# ╔═╡ 0bc56c85-e564-4304-b09b-190121fc64cf
cubic_model(t, p) = @. p[1] * t^3 + p[2] * t^2 + p[3] * t + p[4]

# ╔═╡ 19fa37d2-3899-4bf3-a403-0b3fb120c360
logarithmic_model(t, p) = @. p[1] * log(abs(t + p[2])) + p[3]

# ╔═╡ 24bb44a9-37cd-44f1-993d-c2fa63a89a7d
radical_model(t, p) = @. p[1] * (abs(t))^(p[2]) + p[3]

# ╔═╡ a52c08d0-0322-40af-9531-7695ced309a3
begin
	HeightsAndWeights = dropmissing(RDatasets.dataset("car", "Davis"))
	height_data = filter(x -> x > 60, HeightsAndWeights.Height)
	weight_data = filter(x -> x < 150, HeightsAndWeights.Weight)
	grouped_measurements = (weight_data, height_data)
end;

# ╔═╡ 23fdb757-1283-4401-aee9-0efb6fbcc678
height_data

# ╔═╡ 4e5e35a4-7239-44d2-974e-3fb32be9454f
weight_data

# ╔═╡ 7bf9060a-6a4e-48ae-98ff-a732f327a65f
grouped_measurements

# ╔═╡ e9ab6747-e48e-4eab-b911-f25b8dda4633
linear_fit = curve_fit(linear_model, weight_data, height_data, [10.0, 10.0])

# ╔═╡ 6f8a6cee-c8ff-4091-98c8-38f9c72cee7b
linear_function(t) = linear_model(t, linear_fit.param)

# ╔═╡ 7bef17e5-07bd-4fc1-a067-aa16fe0d9fb8
cubic_fit = curve_fit(cubic_model, weight_data, height_data, [10.0, 10.0, 10.0, 10.0])

# ╔═╡ a6c1b42d-67b4-469e-8ab5-4dc4594e357c
cubic_function(t) = cubic_model(t, cubic_fit.param)

# ╔═╡ 005831e2-62b6-4f70-8e15-2f15bb09039f
logarithmic_fit = curve_fit(logarithmic_model, weight_data, height_data, [10.0, 10.0, 10.0])

# ╔═╡ dba611b7-17ac-4dc3-ab73-6278e0fc0252
logarithmic_function(t) = logarithmic_model(t, logarithmic_fit.param)

# ╔═╡ 0f27095e-4a0a-49d7-92eb-f031e9d19e89
radical_fit = curve_fit(radical_model, weight_data, height_data, [10.0, 1.0, 10.0])

# ╔═╡ 1a7f61f7-e0cc-48a7-9ebc-7ddefadc1360
radical_function(t) = radical_model(t, radical_fit.param)

# ╔═╡ 354a23e0-8f93-4d87-8248-feba176cc3c0
@htl("""
	<hr>
""")

# ╔═╡ 8243a11f-ce9b-4eb7-923a-f185c9c997ea
function scatter_plot(Data::Tuple{AbstractVector{<:Real}, AbstractVector{<:Real}})
	local Scatter_UUID = "scatter-" * string(uuid1())

	local width_UUID = Scatter_UUID * "-width"
	local height_UUID = Scatter_UUID * "-height"
	local color_UUID = Scatter_UUID * "-color"
	local x_min_UUID = Scatter_UUID * "-x_min"
	local x_max_UUID = Scatter_UUID * "-x_max"
	local y_min_UUID = Scatter_UUID * "-y_min"
	local y_max_UUID = Scatter_UUID * "-y_max"
	local svg_UUID = Scatter_UUID * "-svg"
	local panel_UUID = Scatter_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = Scatter_UUID * "-body"
	local toggle_button_UUID = Scatter_UUID * "-toggle"

	return @htl("""
		<div id=$(Scatter_UUID)>
			<svg id=$(svg_UUID) width="400" height="400" viewBox="0 0 300 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Scatter Plot Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="400" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(color_UUID) style="color: hsla(132, 6%, 20%, 1);">Point Color: </label>
					<input type="color" id=$(color_UUID) value="#4682b4" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(x_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(x_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(x_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(x_max_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_min_UUID) style="color: hsla(132, 6%, 20%, 1);">Y Min: </label>
					<input type="number" id=$(y_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_max_UUID) style="color: hsla(132, 6%, 20%, 1);">Y Max: </label>
					<input type="number" id=$(y_max_UUID) style="margin: 10px; width: 80%;">

				</div>
			</div>
		</div>

		<script>
			if (typeof d3 === 'undefined') {
			    var script = document.createElement('script');
			    script.src = "https://d3js.org/d3.v7.min.js";
			    document.head.appendChild(script);
			}

			function drawScatterPlot() {
				let width = +document.getElementById($(width_UUID)).value;
				let height = +document.getElementById($(height_UUID)).value;
				let pointColor = document.getElementById($(color_UUID)).value;

				let x_min = document.getElementById($(x_min_UUID)).value;
				let x_max = document.getElementById($(x_max_UUID)).value;
				let y_min = document.getElementById($(y_min_UUID)).value;
				let y_max = document.getElementById($(y_max_UUID)).value;

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				const xData = $(Data[1]);
				const yData = $(Data[2]);

				let xDomain = [d3.min(xData), d3.max(xData)];
				let yDomain = [d3.min(yData), d3.max(yData)];

				if (x_min !== "") xDomain[0] = +x_min;
				if (x_max !== "") xDomain[1] = +x_max;
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

				svg.append("g")
					.selectAll("circle")
					.data(xData.map((d, i) => ({ x: d, y: yData[i] })))
					.enter()
					.append("circle")
					.attr("cx", d => x(d.x))
					.attr("cy", d => y(d.y))
					.attr("r", 4)
					.attr("fill", pointColor)
					.attr("opacity", 0.75);

				svg.append("g")
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0));

				svg.append("g")
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40));
			}

			drawScatterPlot();

			document.getElementById($(width_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(height_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(color_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(x_min_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(x_max_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(y_min_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawScatterPlot);

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

# ╔═╡ 37e16a0e-7a3e-41bc-a029-4280897aefe6
function scatter_plot(Datas::Tuple{AbstractVector{<:Real}, AbstractVector{<:Real}}...)
	local Scatter_UUID = "scatter-" * string(uuid1())

	local width_UUID = Scatter_UUID * "-width"
	local height_UUID = Scatter_UUID * "-height"
	local color_UUIDs = [Scatter_UUID * "-color-" * string(i) for i in 1:length(Datas)]
	local svg_UUID = Scatter_UUID * "-svg"
	local panel_UUID = Scatter_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = Scatter_UUID * "-body"
	local toggle_button_UUID = Scatter_UUID * "-toggle"
	local color_header_UUID = Scatter_UUID * "-color-header"
	local color_body_UUID = Scatter_UUID * "-color-body"
	local color_toggle_button_UUID = Scatter_UUID * "-color-toggle"
	local x_min_UUID = Scatter_UUID * "-x_min"
	local x_max_UUID = Scatter_UUID * "-x_max"
	local y_min_UUID = Scatter_UUID * "-y_min"
	local y_max_UUID = Scatter_UUID * "-y_max"

	local color_pickers_html = [@htl("""
		<label style="color: hsla(132, 6%, 20%, 1);">Data Set $(i) Color: </label>
		<input type="color" id=$(color_UUIDs[i]) style="margin: 10px; width: 90%;">
		<br>
	""") for i in 1:length(Datas)]

	return @htl("""
		<div id=$(Scatter_UUID)>
			<svg id=$(svg_UUID) width="500" height="400" viewBox="0 0 500 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Scatter Plot Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="500" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					<div id=$(color_header_UUID) style="color: hsla(132, 6%, 20%, 1); display: flex;">
						<h4 style="color: hsla(132, 6%, 20%, 1); margin: 0;">Color Options</h4>
						<button id=$(color_toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: hsla(132, 6%, 20%, 1); font-size: 18px;">&#x25C0;</button>
					</div>
					<div id=$(color_body_UUID) style="padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
						$(color_pickers_html...)
					</div>

					<label for=$(x_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(x_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(x_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(x_max_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_min_UUID) style="color: hsla(132, 6%, 20%, 1);">Y Min: </label>
					<input type="number" id=$(y_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_max_UUID) style="color: hsla(132, 6%, 20%, 1);">Y Max: </label>
					<input type="number" id=$(y_max_UUID) style="margin: 10px; width: 80%;">
				</div>
			</div>
		</div>

		<script>
			if (typeof d3 === 'undefined') {
			    var script = document.createElement('script');
			    script.src = "https://d3js.org/d3.v7.min.js";
			    document.head.appendChild(script);
			}

			function drawScatterPlot() {
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

				let x_min = document.getElementById($(x_min_UUID)).value;
				let x_max = document.getElementById($(x_max_UUID)).value;
				let y_min = document.getElementById($(y_min_UUID)).value;
				let y_max = document.getElementById($(y_max_UUID)).value;

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				let svg = d3.select('#' + $(svg_UUID));
				svg.selectAll("*").remove();
				svg.attr("width", width)
				   .attr("height", height)
				   .attr("viewBox", [0, 0, width, height])
				   .attr("style", "max-width: 100%; height: auto; background-color: white;");

				let allXData = [].concat(...$(Datas).map(d => d[0]));
			    let allYData = [].concat(...$(Datas).map(d => d[1]));

			    let xDomain = [d3.min(allXData), d3.max(allXData)];
			    let yDomain = [d3.min(allYData), d3.max(allYData)];

			    if (x_min !== "") xDomain[0] = +x_min;
				if (x_max !== "") xDomain[1] = +x_max;
				if (y_min !== "") yDomain[0] = +y_min;
				if (y_max !== "") yDomain[1] = +y_max;

				let x = d3.scaleLinear()
					.domain(xDomain)
					.range([marginLeft, width - marginRight]);

				let y = d3.scaleLinear()
					.domain(yDomain)
					.range([height - marginBottom, marginTop]);

				for (let i = 0; i < $(length(Datas)); i++) {
					let [xData, yData] = $(Datas)[i];

					svg.append("g")
						.selectAll("circle")
						.data(xData.map((d, j) => ({x: d, y: yData[j]})))
						.enter()
						.append("circle")
						.attr("cx", d => x(d.x))
						.attr("cy", d => y(d.y))
						.attr("r", 4)
						.attr("fill", colors[i])
						.attr("opacity", 0.75);
				}

				svg.append("g")
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0));

				svg.append("g")
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40));
			}

			drawScatterPlot();

			document.getElementById($(width_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(height_UUID)).addEventListener('input', drawScatterPlot);
			for (let i = 0; i < $(length(Datas)); i++) {
				document.getElementById($(color_UUIDs)[i]).addEventListener('input', drawScatterPlot);
			}
			document.getElementById($(x_min_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(x_max_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(y_min_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawScatterPlot);

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

			let isColorPanelOpen = false;
			const colorBody = document.getElementById($(color_body_UUID));
			const colorToggleButton = document.getElementById($(color_toggle_button_UUID));

			colorBody.style.height = "0px";
			colorBody.style.opacity = 0;
			colorToggleButton.innerHTML = '&#x25C0;';

			document.getElementById($(color_toggle_button_UUID)).addEventListener('click', function() {
				if (isColorPanelOpen) {
					colorBody.style.height = "0px";
					colorBody.style.opacity = 0;
					colorToggleButton.innerHTML = '&#x25C0;';
				} else {
					colorBody.style.height = "auto";
					colorBody.style.opacity = 1;
					colorToggleButton.innerHTML = '&#x25BC;';
				}

				isColorPanelOpen = !isColorPanelOpen;
			});
		</script>
	""")
end

# ╔═╡ 1e2de2e2-0fdc-498e-b70b-2dc140be74b7
scatter_plot(grouped_gravity...)

# ╔═╡ 22f9fe69-e64c-4f08-9e98-c8d89a2bac3d
scatter_plot(grouped_decay...)

# ╔═╡ e2961a8c-9cf6-4266-84dc-409e4c69c28b
scatter_plot(grouped_measurements)

# ╔═╡ 5519b59f-9510-4faa-ae14-2d13d881dc97
function scatter_plot_with_curve(model::Function, Data::Tuple{AbstractVector{<:Real}, AbstractVector{<:Real}})
	local Scatter_UUID = "scatter-" * string(uuid1())

	local width_UUID = Scatter_UUID * "-width"
	local height_UUID = Scatter_UUID * "-height"
	local color_UUID = Scatter_UUID * "-color"
	local x_min_UUID = Scatter_UUID * "-x_min"
	local x_max_UUID = Scatter_UUID * "-x_max"
	local y_min_UUID = Scatter_UUID * "-y_min"
	local y_max_UUID = Scatter_UUID * "-y_max"
	local svg_UUID = Scatter_UUID * "-svg"
	local panel_UUID = Scatter_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = Scatter_UUID * "-body"
	local toggle_button_UUID = Scatter_UUID * "-toggle"

	local x_min = min(Data[1]...)
	local x_max = max(Data[1]...)
	local resolution = 1000
	local x_vals = range(x_min, x_max, length=1000)
	local model_vals = model.(x_vals)

	return @htl("""
		<div id=$(Scatter_UUID)>
			<svg id=$(svg_UUID) width="400" height="400" viewBox="0 0 300 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Scatter Plot Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="400" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(color_UUID) style="color: hsla(132, 6%, 20%, 1);">Point Color: </label>
					<input type="color" id=$(color_UUID) value="#4682b4" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(x_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(x_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(x_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(x_max_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_min_UUID) style="color: hsla(132, 6%, 20%, 1);">Y Min: </label>
					<input type="number" id=$(y_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_max_UUID) style="color: hsla(132, 6%, 20%, 1);">Y Max: </label>
					<input type="number" id=$(y_max_UUID) style="margin: 10px; width: 80%;">

				</div>
			</div>
		</div>

		<script>
			if (typeof d3 === 'undefined') {
			    var script = document.createElement('script');
			    script.src = "https://d3js.org/d3.v7.min.js";
			    document.head.appendChild(script);
			}

			function drawScatterPlot() {
				let width = +document.getElementById($(width_UUID)).value;
				let height = +document.getElementById($(height_UUID)).value;
				let pointColor = document.getElementById($(color_UUID)).value;

				let x_min = document.getElementById($(x_min_UUID)).value;
				let x_max = document.getElementById($(x_max_UUID)).value;
				let y_min = document.getElementById($(y_min_UUID)).value;
				let y_max = document.getElementById($(y_max_UUID)).value;

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				const xData = $(Data[1]);
				const yData = $(Data[2]);

				const x_vals = $(x_vals);
				const model_vals = $(model_vals);

				let xDomain = [d3.min(xData), d3.max(xData)];
				let yDomain = [d3.min(yData), d3.max(yData)];

				if (x_min !== "") xDomain[0] = +x_min;
				if (x_max !== "") xDomain[1] = +x_max;
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

				let line = d3.line()
                    .x((d, i) => x(x_vals[i]))
                    .y((d, i) => y(model_vals[i]));

                svg.append("path")
                    .datum(model_vals)
                    .attr("fill", "none")
                    .attr("stroke", "red")
                    .attr("stroke-width", 2)
                    .attr("d", line)
					.attr("opacity", 0.75);

				svg.append("g")
					.selectAll("circle")
					.data(xData.map((d, i) => ({ x: d, y: yData[i] })))
					.enter()
					.append("circle")
					.attr("cx", d => x(d.x))
					.attr("cy", d => y(d.y))
					.attr("r", 4)
					.attr("fill", pointColor)
					.attr("opacity", 0.75);

				svg.append("g")
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0));

				svg.append("g")
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40));
			}

			drawScatterPlot();

			document.getElementById($(width_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(height_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(color_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(x_min_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(x_max_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(y_min_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawScatterPlot);

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

# ╔═╡ 31211383-2d55-431b-94d9-c39d663257ad
function scatter_plot_with_curve(model::Function, Datas::Tuple{AbstractVector{<:Real}, AbstractVector{<:Real}}...)
	local Scatter_UUID = "scatter-" * string(uuid1())

	local width_UUID = Scatter_UUID * "-width"
	local height_UUID = Scatter_UUID * "-height"
	local color_UUIDs = [Scatter_UUID * "-color-" * string(i) for i in 1:length(Datas)]
	local svg_UUID = Scatter_UUID * "-svg"
	local panel_UUID = Scatter_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = Scatter_UUID * "-body"
	local toggle_button_UUID = Scatter_UUID * "-toggle"
	local color_header_UUID = Scatter_UUID * "-color-header"
	local color_body_UUID = Scatter_UUID * "-color-body"
	local color_toggle_button_UUID = Scatter_UUID * "-color-toggle"
	local x_min_UUID = Scatter_UUID * "-x_min"
	local x_max_UUID = Scatter_UUID * "-x_max"
	local y_min_UUID = Scatter_UUID * "-y_min"
	local y_max_UUID = Scatter_UUID * "-y_max"

	local color_pickers_html = [@htl("""
		<label style="color: hsla(132, 6%, 20%, 1);">Data Set $(i) Color: </label>
		<input type="color" id=$(color_UUIDs[i]) style="margin: 10px; width: 90%;">
		<br>
	""") for i in 1:length(Datas)]

	local x_min = min(vcat((x -> x[1]).(Datas)...)...)
	local x_max = max(vcat((x -> x[1]).(Datas)...)...)
	local resolution = 1000
	local x_vals = range(x_min, x_max, length=1000)
	local model_vals = model.(x_vals)

	return @htl("""
		<div id=$(Scatter_UUID)>
			<svg id=$(svg_UUID) width="500" height="400" viewBox="0 0 500 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Scatter Plot Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="500" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					<div id=$(color_header_UUID) style="color: hsla(132, 6%, 20%, 1); display: flex;">
						<h4 style="color: hsla(132, 6%, 20%, 1); margin: 0;">Color Options</h4>
						<button id=$(color_toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: hsla(132, 6%, 20%, 1); font-size: 18px;">&#x25C0;</button>
					</div>
					<div id=$(color_body_UUID) style="padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
						$(color_pickers_html...)
					</div>

					<label for=$(x_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(x_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(x_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(x_max_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_min_UUID) style="color: hsla(132, 6%, 20%, 1);">Y Min: </label>
					<input type="number" id=$(y_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(y_max_UUID) style="color: hsla(132, 6%, 20%, 1);">Y Max: </label>
					<input type="number" id=$(y_max_UUID) style="margin: 10px; width: 80%;">
				</div>
			</div>
		</div>

		<script>
			if (typeof d3 === 'undefined') {
			    var script = document.createElement('script');
			    script.src = "https://d3js.org/d3.v7.min.js";
			    document.head.appendChild(script);
			}

			function drawScatterPlot() {
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

				let x_min = document.getElementById($(x_min_UUID)).value;
				let x_max = document.getElementById($(x_max_UUID)).value;
				let y_min = document.getElementById($(y_min_UUID)).value;
				let y_max = document.getElementById($(y_max_UUID)).value;

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				let svg = d3.select('#' + $(svg_UUID));
				svg.selectAll("*").remove();
				svg.attr("width", width)
				   .attr("height", height)
				   .attr("viewBox", [0, 0, width, height])
				   .attr("style", "max-width: 100%; height: auto; background-color: white;");

				let allXData = [].concat(...$(Datas).map(d => d[0]));
			    let allYData = [].concat(...$(Datas).map(d => d[1]));

				const x_vals = $(x_vals);
				const model_vals = $(model_vals);

			    let xDomain = [d3.min(allXData), d3.max(allXData)];
			    let yDomain = [d3.min(allYData), d3.max(allYData)];

			    if (x_min !== "") xDomain[0] = +x_min;
				if (x_max !== "") xDomain[1] = +x_max;
				if (y_min !== "") yDomain[0] = +y_min;
				if (y_max !== "") yDomain[1] = +y_max;

				let x = d3.scaleLinear()
					.domain(xDomain)
					.range([marginLeft, width - marginRight]);

				let y = d3.scaleLinear()
					.domain(yDomain)
					.range([height - marginBottom, marginTop]);

				for (let i = 0; i < $(length(Datas)); i++) {
					let [xData, yData] = $(Datas)[i];

					svg.append("g")
						.selectAll("circle")
						.data(xData.map((d, j) => ({x: d, y: yData[j]})))
						.enter()
						.append("circle")
						.attr("cx", d => x(d.x))
						.attr("cy", d => y(d.y))
						.attr("r", 4)
						.attr("fill", colors[i])
						.attr("opacity", 0.75);
				}

				let line = d3.line()
                    .x((d, i) => x(x_vals[i]))
                    .y((d, i) => y(model_vals[i]));

                svg.append("path")
                    .datum(model_vals)
                    .attr("fill", "none")
                    .attr("stroke", "red")
                    .attr("stroke-width", 5)
                    .attr("d", line)
					.attr("opacity", 0.75);

				svg.append("g")
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0));

				svg.append("g")
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40));
			}

			drawScatterPlot();

			document.getElementById($(width_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(height_UUID)).addEventListener('input', drawScatterPlot);
			for (let i = 0; i < $(length(Datas)); i++) {
				document.getElementById($(color_UUIDs)[i]).addEventListener('input', drawScatterPlot);
			}
			document.getElementById($(x_min_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(x_max_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(y_min_UUID)).addEventListener('input', drawScatterPlot);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawScatterPlot);

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

			let isColorPanelOpen = false;
			const colorBody = document.getElementById($(color_body_UUID));
			const colorToggleButton = document.getElementById($(color_toggle_button_UUID));

			colorBody.style.height = "0px";
			colorBody.style.opacity = 0;
			colorToggleButton.innerHTML = '&#x25C0;';

			document.getElementById($(color_toggle_button_UUID)).addEventListener('click', function() {
				if (isColorPanelOpen) {
					colorBody.style.height = "0px";
					colorBody.style.opacity = 0;
					colorToggleButton.innerHTML = '&#x25C0;';
				} else {
					colorBody.style.height = "auto";
					colorBody.style.opacity = 1;
					colorToggleButton.innerHTML = '&#x25BC;';
				}

				isColorPanelOpen = !isColorPanelOpen;
			});
		</script>
	""")
end

# ╔═╡ e86cde84-2b57-4c10-a7f3-952f95180dd8
scatter_plot_with_curve(gravity_function, grouped_gravity...)

# ╔═╡ 3bcfb5d1-4870-4331-9661-b8c5f744ea52
scatter_plot_with_curve(decay_function, grouped_decay...)

# ╔═╡ 95ffe934-39c6-4949-84f0-fe82900fb72e
scatter_plot_with_curve(linear_function, grouped_measurements)

# ╔═╡ 6eaab073-1085-455e-899c-b5b2edddeedb
scatter_plot_with_curve(cubic_function, grouped_measurements)

# ╔═╡ 1b233d62-f18a-4eec-80d8-7bf632d90222
scatter_plot_with_curve(logarithmic_function, grouped_measurements)

# ╔═╡ 1eb70123-ae06-4850-aed2-a60ce824ed77
scatter_plot_with_curve(radical_function, grouped_measurements)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LsqFit = "2fda8390-95c7-5789-9bda-21331edee243"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
RDatasets = "ce6b1742-4840-55fa-b093-852dadbb1d8b"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
HypertextLiteral = "~0.9.5"
LsqFit = "~0.15.0"
PlutoTeachingTools = "~0.3.1"
PlutoUI = "~0.7.60"
RDatasets = "~0.7.7"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "435b7d542ee998707846ccd1ff56a3f8bad69708"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.Adapt]]
deps = ["LinearAlgebra", "Requires"]
git-tree-sha1 = "6a55b747d1812e699320963ffde36f1ebdda4099"
uuid = "79e6a3ab-5dfb-504d-930d-738a2a938a0e"
version = "4.0.4"

    [deps.Adapt.extensions]
    AdaptStaticArraysExt = "StaticArrays"

    [deps.Adapt.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.ArrayInterface]]
deps = ["Adapt", "LinearAlgebra"]
git-tree-sha1 = "3640d077b6dafd64ceb8fd5c1ec76f7ca53bcf76"
uuid = "4fba245c-0d91-5ea0-9b3e-6abc04ee57a9"
version = "7.16.0"

    [deps.ArrayInterface.extensions]
    ArrayInterfaceBandedMatricesExt = "BandedMatrices"
    ArrayInterfaceBlockBandedMatricesExt = "BlockBandedMatrices"
    ArrayInterfaceCUDAExt = "CUDA"
    ArrayInterfaceCUDSSExt = "CUDSS"
    ArrayInterfaceChainRulesExt = "ChainRules"
    ArrayInterfaceGPUArraysCoreExt = "GPUArraysCore"
    ArrayInterfaceReverseDiffExt = "ReverseDiff"
    ArrayInterfaceSparseArraysExt = "SparseArrays"
    ArrayInterfaceStaticArraysCoreExt = "StaticArraysCore"
    ArrayInterfaceTrackerExt = "Tracker"

    [deps.ArrayInterface.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    CUDA = "052768ef-5323-5732-b1bb-66c8b64840ba"
    CUDSS = "45b445bb-4962-46a0-9369-b4df9d0f772e"
    ChainRules = "082447d4-558c-5d27-93f4-14fc19e9eca2"
    GPUArraysCore = "46192b85-c4d5-4398-a991-12ede77f4527"
    ReverseDiff = "37e2e3b7-166d-5795-8a7a-e32c996b4267"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArraysCore = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
    Tracker = "9f7883ad-71c0-57eb-9f7f-b5c9e6d3789c"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "6c834533dc1fabd820c1db03c839bf97e45a3fab"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.14"

[[deps.CategoricalArrays]]
deps = ["DataAPI", "Future", "Missings", "Printf", "Requires", "Statistics", "Unicode"]
git-tree-sha1 = "1568b28f91293458345dabba6a5ea3f183250a61"
uuid = "324d7699-5711-5eae-9e2f-1d82baa6b597"
version = "0.10.8"

    [deps.CategoricalArrays.extensions]
    CategoricalArraysJSONExt = "JSON"
    CategoricalArraysRecipesBaseExt = "RecipesBase"
    CategoricalArraysSentinelArraysExt = "SentinelArrays"
    CategoricalArraysStructTypesExt = "StructTypes"

    [deps.CategoricalArrays.weakdeps]
    JSON = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
    SentinelArrays = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
    StructTypes = "856f2bd8-1eba-4b0a-8007-ebc267875bd4"

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

[[deps.CommonSubexpressions]]
deps = ["MacroTools"]
git-tree-sha1 = "cda2cfaebb4be89c9084adaca7dd7333369715c5"
uuid = "bbf7d656-a473-5ed7-a52c-81e309532950"
version = "0.3.1"

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

[[deps.ConstructionBase]]
git-tree-sha1 = "76219f1ed5771adbb096743bff43fb5fdd4c1157"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.8"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseLinearAlgebraExt = "LinearAlgebra"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    LinearAlgebra = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

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

[[deps.DiffResults]]
deps = ["StaticArraysCore"]
git-tree-sha1 = "782dd5f4561f5d267313f23853baaaa4c52ea621"
uuid = "163ba53b-c6d8-5494-b064-1a9d43ac40c5"
version = "1.1.0"

[[deps.DiffRules]]
deps = ["IrrationalConstants", "LogExpFunctions", "NaNMath", "Random", "SpecialFunctions"]
git-tree-sha1 = "23163d55f885173722d1e4cf0f6110cdbaf7e272"
uuid = "b552c78f-8df3-52c6-915a-8e097449b14b"
version = "1.15.1"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "d7477ecdafb813ddee2ae727afa94e9dcb5f3fb0"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.112"

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

[[deps.ExprTools]]
git-tree-sha1 = "27415f162e6028e81c72b82ef756bf321213b6ec"
uuid = "e2ba6199-217a-4e67-a87a-7c52f15ade04"
version = "0.1.10"

[[deps.FileIO]]
deps = ["Pkg", "Requires", "UUIDs"]
git-tree-sha1 = "82d8afa92ecf4b52d78d869f038ebfb881267322"
uuid = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
version = "1.16.3"

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

[[deps.FiniteDiff]]
deps = ["ArrayInterface", "LinearAlgebra", "Setfield"]
git-tree-sha1 = "b10bdafd1647f57ace3885143936749d61638c3b"
uuid = "6a86dc24-6348-571c-b903-95158fe2bd41"
version = "2.26.0"

    [deps.FiniteDiff.extensions]
    FiniteDiffBandedMatricesExt = "BandedMatrices"
    FiniteDiffBlockBandedMatricesExt = "BlockBandedMatrices"
    FiniteDiffSparseArraysExt = "SparseArrays"
    FiniteDiffStaticArraysExt = "StaticArrays"

    [deps.FiniteDiff.weakdeps]
    BandedMatrices = "aae01518-5342-5314-be14-df237901396f"
    BlockBandedMatrices = "ffab5731-97b5-5995-9138-79e8c1846df0"
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Format]]
git-tree-sha1 = "9c68794ef81b08086aeb32eeaf33531668d5f5fc"
uuid = "1fa38f19-a742-5d3f-a2b9-30dd87b9d5f8"
version = "1.3.7"

[[deps.ForwardDiff]]
deps = ["CommonSubexpressions", "DiffResults", "DiffRules", "LinearAlgebra", "LogExpFunctions", "NaNMath", "Preferences", "Printf", "Random", "SpecialFunctions"]
git-tree-sha1 = "cf0fe81336da9fb90944683b8c41984b08793dad"
uuid = "f6369f11-7733-5829-9624-2563aa707210"
version = "0.10.36"

    [deps.ForwardDiff.extensions]
    ForwardDiffStaticArraysExt = "StaticArrays"

    [deps.ForwardDiff.weakdeps]
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"
version = "1.11.0"

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

[[deps.LsqFit]]
deps = ["Distributions", "ForwardDiff", "LinearAlgebra", "NLSolversBase", "Printf", "StatsAPI"]
git-tree-sha1 = "40acc20cfb253cf061c1a2a2ea28de85235eeee1"
uuid = "2fda8390-95c7-5789-9bda-21331edee243"
version = "0.15.0"

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

[[deps.Mocking]]
deps = ["Compat", "ExprTools"]
git-tree-sha1 = "2c140d60d7cb82badf06d8783800d0bcd1a7daa2"
uuid = "78c3b35d-d492-501b-9361-3d52fe80e533"
version = "0.8.1"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NLSolversBase]]
deps = ["DiffResults", "Distributed", "FiniteDiff", "ForwardDiff"]
git-tree-sha1 = "a0b464d183da839699f4c79e7606d9d186ec172c"
uuid = "d41bc354-129a-5804-8e4c-c37616107c6c"
version = "7.8.3"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

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

[[deps.RData]]
deps = ["CategoricalArrays", "CodecZlib", "DataFrames", "Dates", "FileIO", "Requires", "TimeZones", "Unicode"]
git-tree-sha1 = "19e47a495dfb7240eb44dc6971d660f7e4244a72"
uuid = "df47a6cb-8c03-5eed-afd8-b6050d6c41da"
version = "0.8.3"

[[deps.RDatasets]]
deps = ["CSV", "CodecZlib", "DataFrames", "FileIO", "Printf", "RData", "Reexport"]
git-tree-sha1 = "2720e6f6afb3e562ccb70a6b62f8f308ff810333"
uuid = "ce6b1742-4840-55fa-b093-852dadbb1d8b"
version = "0.7.7"

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

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "3bac05bc7e74a75fd9cba4295cde4045d9fe2386"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.1"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "ff11acffdb082493657550959d4feb4b6149e73a"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.5"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Setfield]]
deps = ["ConstructionBase", "Future", "MacroTools", "StaticArraysCore"]
git-tree-sha1 = "e2cc6d8c88613c05e1defb55170bf5ff211fbeac"
uuid = "efcf1570-3423-57d1-acb7-fd33fddbac46"
version = "1.1.1"

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

[[deps.StaticArraysCore]]
git-tree-sha1 = "192954ef1208c7019899fbf8049e717f92959682"
uuid = "1e83bf80-4336-4d27-bf5d-d5a4f845583c"
version = "1.4.3"

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

[[deps.TZJData]]
deps = ["Artifacts"]
git-tree-sha1 = "36b40607bf2bf856828690e097e1c799623b0602"
uuid = "dc5dba14-91b3-4cab-a142-028a31da12f7"
version = "1.3.0+2024b"

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

[[deps.TimeZones]]
deps = ["Dates", "Downloads", "InlineStrings", "Mocking", "Printf", "Scratch", "TZJData", "Unicode", "p7zip_jll"]
git-tree-sha1 = "8323074bc977aa85cf5ad71099a83ac75b0ac107"
uuid = "f269a46b-ccf7-5d73-abea-4c690281aa53"
version = "1.18.1"

    [deps.TimeZones.extensions]
    TimeZonesRecipesBaseExt = "RecipesBase"

    [deps.TimeZones.weakdeps]
    RecipesBase = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"

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
# ╟─c76a0f7d-df83-42d3-ba39-ba95dcd9f0a2
# ╟─da245bc3-faa2-4c12-85f2-02384289091c
# ╟─7f888dc9-fb10-400e-8aea-84dc3ef13468
# ╟─9a91db02-de9b-46ba-8acf-87fdfad98d44
# ╠═f1b21760-8f54-11ef-2065-c56eed7e1189
# ╟─a96dc249-4e2b-4747-b516-83ef4e0539eb
# ╟─e1cd5309-4db3-4baf-a633-16e7b57f3694
# ╠═d07bf30b-56c1-4814-8042-16b7d32a2617
# ╠═68ead0ca-42c5-4321-9553-3857ee3115c0
# ╠═4b4d442c-96ea-4350-9c0e-b7c7769bc62b
# ╠═bf1f78ba-a424-4eff-9f40-10ad932b9189
# ╠═e8363773-a141-4edc-a8e2-e0b1ac4e8833
# ╠═1e2de2e2-0fdc-498e-b70b-2dc140be74b7
# ╠═253ebaec-c7e0-4a43-906e-ec2c035b2e95
# ╠═1dd00b2a-4c4d-4609-ba08-a4ff77629761
# ╠═4ace9406-3135-4cbb-9da9-152cc7b1b09a
# ╠═78b1cb39-8f93-405a-9a88-3e6115353777
# ╠═e86cde84-2b57-4c10-a7f3-952f95180dd8
# ╟─9ec13a48-7e19-415b-91e2-d436546ccede
# ╟─dd6be3a4-8879-424a-959c-6fc5539e7235
# ╟─edbfcf6f-8212-4e16-b8d0-80fe96adfb39
# ╠═2931226d-92dc-4314-aee0-a96acc31c93e
# ╠═ebb22cac-7000-4a22-b780-bafec8d30c42
# ╠═921b4fe1-c09d-4906-bed0-c160e49d5b10
# ╠═a093dac7-796b-4fdd-bd0e-bdfed87bae2d
# ╠═d4eba482-702f-4139-b520-9cb236736e2d
# ╠═22f9fe69-e64c-4f08-9e98-c8d89a2bac3d
# ╠═ba109fdf-8d88-421f-b15d-79e831cd5ca9
# ╠═cad65584-c7f9-4180-a58d-f0507c36f9c1
# ╠═9e6387c4-c09a-4883-8118-54a570afdc2a
# ╠═03d973c1-a8e2-4647-8155-13b2a95b2325
# ╠═3bcfb5d1-4870-4331-9661-b8c5f744ea52
# ╟─ab79c49f-44c8-4bb6-899b-7557fc2c7f2f
# ╟─dacecec4-c143-4c4d-bfde-4bd9ff3f46d9
# ╟─732f0417-e87b-4609-9c26-88b13273bea2
# ╠═23fdb757-1283-4401-aee9-0efb6fbcc678
# ╠═4e5e35a4-7239-44d2-974e-3fb32be9454f
# ╠═7bf9060a-6a4e-48ae-98ff-a732f327a65f
# ╠═e2961a8c-9cf6-4266-84dc-409e4c69c28b
# ╠═e96096e4-5be2-4f18-88db-afa5a1d6632e
# ╠═e9ab6747-e48e-4eab-b911-f25b8dda4633
# ╠═6f8a6cee-c8ff-4091-98c8-38f9c72cee7b
# ╠═95ffe934-39c6-4949-84f0-fe82900fb72e
# ╠═0bc56c85-e564-4304-b09b-190121fc64cf
# ╠═7bef17e5-07bd-4fc1-a067-aa16fe0d9fb8
# ╠═a6c1b42d-67b4-469e-8ab5-4dc4594e357c
# ╠═6eaab073-1085-455e-899c-b5b2edddeedb
# ╠═19fa37d2-3899-4bf3-a403-0b3fb120c360
# ╠═005831e2-62b6-4f70-8e15-2f15bb09039f
# ╠═dba611b7-17ac-4dc3-ab73-6278e0fc0252
# ╠═1b233d62-f18a-4eec-80d8-7bf632d90222
# ╠═24bb44a9-37cd-44f1-993d-c2fa63a89a7d
# ╠═0f27095e-4a0a-49d7-92eb-f031e9d19e89
# ╠═1a7f61f7-e0cc-48a7-9ebc-7ddefadc1360
# ╠═1eb70123-ae06-4850-aed2-a60ce824ed77
# ╟─a52c08d0-0322-40af-9531-7695ced309a3
# ╟─354a23e0-8f93-4d87-8248-feba176cc3c0
# ╟─8243a11f-ce9b-4eb7-923a-f185c9c997ea
# ╟─37e16a0e-7a3e-41bc-a029-4280897aefe6
# ╟─5519b59f-9510-4faa-ae14-2d13d881dc97
# ╟─31211383-2d55-431b-94d9-c39d663257ad
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
