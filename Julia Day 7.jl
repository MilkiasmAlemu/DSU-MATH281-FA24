### A Pluto.jl notebook ###
# v0.19.47

using Markdown
using InteractiveUtils

# ╔═╡ d27f097c-d668-4522-9934-e850d37d879a
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools
end

# ╔═╡ 44027180-877c-11ef-18ee-d365a175375f
using Distributions, StatsBase, Random

# ╔═╡ aee8d43b-6003-4152-928d-ecbada70f87b
@htl("""
	<head>
		<script src="https://d3js.org/d3.v7.min.js"></script>
	</head>
	<h1>Central Limit Theorem Lab</h1>
""")

# ╔═╡ 0c3a9383-5abd-45b3-9ded-49cfa60cf521
TableOfContents()

# ╔═╡ 839e2e01-7e65-4fb2-a2d3-beb8eed15f44
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ fffc8e19-abb3-4a0b-80cb-123b5f7de4d0
@htl("""
	<hr>
""")

# ╔═╡ 9e4058a5-38b2-4509-87a9-db9399b2c5f3
@htl("""
	<h2>Election Polling Bias</h2>
""")

# ╔═╡ b7bc4370-0a50-43c2-9402-92327c9efbb6
begin
	X = DiscreteNonParametric([1, 2], [0.4,0.6])
	polling_sample_1 = rand(X,1000)
	polling_sample_2 = sample([1,2], Weights([0.65,0.35]), 1000)
	many_polling_samples = shuffle(vcat([rand(X,100) for i in 1:7], [sample([1,2], Weights([0.57,0.43]), 100) for i in 1:3]))
	initial_polling_sample = rand(X,100)
end;

# ╔═╡ 12dbe29b-ffc0-4f4d-bc26-714401b44ec6
polling_sample_1

# ╔═╡ a46673b6-8cd7-49d9-876a-846e08857b60
polling_sample_2

# ╔═╡ 496c51de-0b53-4e93-b57f-8bcdaa4d5876
countmap(polling_sample_1)

# ╔═╡ b6ea2efa-994b-4773-aaaf-64826858bc6a
countmap(polling_sample_2)

# ╔═╡ d6d06e20-aaa2-4d5a-b7cc-3739f281207f
[mean(polling_sample_1), mean(polling_sample_2)]

# ╔═╡ d77772b5-ef46-413a-bbed-cc1c7625367a
many_polling_samples

# ╔═╡ ac0334e3-0b01-455d-abeb-62d6ec172eb2
countmap.(many_polling_samples)

# ╔═╡ a1a8c802-205c-4106-971b-a6bda8e4f833
many_polling_means = mean.(many_polling_samples)

# ╔═╡ 3502291d-0a65-48ad-ad4a-3aa56dc6392a
mean(many_polling_means)

# ╔═╡ 1fb52223-3e0a-4d56-b427-8581bdcacfa8
@htl("""
	<hr>
""")

# ╔═╡ c6422c0e-5b70-4b5c-814a-896fbdd4b94f
@htl("""
	<h2>Bootstrapping</h2>
""")

# ╔═╡ e34909d3-dfaa-419f-a2f5-e4528ed8f6e9
initial_polling_sample

# ╔═╡ 206f0ae4-65c0-4d6b-8673-cf40e32e4fbf
mean(initial_polling_sample)

# ╔═╡ 4ef05424-a557-447e-816b-b87ab9576fa9
bootstrapped_samples = [rand(initial_polling_sample, 100) for i in 1:1000]

# ╔═╡ 86d845b8-46bd-488b-8862-e7f45b1d1afc
countmap.(bootstrapped_samples)

# ╔═╡ b06c8441-2765-4a5e-a350-9e25db7f6d0e
bootstrapped_means = mean.(bootstrapped_samples)

# ╔═╡ b4936bcf-edbf-4e72-8d43-80d8c83fe1c0
mean(bootstrapped_means)

# ╔═╡ 9056c376-174c-4ec6-afdc-4401b00445ff
@htl("""
	<hr>
""")

# ╔═╡ b46eeb35-114b-413a-a2da-23be93444d69
@htl("""
	<h2>The Galton Board</h2>
""")

# ╔═╡ 2970e0c0-94d4-4d14-b687-1b77e35c5f61
@htl("""
	<style>
		#galton-board
			{
				margin: 2.5px 20px 20px 20px;
				background-color: white;
			}
		.peg
			{
				fill: steelblue;
			}
		.ball
			{
				fill: tomato;
			}
		.hist-bar
			{
				fill: lightcoral;
				opacity: 0.75;
			}
		.normal-curve
			{
				fill: none;
				stroke: steelblue;
				stroke-width: 3;
			}
		.controls
			{
				margin: 20px 20px 2.5px 20px;
				background-color: rgba(255,255,255,0.1);
				width: 600px;
			}
	</style>

	<div class="controls">
		<label>&nbsp;&nbsp;&nbsp;Rows: <input type="range" id="row-slider" min="5" max="20" value="5"></label>
		<span id="row-count">5</span>
		<br>
		<label>&nbsp;&nbsp;&nbsp;Drop Delay: <input type="range" id="speed-slider" min="0.5" max="2" value="2" step="0.1"></label>
		<span id="speed-count">2.0</span> seconds
		<br>
		&nbsp;&nbsp;&nbsp;<button id="start-stop">Start</button>
		&nbsp;&nbsp;&nbsp;<button id="reset">Reset</button>
	</div>

	<svg id="galton-board" width="600" height="600"></svg>

	<script>
		const svg = d3.select("#galton-board");
		const width = +svg.attr("width");
		const height = +svg.attr("height");
		
		let rows = 5;
		const pegRadius = 5;
		const ballRadius = 6;
		let dropDelay = 2000;
		const ballFallDuration = 2000;
		const histogramHeight = 150;
		let animationInterval = null;
		let ballCount = Array(rows + 1).fill(0);
		
		function initializeBoard()
		{
			svg.selectAll("*").remove();
			ballCount = Array(rows + 1).fill(0);
		
			const pegSpacingY = (height - 250) / rows;
		
			const binWidth = width / (rows + 1);
			const pegSpacingX = width / (rows + 1);
		
			for (let row = 0; row < rows; row++)
			{
				for (let col = 0; col <= row; col++)
				{
					const x = (width / 2) - (row / 2) * pegSpacingX + col * pegSpacingX;
					const y = 100 + row * pegSpacingY;
					svg.append("circle")
						.attr("class", "peg")
						.attr("cx", x)
						.attr("cy", y)
						.attr("r", pegRadius);
				}
			}

			updateNormalCurve();
		}
		
		function dropBall()
		{
			const ball = svg.append("circle")
				.attr("class", "ball")
				.attr("cx", width / 2)
				.attr("cy", 50)
				.attr("r", ballRadius);
		
			const pegSpacingY = (height - 250) / rows;
			const binWidth = width / (rows + 1);
			const pegSpacingX = width / (rows + 1);
		
			let currentX = width / 2;
			let currentY = 50 + pegSpacingY / 4;
		
			for (let row = 0; row < rows; row++)
			{
				setTimeout(() =>
				{
					const randomDirection = Math.random() < 0.5 ? -1 : 1;
					currentX += randomDirection * pegSpacingX / 2;
					currentY += pegSpacingY;
		
					ball.transition()
						.duration(ballFallDuration / rows)
						.attr("cx", currentX)
						.attr("cy", currentY);
				}, row * (ballFallDuration / rows));
			}
		
			setTimeout(() =>
			{
				const binIndex = Math.floor(currentX / binWidth);
				ball.transition()
					.duration(ballFallDuration / rows)
					.attr("cy", height)
					.on("end", () =>
					{
						ball.remove();
					});
		
				ballCount[binIndex]++;
				updateHistogram();
			}, rows * (ballFallDuration / rows));
		}
		
		function updateHistogram()
		{
			const binWidth = width / (rows + 1);
			const maxCount = Math.max(...ballCount);
		
			const yScale = d3.scaleLinear()
				.domain([0, maxCount])
				.range([height, height - histogramHeight]);
		
			const bars = svg.selectAll(".hist-bar")
				.data(ballCount);
		
			bars.transition()
				.duration(500)
				.attr("y", d => yScale(d))
				.attr("height", d => height - yScale(d));
		
			bars.enter().append("rect")
				.attr("class", "hist-bar")
				.attr("x", (d, i) => i * binWidth)
				.attr("width", binWidth - 2)
				.attr("y", d => yScale(d))
				.attr("height", d => height - yScale(d));
		}
		
		function updateNormalCurve()
		{
			const binWidth = width / (rows + 1);
			const mean = (rows + 1) / 2;
			const variance = rows / 4;
			const stdDev = Math.sqrt(variance);
		
			const yScale = d3.scaleLinear()
				.domain([0, 1])
				.range([height, height - histogramHeight]);
		
			const normal = d3.line()
				.x((d, i) => d * binWidth)
				.y((d) =>
				{
					const z = (d - mean) / stdDev;
					const normalHeight = Math.exp(-0.5 * z * z);
					return yScale(normalHeight);
				});
		
			const normalData = d3.range(0, rows + 1.1, 0.1);
		
			const path = svg.selectAll(".normal-curve").data([normalData]);
		
			path.transition()
				.duration(500)
				.attr("d", normal);
		
			path.enter().append("path")
				.attr("class", "normal-curve")
				.attr("d", normal);
		}
		
		document.getElementById('start-stop').addEventListener('click', function ()
		{
			if (animationInterval)
			{
				clearInterval(animationInterval);
				animationInterval = null;
				this.textContent = 'Start';
			}
			else
			{
				animationInterval = setInterval(dropBall, dropDelay);
				this.textContent = 'Stop';
			}
		});
		
		document.getElementById('reset').addEventListener('click', function ()
		{
			clearInterval(animationInterval);
			animationInterval = null;
			ballCount.fill(0);
			svg.selectAll(".hist-bar").remove();
			svg.selectAll(".normal-curve").remove();
			svg.selectAll(".ball").remove();
			initializeBoard();
			document.getElementById('start-stop').textContent = 'Start';
		});
		
		document.getElementById('row-slider').addEventListener('input', function ()
		{
			rows = +this.value;
			document.getElementById('row-count').textContent = rows;
			initializeBoard();
		});
		
		document.getElementById('speed-slider').addEventListener('input', function ()
		{
			const delayInSeconds = +this.value;
			dropDelay = delayInSeconds * 1000;
			document.getElementById('speed-count').textContent = delayInSeconds.toFixed(1);
			if (animationInterval)
			{
				clearInterval(animationInterval);
				animationInterval = setInterval(dropBall, dropDelay);
			}
		});
		
		initializeBoard();
	</script>
""")

# ╔═╡ b687c7c8-485e-4b63-9158-f05f391f7ce0
@htl("""
	<hr>
""")

# ╔═╡ 544a3f59-e4ba-455a-ab1b-fab3079d6fa0
function line_plot(data::AbstractArray; x_start = nothing, x_stop = nothing)
	local freq_map = sort(countmap(data), by=first)
	local unique_values = collect(keys(freq_map))
	local frequencies = collect(values(freq_map))
	
	local x_min = x_start === nothing ? minimum(unique_values) : x_start
	local x_max = x_stop === nothing ? maximum(unique_values) : x_stop
	local svg_width = 500
	local svg_height = 400
	local margin = (top = 20, right = 20, bottom = 30, left = 40)
	local plot_width = svg_width - margin.left - margin.right
	local plot_height = svg_height - margin.top - margin.bottom
	local plot_UUID = string(uuid1())
	local plot_ID = "line-plot-"*plot_UUID

    return @htl("""
		<style>
			.stem {
				stroke: steelblue;
				stroke-width: 2px;
			}
			.circle {
				fill: steelblue;
			}
			.line-plot {
				background-color: white;
			}
			.axis text{
				fill: black;
			}
		</style>

		<svg id=$(plot_ID) class="line-plot" width="$svg_width" height="$svg_height"></svg>

		<script>
			const data = $frequencies;
			const labels = $unique_values;
			
			const margin = {top: $margin.top, right: $margin.right, bottom: $margin.bottom, left: $margin.left};
			const width = $plot_width;
			const height = $plot_height;
			
			const svg = d3.select("#"+$(plot_ID))
				.attr("width", width + margin.left + margin.right)
				.attr("height", height + margin.top + margin.bottom)
				.append("g")
				.attr("transform", `translate(\${margin.left},\${margin.top})`);
			
			const xScale = d3.scaleLinear()
				.domain([$x_min, $x_max])
				.range([0, width]);
			
			const yScale = d3.scaleLinear()
				.domain([0, d3.max(data)])
				.range([height, 0]);
			
			svg.append("g")
				.attr("class", "axis")
				.attr("transform", `translate(0,\${height})`)
				.call(d3.axisBottom(xScale).tickValues(labels))
					.selectAll("text")  
					.style("text-anchor", "end")
					.attr("dx", "-.8em")
					.attr("dy", ".15em")
					.attr("transform", "rotate(-65)");
			
			svg.append("g")
				.attr("class", "axis")
				.call(d3.axisLeft(yScale));
	
			svg.selectAll(".stem")
				.data(data)
				.enter().append("line")
				.attr("class", "stem")
				.attr("x1", (d, i) => xScale(labels[i]))
				.attr("x2", (d, i) => xScale(labels[i]))
				.attr("y1", height)
				.attr("y2", d => yScale(d));
			
			svg.selectAll(".circle")
				.data(data)
				.enter().append("circle")
				.attr("class", "circle")
				.attr("cx", (d, i) => xScale(labels[i]))
				.attr("cy", d => yScale(d))
				.attr("r", 5);
		</script>
    """)
end;

# ╔═╡ 40dffc65-f902-4329-ae20-142fcaf66aea
line_plot(many_polling_means)

# ╔═╡ 173e523f-b78a-4d44-870d-018d139930a5
line_plot(many_polling_means, x_start=1, x_stop=2)

# ╔═╡ 8005e1f4-4970-4d84-8097-4542947246e7
line_plot(bootstrapped_means)

# ╔═╡ 763d1739-7ec3-4ab5-a6bf-41bb68e0985f
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

# ╔═╡ 40fb4f7c-7ddf-4a22-b76f-d9ed4aacfd00
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

# ╔═╡ bbb08522-b0c0-4de5-b1fa-4d4180f81fbb
render_infobox(InfoBox(body_text="It is election season in the fictional town of Statsburgh, and we have two candidates running for mayor. The two candidates, Candidate ``1`` named Anscombe and Candidate ``2`` named Bernoulli, have both been polling very near one another, and the public wants to know who will be their next mayor!"))

# ╔═╡ 6bcf8c7c-3ffb-4efa-9cb8-96fd1fd8d9ef
render_infobox(InfoBox(body_text="Since we do not know how every single person is planning on voting, we have to make do with polls. From this survey of a portion of this bustling town, we hope to infer who the people really want before election day. Unfortunately, not all polls are perfect, and sometimes there is going to be some bias. A pollster may (either intentionally or unintentionally) canvas people that are not **truly** representative of the population as a whole."))

# ╔═╡ 82eefaec-70fc-4441-9cc1-2a6f043eb91f
render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, body_text="Below are two different polls, each of ``1000`` different individuals, where we asked for which candidate they were planning to vote. If we look at these two polls and their means, we see pretty different stories. What could be going on here? Can you say anything about who you think will win?"))

# ╔═╡ 12913e60-28f0-4769-99b3-178317bb6243
render_infobox(InfoBox(body_text="These are relatively large samples, so they should give a decent idea about what the final voting pattern should look like. Because we only have two different polls, we do not have much more that we can say other than one of them might be accurate, or maybe they are both biased in opposite directions. With only this information, who knows what will happen!"))

# ╔═╡ a4bcad2e-fcae-4727-b5b5-fc793af16865
render_infobox(InfoBox(body_text="Instead of taking these large and expensive polls of many different people from two large samples, suppose we have other polling data that have substantially smaller sample sizes. Below, we have ten different polls each of ``100`` different people. There seems to be some bias floating around, but we are not really sure how strong it is or for which candidate."))

# ╔═╡ 6bba301e-0021-4ddb-b340-d0d8140a9edd
render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, body_text="What do you notice about these smaller samples? Does there seem to be bias still? What would you expect the result of this mayoral election to be?"))

# ╔═╡ 0fac0260-a610-43ed-a12a-88be37445902
render_infobox(InfoBox(body_text="Here we are forming a sampling distribution, and we should probably expect the average of these means to be pretty close to what the actual average of the candidates for which the population as a whole plans to vote. In particular, unless every pollster (or even the majority) are very biased in their sampling, we have more reason to expect these results to be more accurate."))

# ╔═╡ c92e1983-25cd-45d0-9fde-c02d2bd98d93
render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, body_text="If we were to decrease the sample size even further while keeping the same number of total people polled, do you think this would be better or worse? What if we made the sample size ``1``, then what would this be doing?"))

# ╔═╡ 71c48685-be40-488e-8513-bdfd4fc478a4
render_infobox(InfoBox(body_text="Sometimes it is not easy to collect data and we may only be able to get a single relatively small sample. This has both the downside of not being a large enough sample to be confident that it really captures all of the detail of the population, as well as not being varied enough to be confident that it is unbiased. One thing we might try is to **resample** our original sample in a process that is known as **bootstrapping**."))

# ╔═╡ 9cb92e1f-b196-4bf5-81ad-c27085c8d58c
render_infobox(InfoBox(body_text="Below we have a poll that has a relatively small sample size of ``100`` people."))

# ╔═╡ dcc1a924-8d51-4ea9-946d-f466f68a1b30
render_infobox(InfoBox(body_text="The idea of bootstrapping is to form many samples from this **starting sample**."))

# ╔═╡ 67187908-0e35-4726-89ba-47d1e45d3958
render_infobox(InfoBox(body_text="This new sampling distribution will be approximately normal around the mean of the initial polling data. The big picture idea is that this approximate normal distribution should reasonably be nearby the population mean, unless our data was very, very biased. In particular, the election average that we are looking for should be within one standard deviation of this approximate bell curve about ``68\\%`` of the time, two standard deviations about ``95\\%`` of the time, etc."))

# ╔═╡ 44a74757-dc95-4807-a22f-1771a4a24180
render_infobox(InfoBox(body_text="For distributions that are not Bernoulli (for example an election with ten candidates), this is a good way to limit the weight of outliers that may appear in samples due to random chance."))

# ╔═╡ bf197d37-25ad-464c-8bee-8d03a2ec246d
render_infobox(InfoBox(body_text="One nice visualization of the Central Limit Theorem is known as a **Galton Board**. This is a construction where a series of pegs are placed in a triangular pattern. At the top, coins are dropped and allowed to fall downward. At each peg, the coin randomly (with equal chance) travels either to the left or right after bouncing off the peg."))

# ╔═╡ 941b57b9-0a97-4ffe-a001-4c6657741eb6
render_infobox(InfoBox(body_text="The equal chance of traveling to the left or right is a **Bernoulli Distribution** of ``50\\%`` probability. Repeated bouncing off of pegs means that the final boxes that are formed will eventually look like a **Binomial Distribution** with ``N`` equal to the number of rows."))

# ╔═╡ 84c3a2a2-0f5a-484e-8477-4f97b7c7e2d2
render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, body_text="The claim is that the final box–plot that is formed eventually looks like a Normal Distribution because of the Central Limit Theorem. Otherwise stated, the Binomial Distribution is approximately Normal for large enough ``N`` and ``p=0.5``. Why is this true? In particular, where is the Sampling Distribution ``\\overline{X}`` in this example?"))

# ╔═╡ 5d025222-be66-4e16-bdcb-c7fbedc243ea
render_infobox(InfoBox(body_text="This is an [actual physical object](https://en.wikipedia.org/wiki/Galton_board) that one can make. It's pretty neat!"))

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
git-tree-sha1 = "f389674c99bfcde17dc57454011aa44d5a260a40"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.6.0"

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
git-tree-sha1 = "c2b5e92eaf5101404a58ce9c6083d595472361d6"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.0.2"

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
# ╟─d27f097c-d668-4522-9934-e850d37d879a
# ╟─aee8d43b-6003-4152-928d-ecbada70f87b
# ╟─0c3a9383-5abd-45b3-9ded-49cfa60cf521
# ╟─839e2e01-7e65-4fb2-a2d3-beb8eed15f44
# ╠═44027180-877c-11ef-18ee-d365a175375f
# ╟─fffc8e19-abb3-4a0b-80cb-123b5f7de4d0
# ╟─9e4058a5-38b2-4509-87a9-db9399b2c5f3
# ╟─bbb08522-b0c0-4de5-b1fa-4d4180f81fbb
# ╟─6bcf8c7c-3ffb-4efa-9cb8-96fd1fd8d9ef
# ╟─82eefaec-70fc-4441-9cc1-2a6f043eb91f
# ╠═12dbe29b-ffc0-4f4d-bc26-714401b44ec6
# ╠═a46673b6-8cd7-49d9-876a-846e08857b60
# ╠═496c51de-0b53-4e93-b57f-8bcdaa4d5876
# ╠═b6ea2efa-994b-4773-aaaf-64826858bc6a
# ╠═d6d06e20-aaa2-4d5a-b7cc-3739f281207f
# ╟─12913e60-28f0-4769-99b3-178317bb6243
# ╟─a4bcad2e-fcae-4727-b5b5-fc793af16865
# ╠═d77772b5-ef46-413a-bbed-cc1c7625367a
# ╠═ac0334e3-0b01-455d-abeb-62d6ec172eb2
# ╠═a1a8c802-205c-4106-971b-a6bda8e4f833
# ╠═3502291d-0a65-48ad-ad4a-3aa56dc6392a
# ╠═40dffc65-f902-4329-ae20-142fcaf66aea
# ╠═173e523f-b78a-4d44-870d-018d139930a5
# ╟─6bba301e-0021-4ddb-b340-d0d8140a9edd
# ╟─0fac0260-a610-43ed-a12a-88be37445902
# ╟─c92e1983-25cd-45d0-9fde-c02d2bd98d93
# ╟─b7bc4370-0a50-43c2-9402-92327c9efbb6
# ╟─1fb52223-3e0a-4d56-b427-8581bdcacfa8
# ╟─c6422c0e-5b70-4b5c-814a-896fbdd4b94f
# ╟─71c48685-be40-488e-8513-bdfd4fc478a4
# ╟─9cb92e1f-b196-4bf5-81ad-c27085c8d58c
# ╟─e34909d3-dfaa-419f-a2f5-e4528ed8f6e9
# ╠═206f0ae4-65c0-4d6b-8673-cf40e32e4fbf
# ╟─dcc1a924-8d51-4ea9-946d-f466f68a1b30
# ╠═4ef05424-a557-447e-816b-b87ab9576fa9
# ╠═86d845b8-46bd-488b-8862-e7f45b1d1afc
# ╠═b06c8441-2765-4a5e-a350-9e25db7f6d0e
# ╠═b4936bcf-edbf-4e72-8d43-80d8c83fe1c0
# ╠═8005e1f4-4970-4d84-8097-4542947246e7
# ╟─67187908-0e35-4726-89ba-47d1e45d3958
# ╟─44a74757-dc95-4807-a22f-1771a4a24180
# ╟─9056c376-174c-4ec6-afdc-4401b00445ff
# ╟─b46eeb35-114b-413a-a2da-23be93444d69
# ╟─bf197d37-25ad-464c-8bee-8d03a2ec246d
# ╟─2970e0c0-94d4-4d14-b687-1b77e35c5f61
# ╟─941b57b9-0a97-4ffe-a001-4c6657741eb6
# ╟─84c3a2a2-0f5a-484e-8477-4f97b7c7e2d2
# ╟─5d025222-be66-4e16-bdcb-c7fbedc243ea
# ╟─b687c7c8-485e-4b63-9158-f05f391f7ce0
# ╟─544a3f59-e4ba-455a-ab1b-fab3079d6fa0
# ╟─40fb4f7c-7ddf-4a22-b76f-d9ed4aacfd00
# ╟─763d1739-7ec3-4ab5-a6bf-41bb68e0985f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
