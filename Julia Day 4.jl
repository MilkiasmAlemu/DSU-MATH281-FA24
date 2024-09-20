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

# ╔═╡ f06ad5e6-769e-4606-95d4-6df3fb8dd9a7
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools
end

# ╔═╡ 0102e00f-7b7d-4555-a745-66ae8faef890
using StatsBase,Distributions,CSV,HTTP,DataFrames

# ╔═╡ 0f4001c7-19b2-4ab1-951d-b042c77881f8
@htl("""
	<h1>Distribution Lab</h1>
""")

# ╔═╡ a0d6c2a3-f995-47ba-852e-64c68c9ac9b7
TableOfContents()

# ╔═╡ 01dc5bc7-d0f9-47f9-98ad-35c2c261e7c3
@htl("""
<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ 1ac027f3-4183-4578-a7af-d36d65143321
@htl("""
	<hr>
""")

# ╔═╡ 0d6576ae-2826-4517-8245-832c21312495
@htl("""
	<h2>Properties of Statistical Measures</h2>
""")

# ╔═╡ b5feb96b-8a33-47b0-9089-a721f434b77c
aside("This distribution has only a single label that has probability 1",v_offset=50)

# ╔═╡ f484a378-2cd7-4059-8ab1-b52c95536e7c
X_Dirac = Dirac(0.75)

# ╔═╡ 82906eae-3671-4e2a-aad3-18586df6eb8c
aside("Since the variance and standard deviation are 0, the skewness and kurtosis do not make sense here.",v_offset=30)

# ╔═╡ 0cadb1fa-258d-4907-b25a-037acb8091bc
[mean(X_Dirac), var(X_Dirac), std(X_Dirac)]

# ╔═╡ 21fae208-715e-40d3-a6f8-bddf9a891e33
@htl("""
<hr>
""")

# ╔═╡ 2c9b5311-de0a-473b-8ca5-e87f33b9a7c1
@htl("""
	<hr>
""")

# ╔═╡ ccc269fd-278e-4453-88a0-9172b20baaea
@htl("""
	<hr>
""")

# ╔═╡ 7721ab8e-b8ce-4afa-a170-69b409aa30f0
@htl("""
	<h2>Benford's Law</h2>
""")

# ╔═╡ 83bdda56-235c-4624-b368-2c8f83db05d8
begin
	PopulationCSV = HTTP.get("https://raw.githubusercontent.com/plevanDSU/DSU-MATH281-FA24/refs/heads/main/data/population.csv")
	PopulationDF = CSV.File(IOBuffer(PopulationCSV.body)) |> DataFrame
	WorldPopulation = parse(Int, replace(names(PopulationDF)[2],","=>""))
	rename!(PopulationDF, ["Country", "Population"])
	PopulationDF.Population = parse.(Int, replace.(PopulationDF.Population,","=>""))
end;

# ╔═╡ d44561b5-0b71-45b4-92fb-e7fc00091be5
PopulationDF

# ╔═╡ 136ce3a5-0b56-44b3-949f-2433321ac797
PopulationFirstDigits = sort(countmap((x -> parse(Int, first(string(x)))).(PopulationDF.Population)))

# ╔═╡ f43418a4-e5b9-4ea8-a55d-583a6a01c111
@htl("""
<hr>
""")

# ╔═╡ f7622962-7354-44e9-a5cc-24234fd7dbc5
begin
	COVIDCSV = HTTP.get("https://raw.githubusercontent.com/plevanDSU/DSU-MATH281-FA24/refs/heads/main/data/covid.csv")
	COVIDDF = CSV.File(IOBuffer(COVIDCSV.body)) |> DataFrame
	TotalCases = sum(COVIDDF."Number of Cases")
	TotalDeaths = sum(COVIDDF.Deaths)
end;

# ╔═╡ 147f6ced-fa34-445d-b37a-cb0eaf3c0191
COVIDDF

# ╔═╡ 02b4717a-5f70-4ee9-9552-9a5dc8ac4240
CasesFirstDigits = sort(countmap((x -> parse(Int, first(string(x)))).(COVIDDF."Number of Cases")))

# ╔═╡ 20e57950-df5a-4e20-a71c-40e9309f7ccd
begin
	local tempArr = countmap((x -> parse(Int, first(string(x)))).(COVIDDF.Deaths))
	tempArr[6] = 0
	tempArr[7] = 0
	DeathsFirstDigits = sort(tempArr)
end

# ╔═╡ 6e31cce0-dd99-446f-be07-22437dd5f5c1
@htl("""
<hr>
""")

# ╔═╡ e7d56fa2-dead-4a28-b539-ece49457fbc7
@htl("""
<hr>
""")

# ╔═╡ bc65014d-d2fa-4886-b5a4-da02f26c235d
begin
	logBenford(x) = log(10, 1 + 1/x)
	logBenford.(1:9)
end

# ╔═╡ b13eb90f-bc56-4e11-9e10-ad308772027c
@htl("""
<hr>
""")

# ╔═╡ bf49e0dc-f8af-4cee-b095-fbdceb382564
@htl("""
	<h2>Zipf's Law</h2>
""")

# ╔═╡ a8ddb7a4-393d-4a0c-87fd-17e3338a2d01
@bindname N Slider(1:100, show_value=true)

# ╔═╡ a3511fce-cd5b-4f7f-bedf-c4766aa8262f
α = sum([1/x for x in 1:N])

# ╔═╡ c1543df2-1bf7-4296-bc00-33a14430c4c9
f(x) = 1 / α * 1 / x

# ╔═╡ 16b35ab9-f8f3-4074-89ff-273d4c3e8f51
@bindname x Slider(1:N, show_value=true)

# ╔═╡ 6ed6f15a-5bc5-428e-82bc-23ae51772a7f
f(x)

# ╔═╡ 9653f9c6-d309-45bd-b77f-74b63d5dbdc9
@htl("""
<hr>
""")

# ╔═╡ 1df7dbfa-8018-4158-81ab-d062cbeb93b5
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

# ╔═╡ 66b0d106-3844-4a98-a0bc-ec8ab9047ac4
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

# ╔═╡ fe248d65-3681-49ff-a5ae-2030f14b230a
render_infobox(InfoBox(outer_box_saturation=0, outer_box_lightness=25,inner_box_saturation=0, inner_box_lightness=20, body_text="The **Variance** of a distribution ``X`` with probability function ``f(X)`` is given by: \n```math\n\\sigma^2=\\text{E}\\left[\\left(X - \\mu\\right)^2\\right]=\\sum_{x}\\left(x - \\mu\\right)^2\\cdot f(x)\n```\n The **Skewness** is given by: \n```math\n\\gamma=\\text{E}\\left[\\left(\\frac{X - \\mu}{\\sigma}\\right)^3\\right]=\\sum_{x}\\left(\\frac{x - \\mu}{\\sigma}\\right)^3\\cdot f(x)\n```\n The **Kurtosis** is given by: \n```math\n\\kappa=\\text{E}\\left[\\left(\\frac{X - \\mu}{\\sigma}\\right)^4\\right]=\\sum_{x}\\left(\\frac{x - \\mu}{\\sigma}\\right)^4\\cdot f(x)\n```\n Try to convince yourself why these measures have their listed properties."))

# ╔═╡ b60f2c7f-4b45-4703-88df-5e36052ffba3
render_infobox(InfoBox(title_text="Variance of the Dirac Distribution", body_text="For the Dirac Distribution at ``x=a``, the Expected Value is ``a`` and the Variance is ``0``."))

# ╔═╡ 0411535e-4fae-4595-b7a0-e1e8465b639e
render_infobox(InfoBox(title_text="Variance and Kurtosis are Non–Negative", body_text="The Variance and Kurtosis satisfy:\n```math\n\\sigma^2 \\geq 0 \\qquad\\text{ and }\\qquad \\kappa \\geq 0\n```"))

# ╔═╡ 092ec7ce-db10-489a-97f2-5db554ae26cf
render_infobox(InfoBox(title_text="World Population", body_text="The [UN estimates](https://en.wikipedia.org/wiki/List_of_countries_and_dependencies_by_population) of the populations of countries are given in the table below. If we make a count of the first digits of all of the populations, we get the list below this."))

# ╔═╡ 44210666-efa7-4437-abb2-705489306b69
render_infobox(InfoBox(body_text="Below is a plot of these frequencies along with the graph of:\n```math\ny=\\log_{10}\\left(1+\\frac{1}{x}\\right)\n```"))

# ╔═╡ 905a9e06-8364-4908-bb33-e6ff18516050
render_infobox(InfoBox(title_text="COVID Cases and Deaths", body_text="[COVID Confirmed Case and Death Numbers](https://github.com/nytimes/covid-19-data?tab=readme-ov-file) by state and territory up to 2023 are given in the table below. If we make a count of the first digits of all of the cases or deaths, we get the list below this."))

# ╔═╡ 2fb63029-bd1b-4aa7-b67b-65a31696040e
render_infobox(InfoBox(body_text="Below are plots of these frequencies along with the graph of:\n```math\ny=\\log_{10}\\left(1+\\frac{1}{x}\\right)\n```"))

# ╔═╡ 1fc6dcd8-000f-4acd-a126-1756c0b2fec3
render_infobox(InfoBox(title_text="Random Numbers", body_text="Below is the frequency plot of the first digit of ``1000`` numbers where we first choose a random number between ``1`` and ``10000`` and then raise that number to the power of ``4``."))

# ╔═╡ 216bffd0-e281-4e30-bbda-8a1884b87c22
render_infobox(InfoBox(title_text="Benford's Law", body_text="Benford's Law states that, in many cases, when you have data which spans many order of magnitudes, the first digits of the data have frequencies which pretty closely follow this data. That is, the frequency of ``1``, ``2``, ``3``, etc. as first digits are given by:"))

# ╔═╡ 9b49fe75-78d4-4119-87a5-6f51b746bc67
render_infobox(InfoBox(body_text="This is frequently used in practice to test if data comes from the real world, or if there is fraud. For example, in accounting, criminal trials, elections, etc.. If somebody is making up data, they often do not respect this rule since people are not great at being random."))

# ╔═╡ d6bee8ef-dc59-411e-9eba-6a2913e1c8f2
render_infobox(InfoBox(title_text="Zipfian Distribution", body_text="A Zipfian distribution is the probability distribution with labels ``{1,2,3,\\ldots,N}`` and probability function ``f(x) = \\frac{1}{\\alpha} \\cdot \\frac{1}{x}``, where ``\\alpha = \\frac{1}{1} + \\frac{1}{2} + \\frac{1}{3} + \\ldots + \\frac{1}{N}`` normalizes the total probability to be ``1``."))

# ╔═╡ 6309eb94-2ebc-4550-a614-f863ec5c2f0e
render_infobox(InfoBox(body_text="In practice, across most languages, when a large sample of text is taken, and the words are ranked in order of frequency, their frequencies follow a Zipfian Distribution. This is experimentally true regardless of language, as long as the sample of text is varied enough and representative of the language as a whole. People are not sure why this is that far spread.\\
\\
For example, in a sampling called the Brown Corpus of over a million words of different texts in English chosen randomly, the word \"the\" appears the most frequently at ``69,971`` times, \"of\" the next most at ``36,411``, and \"and\" at ``28,852`` times."))

# ╔═╡ a6c0513c-45d8-41c7-9e0f-38d0c5c256c0
#Function for Plotting a Discrete Distribution
function plotDiscDist(X::UnivariateDistribution)
    local width = 500
    local height = 300
    local bottom_margin = 30
    local x_start = min(0,minimum(X)) - 0.5
    local x_end = maximum(X) + 0.5
    local paddingLeft = 25

	local Prob = pdf.(X,minimum(X):maximum(X))
	local ex = mean(X)
	local stddev = std(X)

	local DistUUID = string(uuid1())

    local x_zero_position = paddingLeft + (0 - x_start) * (width - 2 * paddingLeft) / (x_end - x_start)

    return @htl("""
    <svg width="$(width)" height="$(height)" style="background-color: white;" id=$(DistUUID*"-axis-svg")>
      <g id=$(DistUUID*"-lines-group")></g>
      <line x1="$(paddingLeft)" y1="$(height-bottom_margin)" x2="$(width-paddingLeft)" y2="$(height-bottom_margin)" stroke="black" stroke-width="2" opacity="0.5"/>
      <line x1="$(x_zero_position)" y1="$(height-bottom_margin)" x2="$(x_zero_position)" y2="10" stroke="black" stroke-width="2" opacity="0.5"/>
    </svg>
    <script>
      const svg = document.getElementById($(DistUUID*"-axis-svg"));
      const linesGroup = document.getElementById($(DistUUID*"-lines-group"));
      const maxY = $(height - bottom_margin);
      const paddingLeft = $(paddingLeft);
      const paddingRight = $(width) - paddingLeft;
      const minY = 10;
      const ymax = 1;
      const ex = $(ex);
      const stddev = $(stddev);
      const scaleRange = paddingRight - paddingLeft;

      const Prob = $(Prob);
      const xScaleStart = $(x_start);
      const xScaleEnd = $(x_end);

      function scaleY(value) {
        return minY + (1 - (value / ymax)) * (maxY - minY);
      }

      function updateLines() {
        while (linesGroup.firstChild) {
          linesGroup.removeChild(linesGroup.firstChild);
        }

        for (let i = 0; i <= $(maximum(X)-minimum(X)); i++) {
          const x = paddingLeft + (($(minimum(X)) + i - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
          const y = scaleY(Prob[i]);
          const line = document.createElementNS("http://www.w3.org/2000/svg", "line");
          line.setAttribute("x1", x);
          line.setAttribute("y1", y);
          line.setAttribute("x2", x);
          line.setAttribute("y2", maxY);
          line.setAttribute("stroke", "rgba(0,0,255,0.5)");
          line.setAttribute("stroke-width", 10);
          linesGroup.appendChild(line);

		  const label = document.createElementNS("http://www.w3.org/2000/svg", "text");
          label.setAttribute("x", x);
          label.setAttribute("y", maxY + 15);
          label.setAttribute("text-anchor", "middle");
          label.setAttribute("fill", "black");
          label.textContent = (xScaleStart + (x - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
          svg.appendChild(label);
        }

        const exX = paddingLeft + ((ex - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
        const dashedLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
        dashedLine.setAttribute("x1", exX);
        dashedLine.setAttribute("y1", minY);
        dashedLine.setAttribute("x2", exX);
        dashedLine.setAttribute("y2", maxY);
        dashedLine.setAttribute("stroke", "grey");
        dashedLine.setAttribute("stroke-width", 2);
        dashedLine.setAttribute("stroke-dasharray", "5,5");
        dashedLine.setAttribute("opacity", "0.5");
        svg.appendChild(dashedLine);

		const label = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label.setAttribute("x", exX);
	    label.setAttribute("y", maxY + 15);
	    label.setAttribute("text-anchor", "middle");
	    label.setAttribute("fill", "black");
        label.textContent = (xScaleStart + (exX - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
	    svg.appendChild(label);

        const exMinusStddevX = paddingLeft + (((ex - stddev) - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
        const exPlusStddevX = paddingLeft + (((ex + stddev) - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
        const line1 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line1.setAttribute("x1", exMinusStddevX);
        line1.setAttribute("y1", maxY-10);
        line1.setAttribute("x2", exMinusStddevX);
        line1.setAttribute("y2", maxY+10);
        line1.setAttribute("stroke", "black");
        line1.setAttribute("stroke-width", 2);
        line1.setAttribute("opacity", "0.5");
        svg.appendChild(line1);

		const label1 = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label1.setAttribute("x", exMinusStddevX - 15);
        label1.setAttribute("y", maxY + 25);
        label1.setAttribute("text-anchor", "middle");
        label1.setAttribute("fill", "black");
        label1.textContent = (xScaleStart + (exMinusStddevX - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
        svg.appendChild(label1);

        const line2 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line2.setAttribute("x1", exPlusStddevX);
        line2.setAttribute("y1", maxY-10);
        line2.setAttribute("x2", exPlusStddevX);
        line2.setAttribute("y2", maxY+10);
        line2.setAttribute("stroke", "black");
        line2.setAttribute("stroke-width", 2);
        line2.setAttribute("opacity", "0.5");
        svg.appendChild(line2);

		const label2 = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label2.setAttribute("x", exPlusStddevX + 15);
        label2.setAttribute("y", maxY + 25);
        label2.setAttribute("text-anchor", "middle");
        label2.setAttribute("fill", "black");
        label2.textContent = (xScaleStart + (exPlusStddevX - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
        svg.appendChild(label2);
      }

      updateLines();
    </script>
    """)
end;

# ╔═╡ e5f3bd5b-304e-4271-8654-296c531e1ffe
plotDiscDist(X_Dirac)

# ╔═╡ 9fcb2db8-94c9-455c-910c-af6e03fa56b3
#Function for Plotting a Benford Array
function plotBenfordArray(Arr::AbstractArray, f::Function)
    local width = 500
    local height = 300
    local bottom_margin = 30
    local x_start = -0.5
    local x_end = 9.5
    local paddingLeft = 25

	local Prob = Arr
	local ex = mean(1:9, Weights(Arr))
	local stddev = std(1:9, Weights(Arr))

	local BenfUUID = string(uuid1())

    local x_zero_position = paddingLeft + (0 - x_start) * (width - 2 * paddingLeft) / (x_end - x_start)

	local x_vals = range(x_start + 1, x_end, 100)
	local y_vals = f.(x_vals)

    return @htl("""
    <svg width="$(width)" height="$(height)" style="background-color: white;" id=$(BenfUUID*"-axis-svg")>
      <g id=$(BenfUUID*"-lines-group")></g>
      <line x1="$(paddingLeft)" y1="$(height-bottom_margin)" x2="$(width-paddingLeft)" y2="$(height-bottom_margin)" stroke="black" stroke-width="2" opacity="0.5"/>
      <line x1="$(x_zero_position)" y1="$(height-bottom_margin)" x2="$(x_zero_position)" y2="10" stroke="black" stroke-width="2" opacity="0.5"/>
    </svg>
    <script>
      const svg = document.getElementById($(BenfUUID*"-axis-svg"));
      const linesGroup = document.getElementById($(BenfUUID*"-lines-group"));
      const maxY = $(height - bottom_margin);
      const paddingLeft = $(paddingLeft);
      const paddingRight = $(width) - paddingLeft;
      const minY = 10;
      const ymax = 1;
      const ex = $(ex);
      const stddev = $(stddev);
      const scaleRange = paddingRight - paddingLeft;

      const Prob = $(Prob);
      const xScaleStart = $(x_start);
      const xScaleEnd = $(x_end);

      const xVals = $(x_vals);
      const yVals = $(y_vals);

      function scaleY(value) {
        return minY + (1 - (value / ymax)) * (maxY - minY);
      }

      function updateLines() {
        while (linesGroup.firstChild) {
          linesGroup.removeChild(linesGroup.firstChild);
        }

        for (let i = 1; i <= 9; i++) {
          const x = paddingLeft + ((i - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
          const y = scaleY(Prob[i-1]);
          const line = document.createElementNS("http://www.w3.org/2000/svg", "line");
          line.setAttribute("x1", x);
          line.setAttribute("y1", y);
          line.setAttribute("x2", x);
          line.setAttribute("y2", maxY);
          line.setAttribute("stroke", "rgba(0,0,255,0.5)");
          line.setAttribute("stroke-width", 10);
          linesGroup.appendChild(line);

		  const label = document.createElementNS("http://www.w3.org/2000/svg", "text");
          label.setAttribute("x", x);
          label.setAttribute("y", maxY + 15);
          label.setAttribute("text-anchor", "middle");
          label.setAttribute("fill", "black");
          label.textContent = (xScaleStart + (x - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(0);
          svg.appendChild(label);
        }

		for (let i = 1; i < xVals.length; i++) {
          const x1 = paddingLeft + ((xVals[i-1] - xScaleStart) * scaleRange / (xScaleEnd - xScaleStart));
          const y1 = scaleY(yVals[i-1]);
          const x2 = paddingLeft + ((xVals[i] - xScaleStart) * scaleRange / (xScaleEnd - xScaleStart));
          const y2 = scaleY(yVals[i]);

          const functionLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
          functionLine.setAttribute("x1", x1);
          functionLine.setAttribute("y1", y1);
          functionLine.setAttribute("x2", x2);
          functionLine.setAttribute("y2", y2);
          functionLine.setAttribute("stroke", "rgba(255,0,0,0.75)");
          functionLine.setAttribute("stroke-width", 2);
          linesGroup.appendChild(functionLine);
        }

        const exX = paddingLeft + ((ex - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
        const dashedLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
        dashedLine.setAttribute("x1", exX);
        dashedLine.setAttribute("y1", minY);
        dashedLine.setAttribute("x2", exX);
        dashedLine.setAttribute("y2", maxY);
        dashedLine.setAttribute("stroke", "grey");
        dashedLine.setAttribute("stroke-width", 2);
        dashedLine.setAttribute("stroke-dasharray", "5,5");
        dashedLine.setAttribute("opacity", "0.5");
        svg.appendChild(dashedLine);

		const label = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label.setAttribute("x", exX);
	    label.setAttribute("y", maxY + 15);
	    label.setAttribute("text-anchor", "middle");
	    label.setAttribute("fill", "black");
        label.textContent = (xScaleStart + (exX - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
	    svg.appendChild(label);

        const exMinusStddevX = paddingLeft + (((ex - stddev) - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
        const exPlusStddevX = paddingLeft + (((ex + stddev) - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
        const line1 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line1.setAttribute("x1", exMinusStddevX);
        line1.setAttribute("y1", maxY-10);
        line1.setAttribute("x2", exMinusStddevX);
        line1.setAttribute("y2", maxY+10);
        line1.setAttribute("stroke", "black");
        line1.setAttribute("stroke-width", 2);
        line1.setAttribute("opacity", "0.5");
        svg.appendChild(line1);

		const label1 = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label1.setAttribute("x", exMinusStddevX - 15);
        label1.setAttribute("y", maxY + 25);
        label1.setAttribute("text-anchor", "middle");
        label1.setAttribute("fill", "black");
        label1.textContent = (xScaleStart + (exMinusStddevX - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
        svg.appendChild(label1);

        const line2 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line2.setAttribute("x1", exPlusStddevX);
        line2.setAttribute("y1", maxY-10);
        line2.setAttribute("x2", exPlusStddevX);
        line2.setAttribute("y2", maxY+10);
        line2.setAttribute("stroke", "black");
        line2.setAttribute("stroke-width", 2);
        line2.setAttribute("opacity", "0.5");
        svg.appendChild(line2);

		const label2 = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label2.setAttribute("x", exPlusStddevX + 15);
        label2.setAttribute("y", maxY + 25);
        label2.setAttribute("text-anchor", "middle");
        label2.setAttribute("fill", "black");
        label2.textContent = (xScaleStart + (exPlusStddevX - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
        svg.appendChild(label2);
      }

      updateLines();
    </script>
    """)
end;

# ╔═╡ 523c17de-a068-42ec-82d1-e0c696fa3a0f
begin
	local arr = collect(values(PopulationFirstDigits))
	plotBenfordArray(arr / sum(arr),x->log(10,1+1/x))
end

# ╔═╡ 2716c30a-ebf4-4bfe-9bc6-8f42e7ceab41
begin
	local arr = collect(values(CasesFirstDigits))
	plotBenfordArray(arr / sum(arr),x->log(10,1+1/x))
end

# ╔═╡ f82bf7c5-97a3-46a9-8fc0-93752562d0b1
begin
	local arr = collect(values(DeathsFirstDigits))
	plotBenfordArray(arr / sum(arr),x->log(10,1+1/x))
end

# ╔═╡ 5dc20180-3ca6-4af0-967b-ee5affb0b60c
begin
	local arr = collect(values(sort(countmap((x ->  parse(Int, first(string(x^4)))).(rand(1:10000,1000))))))
	plotBenfordArray(arr / sum(arr),x->log(10,1+1/x))
end

# ╔═╡ 9adcbdb3-d50d-4a39-a2d6-2ef3b225b1db
#Function for Plotting a Zipf Array
function plotZipfArray(Arr::AbstractArray, f::Function)
    local width = 500
    local height = 300
    local bottom_margin = 30
	local N = length(Arr)
    local x_start = -0.5
    local x_end = max(10, N) + 0.5
    local paddingLeft = 25

	local Prob = Arr
	local ex = mean(1:N, Weights(Arr))
	local stddev = std(1:N, Weights(Arr))

	local ZipfUUID = string(uuid1())

    local x_zero_position = paddingLeft + (0 - x_start) * (width - 2 * paddingLeft) / (x_end - x_start)

	local x_vals = range(x_start + 1, x_end, 100)
	local y_vals = f.(x_vals)

    return @htl("""
    <svg width="$(width)" height="$(height)" style="background-color: white;" id=$(ZipfUUID*"-axis-svg")>
      <g id=$(ZipfUUID*"-lines-group")></g>
      <line x1="$(paddingLeft)" y1="$(height-bottom_margin)" x2="$(width-paddingLeft)" y2="$(height-bottom_margin)" stroke="black" stroke-width="2" opacity="0.5"/>
      <line x1="$(x_zero_position)" y1="$(height-bottom_margin)" x2="$(x_zero_position)" y2="10" stroke="black" stroke-width="2" opacity="0.5"/>
    </svg>
    <script>
      const svg = document.getElementById($(ZipfUUID*"-axis-svg"));
      const linesGroup = document.getElementById($(ZipfUUID*"-lines-group"));
      const maxY = $(height - bottom_margin);
      const paddingLeft = $(paddingLeft);
      const paddingRight = $(width) - paddingLeft;
      const minY = 10;
      const ymax = 1;
      const ex = $(ex);
      const stddev = $(stddev);
      const scaleRange = paddingRight - paddingLeft;

      const Prob = $(Prob);
      const xScaleStart = $(x_start);
      const xScaleEnd = $(x_end);

      const xVals = $(x_vals);
      const yVals = $(y_vals);

      function scaleY(value) {
        return minY + (1 - (value / ymax)) * (maxY - minY);
      }

      function updateLines() {
        while (linesGroup.firstChild) {
          linesGroup.removeChild(linesGroup.firstChild);
        }

        for (let i = 1; i <= $(N); i++) {
          const x = paddingLeft + ((i - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
          const y = scaleY(Prob[i-1]);
          const line = document.createElementNS("http://www.w3.org/2000/svg", "line");
          line.setAttribute("x1", x);
          line.setAttribute("y1", y);
          line.setAttribute("x2", x);
          line.setAttribute("y2", maxY);
          line.setAttribute("stroke", "rgba(0,0,255,0.5)");
          line.setAttribute("stroke-width", 10);
          linesGroup.appendChild(line);

		  const label = document.createElementNS("http://www.w3.org/2000/svg", "text");
          label.setAttribute("x", x);
          label.setAttribute("y", maxY + 15);
          label.setAttribute("text-anchor", "middle");
          label.setAttribute("fill", "black");
          label.textContent = (xScaleStart + (x - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(0);
          svg.appendChild(label);
        }

		for (let i = 1; i < xVals.length; i++) {
          const x1 = paddingLeft + ((xVals[i-1] - xScaleStart) * scaleRange / (xScaleEnd - xScaleStart));
          const y1 = scaleY(yVals[i-1]);
          const x2 = paddingLeft + ((xVals[i] - xScaleStart) * scaleRange / (xScaleEnd - xScaleStart));
          const y2 = scaleY(yVals[i]);

          const functionLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
          functionLine.setAttribute("x1", x1);
          functionLine.setAttribute("y1", y1);
          functionLine.setAttribute("x2", x2);
          functionLine.setAttribute("y2", y2);
          functionLine.setAttribute("stroke", "rgba(255,0,0,0.75)");
          functionLine.setAttribute("stroke-width", 2);
          linesGroup.appendChild(functionLine);
        }

        const exX = paddingLeft + ((ex - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
        const dashedLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
        dashedLine.setAttribute("x1", exX);
        dashedLine.setAttribute("y1", minY);
        dashedLine.setAttribute("x2", exX);
        dashedLine.setAttribute("y2", maxY);
        dashedLine.setAttribute("stroke", "grey");
        dashedLine.setAttribute("stroke-width", 2);
        dashedLine.setAttribute("stroke-dasharray", "5,5");
        dashedLine.setAttribute("opacity", "0.5");
        svg.appendChild(dashedLine);

		const label = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label.setAttribute("x", exX);
	    label.setAttribute("y", maxY + 15);
	    label.setAttribute("text-anchor", "middle");
	    label.setAttribute("fill", "black");
        label.textContent = (xScaleStart + (exX - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
	    svg.appendChild(label);

        const exMinusStddevX = paddingLeft + (((ex - stddev) - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
        const exPlusStddevX = paddingLeft + (((ex + stddev) - xScaleStart) * scaleRange / (xScaleEnd-xScaleStart));
        const line1 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line1.setAttribute("x1", exMinusStddevX);
        line1.setAttribute("y1", maxY-10);
        line1.setAttribute("x2", exMinusStddevX);
        line1.setAttribute("y2", maxY+10);
        line1.setAttribute("stroke", "black");
        line1.setAttribute("stroke-width", 2);
        line1.setAttribute("opacity", "0.5");
        svg.appendChild(line1);

		const label1 = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label1.setAttribute("x", exMinusStddevX - 15);
        label1.setAttribute("y", maxY + 25);
        label1.setAttribute("text-anchor", "middle");
        label1.setAttribute("fill", "black");
        label1.textContent = (xScaleStart + (exMinusStddevX - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
        svg.appendChild(label1);

        const line2 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line2.setAttribute("x1", exPlusStddevX);
        line2.setAttribute("y1", maxY-10);
        line2.setAttribute("x2", exPlusStddevX);
        line2.setAttribute("y2", maxY+10);
        line2.setAttribute("stroke", "black");
        line2.setAttribute("stroke-width", 2);
        line2.setAttribute("opacity", "0.5");
        svg.appendChild(line2);

		const label2 = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label2.setAttribute("x", exPlusStddevX + 15);
        label2.setAttribute("y", maxY + 25);
        label2.setAttribute("text-anchor", "middle");
        label2.setAttribute("fill", "black");
        label2.textContent = (xScaleStart + (exPlusStddevX - paddingLeft) * (xScaleEnd-xScaleStart) / scaleRange).toFixed(2);
        svg.appendChild(label2);
      }

      updateLines();
    </script>
    """)
end;

# ╔═╡ 76fff65f-e1b2-43dd-b76b-3c484143bf6d
begin
	local ZipfArray = (x->1/x).(1:N)
	local α = sum(ZipfArray)
	plotZipfArray(ZipfArray / α, x -> 1/(x*α))
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
CSV = "~0.10.14"
DataFrames = "~1.6.1"
Distributions = "~0.25.111"
HTTP = "~1.10.8"
HypertextLiteral = "~0.9.5"
PlutoTeachingTools = "~0.3.0"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "7a252db8c5f32355d8f479cc025fc4b0ac47a49d"

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
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

[[deps.CSV]]
deps = ["CodecZlib", "Dates", "FilePathsBase", "InlineStrings", "Mmap", "Parsers", "PooledArrays", "PrecompileTools", "SentinelArrays", "Tables", "Unicode", "WeakRefStrings", "WorkerUtilities"]
git-tree-sha1 = "6c834533dc1fabd820c1db03c839bf97e45a3fab"
uuid = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
version = "0.10.14"

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

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "ea32b83ca4fefa1768dc84e504cc0a94fb1ab8d1"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.4.2"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "abe83f3a2f1b857aac70ef8b269080af17764bbe"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.16.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "DataStructures", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrecompileTools", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "04c738083f29f86e62c8afc341f0967d8717bdb8"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.6.1"

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

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"

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

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "dcb08a0d93ec0b1cdc4af184b26b591e9695423a"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.10"

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

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "d1d712be3164d61d1fb98e7ce9bcbc6cc06b45ed"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.10.8"

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

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "c1dd6d7978c12545b4179fb6153b9250c96b0075"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.3"

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

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "NetworkOptions", "Random", "Sockets"]
git-tree-sha1 = "c067a280ddc25f196b5e7df3877c6b226d390aaf"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.9"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "ec4f7fbeab05d7747bdf98eb74d130a2a2ed298d"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.2.0"

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

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+2"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "38cb508d080d21dc1128f7fb04f20387ed4c0af4"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.3"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1b35263570443fdd9e76c76b7062116e2f374ab8"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "3.0.15+0"

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
deps = ["Downloads", "HypertextLiteral", "Latexify", "Markdown", "PlutoLinks", "PlutoUI"]
git-tree-sha1 = "e2593782a6b53dc5176058d27e20387a0576a59e"
uuid = "661c6b06-c737-4d37-b85c-46df65de6f69"
version = "0.3.0"

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
git-tree-sha1 = "66b20dd35966a748321d3b2537c4584cf40387c7"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.3.2"

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
git-tree-sha1 = "ff11acffdb082493657550959d4feb4b6149e73a"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.5"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "f305871d2f381d21527c770d4788c06c097c9bc1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.2.0"

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

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a04cabe79c5f01f4d723cc6704070ada0b9d46d5"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.4"

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

[[deps.TranscodingStreams]]
git-tree-sha1 = "e84b3a11b9bece70d14cce63406bbc79ed3464d2"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.11.2"

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
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─f06ad5e6-769e-4606-95d4-6df3fb8dd9a7
# ╟─0f4001c7-19b2-4ab1-951d-b042c77881f8
# ╟─a0d6c2a3-f995-47ba-852e-64c68c9ac9b7
# ╟─01dc5bc7-d0f9-47f9-98ad-35c2c261e7c3
# ╠═0102e00f-7b7d-4555-a745-66ae8faef890
# ╟─1ac027f3-4183-4578-a7af-d36d65143321
# ╟─0d6576ae-2826-4517-8245-832c21312495
# ╟─fe248d65-3681-49ff-a5ae-2030f14b230a
# ╟─b5feb96b-8a33-47b0-9089-a721f434b77c
# ╟─f484a378-2cd7-4059-8ab1-b52c95536e7c
# ╟─e5f3bd5b-304e-4271-8654-296c531e1ffe
# ╟─82906eae-3671-4e2a-aad3-18586df6eb8c
# ╠═0cadb1fa-258d-4907-b25a-037acb8091bc
# ╟─21fae208-715e-40d3-a6f8-bddf9a891e33
# ╟─b60f2c7f-4b45-4703-88df-5e36052ffba3
# ╟─2c9b5311-de0a-473b-8ca5-e87f33b9a7c1
# ╟─0411535e-4fae-4595-b7a0-e1e8465b639e
# ╟─ccc269fd-278e-4453-88a0-9172b20baaea
# ╟─7721ab8e-b8ce-4afa-a170-69b409aa30f0
# ╟─83bdda56-235c-4624-b368-2c8f83db05d8
# ╟─092ec7ce-db10-489a-97f2-5db554ae26cf
# ╟─d44561b5-0b71-45b4-92fb-e7fc00091be5
# ╟─136ce3a5-0b56-44b3-949f-2433321ac797
# ╟─44210666-efa7-4437-abb2-705489306b69
# ╟─523c17de-a068-42ec-82d1-e0c696fa3a0f
# ╟─f43418a4-e5b9-4ea8-a55d-583a6a01c111
# ╟─f7622962-7354-44e9-a5cc-24234fd7dbc5
# ╟─905a9e06-8364-4908-bb33-e6ff18516050
# ╟─147f6ced-fa34-445d-b37a-cb0eaf3c0191
# ╟─02b4717a-5f70-4ee9-9552-9a5dc8ac4240
# ╟─20e57950-df5a-4e20-a71c-40e9309f7ccd
# ╟─2fb63029-bd1b-4aa7-b67b-65a31696040e
# ╟─2716c30a-ebf4-4bfe-9bc6-8f42e7ceab41
# ╟─f82bf7c5-97a3-46a9-8fc0-93752562d0b1
# ╟─6e31cce0-dd99-446f-be07-22437dd5f5c1
# ╟─1fc6dcd8-000f-4acd-a126-1756c0b2fec3
# ╠═5dc20180-3ca6-4af0-967b-ee5affb0b60c
# ╟─e7d56fa2-dead-4a28-b539-ece49457fbc7
# ╟─216bffd0-e281-4e30-bbda-8a1884b87c22
# ╠═bc65014d-d2fa-4886-b5a4-da02f26c235d
# ╟─9b49fe75-78d4-4119-87a5-6f51b746bc67
# ╟─b13eb90f-bc56-4e11-9e10-ad308772027c
# ╟─bf49e0dc-f8af-4cee-b095-fbdceb382564
# ╟─d6bee8ef-dc59-411e-9eba-6a2913e1c8f2
# ╟─a8ddb7a4-393d-4a0c-87fd-17e3338a2d01
# ╠═a3511fce-cd5b-4f7f-bedf-c4766aa8262f
# ╠═c1543df2-1bf7-4296-bc00-33a14430c4c9
# ╟─16b35ab9-f8f3-4074-89ff-273d4c3e8f51
# ╠═6ed6f15a-5bc5-428e-82bc-23ae51772a7f
# ╟─76fff65f-e1b2-43dd-b76b-3c484143bf6d
# ╟─6309eb94-2ebc-4550-a614-f863ec5c2f0e
# ╟─9653f9c6-d309-45bd-b77f-74b63d5dbdc9
# ╟─66b0d106-3844-4a98-a0bc-ec8ab9047ac4
# ╟─1df7dbfa-8018-4158-81ab-d062cbeb93b5
# ╟─a6c0513c-45d8-41c7-9e0f-38d0c5c256c0
# ╟─9fcb2db8-94c9-455c-910c-af6e03fa56b3
# ╟─9adcbdb3-d50d-4a39-a2d6-2ef3b225b1db
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
