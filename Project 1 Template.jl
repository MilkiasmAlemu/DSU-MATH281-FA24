### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 6b5b82d6-871e-4333-9d68-df27f89045c2
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools
end

# ╔═╡ 5ae94e1f-08b7-4f03-8c30-89fd64ca5dd0
using Distributions, StatsBase, RDatasets

# ╔═╡ ef3c7620-7c11-11ef-1101-7f7a0fde04e5
@htl("""
	<h1>Project 1</h1>
""")

# ╔═╡ a6495731-94fd-4f63-b60e-5440fae89517
TableOfContents()

# ╔═╡ ce2d0ac9-7ef2-41a4-a7a5-deed9c91acff
md"""
###### My Name is: 
"""

# ╔═╡ c4d5e3c5-516c-4b99-bb93-6d3d121cbb9d
@htl("""
<div style="margin: 0 auto; width:80%;">
	$(Markdown.parse("""!!! danger "<span style="color:white"> Reminder! </span>"
					###### Remember to click **[ctrl] + M** to be able to enter text in a cell, and please hit **[shift]** + **[enter]** to save your work in a cell.
				"""))
</div>
""")

# ╔═╡ 31ab142d-f7a7-4744-8dda-08c6867f6ccd
@htl("""
	<h5>These are the different packages being used for this project.</h5>
""")

# ╔═╡ 7fd819cd-5f8b-446f-8990-1efc6815d347
@htl("""
	<hr>
""")

# ╔═╡ 8bec72e6-7e0b-4182-ab10-24e89ce22d97
@htl("""<div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! note "<h3 class="admonition-title" style="color:white"> The Setup </h3>"
						###### The goal of this project is to use a real world dataset and apply the statistical knowledge that you have learned so far throughout the semester to tell a story about the data. Your goal is to try to describe the data and convince me that the conclusions you are making are true by backing up your arguments with data. For all of your answers, make sure to give full justification/reasoning.
					"""))
	</div>
</div>
""")

# ╔═╡ b78c8f16-e924-4dbc-8093-90d6933b1504
@htl("""
	<hr>
""")

# ╔═╡ 912483d9-023b-48a6-9728-fda5505c1a07
@htl("""<div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! question "<h3 class="admonition-title" style="color:white">Task 1 – Choosing</h3>"
						###### **RDatasets** has many different collections of data available. Look through the collection below to find a dataset that interests you. For more information, most documentation should be [available here](https://vincentarelbundock.github.io/Rdatasets/articles/data.html), where you can **search** for your dataset and then click on the **Doc** link to see what all of the information means.
					"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! danger ""
						###### You are not allowed to choose the example with Package "car" and Dataset "Davis".
					"""))
	</div>
</div>
""")

# ╔═╡ c850a7d5-36cd-4ce2-b928-9c40173061e6
filter(row -> !(row."Package" ∈ ["COUNT", "KMsurv", "gamair"]) && (row."Rows" > 30) && (row."Columns" > 3), RDatasets.datasets())

# ╔═╡ 41eecc09-df09-44e8-bd8e-b8fe22304e11
@htl("""
	<hr>
""")

# ╔═╡ c0c00af7-1edd-4ada-ad3e-13a6cb343488
@htl("""<div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! question "<h3 class="admonition-title" style="color:white">Task 2 – Loading</h3>"
						###### Load your dataset into Julia using:
					"""))
	</div>
	<div>
		$(Markdown.parse("""
		```julia
		MyData = dropmissing(RDatasets.dataset(#== Package ==#, #== Dataset ==#))
		```
		"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! danger ""
						###### Make sure to replace the two entries with the Package name and the Dataset name **in quotes**!
					"""))
	</div>
</div>
""")

# ╔═╡ 0c47a175-5ead-430f-9e1f-e3c8db4ca4e1


# ╔═╡ 3eff8241-526d-4c3f-b9c5-aac9f1e7b6a2
@htl("""
	<hr>
""")

# ╔═╡ 4c785258-be36-4f46-b343-ad112cadaa39
@htl("""<div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! question "<h3 class="admonition-title" style="color:white">Task 3 – Probabilities</h3>"
						##### Based off of your data,
						* ###### Pick two columns and calculate the probability of some outcome occurring for each of them.
						* ###### Using the two probabilities ``\\operatorname{Prob}(A)`` and ``\\operatorname{Prob}(B)`` from the last part, compute the conditional probabilities ``\\operatorname{Prob}\\left(A \\mid B\\right)`` and ``\\operatorname{Prob}\\left(B  \\mid A\\right)``.
						* ###### Verify that Bayes' Theorem is true for your probabilities.
						* ###### Interpret the probabilities in terms of the physical situation given by your dataset.
					"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! danger ""
						###### The probabilities in the first part must be between ``10\\%`` and ``90\\%``, and the conditional probabilities must be different than the original probabilities.
					"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! note ""
						###### You can get a specific column using:
					"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""
		```julia
		MyData[!, #== Column ==#]
		```
		"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! danger ""
						###### Make sure to replace the Colum name **in quotes**!
					"""))
	</div>
</div>
""")

# ╔═╡ b9055c8d-b87b-4a5c-956c-b1d78aeb2385


# ╔═╡ c65eb8ca-da5c-4910-9bba-d9c784bf339e
@htl("""
	<hr>
""")

# ╔═╡ ab85b92e-0dc5-4e8a-8681-d87a62ba2095
@htl("""<div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! question "<h3 class="admonition-title" style="color:white">Task 4 – Random Variable</h3>"
						##### Based off of your data,
						* ###### Pick a (numeric) column and assign a random variable to this data. Unless you want to be fancy, all this means is to recognize the numbers in this column as being the values of a random variable.
						* ###### What are the statistical measures of this random variable? Meaning at least the mean, standard deviation, and skewness.
						* ###### Interpret these statistical measures to tell you something about the real world situation captured by the data.
					"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! danger ""
						###### The standard deviation must be nonzero for the column that you choose.
					"""))
	</div>
</div>
""")

# ╔═╡ ea256869-8feb-49c2-a6da-bd9aa5f53fd5


# ╔═╡ 6b3aca99-b3e6-45ac-b6f9-995548dd6be5
@htl("""
	<hr>
""")

# ╔═╡ 1eb34613-433c-4ff4-84c3-cae1836ef192
@htl("""<div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! question "<h3 class="admonition-title" style="color:white">Task 5 – Distributions</h3>"
						##### Based off of your data,
						* ###### Does your choice of random variable seem to be discrete or continuous? Why?
						
						* ###### If discrete, which of the following distributions does it most closely look like? This doesn't need to be a perfect fit, just use your best judgement.
						
						  + ###### (Discrete) Uniform - DiscreteUniform(a, b)
						  + ###### Binomial - Binomial(n, p)
						  + ###### Geometric - Geometric(p)
						  + ###### Poisson - Poisson(λ)
						
						* ###### If continuous, which of the following distributions does it most closely look like? This doesn't need to be a perfect fit, just use your best judgement.
						
						  + ###### (Continuous) Uniform - Uniform(a, b)
						  + ###### Normal - Normal(μ, σ)
						
						* ###### Plot the distribution and a line plot of your data and try to figure out what the parameters of your distribution need to be in order to most closely match your data.
					"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! note ""
						###### You can plot a line plot in this document with:
					"""))
	</div>
	<div style="margin: 0 auto; width:100%;">
		$(Markdown.parse("""
		```julia
			plotLinePlot(#== Random Variable List ==#)
		```
		"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! note ""
						###### You can plot a discrete distribution in this document with:
					"""))
	</div>
	<div style="margin: 0 auto; width:100%;">
		$(Markdown.parse("""
		```julia
			plotDiscDist(#== Discrete Distribution ==#, #== Random Variable List ==#)
		```
		"""))
	</div>
	<div style="margin: 0 auto; width:80%;">
		$(Markdown.parse("""!!! note ""
						###### You can plot a continuous distribution in this document with:
					"""))
	</div>
	<div style="margin: 0 auto; width:100%;">
		$(Markdown.parse("""
		```julia
			plotDiscDist(#== Discrete Distribution ==#, #== Random Variable List ==#)
		```
		"""))
	</div>
</div>
""")

# ╔═╡ 91ff9078-6164-4ac9-98e7-a7ac9b8c9ef0


# ╔═╡ 50a26147-ae15-4583-8f49-3f0bbb732da1
@htl("""
	<hr>
""")

# ╔═╡ ba9e44e3-0fe0-4585-853b-6f58c8c53780
# Function for Plotting a Discrete Distribution
function plotDiscDist(X::UnivariateDistribution, Arr::AbstractArray{<:Number})
    local a = 0
    local b = maximum(Arr)
    local c = maximum(values(countmap(Arr))) / length(Arr)
    local width = 500
    local height = 300
    local bottom_margin = 30
    local x_start = a - 0.5
    local x_end = b + 0.5
    local paddingLeft = 25

    local Prob = pdf.(X, a:b)
    local ex = mean(X)
    local stddev = std(X)

    local DistUUID = string(uuid1())

    local maxY = height - bottom_margin
    local ymax = c

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
      const maxY = $(maxY);
      const paddingLeft = $(paddingLeft);
      const paddingRight = $(width) - paddingLeft;
      const minY = 10;
      const ymax = $(ymax);
      const ex = $(ex);
      const stddev = $(stddev);
      const scaleRange = paddingRight - paddingLeft;

      const Prob = $(Prob);
      const xScaleStart = $(x_start);
      const xScaleEnd = $(x_end);

      function scaleY(value) {
        return minY + (1 - (value / ymax)) * (maxY - minY);
      }

      function scaleX(value) {
        return paddingLeft + ((value - xScaleStart) * scaleRange / (xScaleEnd - xScaleStart));
      }

      function updateLines() {
        while (linesGroup.firstChild) {
          linesGroup.removeChild(linesGroup.firstChild);
        }

        for (let i = 0; i <= $(b-a); i++) {
          const x = scaleX($(a) + i);
          const y = scaleY(Prob[i]);
          const line = document.createElementNS("http://www.w3.org/2000/svg", "line");
          line.setAttribute("x1", x);
          line.setAttribute("y1", y);
          line.setAttribute("x2", x);
          line.setAttribute("y2", maxY);
          line.setAttribute("stroke", "rgba(0,0,255,0.5)");
          line.setAttribute("stroke-width", 10);
          linesGroup.appendChild(line);
        }

        const exX = scaleX(ex);
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

        const exLabel = document.createElementNS("http://www.w3.org/2000/svg", "text");
        exLabel.setAttribute("x", exX);
        exLabel.setAttribute("y", maxY + 15);
        exLabel.setAttribute("text-anchor", "middle");
        exLabel.setAttribute("fill", "black");
        exLabel.textContent = ex.toFixed(2);
        svg.appendChild(exLabel);

        const exMinusStddevX = scaleX(ex - stddev);
        const exPlusStddevX = scaleX(ex + stddev);
        
        const line1 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line1.setAttribute("x1", exMinusStddevX);
        line1.setAttribute("y1", maxY - 10);
        line1.setAttribute("x2", exMinusStddevX);
        line1.setAttribute("y2", maxY + 10);
        line1.setAttribute("stroke", "black");
        line1.setAttribute("stroke-width", 2);
        line1.setAttribute("opacity", "0.5");
        svg.appendChild(line1);

        const label1 = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label1.setAttribute("x", exMinusStddevX - 15);
        label1.setAttribute("y", maxY + 25);
        label1.setAttribute("text-anchor", "middle");
        label1.setAttribute("fill", "black");
        label1.textContent = (ex - stddev).toFixed(2);
        svg.appendChild(label1);

        const line2 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        line2.setAttribute("x1", exPlusStddevX);
        line2.setAttribute("y1", maxY - 10);
        line2.setAttribute("x2", exPlusStddevX);
        line2.setAttribute("y2", maxY + 10);
        line2.setAttribute("stroke", "black");
        line2.setAttribute("stroke-width", 2);
        line2.setAttribute("opacity", "0.5");
        svg.appendChild(line2);

        const label2 = document.createElementNS("http://www.w3.org/2000/svg", "text");
        label2.setAttribute("x", exPlusStddevX + 15);
        label2.setAttribute("y", maxY + 25);
        label2.setAttribute("text-anchor", "middle");
        label2.setAttribute("fill", "black");
        label2.textContent = (ex + stddev).toFixed(2);
        svg.appendChild(label2);
      }

      updateLines();
    </script>
    """)
end;

# ╔═╡ 774c75d5-8c31-4265-9f44-f5141584741b
# Function for Plotting a Continuous Distribution
function plotContDist(X::UnivariateDistribution, Arr::AbstractArray{<:Number})
    local a = 0
    local b = maximum(Arr)
    local c = maximum(values(countmap(Arr))) / length(Arr)
    local width = 500
    local height = 300
    local bottom_margin = 30
    local x_start = a - 0.5
    local x_end = b + 0.5
    local paddingLeft = 25
    
    local resolution = 1000
    local x_vals = range(x_start, x_end, length=resolution)
    local pdf_vals = pdf.(X, x_vals)
    local ex = mean(X)
    local stddev = std(X)
    local max_prob = max(pdf_vals...)

    local DistUUID = string(uuid1())

    local x_zero_position = paddingLeft + (0 - x_start) * (width - 2 * paddingLeft) / (x_end - x_start)

    return @htl("""
        <svg width="$(width)" height="$(height)" style="background-color: white;" id=$(DistUUID*"-axis-svg")>
            <g id=$(DistUUID*"-pdf-curve-group")></g>
            <g id=$(DistUUID*"-line-group")></g>
            <g id=$(DistUUID*"-area-group")></g>
            <line x1="$(paddingLeft)" y1="$(height-bottom_margin)" x2="$(width-paddingLeft)" y2="$(height-bottom_margin)" stroke="black" stroke-width="2" opacity="0.5"/>
            <line x1="$(x_zero_position)" y1="$(height-bottom_margin)" x2="$(x_zero_position)" y2="10" stroke="black" stroke-width="2" opacity="0.5"/>
        </svg>

        <script>
            const svg = document.getElementById($(DistUUID*"-axis-svg"));
            const pdfCurveGroup = document.getElementById($(DistUUID*"-pdf-curve-group"));
            const areaGroup = document.getElementById($(DistUUID*"-area-group"));
            const lineGroup = document.getElementById($(DistUUID*"-line-group"));
            const paddingLeft = $(paddingLeft);
            const paddingRight = $(width) - paddingLeft;
            
            const xScaleStart = $(x_start);
            const xScaleEnd = $(x_end);
            const minY = 10;
            const maxY = $(height - bottom_margin);
            const ymax = $(c);
            
            const x_vals = $(x_vals);
            const pdf_vals = $(pdf_vals);
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
                let max_i = x_vals.length;
                for (let i = 0; i < x_vals.length; i++) {
                    points += ` \${scaleX(x_vals[i])},\${scaleY(pdf_vals[i])}`;
                }
                points += ` \${scaleX(x_vals[max_i - 1])},\${scaleY(0)}`;
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
                stddevLeftLabel.setAttribute("font-size", "12px");
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
                stddevRightLabel.setAttribute("font-size", "12px");
                stddevRightLabel.setAttribute("text-anchor", "middle");
                stddevRightLabel.textContent = stddevRight.toFixed(1);
                lineGroup.appendChild(stddevRightLabel);
            }

            updatePDF();
            updateArea();
            updateLines();
        </script>
    """)
end;

# ╔═╡ 25dcb670-d252-4b9d-b185-00cdf2faf141
# Function for Plotting Vertical Line Plot
function plotLinePlot(Arr::AbstractArray{<:Number})
    local width = 500
    local height = 300
    local bottom_margin = 30

    local X = unique(Arr)
    local Y = countmap(Arr)
    
    local x_start = min(0, minimum(X)) - 0.5
    local x_end = maximum(X) + 0.5
    local y_start = 0
    local y_end = maximum(values(Y)) + 0.5
    local paddingLeft = 25

    local ex = mean(Arr)
    local stddev = std(Arr)

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
      const paddingLeft = $(paddingLeft);
      const paddingRight = $(width) - paddingLeft;
      const svgHeight = $(height);
      const paddingBottom = $(bottom_margin);
      const paddingTop = svgHeight - paddingBottom;
      const scaleXRange = paddingRight - paddingLeft;
      const scaleYRange = paddingTop - paddingBottom;

      const bars = $(Y);
      const ex = $(ex);
      const stddev = $(stddev);

      const xScaleStart = $(x_start);
      const xScaleEnd = $(x_end);
      const yScaleStart = $(y_start);
      const yScaleEnd = $(y_end);

      function updateLines() {
        while (linesGroup.firstChild) {
          linesGroup.removeChild(linesGroup.firstChild);
        }

        const dataKeys = Object.keys(bars).map(Number);
        const dataValues = Object.values(bars);

        dataKeys.forEach((key, index) => {
          const x = paddingLeft + ((key - xScaleStart) * scaleXRange / (xScaleEnd - xScaleStart));
          const y = svgHeight - (dataValues[index] * scaleYRange / (yScaleEnd - yScaleStart)) - paddingBottom;

          const line = document.createElementNS("http://www.w3.org/2000/svg", "line");
          line.setAttribute("x1", x);
          line.setAttribute("y1", svgHeight - paddingBottom);
          line.setAttribute("x2", x);
          line.setAttribute("y2", y);
          line.setAttribute("stroke", "rgba(0,0,255,0.8)");
          line.setAttribute("stroke-width", 2);
          linesGroup.appendChild(line);
        });

        const exX = paddingLeft + ((ex - xScaleStart) * scaleXRange / (xScaleEnd - xScaleStart));
        const dashedLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
        dashedLine.setAttribute("x1", exX);
        dashedLine.setAttribute("y1", paddingBottom-25);
        dashedLine.setAttribute("x2", exX);
        dashedLine.setAttribute("y2", paddingTop+15);
        dashedLine.setAttribute("stroke", "grey");
        dashedLine.setAttribute("stroke-width", 2);
        dashedLine.setAttribute("stroke-dasharray", "5,5");
        dashedLine.setAttribute("opacity", "0.5");
        svg.appendChild(dashedLine);

        const exLabel = document.createElementNS("http://www.w3.org/2000/svg", "text");
        exLabel.setAttribute("x", exX);
        exLabel.setAttribute("y", svgHeight - paddingBottom + 25);
        exLabel.setAttribute("text-anchor", "middle");
        exLabel.setAttribute("fill", "black");
        exLabel.textContent = ex.toFixed(2);
        svg.appendChild(exLabel);

        const exMinusStddevX = paddingLeft + ((ex - stddev - xScaleStart) * scaleXRange / (xScaleEnd - xScaleStart));
        const exPlusStddevX = paddingLeft + ((ex + stddev - xScaleStart) * scaleXRange / (xScaleEnd - xScaleStart));

        const stddevLine1 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        stddevLine1.setAttribute("x1", exMinusStddevX);
        stddevLine1.setAttribute("y1", paddingTop-10);
        stddevLine1.setAttribute("x2", exMinusStddevX);
        stddevLine1.setAttribute("y2", paddingTop+10);
        stddevLine1.setAttribute("stroke", "black");
        stddevLine1.setAttribute("stroke-width", 2);
        stddevLine1.setAttribute("opacity", "0.5");
        svg.appendChild(stddevLine1);

        const stddevLine2 = document.createElementNS("http://www.w3.org/2000/svg", "line");
        stddevLine2.setAttribute("x1", exPlusStddevX);
        stddevLine2.setAttribute("y1", paddingTop-10);
        stddevLine2.setAttribute("x2", exPlusStddevX);
        stddevLine2.setAttribute("y2", paddingTop+10);
        stddevLine2.setAttribute("stroke", "black");
        stddevLine2.setAttribute("stroke-width", 2);
        stddevLine2.setAttribute("opacity", "0.5");
        svg.appendChild(stddevLine2);
      }

      updateLines();
    </script>
    """)
end;

# ╔═╡ 26b50c5e-9ed4-43cf-a957-05985abaa94d
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

# ╔═╡ 124af1e5-9fc5-4c7a-9865-7f74a27e522f
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
Distributions = "~0.25.111"
HypertextLiteral = "~0.9.5"
PlutoTeachingTools = "~0.3.0"
PlutoUI = "~0.7.60"
RDatasets = "~0.7.7"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "9cc63f941d481db2b02b8ec98f2466437e4dbeba"

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

[[deps.Mocking]]
deps = ["Compat", "ExprTools"]
git-tree-sha1 = "2c140d60d7cb82badf06d8783800d0bcd1a7daa2"
uuid = "78c3b35d-d492-501b-9361-3d52fe80e533"
version = "0.8.1"

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
# ╟─6b5b82d6-871e-4333-9d68-df27f89045c2
# ╟─ef3c7620-7c11-11ef-1101-7f7a0fde04e5
# ╟─a6495731-94fd-4f63-b60e-5440fae89517
# ╠═ce2d0ac9-7ef2-41a4-a7a5-deed9c91acff
# ╟─c4d5e3c5-516c-4b99-bb93-6d3d121cbb9d
# ╟─31ab142d-f7a7-4744-8dda-08c6867f6ccd
# ╠═5ae94e1f-08b7-4f03-8c30-89fd64ca5dd0
# ╟─7fd819cd-5f8b-446f-8990-1efc6815d347
# ╟─8bec72e6-7e0b-4182-ab10-24e89ce22d97
# ╟─b78c8f16-e924-4dbc-8093-90d6933b1504
# ╟─912483d9-023b-48a6-9728-fda5505c1a07
# ╟─c850a7d5-36cd-4ce2-b928-9c40173061e6
# ╟─41eecc09-df09-44e8-bd8e-b8fe22304e11
# ╟─c0c00af7-1edd-4ada-ad3e-13a6cb343488
# ╠═0c47a175-5ead-430f-9e1f-e3c8db4ca4e1
# ╟─3eff8241-526d-4c3f-b9c5-aac9f1e7b6a2
# ╟─4c785258-be36-4f46-b343-ad112cadaa39
# ╠═b9055c8d-b87b-4a5c-956c-b1d78aeb2385
# ╟─c65eb8ca-da5c-4910-9bba-d9c784bf339e
# ╟─ab85b92e-0dc5-4e8a-8681-d87a62ba2095
# ╠═ea256869-8feb-49c2-a6da-bd9aa5f53fd5
# ╟─6b3aca99-b3e6-45ac-b6f9-995548dd6be5
# ╟─1eb34613-433c-4ff4-84c3-cae1836ef192
# ╠═91ff9078-6164-4ac9-98e7-a7ac9b8c9ef0
# ╟─50a26147-ae15-4583-8f49-3f0bbb732da1
# ╟─ba9e44e3-0fe0-4585-853b-6f58c8c53780
# ╟─774c75d5-8c31-4265-9f44-f5141584741b
# ╟─25dcb670-d252-4b9d-b185-00cdf2faf141
# ╟─124af1e5-9fc5-4c7a-9865-7f74a27e522f
# ╟─26b50c5e-9ed4-43cf-a957-05985abaa94d
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
