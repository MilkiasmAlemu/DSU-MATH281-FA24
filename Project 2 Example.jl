### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# ╔═╡ 805e5510-4724-4cc9-9c57-ea78d61bb0ae
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools
end

# ╔═╡ cb08b6b9-3b80-4426-932f-6915ec8a14bd
using Distributions, StatsBase, RDatasets

# ╔═╡ ecc35080-034b-44e1-972f-49d13d3c449c
TableOfContents()

# ╔═╡ 3337d02c-e41f-4940-9b0f-520e0a325a7a
md"""
###### My Name is: **Victor**
"""

# ╔═╡ 256b046a-50de-49da-b627-b56a691a39a9
@htl("""
	<h5>These are the different packages being used for this project.</h5>
""")

# ╔═╡ a6e6147d-91fc-45aa-9fa5-dec250b7454f
@htl("""
	<hr>
""")

# ╔═╡ f96fe433-4375-44fd-8cb5-03a569ebc757
@htl("""
	<hr>
""")

# ╔═╡ e65a1b49-32ca-4172-bbf7-953e1a6cc0bf
md"""
For this example document, I am using this forbidden package. 🙃
"""

# ╔═╡ 1bbc1dce-4627-4201-8e51-9c9bd7038cf4
filter(row -> !(row."Package" ∈ ["COUNT", "KMsurv", "gamair"]) && (row."Rows" > 30) && (row."Columns" > 3), RDatasets.datasets())

# ╔═╡ 4f8becde-555b-41e0-a403-c119677673bd
@htl("""
	<hr>
""")

# ╔═╡ 8c2abc8e-4448-4a48-b709-ca6873223596
MyData = dropmissing(RDatasets.dataset("car", "Davis"))

# ╔═╡ 9697331c-ff04-443d-995f-795a64429c67
@htl("""
	<hr>
""")

# ╔═╡ 58da6326-28c8-4f33-9c0b-3c6e79598de2
Column_1 = MyData[!, "Weight"]

# ╔═╡ 70360f6c-02df-4faf-8d8c-382faa563515
Column_2 = MyData[!, "Height"]

# ╔═╡ 2ff0bc44-6eb8-4d1f-835a-fa74037628d4
cov(Column_1, Column_2)

# ╔═╡ 948dbec8-d97a-42ab-83d7-443d5152faf0
rho = cor(Column_1, Column_2)

# ╔═╡ 9e19d921-e515-443c-8f96-384fc45d5f5c
mu_1 = mean(Column_1)

# ╔═╡ 14f879cf-64e9-43c7-a929-d4d3f0eb3796
mu_2 = mean(Column_2)

# ╔═╡ 52077178-b894-4645-82d6-6e757498c598
std_1 = std(Column_1)

# ╔═╡ f6891e5f-add8-4f6f-8ec1-bf83081b4670
std_2 = std(Column_2)

# ╔═╡ 06e47963-a012-4560-b89b-68a512745600
m = rho * std_2 / std_1

# ╔═╡ d68f8aa7-94e9-4da8-9d78-c70418eb97f4
b = mu_2 - m * mu_1

# ╔═╡ 2857a674-302b-4f2a-8a42-89c43cd276e3
md"""
Make sure to interpret! 🚂
"""

# ╔═╡ 0d608ccb-f1fb-448e-93e8-3870bd5851c8
@htl("""
	<hr>
""")

# ╔═╡ 3d475ce4-4e75-4f29-a2f7-c4e83516254d
sample_mu = mean(Column_1)

# ╔═╡ a04da640-2853-42db-8a39-b2b0874e028e
sample_var = var(Column_1)

# ╔═╡ cd4ae1d5-970a-41a3-bd9d-95c4bcb8a9a1
sample_skew = skewness(Column_1)

# ╔═╡ 7d4f40b7-4624-4e20-ba12-9c8c0caf08bd
sample_kurt = 3 + kurtosis(Column_1)

# ╔═╡ 1e51ef8f-4f4b-41a4-8332-e38faacef3a6
md"""
I should really interpret these!
"""

# ╔═╡ ac559c63-e53f-4389-81d9-37efaf7af428
n = length(Column_1)

# ╔═╡ b89a1dcc-4574-464b-a622-ed7e59bcc08b
resampled_mus = [mean(rand(Column_1, n)) for i in 1:1000]

# ╔═╡ 89c59ecd-faa1-475e-9835-494bc5f88aa7
md"""
I should interpret this value against the others.
"""

# ╔═╡ 7c2b993e-7abd-45de-8e55-373582193d6a
resampled_vars = [var(rand(Column_1, n)) for i in 1:1000]

# ╔═╡ 805355f0-9a9d-4a0a-8af3-194f84b598eb
average_var = mean(resampled_vars)

# ╔═╡ 49e3b310-b52c-49f1-9d42-d81749b7ece9
resampled_skews = [skewness(rand(Column_1, n)) for i in 1:1000]

# ╔═╡ 27993303-23c0-43bf-9134-b73de37eb5f7
resampled_kurts = [3 + kurtosis(rand(Column_1, n)) for i in 1:1000]

# ╔═╡ 944ab70f-beff-4dd5-a3d2-a9329c3b40ce
md"""
If only I knew how to interpret all of this! 😢
"""

# ╔═╡ af965f0e-d687-431e-b8fc-be8991c1fec5
@htl("""
	<hr>
""")

# ╔═╡ b674c60f-a0fb-4ec2-a9d2-59099e952f99
md"""
Who knows what this means?
"""

# ╔═╡ f0a95dbd-5151-458f-ba44-edde05f02da6
md"""
And I think to myself, what a wonderful plot. 💹
"""

# ╔═╡ 8c9d788a-e87f-4c6e-ad6d-6bad6d82113c
@htl("""
	<hr>
""")

# ╔═╡ 606355de-0d55-4a8a-98a0-289a2733e8c7
@htl("""
	<h4>Chart Functions</h2>
	<h5>Hic Sunt Dracones</h5>
""")

# ╔═╡ 0a1492fe-3148-4dfc-a9f2-8408163d0fa3
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

# ╔═╡ d328f756-573c-4773-9899-7cb6c26c103e
histogram(resampled_mus)

# ╔═╡ 10fa44af-f5ba-4fc5-8675-4158e3df381a
histogram(resampled_vars)

# ╔═╡ 2e1ab134-5062-4bea-a98a-d599593bb20f
histogram(resampled_skews)

# ╔═╡ ae4aff0f-ea4d-41a6-8f5d-656c7da8842e
histogram(resampled_kurts)

# ╔═╡ 35e230ea-e342-49f8-aeab-1e4607b256a2
histogram(Column_1)

# ╔═╡ a91c2b3a-cf2d-4f32-babd-b9aa3464aadf
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

# ╔═╡ b87124b5-72c6-406f-b098-215c235ad6a1
stem_plot(Column_2)

# ╔═╡ bebaad61-3d6f-49d7-82da-335077da52be
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

# ╔═╡ f954f820-7a89-4e76-be88-3bbd21a25177
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

# ╔═╡ c8ff898f-1d90-4020-a205-1603dee22f50
line_chart(Column_1, Column_2)

# ╔═╡ 2f0c5fe4-1591-418e-9b7c-639bd7bed30c
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

# ╔═╡ 542f3fb3-2063-4a0e-a6bf-8fcfa7c05260
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

# ╔═╡ 6d87887f-a051-4a1f-9aa6-2c3053cee772
box_plot(Column_1, Column_2)

# ╔═╡ 2502200d-8dae-4aab-be36-27e39aa92591
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

# ╔═╡ 5f241897-8655-4687-9302-aaac54666dba
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

# ╔═╡ 3d0cba9e-8aab-4b0e-a3d3-592b980d6b22
scatter_plot((Column_1, Column_2))

# ╔═╡ 4ef24d3c-bbf1-4d8d-9ad7-542080d5ce22
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

# ╔═╡ dda64c40-6fe5-4619-8c07-de833ecc5dbd
qq_plot((Column_1, Column_2))

# ╔═╡ 5f784dbd-3443-411e-b8ad-0e85d769f979
@htl("""
	<hr>
""")

# ╔═╡ fff50b12-82b7-40a5-ad28-a89fb0d6969f
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

# ╔═╡ 74c70c81-3b31-45b7-a71c-60a03ececc4a
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

# ╔═╡ 622dbd61-4d3a-44c6-a403-07d17ede6cf3
@htl("""
	<head>
		<script src="https://d3js.org/d3.v7.min.js"></script>
	</head>
	<h1>Project 2 – Example</h1>
	$(stop_box("Be aware that this example does not have any of the interpretation for which you are being asked. It is purely intended for how to use the code."))
""")

# ╔═╡ c65b48e0-6c1b-4397-9293-6d14515430bb
stop_box("Remember to click **[ctrl]** + M to be able to enter text in a cell, and please hit **[shift]** + **[enter]** to save your work in a cell.")

# ╔═╡ 20eb91bd-ed76-4c83-8513-8621ecb9bc45
note_box("The goal of this project is to use a real world dataset and apply the statistical knowledge that you have learned so far throughout the semester to tell a story about the data. Your goal is to try to describe the data and convince me that the conclusions you are making are true by backing up your arguments with data. For all of your answers, make sure to give full justification/reasoning.")

# ╔═╡ fd85e757-07d3-4064-9678-726fec1f1675
@htl("""
	$(go_box("Task 1 – Choosing", "**RDatasets** has many different collections of data available. Look through the collection below to find a dataset that interests you. For more information, most documentation should be [available here](https://vincentarelbundock.github.io/Rdatasets/articles/data.html), where you can **search** for your dataset and then click on the **Doc** link to see what all of the information means. You are welcome to use the same dataset from your previous project or look at something completely different!"))
	<br>
	$(stop_box("You are not allowed to choose the example with Package \"car\" and Dataset \"Davis\""))
""")

# ╔═╡ 2c1af774-ea2c-4204-8108-67a3edc3d486
@htl("""
	$(go_box("Task 2 – Loading", "Load your dataset into Julia using:"))
	<br>
	<div>
		$(Markdown.parse("""
		```julia
		MyData = dropmissing(RDatasets.dataset(#== Package ==#, #== Dataset ==#))
		```
		"""))
	</div>
	<br>
	$(stop_box("Make sure to replace the two entries with the Package name and the Dataset name **in quotes**!"))
""")

# ╔═╡ c5bb3401-77a0-441d-8f9e-64b30301dc76
@htl("""
	$(go_box("Task 3 – Bivariate Measurements", "Choose two numeric columns of your dataset. Using these columns:\n
* Plot a **scatterplot** of your two columns\n
* Calculate the **covariance** and **correlation coefficient** of your two columns\n
* Calculate the **Line of Best Fit** from your chosen bivariate measurement\n
Given these different measures, interpret what these mean in the context of your dataset. In particular:\n
* How does increasing one of your measurements seem to affect the other?\n
* What do you think is the underlying reason (if any) that your data points are correlated in this way?"))
	<br>
	$(stop_box("For things to be interesting, the correlation coefficient for your choice must be between ``0.1`` and ``0.9`` if positive and between ``-0.9`` and ``-0.1`` if negative."))
	<br>
	$(note_box("You can get a specific column using:"))
	</div>
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""
		```julia
		MyData[!, #== Column Name ==#]
		```
		"""))
	</div>
	<br>
	$(note_box("In this document, you can plot a scatterplot using:"))
	</div>
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""
		```julia
		scatter_plot((#== Column 1 ==#, #== Column 2 ==#))
		```
		"""))
	</div>
	<br>
	$(note_box("For the **covariance**, **correlation coefficient**, and slope and ``y``–intercept of the **line of best fit** you can use the following lines:"))
	</div>
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Foldable("Expand to see Code", Markdown.parse("""
		```julia
		# This gives the covariance
		cov(#== Column 1 ==#, #== Column 2 ==#)
		```\n
		```julia
		# This gives the correlation coefficient
		rho = cor(#== Column 1 ==#, #== Column 2 ==#)
		```\n
		```julia
		mu_1 = mean(#== Column 1 ==#)
		```\n
		```julia
		mu_2 = mean(#== Column 2 ==#)
		```\n
		```julia
		std_1 = std(#== Column 1 ==#)
		```\n
		```julia
		std_2 = std(#== Column 2 ==#)
		```\n
		```julia
		# This gives the slope
		m = rho * std_2 / std_1
		```\n
		```julia
		# This gives the y-intercept
		b = mu_2 - m * mu_1
		```\n
		""")))
	</div>
""")

# ╔═╡ 8420b6f2-8f75-45fa-b827-87eacce9e9f4
@htl("""
	$(go_box("Task 4 - Resampling", "Choose one of your columns of numeric data. To make things interesting, this column should not be uniformly distributed and should be a measurement, not just a state index for instance. This sample should give you an approximation of the corresponding measurement from the population.\n
* Compute the mean, variance, skewness, and kurtosis of this column\n
* What can you estimate and infer about the population based off of this single sample?"))
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Foldable("Expand to see Code", Markdown.parse("""
		```julia
		# This gives the mean
		sample_mu = mean(#== Column ==#)
		```\n
		```julia
		# This gives the variance
		sample_var = var(#== Column ==#)
		```\n
		```julia
		# This gives the skewness 
		sample_skew = skewness(#== Column ==#)
		```\n
		```julia
		# This gives the kurtosis
		# The way we defined it in class is a little different
		# than the Julia function
		sample_kurt = 3 + kurtosis(#== Column ==#)
		```
		""")))
	</div>
	<br>
	$(go_box("In order to try to limit outliers from your data, perform a bootstrapping estimate using the code provided.\n
* Compute ``1000`` resamplings of the mean, variance, skewness, and kurtosis.\n
* Plot a histogram of the resamplings for each of these measures. What do you notice about the distributions?\n
* Do any of your initial sampled values seem to be inconsistent with the resampled histograms?\n
* Would you update your inferences about the population based off of these resampled values? If so, what would the updates tell you? If not, why not? Do you feel more confident in your assessments?"))
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Foldable("Expand to see Code", @htl("""
		$(note_box("This is just the resampling for the mean, you should do the same for variance, skewness, and kurtosis"))
		<br>
		$(Markdown.parse("""
		```julia
		# This computes the length of your column of data
		n = length(#== Column == #)
		```\n
		```julia
		# This gives 1000 resamplings of the mean
		resampled_mus = [mean(rand(#== Column ==#, n)) for i in 1:1000]
		```\n
		```julia
		# This plots the histogram
		histogram(resampled_mus)
		```
		"""))""")))
	</div>
""")

# ╔═╡ 95eed7dc-b95e-4795-86e8-8f74b5da083d
@htl("""
	$(go_box("Task 5 - Visualization", "For your two different columns of data, plot their histograms (or line–charts or stem–plots) and box–plots.\n
* Interpret what the shape of your plots means for your dataset in the real world setting. In particular, are their any noticeable outliers? What should you expect the measurements to be on average?
* What do you think would be the best way to visualize your data? If not one of these, what might be a better way to convince people your interpretation is correct?"))
	<br>
	$(note_box("In this document, you can plot a histogram using:"))
	</div>
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""
		```julia
		histogram(#== Column ==#)
		```
		"""))
	</div>
	<br>
	$(note_box("In this document, you can plot a box–plot using:"))
	</div>
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""
		```julia
		box_plot(#== Column 1 ==#, #== Column 2 ==#)
		```
		"""))
	</div>
	<br>
	$(go_box("Plot a **qq–plot** of your two columns.\n
* Do you think your two measurements come from a similar distribution? Why or why not?"))
	<br>
	$(note_box("In this document, you can plot a qq–plot using:"))
	</div>
	<br>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""
		```julia
		qq_plot((#== Column 1 ==#, #== Column 2 ==#))
		```
		"""))
	</div>
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
RDatasets = "ce6b1742-4840-55fa-b093-852dadbb1d8b"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
Distributions = "~0.25.112"
HypertextLiteral = "~0.9.5"
PlutoTeachingTools = "~0.3.1"
PlutoUI = "~0.7.60"
RDatasets = "~0.7.7"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "e1df9109b0eb14995b5e74d42d2ae101d2139c27"

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
# ╟─805e5510-4724-4cc9-9c57-ea78d61bb0ae
# ╟─622dbd61-4d3a-44c6-a403-07d17ede6cf3
# ╟─ecc35080-034b-44e1-972f-49d13d3c449c
# ╠═3337d02c-e41f-4940-9b0f-520e0a325a7a
# ╟─c65b48e0-6c1b-4397-9293-6d14515430bb
# ╟─256b046a-50de-49da-b627-b56a691a39a9
# ╠═cb08b6b9-3b80-4426-932f-6915ec8a14bd
# ╟─a6e6147d-91fc-45aa-9fa5-dec250b7454f
# ╟─20eb91bd-ed76-4c83-8513-8621ecb9bc45
# ╟─f96fe433-4375-44fd-8cb5-03a569ebc757
# ╟─fd85e757-07d3-4064-9678-726fec1f1675
# ╠═e65a1b49-32ca-4172-bbf7-953e1a6cc0bf
# ╟─1bbc1dce-4627-4201-8e51-9c9bd7038cf4
# ╟─4f8becde-555b-41e0-a403-c119677673bd
# ╟─2c1af774-ea2c-4204-8108-67a3edc3d486
# ╠═8c2abc8e-4448-4a48-b709-ca6873223596
# ╟─9697331c-ff04-443d-995f-795a64429c67
# ╟─c5bb3401-77a0-441d-8f9e-64b30301dc76
# ╠═58da6326-28c8-4f33-9c0b-3c6e79598de2
# ╠═70360f6c-02df-4faf-8d8c-382faa563515
# ╠═3d0cba9e-8aab-4b0e-a3d3-592b980d6b22
# ╠═2ff0bc44-6eb8-4d1f-835a-fa74037628d4
# ╠═948dbec8-d97a-42ab-83d7-443d5152faf0
# ╠═9e19d921-e515-443c-8f96-384fc45d5f5c
# ╠═14f879cf-64e9-43c7-a929-d4d3f0eb3796
# ╠═52077178-b894-4645-82d6-6e757498c598
# ╠═f6891e5f-add8-4f6f-8ec1-bf83081b4670
# ╠═06e47963-a012-4560-b89b-68a512745600
# ╠═d68f8aa7-94e9-4da8-9d78-c70418eb97f4
# ╠═2857a674-302b-4f2a-8a42-89c43cd276e3
# ╟─0d608ccb-f1fb-448e-93e8-3870bd5851c8
# ╟─8420b6f2-8f75-45fa-b827-87eacce9e9f4
# ╠═3d475ce4-4e75-4f29-a2f7-c4e83516254d
# ╠═a04da640-2853-42db-8a39-b2b0874e028e
# ╠═cd4ae1d5-970a-41a3-bd9d-95c4bcb8a9a1
# ╠═7d4f40b7-4624-4e20-ba12-9c8c0caf08bd
# ╠═1e51ef8f-4f4b-41a4-8332-e38faacef3a6
# ╠═ac559c63-e53f-4389-81d9-37efaf7af428
# ╠═b89a1dcc-4574-464b-a622-ed7e59bcc08b
# ╠═d328f756-573c-4773-9899-7cb6c26c103e
# ╠═89c59ecd-faa1-475e-9835-494bc5f88aa7
# ╠═7c2b993e-7abd-45de-8e55-373582193d6a
# ╠═10fa44af-f5ba-4fc5-8675-4158e3df381a
# ╠═805355f0-9a9d-4a0a-8af3-194f84b598eb
# ╠═49e3b310-b52c-49f1-9d42-d81749b7ece9
# ╟─2e1ab134-5062-4bea-a98a-d599593bb20f
# ╠═27993303-23c0-43bf-9134-b73de37eb5f7
# ╠═ae4aff0f-ea4d-41a6-8f5d-656c7da8842e
# ╠═944ab70f-beff-4dd5-a3d2-a9329c3b40ce
# ╟─af965f0e-d687-431e-b8fc-be8991c1fec5
# ╟─95eed7dc-b95e-4795-86e8-8f74b5da083d
# ╠═35e230ea-e342-49f8-aeab-1e4607b256a2
# ╠═b87124b5-72c6-406f-b098-215c235ad6a1
# ╠═c8ff898f-1d90-4020-a205-1603dee22f50
# ╠═6d87887f-a051-4a1f-9aa6-2c3053cee772
# ╠═b674c60f-a0fb-4ec2-a9d2-59099e952f99
# ╟─dda64c40-6fe5-4619-8c07-de833ecc5dbd
# ╠═f0a95dbd-5151-458f-ba44-edde05f02da6
# ╟─8c9d788a-e87f-4c6e-ad6d-6bad6d82113c
# ╟─606355de-0d55-4a8a-98a0-289a2733e8c7
# ╟─0a1492fe-3148-4dfc-a9f2-8408163d0fa3
# ╟─a91c2b3a-cf2d-4f32-babd-b9aa3464aadf
# ╟─bebaad61-3d6f-49d7-82da-335077da52be
# ╟─f954f820-7a89-4e76-be88-3bbd21a25177
# ╟─2f0c5fe4-1591-418e-9b7c-639bd7bed30c
# ╟─542f3fb3-2063-4a0e-a6bf-8fcfa7c05260
# ╟─2502200d-8dae-4aab-be36-27e39aa92591
# ╟─5f241897-8655-4687-9302-aaac54666dba
# ╟─4ef24d3c-bbf1-4d8d-9ad7-542080d5ce22
# ╟─5f784dbd-3443-411e-b8ad-0e85d769f979
# ╟─74c70c81-3b31-45b7-a71c-60a03ececc4a
# ╟─fff50b12-82b7-40a5-ad28-a89fb0d6969f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
