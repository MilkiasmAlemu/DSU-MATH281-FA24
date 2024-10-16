### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# ╔═╡ b341d260-ca7c-4142-9a8b-2b0f213a7a53
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools
end

# ╔═╡ 64198a31-a6cb-432a-8359-c37f4cd8e332
using Distributions, StatsBase, Random

# ╔═╡ 57445fe2-0fe0-4f46-826b-cf9eacf0228c
@htl("""
	<head>
		<script src="https://d3js.org/d3.v7.min.js"></script>
	</head>
	<h1>Lecture 14</h1>
""")

# ╔═╡ b7589596-1209-4b00-a867-48943c199f7d
TableOfContents()

# ╔═╡ 09e5dfb3-6885-4b30-b8b3-98acf724e167
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ a745359e-c363-49bc-8045-728b7babcdf0
@htl("""
	<hr>
""")

# ╔═╡ 1475277c-68de-4dc2-b68a-1b368fe0a70f
@htl("""
	<h2>Discretizing Data</h2>
""")

# ╔═╡ acbc191f-d444-4891-ae9e-193dc5f0b4ae
Continuous_Data = rand(Normal(50, 10), 1000)

# ╔═╡ fe8715a3-105c-4a5d-bfeb-2ba804117c0e
number_of_bins = 20

# ╔═╡ 145b363a-9c22-4f30-897c-191e9819f308
min_Data = minimum(Continuous_Data)

# ╔═╡ 3fc2ce7a-3d05-4191-927c-9564f438bda2
max_Data = maximum(Continuous_Data)

# ╔═╡ be820392-8609-4c3c-9aa9-5a8fdfec3c38
class_boundaries = range(min_Data, max_Data, length = number_of_bins + 1)

# ╔═╡ dc336188-c78f-49b4-b50b-9b7023e5a35c
classes = (x -> searchsortedfirst(class_boundaries, x) - 1).(Continuous_Data)

# ╔═╡ 360323be-564b-4f83-bf1d-9166504f65db
sort(countmap(classes))

# ╔═╡ cf48e786-c0b0-49d8-a2cc-895dd984c3e6
@htl("""
	<hr>
""")

# ╔═╡ 5a48b2bf-2104-409d-865e-0cab924b6713
@htl("""
	<h2>Histogram</h2>
""")

# ╔═╡ bc196ec0-fb2c-4916-af5f-385e5d0007e0
@htl("""
	<hr>
""")

# ╔═╡ 5ab3d716-98af-4445-af8d-09949dd91cf4
@htl("""
	<h2>Line Chart</h2>
""")

# ╔═╡ e7abf089-8672-49e2-8f4d-c2b597baf1bd
Continuous_Data2 = rand(Normal(50, 10), 1000)

# ╔═╡ d9ac146f-dbb8-41aa-b937-ab57cb83990d
@htl("""
	<hr>
""")

# ╔═╡ 77dacf4b-6a41-4444-b45c-2b97a5abc80a
@htl("""
	<h2>Stem Plot</h2>
""")

# ╔═╡ 71756874-bbe6-49c0-a957-92f898911714
@htl("""
	<hr>
""")

# ╔═╡ eac915f3-52e0-4640-ba6a-3183581293f6
@htl("""
	<h2>Box–and–Whisker Plot</h2>
""")

# ╔═╡ e119ea63-1016-4a1f-82f9-f7b4bd8ae6a1
@htl("""
	<hr>
""")

# ╔═╡ 0c3e7946-7d86-404c-80c6-87b9c22c12c5
@htl("""
	<h2>Scatterplot</h2>
""")

# ╔═╡ 69513359-fc4c-4826-a970-e8af97a65f8e
@htl("""
	<hr>
""")

# ╔═╡ 215188c0-1644-4ccb-bbf2-357a3dcc693f
@htl("""
	<h2>Violin Plot</h2>
""")

# ╔═╡ 809956b6-e4b2-415d-9a58-30f4e0b1d016
@htl("""
	<h2>Quantile–Quantile Plot</h2>
""")

# ╔═╡ 53fe90f8-420c-4aed-b298-0132dd4434be
@htl("""
	<hr>
""")

# ╔═╡ 667adfe1-d50f-41de-acdb-9b326badece7
@htl("""
	<h4>Chart Functions</h2>
	<h5>Hic Sunt Dracones</h5>
""")

# ╔═╡ 7cbdaeee-38d3-41c3-964b-2f8c0b211df2
function histogram(Data::AbstractVector{<:Real})
	local Bar_UUID = "bar-" * string(uuid1())

	local width_UUID = Bar_UUID * "-width"
	local height_UUID = Bar_UUID * "-height"
	local bins_UUID = Bar_UUID * "-bins"
	local color_UUID = Bar_UUID * "-color"
	local svg_UUID = Bar_UUID * "-svg"
	local panel_UUID = Bar_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = panel_UUID * "-body"
	local toggle_button_UUID = panel_UUID * "-toggle"
	local x_min_UUID = Bar_UUID * "-x_min"
	local x_max_UUID = Bar_UUID * "-x_max"
	local y_max_UUID = Bar_UUID * "-y_max"

	return @htl("""
		<div id=$(Bar_UUID)>
			<svg id=$(svg_UUID) width="500" height="400" viewBox="0 0 500 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Histogram Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25BC;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: auto; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="500" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(bins_UUID) style="color: hsla(132, 6%, 20%, 1);">Bin Number: </label>
					<input type="range" id=$(bins_UUID) min="5" max="50" value="20" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(color_UUID) style="color: hsla(132, 6%, 20%, 1);">Bin Color: </label>
					<input type="color" id=$(color_UUID) value="#4682b4" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(x_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(x_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(x_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(x_max_UUID) style="margin: 10px; width: 80%;">

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

			function drawHistogram() {
				let width = +document.getElementById($(width_UUID)).value;
				let height = +document.getElementById($(height_UUID)).value;
				let number_of_bins = +document.getElementById($(bins_UUID)).value;
				let binColor = document.getElementById($(color_UUID)).value;

				let x_min = document.getElementById($(x_min_UUID)).value;
				let x_max = document.getElementById($(x_max_UUID)).value;
				let y_max = document.getElementById($(y_max_UUID)).value;

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				const Data = $(Data);

				let bins = d3.bin()
					.thresholds((data, min, max) =>
						d3.range(number_of_bins).map(t => min + (t / number_of_bins) * (max - min))
					)
					.value((d) => d)
					(Data);

				let xDomain = [bins[0].x0, bins[bins.length - 1].x1];
				let yDomain = [0, d3.max(bins, (d) => d.length)];

				if (x_min !== "") xDomain[0] = +x_min;
				if (x_max !== "") xDomain[1] = +x_max;
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
					.attr("fill", binColor)
					.selectAll("rect")
					.data(bins)
					.join("rect")
					.attr("x", (d) => x(d.x0) + 1)
					.attr("width", (d) => x(d.x1) - x(d.x0) - 1)
					.attr("y", (d) => y(d.length))
					.attr("height", (d) => y(0) - y(d.length));

				svg.append("g")
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0))
					.call((g) => g.append("text")
						.attr("x", width)
						.attr("y", marginBottom - 4)
						.attr("fill", "currentColor")
						.attr("text-anchor", "end")
						.text("Data →"));

				svg.append("g")
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40))
					.call((g) => g.select(".domain").remove())
					.call((g) => g.append("text")
						.attr("x", -marginLeft)
						.attr("y", 10)
						.attr("fill", "currentColor")
						.attr("text-anchor", "start")
						.text("↑ Number of Entries"));
			}

			drawHistogram();

			document.getElementById($(width_UUID)).addEventListener('input', drawHistogram);
			document.getElementById($(height_UUID)).addEventListener('input', drawHistogram);
			document.getElementById($(bins_UUID)).addEventListener('input', drawHistogram);
			document.getElementById($(color_UUID)).addEventListener('input', drawHistogram);
			document.getElementById($(x_min_UUID)).addEventListener('input', drawHistogram);
			document.getElementById($(x_max_UUID)).addEventListener('input', drawHistogram);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawHistogram);

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

# ╔═╡ 8caef1ad-1ad5-4e3b-982e-59f571db5bbe
histogram(Continuous_Data)

# ╔═╡ 5d3892f0-2ed1-49af-9d0d-e9bb54ff6bcb
function stem_plot(Data::AbstractVector{<:Real})
	local Stem_UUID = "stem-" * string(uuid1())

	local width_UUID = Stem_UUID * "-width"
	local height_UUID = Stem_UUID * "-height"
	local bins_UUID = Stem_UUID * "-bins"
	local color_UUID = Stem_UUID * "-color"
	local svg_UUID = Stem_UUID * "-svg"
	local panel_UUID = Stem_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = Stem_UUID * "-body"
	local toggle_button_UUID = Stem_UUID * "-toggle"
	local x_min_UUID = Stem_UUID * "-x_min"
	local x_max_UUID = Stem_UUID * "-x_max"
	local y_max_UUID = Stem_UUID * "-y_max"

	return @htl("""
		<div id=$(Stem_UUID)>
			<svg id=$(svg_UUID) width="500" height="400" viewBox="0 0 500 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Stem Plot Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="500" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(bins_UUID) style="color: hsla(132, 6%, 20%, 1);">Bin Number: </label>
					<input type="range" id=$(bins_UUID) min="5" max="50" value="20" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(color_UUID) style="color: hsla(132, 6%, 20%, 1);">Stem Color: </label>
					<input type="color" id=$(color_UUID) value="#4682b4" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(x_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(x_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(x_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(x_max_UUID) style="margin: 10px; width: 80%;">

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

			function drawStemPlot() {
				let width = +document.getElementById($(width_UUID)).value;
				let height = +document.getElementById($(height_UUID)).value;
				let number_of_bins = +document.getElementById($(bins_UUID)).value;
				let stemColor = document.getElementById($(color_UUID)).value;

				let x_min = document.getElementById($(x_min_UUID)).value;
				let x_max = document.getElementById($(x_max_UUID)).value;
				let y_max = document.getElementById($(y_max_UUID)).value;

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				const Data = $(Data);

				let bins = d3.bin()
					.thresholds((data, min, max) =>
						d3.range(number_of_bins).map(t => min + (t / number_of_bins) * (max - min))
					)
					.value((d) => d)
					(Data);

				let xDomain = [bins[0].x0, bins[bins.length - 1].x1];
				let yDomain = [0, d3.max(bins, (d) => d.length)];

				if (x_min !== "") xDomain[0] = +x_min;
				if (x_max !== "") xDomain[1] = +x_max;
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
					.attr("stroke", stemColor)
					.selectAll("line")
					.data(bins)
					.join("line")
					.attr("x1", (d) => x((d.x0 + d.x1) / 2))
					.attr("x2", (d) => x((d.x0 + d.x1) / 2))
					.attr("y1", y(0))
					.attr("y2", (d) => y(d.length))
					.attr("stroke-width", 2);

				svg.append("g")
					.attr("fill", stemColor)
					.selectAll("circle")
					.data(bins)
					.join("circle")
					.attr("cx", (d) => x((d.x0 + d.x1) / 2))
					.attr("cy", (d) => y(d.length))
					.attr("r", 4);

				svg.append("g")
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0))
					.call((g) => g.append("text")
						.attr("x", width)
						.attr("y", marginBottom - 4)
						.attr("fill", "currentColor")
						.attr("text-anchor", "end")
						.text("Data →"));

				svg.append("g")
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40))
					.call((g) => g.select(".domain").remove())
					.call((g) => g.append("text")
						.attr("x", -marginLeft)
						.attr("y", 10)
						.attr("fill", "currentColor")
						.attr("text-anchor", "start")
						.text("↑ Number of Entries"));
			}

			drawStemPlot();

			document.getElementById($(width_UUID)).addEventListener('input', drawStemPlot);
			document.getElementById($(height_UUID)).addEventListener('input', drawStemPlot);
			document.getElementById($(bins_UUID)).addEventListener('input', drawStemPlot);
			document.getElementById($(color_UUID)).addEventListener('input', drawStemPlot);
			document.getElementById($(x_min_UUID)).addEventListener('input', drawStemPlot);
			document.getElementById($(x_max_UUID)).addEventListener('input', drawStemPlot);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawStemPlot);

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

# ╔═╡ bb2cb641-952c-4aa0-8411-9fba9d32b03a
stem_plot(Continuous_Data)

# ╔═╡ a9543eaa-8c15-488c-b399-97cd26aaec5e
function line_chart(Data::AbstractVector{<:Real})
	local Line_UUID = "line-" * string(uuid1())

	local width_UUID = Line_UUID * "-width"
	local height_UUID = Line_UUID * "-height"
	local bins_UUID = Line_UUID * "-bins"
	local color_UUID = Line_UUID * "-color"
	local svg_UUID = Line_UUID * "-svg"
	local panel_UUID = Line_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = Line_UUID * "-body"
	local toggle_button_UUID = Line_UUID * "-toggle"
	local x_min_UUID = Line_UUID * "-x_min"
	local x_max_UUID = Line_UUID * "-x_max"
	local y_max_UUID = Line_UUID * "-y_max"

	return @htl("""
		<div id=$(Line_UUID)>
			<svg id=$(svg_UUID) width="500" height="400" viewBox="0 0 500 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Line Chart Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="500" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(bins_UUID) style="color: hsla(132, 6%, 20%, 1);">Bin Number: </label>
					<input type="range" id=$(bins_UUID) min="5" max="50" value="20" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(color_UUID) style="color: hsla(132, 6%, 20%, 1);">Line Color: </label>
					<input type="color" id=$(color_UUID) value="#4682b4" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(x_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(x_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(x_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(x_max_UUID) style="margin: 10px; width: 80%;">

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

			function drawLinePlot() {
				let width = +document.getElementById($(width_UUID)).value;
				let height = +document.getElementById($(height_UUID)).value;
				let number_of_bins = +document.getElementById($(bins_UUID)).value;
				let lineColor = document.getElementById($(color_UUID)).value;

				let x_min = document.getElementById($(x_min_UUID)).value;
				let x_max = document.getElementById($(x_max_UUID)).value;
				let y_max = document.getElementById($(y_max_UUID)).value;

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				const Data = $(Data);

				let bins = d3.bin()
					.thresholds((data, min, max) =>
						d3.range(number_of_bins).map(t => min + (t / number_of_bins) * (max - min))
					)
					.value((d) => d)
					(Data);

				let xDomain = [bins[0].x0, bins[bins.length - 1].x1];
				let yDomain = [0, d3.max(bins, (d) => d.length)];

				if (x_min !== "") xDomain[0] = +x_min;
				if (x_max !== "") xDomain[1] = +x_max;
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
					.x((d) => x((d.x0 + d.x1) / 2))
					.y((d) => y(d.length));

				svg.append("path")
					.datum(bins)
					.attr("fill", "none")
					.attr("stroke", lineColor)
					.attr("stroke-width", 2)
					.attr("d", line);

				svg.append("g")
					.attr("fill", lineColor)
					.selectAll("circle")
					.data(bins)
					.join("circle")
					.attr("cx", (d) => x((d.x0 + d.x1) / 2))
					.attr("cy", (d) => y(d.length))
					.attr("r", 4);

				svg.append("g")
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0))
					.call((g) => g.append("text")
						.attr("x", width)
						.attr("y", marginBottom - 4)
						.attr("fill", "currentColor")
						.attr("text-anchor", "end")
						.text("Data →"));

				svg.append("g")
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40))
					.call((g) => g.select(".domain").remove())
					.call((g) => g.append("text")
						.attr("x", -marginLeft)
						.attr("y", 10)
						.attr("fill", "currentColor")
						.attr("text-anchor", "start")
						.text("↑ Number of Entries"));
			}

			drawLinePlot();

			document.getElementById($(width_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(height_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(bins_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(color_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(x_min_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(x_max_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawLinePlot);

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

# ╔═╡ 55a0de18-e367-4bc6-bb92-2f47d19889c0
function line_chart(Datas::AbstractVector{<:Real}...)
	local Line_UUID = "line-" * string(uuid1())

	local width_UUID = Line_UUID * "-width"
	local height_UUID = Line_UUID * "-height"
	local bins_UUID = Line_UUID * "-bins"
	local color_UUIDs = [Line_UUID * "-color-" * string(i) for i in 1:length(Datas)]
	local svg_UUID = Line_UUID * "-svg"
	local panel_UUID = Line_UUID * "-panel"
	local panel_header_UUID = panel_UUID * "-header"
	local panel_body_UUID = Line_UUID * "-body"
	local toggle_button_UUID = Line_UUID * "-toggle"
	local x_min_UUID = Line_UUID * "-x_min"
	local x_max_UUID = Line_UUID * "-x_max"
	local y_max_UUID = Line_UUID * "-y_max"

	local color_pickers_html = [@htl("""
		<br>
		<label style="color: hsla(132, 6%, 20%, 1);">Data Set $(i) Color: </label>
		<input type="color" id=$(color_UUIDs[i]) style="margin: 10px; width: 90%;">
	""") for i in 1:length(Datas)]

	return @htl("""
		<div id=$(Line_UUID)>
			<svg id=$(svg_UUID) width="500" height="400" viewBox="0 0 500 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

			<div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
				<div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
					<h4 style="margin: 0;">Line Charts Options</h4>
					<button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
				</div>

				<div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
					<label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
					<input type="range" id=$(width_UUID) min="300" max="800" value="500" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
					<input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

					<br>

					<label for=$(bins_UUID) style="color: hsla(132, 6%, 20%, 1);">Bin Number: </label>
					<input type="range" id=$(bins_UUID) min="5" max="50" value="20" style="margin: 10px; width: 90%;">

					<br>

					$(color_pickers_html...)

					<br>

					<label for=$(x_min_UUID) style="color: hsla(132, 6%, 20%, 1);">X Min: </label>
					<input type="number" id=$(x_min_UUID) style="margin: 10px; width: 80%;">

					<br>

					<label for=$(x_max_UUID) style="color: hsla(132, 6%, 20%, 1);">X Max: </label>
					<input type="number" id=$(x_max_UUID) style="margin: 10px; width: 80%;">

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

			function drawLinePlot() {
				let width = +document.getElementById($(width_UUID)).value;
				let height = +document.getElementById($(height_UUID)).value;
				let number_of_bins = +document.getElementById($(bins_UUID)).value;
				
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
				let y_max = document.getElementById($(y_max_UUID)).value;

				const marginTop = 10;
				const marginRight = 10;
				const marginBottom = 30;
				const marginLeft = 25;

				const Data = $(Datas[1]);

				let bins = d3.bin()
					.thresholds((data, min, max) =>
						d3.range(number_of_bins).map(t => min + (t / number_of_bins) * (max - min))
					)
					.value((d) => d)
					(Data);

				let xDomain = [bins[0].x0, bins[bins.length - 1].x1];
				let yDomain = [0, d3.max(bins, (d) => d.length)];

				if (x_min !== "") xDomain[0] = +x_min;
				if (x_max !== "") xDomain[1] = +x_max;
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

				for (let i = 0; i < $(length(Datas)); i++) {
					let bins = d3.bin()
						.thresholds((data, min, max) =>
							d3.range(number_of_bins).map(t => min + (t / number_of_bins) * (max - min))
						)
						.value((d) => d)
						($(Datas)[i]);

					let line = d3.line()
						.x((d) => x((d.x0 + d.x1) / 2))
						.y((d) => y(d.length));

					svg.append("path")
						.datum(bins)
						.attr("fill", "none")
						.attr("stroke", colors[i])
						.attr("stroke-width", 2)
						.attr("d", line);

					svg.append("g")
						.attr("fill", colors[i])
						.selectAll("circle")
						.data(bins)
						.join("circle")
						.attr("cx", (d) => x((d.x0 + d.x1) / 2))
						.attr("cy", (d) => y(d.length))
						.attr("r", 4);
				}


				svg.append("g")
					.attr("transform", "translate(0," + (height - marginBottom) + ")")
					.call(d3.axisBottom(x).ticks(width / 80).tickSizeOuter(0))
					.call((g) => g.append("text")
						.attr("x", width)
						.attr("y", marginBottom - 4)
						.attr("fill", "currentColor")
						.attr("text-anchor", "end")
						.text("Data →"));

				svg.append("g")
					.attr("transform", "translate(" + marginLeft + ",0)")
					.call(d3.axisLeft(y).ticks(height / 40))
					.call((g) => g.select(".domain").remove())
					.call((g) => g.append("text")
						.attr("x", -marginLeft)
						.attr("y", 10)
						.attr("fill", "currentColor")
						.attr("text-anchor", "start")
						.text("↑ Number of Entries"));
			}

			drawLinePlot();

			document.getElementById($(width_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(height_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(bins_UUID)).addEventListener('input', drawLinePlot);
			for (let i = 0; i < $(length(Datas)); i++) {
				document.getElementById($(color_UUIDs)[i]).addEventListener('input', drawLinePlot);
			}
			document.getElementById($(x_min_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(x_max_UUID)).addEventListener('input', drawLinePlot);
			document.getElementById($(y_max_UUID)).addEventListener('input', drawLinePlot);

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

# ╔═╡ b231edde-d941-42f0-b559-6c8e0bc97110
line_chart(Continuous_Data)

# ╔═╡ 1db6c1c2-79a3-404a-ad99-6fabbb74e6ed
line_chart(Continuous_Data, Continuous_Data2)

# ╔═╡ 6e937516-b6ba-4ced-9d0d-fd93cdeff2ce
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

		<script>
			if (typeof d3 === 'undefined') {
			    var script = document.createElement('script');
			    script.src = "https://d3js.org/d3.v7.min.js";
			    document.head.appendChild(script);
			}

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

# ╔═╡ 9e3673d9-fe49-4e28-9ffc-2fc417b8e8b2
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

		<script>
			if (typeof d3 === 'undefined') {
			    var script = document.createElement('script');
			    script.src = "https://d3js.org/d3.v7.min.js";
			    document.head.appendChild(script);
			}

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

# ╔═╡ 59c75360-4dbf-4ac6-9483-d45fe854925f
box_plot(Continuous_Data)

# ╔═╡ 5732b639-488e-40c8-9af9-44e53a9979c4
box_plot(Continuous_Data, Continuous_Data2)

# ╔═╡ 69055bb9-23e6-4bf6-95de-55bfd4da7430
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

# ╔═╡ 7a1b843e-fe83-45ea-873b-9817e763fd11
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
	local x_min_UUID = Scatter_UUID * "-x_min"
	local x_max_UUID = Scatter_UUID * "-x_max"
	local y_min_UUID = Scatter_UUID * "-y_min"
	local y_max_UUID = Scatter_UUID * "-y_max"

	local color_pickers_html = [@htl("""
		<br>
		<label style="color: hsla(132, 6%, 20%, 1);">Data Set $(i) Color: </label>
		<input type="color" id=$(color_UUIDs[i]) style="margin: 10px; width: 90%;">
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

					$(color_pickers_html...)

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
		</script>
	""")
end

# ╔═╡ 81e0cf25-1ec3-4c77-8077-e895867df002
scatter_plot((Continuous_Data, Continuous_Data2))

# ╔═╡ 3e741d59-7626-4a3e-b303-a2d51167d211
function violin_plot(X::Distributions.UnivariateDistribution)
    local Violin_UUID = "violin-" * string(uuid1())

    local width_UUID = Violin_UUID * "-width"
    local height_UUID = Violin_UUID * "-height"
    local color_UUID = Violin_UUID * "-color"
    local svg_UUID = Violin_UUID * "-svg"
    local panel_UUID = Violin_UUID * "-panel"
    local panel_header_UUID = panel_UUID * "-header"
    local panel_body_UUID = Violin_UUID * "-body"
    local toggle_button_UUID = Violin_UUID * "-toggle"

    local resolution = 1000
    local sample_start = quantile(X, 0.001)
	local sample_end = quantile(X, 0.999)
    local y_vals = range(sample_start, sample_end, length=resolution)
    local pdf_vals = pdf.(X, y_vals)

    return @htl("""
        <div id=$(Violin_UUID)>
            <svg id=$(svg_UUID) width="300" height="400" viewBox="0 0 300 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

            <div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
                <div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
                    <h4 style="margin: 0;">Violin Plot Options</h4>
                    <button id=$(toggle_button_UUID) style="cursor: pointer; background-color: transparent; border: none; color: white; font-size: 18px;">&#x25C0;</button>
                </div>

                <div id=$(panel_body_UUID) style="background-color: hsla(99, 20%, 95%, 1); padding: 10px; border-radius: 5px; transition: height 0.4s ease, opacity 0.4s ease; height: 0px; opacity: 0; overflow: hidden;">
                    <label for=$(width_UUID) style="color: hsla(132, 6%, 20%, 1);">Width: </label>
                    <input type="range" id=$(width_UUID) min="300" max="800" value="300" style="margin: 10px; width: 90%;">

                    <br>

                    <label for=$(height_UUID) style="color: hsla(132, 6%, 20%, 1);">Height: </label>
                    <input type="range" id=$(height_UUID) min="200" max="600" value="400" style="margin: 10px; width: 90%;">

                    <br>

                    <label for=$(color_UUID) style="color: hsla(132, 6%, 20%, 1);">Violin Color: </label>
                    <input type="color" id=$(color_UUID) value="#4682b4" style="margin: 10px; width: 90%;">
                </div>
            </div>
        </div>

        <script>
            if (typeof d3 === 'undefined') {
                var script = document.createElement('script');
                script.src = "https://d3js.org/d3.v7.min.js";
                document.head.appendChild(script);
            }

            function drawViolinPlot() {
                let width = +document.getElementById($(width_UUID)).value;
                let height = +document.getElementById($(height_UUID)).value;
                let violinColor = document.getElementById($(color_UUID)).value;

                let y_min = $(sample_start);
                let y_max = $(sample_end);

                const marginTop = 10;
                const marginRight = 10;
                const marginBottom = 30;
                const marginLeft = 25;

                const pdf_vals = $(pdf_vals);
                const y_vals = $(y_vals);

                let yDomain = [y_min, y_max];

                let x = d3.scaleLinear()
                    .domain([-d3.max(pdf_vals), d3.max(pdf_vals)])
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

                let area = d3.area()
                    .x0(d => x(-d[1]))
                    .x1(d => x(d[1]))
                    .y(d => y(d[0]));

                let data = d3.zip(y_vals, pdf_vals);

                svg.append("path")
                    .datum(data)
                    .attr("fill", violinColor)
                    .attr("stroke", "black")
                    .attr("stroke-width", 1)
                    .attr("d", area);

                svg.append("line")
                    .attr("x1", x(0))
                    .attr("x2", x(0))
                    .attr("y1", y(yDomain[0]))
                    .attr("y2", y(yDomain[1]))
                    .attr("stroke", "black");

                svg.append("g")
                    .attr("transform", "translate(0," + (height - marginBottom) + ")")
                    .call(d3.axisBottom(x).ticks(1).tickSizeOuter(0));

                svg.append("g")
                    .attr("transform", "translate(" + marginLeft + ",0)")
                    .call(d3.axisLeft(y).ticks(height / 40));
            }

            drawViolinPlot();

            document.getElementById($(width_UUID)).addEventListener('input', drawViolinPlot);
            document.getElementById($(height_UUID)).addEventListener('input', drawViolinPlot);
            document.getElementById($(color_UUID)).addEventListener('input', drawViolinPlot);

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

# ╔═╡ a5c255e6-54fe-44fc-be20-491625106fa3
violin_plot(Normal(0,1))

# ╔═╡ 3e7b5210-7b8c-4eae-bf0b-406853958e9f
function qq_plot(Data::Tuple{AbstractVector{<:Real}, AbstractVector{<:Real}})
    local QQ_UUID = "qq-" * string(uuid1())

    local width_UUID = QQ_UUID * "-width"
    local height_UUID = QQ_UUID * "-height"
    local color_UUID = QQ_UUID * "-color"
    local x_min_UUID = QQ_UUID * "-x_min"
    local x_max_UUID = QQ_UUID * "-x_max"
    local y_min_UUID = QQ_UUID * "-y_min"
    local y_max_UUID = QQ_UUID * "-y_max"
    local svg_UUID = QQ_UUID * "-svg"
    local panel_UUID = QQ_UUID * "-panel"
    local panel_header_UUID = panel_UUID * "-header"
    local panel_body_UUID = QQ_UUID * "-body"
    local toggle_button_UUID = QQ_UUID * "-toggle"

    return @htl("""
        <div id=$(QQ_UUID)>
            <svg id=$(svg_UUID) width="400" height="400" viewBox="0 0 300 400" style="max-width: 100%; height: auto; background-color: white;"></svg>

            <div id=$(panel_UUID) style="position: absolute; z-index: 100; background-color: hsla(100, 27%, 65%, 1); padding: 10px; border-radius: 10px; width: 300px; top: 10%; left: 100%;">
                <div id=$(panel_header_UUID) style="cursor: move; color: white; margin: 5px; display: flex; justify-content: space-between; align-items: center;">
                    <h4 style="margin: 0;">Q-Q Plot Options</h4>
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

            function drawQQPlot() {
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

                let xData = $(Data[1]).sort(d3.ascending);
                let yData = $(Data[2]).sort(d3.ascending);

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

				svg.append("line")
					.attr("x1", x(d3.min(xDomain)))
					.attr("y1", y(d3.min(xDomain)))
					.attr("x2", x(d3.max(xDomain)))
					.attr("y2", y(d3.max(xDomain)))
					.attr("stroke", "black")
					.attr("opacity", 0.5)
					.attr("stroke-width", 2)
					.attr("stroke-dasharray", "5,5");

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

            drawQQPlot();

            document.getElementById($(width_UUID)).addEventListener('input', drawQQPlot);
            document.getElementById($(height_UUID)).addEventListener('input', drawQQPlot);
            document.getElementById($(color_UUID)).addEventListener('input', drawQQPlot);
            document.getElementById($(x_min_UUID)).addEventListener('input', drawQQPlot);
            document.getElementById($(x_max_UUID)).addEventListener('input', drawQQPlot);
            document.getElementById($(y_min_UUID)).addEventListener('input', drawQQPlot);
            document.getElementById($(y_max_UUID)).addEventListener('input', drawQQPlot);

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

# ╔═╡ c8ac81e2-0524-4508-a4ba-ca48022c158c
qq_plot((Continuous_Data, Continuous_Data2))

# ╔═╡ e76472a0-287e-4b9c-a752-10d2f88209fc
@htl("""
	<hr>
""")

# ╔═╡ fd7274e8-b840-44b6-b481-a23388da7954
#Some Helper Functions for LaTeX
begin
	macro LC(str, latex_UUID)
		return @htl("""
					<div id=$(latex_UUID) class="LaTeXContainer" style="display:inline;">$(Markdown.parse(str))</div>
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

# ╔═╡ 56b97f78-c7c6-4733-b591-9fc1745e462d
#Some Helper Structures for Option Panels
begin
	@kwdef struct OptionPanel
	    outer_box_hue::Float64 = 100.0
		outer_box_saturation::Float64 = 27.0
		outer_box_lightness::Float64 = 65.0
		outer_box_alpha::Float64 = 1.0
		inner_box_hue::Float64 = 99.0
		inner_box_saturation::Float64 = 20.0
		inner_box_lightness::Float64 = 95.0
		inner_box_alpha::Float64 = 1.0
	    title_text::String = "Options"
	    title_size::Int = 4
	    html_title::Union{Nothing, HypertextLiteral.Result} = nothing
		options_text::Union{Nothing, AbstractVector{String}} = nothing
	    html_options::Union{Nothing, AbstractVector{HypertextLiteral.Result}} = nothing
	end
	
	function render_optionpanel(panel::OptionPanel)
		local panel_UUID = "panel-"*string(uuid1())
		local panel_header_UUID = panel_UUID*"-header"
	    local title_html = nothing
	    if panel.html_title !== nothing
	        title_html = panel.html_title
	    elseif panel.title_text !== nothing
	        local title_size = panel.title_size !== nothing ? panel.title_size : 3
	        title_html = @htl("""<$("h"*string(title_size)) id=$(panel_header_UUID) style='cursor: move; z-index: 101; color: white; margin-left: 10px; margin-top: 10px;'>$(panel.title_text)</$("h"*string(title_size))>""")
	    end

		local exterior_color = "hsla($(panel.outer_box_hue), $(panel.outer_box_saturation)%, $(panel.outer_box_lightness)%, $(panel.outer_box_alpha))"
	    local interior_color = "hsla($(panel.inner_box_hue), $(panel.inner_box_saturation)%, $(panel.inner_box_lightness)%, $(panel.inner_box_alpha))"

		local options_html = nothing
	    if panel.html_options !== nothing
	        options_html = panel.html_options
	    elseif panel.options_text !== nothing
	        options_html = @htl("""
				$([@htl("""
					<div style='border: 3px solid $(exterior_color); border-radius: 0px;'><h6 style='padding: 5px 10px 5px;'>$(lmd(text, text_color="hsla(132,6%,20%,1)"))</h6></div>
				""") for text in panel.options_text]...)
			""")
	    end
	
	    return @htl("""
		    <div id=$(panel_UUID) style="position: absolute; z-index: 100; margin: 0px auto; background-color: $(exterior_color); padding: 5px; border-radius: 10px; width: 40%; top: 0%; left: 100%;">
		        $(title_html !== nothing ? title_html : "")
		        <div style="background-color: $(interior_color); color: white; padding: 0px; border-radius: 5px;">
		            $(options_html)
		        </div>
		    </div>
			<script>
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
			</script>
	    """)
	end
end;

# ╔═╡ 0e678766-c45b-422a-93ee-f3a85cbfae17
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

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
Distributions = "~0.25.112"
HypertextLiteral = "~0.9.5"
PlutoTeachingTools = "~0.3.1"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.0"
manifest_format = "2.0"
project_hash = "bc3eba8cfed400a77419eeb5855d67f47f179af9"

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
git-tree-sha1 = "96d2a4a668f5c098fb8a26ce7da53cde3e462a80"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.0.3"

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
git-tree-sha1 = "2d4e5de3ac1c348fd39ddf8adbef82aa56b65576"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.6.1"

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
# ╟─b341d260-ca7c-4142-9a8b-2b0f213a7a53
# ╟─57445fe2-0fe0-4f46-826b-cf9eacf0228c
# ╟─b7589596-1209-4b00-a867-48943c199f7d
# ╟─09e5dfb3-6885-4b30-b8b3-98acf724e167
# ╠═64198a31-a6cb-432a-8359-c37f4cd8e332
# ╟─a745359e-c363-49bc-8045-728b7babcdf0
# ╟─1475277c-68de-4dc2-b68a-1b368fe0a70f
# ╠═acbc191f-d444-4891-ae9e-193dc5f0b4ae
# ╠═fe8715a3-105c-4a5d-bfeb-2ba804117c0e
# ╠═145b363a-9c22-4f30-897c-191e9819f308
# ╠═3fc2ce7a-3d05-4191-927c-9564f438bda2
# ╠═be820392-8609-4c3c-9aa9-5a8fdfec3c38
# ╠═dc336188-c78f-49b4-b50b-9b7023e5a35c
# ╠═360323be-564b-4f83-bf1d-9166504f65db
# ╟─cf48e786-c0b0-49d8-a2cc-895dd984c3e6
# ╟─5a48b2bf-2104-409d-865e-0cab924b6713
# ╠═8caef1ad-1ad5-4e3b-982e-59f571db5bbe
# ╟─bc196ec0-fb2c-4916-af5f-385e5d0007e0
# ╟─5ab3d716-98af-4445-af8d-09949dd91cf4
# ╠═b231edde-d941-42f0-b559-6c8e0bc97110
# ╠═e7abf089-8672-49e2-8f4d-c2b597baf1bd
# ╠═1db6c1c2-79a3-404a-ad99-6fabbb74e6ed
# ╟─d9ac146f-dbb8-41aa-b937-ab57cb83990d
# ╟─77dacf4b-6a41-4444-b45c-2b97a5abc80a
# ╠═bb2cb641-952c-4aa0-8411-9fba9d32b03a
# ╟─71756874-bbe6-49c0-a957-92f898911714
# ╟─eac915f3-52e0-4640-ba6a-3183581293f6
# ╟─59c75360-4dbf-4ac6-9483-d45fe854925f
# ╠═5732b639-488e-40c8-9af9-44e53a9979c4
# ╟─e119ea63-1016-4a1f-82f9-f7b4bd8ae6a1
# ╟─0c3e7946-7d86-404c-80c6-87b9c22c12c5
# ╠═81e0cf25-1ec3-4c77-8077-e895867df002
# ╟─69513359-fc4c-4826-a970-e8af97a65f8e
# ╟─215188c0-1644-4ccb-bbf2-357a3dcc693f
# ╠═a5c255e6-54fe-44fc-be20-491625106fa3
# ╟─809956b6-e4b2-415d-9a58-30f4e0b1d016
# ╠═c8ac81e2-0524-4508-a4ba-ca48022c158c
# ╟─53fe90f8-420c-4aed-b298-0132dd4434be
# ╟─667adfe1-d50f-41de-acdb-9b326badece7
# ╟─7cbdaeee-38d3-41c3-964b-2f8c0b211df2
# ╟─5d3892f0-2ed1-49af-9d0d-e9bb54ff6bcb
# ╟─a9543eaa-8c15-488c-b399-97cd26aaec5e
# ╟─55a0de18-e367-4bc6-bb92-2f47d19889c0
# ╟─6e937516-b6ba-4ced-9d0d-fd93cdeff2ce
# ╟─9e3673d9-fe49-4e28-9ffc-2fc417b8e8b2
# ╟─69055bb9-23e6-4bf6-95de-55bfd4da7430
# ╟─7a1b843e-fe83-45ea-873b-9817e763fd11
# ╟─3e741d59-7626-4a3e-b303-a2d51167d211
# ╟─3e7b5210-7b8c-4eae-bf0b-406853958e9f
# ╟─e76472a0-287e-4b9c-a752-10d2f88209fc
# ╟─56b97f78-c7c6-4733-b591-9fc1745e462d
# ╟─0e678766-c45b-422a-93ee-f3a85cbfae17
# ╟─fd7274e8-b840-44b6-b481-a23388da7954
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
