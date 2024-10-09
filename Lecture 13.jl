### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 6e0e7a30-eb30-4cbd-874f-cc694cc50e1b
using HypertextLiteral, UUIDs

# ╔═╡ 04eca7a4-68f6-4418-89f3-c883b75d040b
using Random, Distributions

# ╔═╡ dd5f9428-3b9e-45a0-8e52-25ff86e8398d
@htl("""
	<h1>Lecture 13</h1>
""")

# ╔═╡ 9d424b5b-294e-4823-914c-6bab99f5ccc6
@htl("""
	<h2>Central Limit Theorem</h1>
""")

# ╔═╡ c3201be2-49c8-4bbf-a8cc-e4e4cf7b76f4
X = Uniform(-1,4)

# ╔═╡ 8bc25563-96af-4400-8fdd-d0d2d918960a
@htl("""
	<hr>
""")

# ╔═╡ 22733919-f9b6-4e5e-a1a3-633f56d27843
# Function for Plotting and Sampling a Distribution with Central Limit Theorem
function plotSampleDist(X::UnivariateDistribution)
	local width = 500
	local height = 300
	local bottom_margin = 30
	local x_start = (minimum(X) == -Inf) ? -10.5 : minimum(X)-0.5
	local x_end = (maximum(X) == Inf) ? 10.5 : maximum(X)+0.5
	local paddingLeft = 25
	local slider_height = 30

	local min_rate = 500
	local max_rate = 1000
	local resolution = 0.001
	local x_vals = filter(x -> insupport(X,x), range(x_start, x_end, step=resolution))
	local pdf_vals = pdf.(X, x_vals)
	local ex = mean(X)
	local stddev = std(X)
	local samples = rand(X, 10000)
	local max_prob = maximum(pdf_vals)
	
	local DistUUID = string(uuid1())
	
	local x_zero_position = paddingLeft + (0 - x_start) * (width - 2 * paddingLeft) / (x_end - x_start)
	
	return @htl("""
		<svg width="$(width)" height="$(2*height)" style="background-color: white;" id=$(DistUUID*"-axis-svg")>
			<g id=$(DistUUID*"-pdf-curve-group")></g>
			<g id=$(DistUUID*"-line-group")></g>
			<g id=$(DistUUID*"-area-group")></g>
			<g id=$(DistUUID*"-normal-pdf-curve-group")></g>
			<g id=$(DistUUID*"-histogram-group")></g>
			<g id=$(DistUUID*"-top-circle-group")></g>
			<g id=$(DistUUID*"-middle-circle-group")></g>
			<g id=$(DistUUID*"-bottom-circle-group")></g>
			<line x1="$(paddingLeft)" y1="$(height-bottom_margin)" x2="$(width-paddingLeft)" y2="$(height-bottom_margin)" stroke="black" stroke-width="2" opacity="0.5"/>
			<line x1="$(x_zero_position)" y1="$(height-bottom_margin)" x2="$(x_zero_position)" y2="10" stroke="black" stroke-width="2" opacity="0.5"/>
			<line x1="$(paddingLeft)" y1="$(2*height-bottom_margin)" x2="$(width-paddingLeft)" y2="$(2*height-bottom_margin)" stroke="black" stroke-width="2" opacity="0.5"/>
			<line x1="$(x_zero_position)" y1="$(2*height-bottom_margin)" x2="$(x_zero_position)" y2="$(height - 20 +  bottom_margin)" stroke="black" stroke-width="2" opacity="0.5"/>
		</svg>

		<div style="background-color: grey; opacity: 0.75; width: $(width)px; height: $(slider_height)px; position: relative; display: flex; justify-content: space-between; align-items: center; padding: 0 10px;">
		    <h6 style="color: white; flex-basis: 30%; margin: 0; display: flex; align-items: center; justify-content: center;">Sampling Rate</h6>
		    <h6 style="color: white; flex-basis: 30%; margin: 0; display: flex; align-items: center; justify-content: center;">Number of Bins</h6>
			<h6 style="color: white; flex-basis: 30%; margin: 0; display: flex; align-items: center; justify-content: center;">Samples per Mean</h6>
		</div>
	
		<div style="background-color: grey; opacity: 0.75; width: $(width)px; height: $(slider_height)px; position: relative; display: flex; justify-content: center; align-items: center;">
			<input type="range" id=$(DistUUID*"-rate-slider") min="$(min_rate)" max="$(max_rate)" step="25" value="$(min_rate)" style="width: 30%;"/>
    		<input type="range" id=$(DistUUID*"-bin-slider") min="10" max="100" step="1" value="25" style="width: 30%;"/>
			<input type="range" id=$(DistUUID*"-sample-slider") min="1" max="10" step="1" value="1" style="width: 30%;"/>
		</div>

		<div style="background-color: grey; opacity: 0.75; width: $(width)px; height: $(slider_height)px; position: relative; display: flex; justify-content: center; align-items: center;">
			<h6 style="color: white; flex-basis: 25%; margin: 0; display: flex; align-items: center; justify-content: center;"></h6>
			<h6 style="color: white; flex-basis: 50%; margin: 0; display: flex; align-items: center; justify-content: center;">Show Theoretical Distribution</h6>
			<div style="width: 25%;">
				<input type="checkbox" id=$(DistUUID*"-dist-checkbox")/>
				<label for=$(DistUUID*"-dist-checkbox") value="isDist"></label>
			</div>
		</div>
		
		<script>
			const svg = document.getElementById($(DistUUID*"-axis-svg"));
			const rateSlider = document.getElementById($(DistUUID*"-rate-slider"));
			const binSlider = document.getElementById($(DistUUID*"-bin-slider"));
			const sampleSlider = document.getElementById($(DistUUID*"-sample-slider"));
			const distCheckbox = document.getElementById($(DistUUID*"-dist-checkbox"));
			const pdfCurveGroup = document.getElementById($(DistUUID*"-pdf-curve-group"));
			const normalpdfCurveGroup = document.getElementById($(DistUUID*"-normal-pdf-curve-group"));
			const areaGroup = document.getElementById($(DistUUID*"-area-group"));
			const lineGroup = document.getElementById($(DistUUID*"-line-group"));
			const histogramGroup = document.getElementById($(DistUUID*"-histogram-group"));
			const topCircleGroup = document.getElementById($(DistUUID*"-top-circle-group"));
			const middleCircleGroup = document.getElementById($(DistUUID*"-middle-circle-group"));
			const bottomCircleGroup = document.getElementById($(DistUUID*"-bottom-circle-group"));
			const paddingLeft = $(paddingLeft);
			const paddingRight = $(width) - paddingLeft;
			
			const xScaleStart = $(x_start);
			const xScaleEnd = $(x_end);
			const minY = 10;
			const maxY = $(height - bottom_margin);
			const ymax = 1;
			
			const x_vals = $(x_vals);
			const pdf_vals = $(pdf_vals);
			const samples = $(samples);
			const ex = $(ex);
			const stddev = $(stddev);
			const max_prob = $(max_prob);
			const scaleRange = paddingRight - paddingLeft;
			
			function scaleX(value) {
				return paddingLeft + ((value - xScaleStart) * scaleRange / (xScaleEnd - xScaleStart));
			}
			
			function scaleY(value) {
				return minY + (1 - (value / ymax)) * (maxY - minY);
			}
			
			function updatePDF() {
				while (pdfCurveGroup.firstChild) {
					pdfCurveGroup.removeChild(pdfCurveGroup.firstChild);
				}
				
				const path = document.createElementNS("http://www.w3.org/2000/svg", "path");
				let d = `M \${scaleX(x_vals[0])} \${scaleY(pdf_vals[0])}`;
				for (let i = 1; i < x_vals.length; i++) {
					d += ` L \${scaleX(x_vals[i])} \${scaleY(pdf_vals[i])}`;
				}
					path.setAttribute("d", d);
					path.setAttribute("stroke", "rgba(0,0,255,0.75)");
					path.setAttribute("fill", "none");
					path.setAttribute("stroke-width", 2);
				pdfCurveGroup.appendChild(path);
			}
			
			function updateArea() {
				while (areaGroup.firstChild) {
					areaGroup.removeChild(areaGroup.firstChild);
				}
			
				const filledArea = document.createElementNS("http://www.w3.org/2000/svg", "polygon");
				let points = `\${scaleX(x_vals[0])},\${scaleY(0)}`;
				let max_i = x_vals.length - 1;
				for (let i = 0; i < x_vals.length; i++) {
					points += ` \${scaleX(x_vals[i])},\${scaleY(pdf_vals[i])}`;
				}
				points += ` \${scaleX(x_vals[max_i])},\${scaleY(0)}`;
					filledArea.setAttribute("points", points);
					filledArea.setAttribute("fill", "rgba(0,0,255,0.3)");
				areaGroup.appendChild(filledArea);
			}
			
			function updateLines() {
				while (lineGroup.firstChild) {
					lineGroup.removeChild(lineGroup.firstChild);
				}
			
				const exX = scaleX(ex);
				const meanLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
					meanLine.setAttribute("x1", exX);
					meanLine.setAttribute("y1", minY);
					meanLine.setAttribute("x2", exX);
					meanLine.setAttribute("y2", maxY+1);
					meanLine.setAttribute("stroke", "grey");
					meanLine.setAttribute("stroke-width", 2);
					meanLine.setAttribute("stroke-dasharray", "5,5");
				lineGroup.appendChild(meanLine);
				
				const meanLabel = document.createElementNS("http://www.w3.org/2000/svg", "text");
					meanLabel.setAttribute("x", exX);
					meanLabel.setAttribute("y", maxY + 15);
					meanLabel.setAttribute("fill", "black");
					meanLabel.setAttribute("font-size", "15px");
					meanLabel.setAttribute("text-anchor", "middle");
					meanLabel.textContent = ex.toFixed(1);
				lineGroup.appendChild(meanLabel);
				
				const stddevLeft = ex - stddev;
				const stddevRight = ex + stddev;
				const stddevLeftX = scaleX(stddevLeft);
				const stddevRightX = scaleX(stddevRight);
				
				const stddevLineLeft = document.createElementNS("http://www.w3.org/2000/svg", "line");
					stddevLineLeft.setAttribute("x1", stddevLeftX);
					stddevLineLeft.setAttribute("y1", maxY+10);
					stddevLineLeft.setAttribute("x2", stddevLeftX);
					stddevLineLeft.setAttribute("y2", maxY-10);
					stddevLineLeft.setAttribute("stroke", "black");
					stddevLineLeft.setAttribute("stroke-width", 2);
					stddevLineLeft.setAttribute("opacity", "0.5");
				lineGroup.appendChild(stddevLineLeft);
				
				const stddevLeftLabel = document.createElementNS("http://www.w3.org/2000/svg", "text");
					stddevLeftLabel.setAttribute("x", stddevLeftX);
					stddevLeftLabel.setAttribute("y", maxY + 20);
					stddevLeftLabel.setAttribute("fill", "black");
					stddevLeftLabel.setAttribute("font-size", "15px");
					stddevLeftLabel.setAttribute("text-anchor", "middle");
					stddevLeftLabel.textContent = stddevLeft.toFixed(1);
				lineGroup.appendChild(stddevLeftLabel);
				
				const stddevLineRight = document.createElementNS("http://www.w3.org/2000/svg", "line");
					stddevLineRight.setAttribute("x1", stddevRightX);
					stddevLineRight.setAttribute("y1", maxY+10);
					stddevLineRight.setAttribute("x2", stddevRightX);
					stddevLineRight.setAttribute("y2", maxY-10);
					stddevLineRight.setAttribute("stroke", "black");
					stddevLineRight.setAttribute("stroke-width", 2);
					stddevLineRight.setAttribute("opacity", "0.5");
				lineGroup.appendChild(stddevLineRight);
				
				const stddevRightLabel = document.createElementNS("http://www.w3.org/2000/svg", "text");
					stddevRightLabel.setAttribute("x", stddevRightX);
					stddevRightLabel.setAttribute("y", maxY + 20);
					stddevRightLabel.setAttribute("fill", "black");
					stddevRightLabel.setAttribute("font-size", "15px");
					stddevRightLabel.setAttribute("text-anchor", "middle");
					stddevRightLabel.textContent = stddevRight.toFixed(1);
				lineGroup.appendChild(stddevRightLabel);
			}
			
			updatePDF();
			updateArea();
			updateLines();

			let n_bins = 25;
			let bins = Array(n_bins).fill(0);
			let total = 0;
			let binWidth = (paddingRight - paddingLeft) / n_bins;

			function createFallingCircleTop(onComplete) {
				let randomX = scaleX(samples[Math.floor(Math.random() * samples.length)]);
				const radius = 5;
				const acceleration = 0.05;
				let speed = 0;
				let currentY = radius;
				let bouncesLeft = 3;

				const circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
					circle.setAttribute('cx', randomX);
					circle.setAttribute('cy', currentY);
					circle.setAttribute('r', radius);
					circle.setAttribute('fill', 'rgba(0,0,255,1)');
					circle.setAttribute('fill-opacity', '0.5');
				topCircleGroup.appendChild(circle);

				function animateCircle() {
					speed += acceleration;
					currentY += speed;

					if (currentY > maxY) {
						if (bouncesLeft > 0) {
							speed = -Math.abs(speed) * 0.5;
							bouncesLeft -= 1;
						} else {
							speed += acceleration;
						}
					}

					circle.setAttribute('cy', currentY);
	
					if (currentY > $(height) + radius) {
						topCircleGroup.removeChild(circle);
						if (onComplete) onComplete(randomX);
					} else {
						requestAnimationFrame(animateCircle);
					}
				}

				requestAnimationFrame(animateCircle);
			}

			function createFallingCircleMiddle(x_pos, avgX) {
				const radius = 5;
				const acceleration = 0.025;
				let speed = 0;
				let currentX = x_pos;

				const circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
					circle.setAttribute('cx', x_pos);
					circle.setAttribute('cy', $(height) + radius);
					circle.setAttribute('r', radius);
					circle.setAttribute('fill', 'rgba(0,0,255,1)');
					circle.setAttribute('fill-opacity', '0.75');
				middleCircleGroup.appendChild(circle);

				function moveTowardAverage() {
					speed += acceleration;
					currentX += speed * (avgX - currentX);

					circle.setAttribute('cx', currentX);
	
					if (Math.abs(avgX - currentX) < 0.01) {
						middleCircleGroup.removeChild(circle);
					} else {
						requestAnimationFrame(moveTowardAverage);
					}
				}

				requestAnimationFrame(moveTowardAverage);
			}

			function createFallingCircleBottom(x_pos) {
				const radius = 7.5;
				const acceleration = 0.075;
				let speed = 0;
				let currentY = $(height) + radius;
				let bouncesLeft = 3;

				const circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
					circle.setAttribute('cx', x_pos);
					circle.setAttribute('cy', currentY);
					circle.setAttribute('r', radius);
					circle.setAttribute('fill', 'rgba(0,0,255,1)');
					circle.setAttribute('fill-opacity', '0.75');
				bottomCircleGroup.appendChild(circle);

				function animateCircle() {
					speed += acceleration;
					currentY += speed;

					if (currentY > $(height) + maxY) {
						if (bouncesLeft > 0) {
							speed = -Math.abs(speed) * 0.5;
							bouncesLeft -= 1;
						} else {
							speed += acceleration;
						}
					}

					circle.setAttribute('cy', currentY);
	
					if(currentY > 2 * $(height) + radius) {
						bottomCircleGroup.removeChild(circle);
			        	total += 1;
						const binIndex = getBinIndex(x_pos);
						bins[binIndex] += 1;
						updateHistogram();
					} else {
						requestAnimationFrame(animateCircle);
					}
				}

				function getBinIndex(xValue) {
					const binIndex = Math.floor((xValue - paddingLeft) / binWidth);
					return Math.max(0, Math.min(binIndex, n_bins - 1));
				}

				requestAnimationFrame(animateCircle);
			}

			function updateHistogram() {
				while (histogramGroup.firstChild) {
					histogramGroup.removeChild(histogramGroup.firstChild);
				}

				const max_bins = Math.max(...bins);
			
				for (let i = 0; i < n_bins; i++) {
					const binCount = bins[i];
					const barHeight = (binCount / max_bins) * maxY * (max_prob / ymax);
					const barX = paddingLeft + (1/ 2 + i) * binWidth * (n_bins-1) / n_bins;
			
					const rect = document.createElementNS("http://www.w3.org/2000/svg", "rect");
						rect.setAttribute("x", barX);
						rect.setAttribute("y", $(height) + maxY - barHeight);
						rect.setAttribute("width", binWidth * (n_bins-1) / n_bins);
						rect.setAttribute("height", barHeight);
						rect.setAttribute("fill", "rgba(0, 0, 255, 0.25)");
					histogramGroup.appendChild(rect);
				}
			}

			function plotNormal(isChecked) {
				if (isChecked) {
					const new_mean = ex;
					const new_stddev = stddev / Math.sqrt(prev_num);
			
					let newX_vals = [];
					let newPdf_vals = [];

					let max_normal_prob = 1;

					if (prev_num > 1) {
						for (let x = xScaleStart; x <= xScaleEnd; x += $(resolution)) {
							newX_vals.push(x);
		
							const newPdf = (1 / (new_stddev * Math.sqrt(2 * Math.PI))) * Math.exp(-0.5 * Math.pow((x - new_mean) / new_stddev, 2));
							newPdf_vals.push(newPdf);
							max_normal_prob = Math.max(max_normal_prob, newPdf);
						}
					} else {
						newX_vals = x_vals.slice();
						newPdf_vals = pdf_vals.slice();
					}
			
					while (normalpdfCurveGroup.firstChild) {
						normalpdfCurveGroup.removeChild(normalpdfCurveGroup.firstChild);
					}
					const path = document.createElementNS("http://www.w3.org/2000/svg", "path");
					let d = `M \${scaleX(newX_vals[0])} \${$(height) + scaleY(newPdf_vals[0] / max_normal_prob)}`;
					for (let i = 1; i < newX_vals.length; i++) {
						d += ` L \${scaleX(newX_vals[i])} \${$(height) + scaleY(newPdf_vals[i] / max_normal_prob)}`;
					}
					path.setAttribute("d", d);
					path.setAttribute("stroke", "rgba(0,0,255,1)");
					path.setAttribute("fill", "none");
					path.setAttribute("stroke-width", 2);
					normalpdfCurveGroup.appendChild(path);
				} else {
					while (normalpdfCurveGroup.firstChild) {
						normalpdfCurveGroup.removeChild(normalpdfCurveGroup.firstChild);
					}
				}
			}

			let intervalID;
			let prev_rate = $(max_rate);
			let prev_num = 1;
			let isDist = false;

			function startAnimation(rate, num_samples) {
				if (intervalID) {
					clearInterval(intervalID);
				}
				intervalID = setInterval(() => {
					let circles_pos = [];
					let completedCircles = 0;
	
					function circleComplete(x_pos) {
						circles_pos.push(x_pos);
						completedCircles += 1;
						if (completedCircles === num_samples) {
							let avgX = circles_pos.reduce((sum,x) => sum + x, 0) / circles_pos.length;
							for (let i = 0; i < num_samples; i++) {
								createFallingCircleMiddle(circles_pos[i], avgX);
							}
							createFallingCircleBottom(avgX);
						}
					}

					
					for (let i = 0; i < num_samples; i++) {
						createFallingCircleTop(circleComplete);
					}
				}, rate);
			}
			
			rateSlider.addEventListener("input", function(event) {
				const rate = $(max_rate + min_rate) - parseInt(event.target.value);
				prev_rate = rate;
				if (rate < $(max_rate)) {
					startAnimation(rate, prev_num);
				} else {
					if (intervalID) {
						clearInterval(intervalID);
					}
				}
			});

			binSlider.addEventListener("input", function(event) {
				n_bins = parseInt(event.target.value);
				bins = Array(n_bins).fill(0);
				total = 0;
				binWidth = (paddingRight - paddingLeft) / n_bins;
				updateHistogram();
			});

			sampleSlider.addEventListener("input", function(event) {
				const num_samples = parseInt(event.target.value);
				prev_num = num_samples;
				bins = Array(n_bins).fill(0);
				total = 0;
				updateHistogram();
				plotNormal(isDist);
				if (prev_rate < $(max_rate)) {
					startAnimation(prev_rate, num_samples);
				} else {
					if (intervalID) {
						clearInterval(intervalID);
					}
				}
			});

			distCheckbox.addEventListener("change", function(event) {
				const isChecked = event.target.checked;
				isDist = isChecked;
				plotNormal(isChecked);
			});
		</script>
	""")
end;

# ╔═╡ a9e31bb7-5fdc-42d3-8845-6cd894edd8db
plotSampleDist(X)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
Distributions = "~0.25.111"
HypertextLiteral = "~0.9.5"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "29f1245eee4b322a61b92d5f7415e319021fe54a"

[[deps.AliasTables]]
deps = ["PtrArrays", "Random"]
git-tree-sha1 = "9876e1e164b144ca45e9e3198d0b689cadfed9ff"
uuid = "66dad0bd-aa9a-41b7-9441-69ab47430ed8"
version = "1.1.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

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

[[deps.Distributions]]
deps = ["AliasTables", "FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns"]
git-tree-sha1 = "e6c693a0e4394f8fda0e51a5bdf5aef26f8235e9"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.111"

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

[[deps.HypergeometricFunctions]]
deps = ["LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "7c4195be1649ae622304031ed46a2f4df989f1eb"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.24"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLLWrappers]]
deps = ["Artifacts", "Preferences"]
git-tree-sha1 = "f389674c99bfcde17dc57454011aa44d5a260a40"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.6.0"

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

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

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

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

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
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

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

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "66e0a8e672a0bdfca2c3f5937efb8538b9ddc085"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.2.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

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
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

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

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

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

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

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
# ╟─dd5f9428-3b9e-45a0-8e52-25ff86e8398d
# ╟─6e0e7a30-eb30-4cbd-874f-cc694cc50e1b
# ╠═04eca7a4-68f6-4418-89f3-c883b75d040b
# ╟─9d424b5b-294e-4823-914c-6bab99f5ccc6
# ╠═c3201be2-49c8-4bbf-a8cc-e4e4cf7b76f4
# ╠═a9e31bb7-5fdc-42d3-8845-6cd894edd8db
# ╟─8bc25563-96af-4400-8fdd-d0d2d918960a
# ╟─22733919-f9b6-4e5e-a1a3-633f56d27843
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
