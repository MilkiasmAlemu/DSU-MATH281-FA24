### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ 58180940-6fc7-11ef-0efb-532ff5cbfaba
using PlutoUI, HypertextLiteral

# ╔═╡ 15af6187-bf68-44d5-a450-2cd6071d9c06
using StatsBase

# ╔═╡ f72445a7-bf9c-4183-a7ee-5e90085233a9
@htl("<h1>Lecture 5</h1>")

# ╔═╡ 820ea80f-664c-40c0-8934-12a8402a551c
md"### The Cumulative Distribution Function
---"

# ╔═╡ ad5c1d76-5c96-4693-9720-cd4c894aa1f5
begin
    width = 500
    height = 300
    bottom_margin = 30
    half_bottom_margin = bottom_margin / 2
    circle_radius = 5
    x_start = -0.5
    x_end = 6.5
    paddingLeft = 25
    slider_height = 30

    x_zero_position = paddingLeft + (0 - x_start) * (width - 2 * paddingLeft) / (x_end - x_start)

    @htl("""
    <svg width="$(width)" height="$(height)" style="background-color: white;" id="axis-svg">
      <g id="staircase-group"></g>
      <g id="segment-labels"></g>
      <g id="y-axis-labels"></g>
      <g id="points-group"></g>
      <g id="lines-group"></g>
    <line x1="$(paddingLeft)" y1="$(height-bottom_margin)" x2="$(width-paddingLeft)" y2="$(height-bottom_margin)" stroke="black" stroke-width="2" opacity="0.5"/>
      <line x1="$(x_zero_position)" y1="$(height-bottom_margin + half_bottom_margin)" x2="$(x_zero_position)" y2="10" stroke="black" stroke-width="2" opacity="0.5"/>
    </svg>

    <div style="background-color: grey; opacity: 0.75; width: $(width)px; height: $(slider_height)px; position: relative; display: flex; justify-content: center; align-items: center;">
      <input type="range" id="x-slider" min="$(paddingLeft)" max="$(width-paddingLeft)" value="$(paddingLeft)" style="width: calc(100% - 2 * $(paddingLeft)px);"/>
    </div>

    <button id="reset-button" style="margin-top: 10px;">Reset</button>

    <script>
      const svg = document.getElementById("axis-svg");
      const slider = document.getElementById("x-slider");
      const staircaseGroup = document.getElementById("staircase-group");
      const labelsGroup = document.getElementById("segment-labels");
      const yAxisLabelsGroup = document.getElementById("y-axis-labels");
      const pointsGroup = document.getElementById("points-group");
      const linesGroup = document.getElementById("lines-group");
      const resetButton = document.getElementById("reset-button");
      const maxY = $(height - bottom_margin);
      const paddingLeft = $(paddingLeft);
      const paddingRight = $(width) - paddingLeft;
      const circleRadius = $(circle_radius);
      const minY = 10;
      const xScaleStart = $(x_start);
      const xScaleEnd = $(x_end);
      const scaleRange = paddingRight - paddingLeft;
      const yRange = maxY - minY;
      let verticalLines = [];

      let isDragging = false;
      let dragMoved = false;

      function scaleXPosition(x) {
        const relativeX = (x - paddingLeft) / scaleRange;
        return (relativeX * (xScaleEnd - xScaleStart)) + xScaleStart;
      }

      function normalizeHeight(height, totalHeight) {
        return (height / totalHeight) * yRange;
      }

      function normalizeSegmentHeights() {
        let totalCumulativeHeight = verticalLines.reduce((sum, line) => sum + line.height, 0);
        verticalLines.forEach(line => {
          let scaledHeight = normalizeHeight(line.height, totalCumulativeHeight);
          const lineSegment = document.querySelector(`.segment-line[data-id="\${line.id}"]`);
          const verticalPoint = document.querySelector(`.draggable-vertical-point[data-id="\${line.id}"]`);

          if (lineSegment && verticalPoint) {
            lineSegment.setAttribute("y2", maxY - scaledHeight + circleRadius);
            verticalPoint.setAttribute("cy", maxY - scaledHeight);
          }
        });
      }

      function updateStaircase(xSliderValue) {
        let cumulativeHeight = 0;
        let totalCumulativeHeight = verticalLines.reduce((sum, line) => sum + line.height, 0);
        let lastX = paddingLeft;

        verticalLines.sort((a, b) => a.x - b.x);

        while (staircaseGroup.firstChild) {
          staircaseGroup.removeChild(staircaseGroup.firstChild);
        }

        if (totalCumulativeHeight > 0) {
          verticalLines.forEach(line => {
            const lineX = line.x;
            const height = normalizeHeight(line.height, totalCumulativeHeight);

            if (lineX <= xSliderValue) {
              const step = document.createElementNS("http://www.w3.org/2000/svg", "line");
              step.setAttribute("x1", lastX);
              step.setAttribute("y1", maxY - cumulativeHeight);
              step.setAttribute("x2", lineX);
              step.setAttribute("y2", maxY - cumulativeHeight);
              step.setAttribute("stroke", "blue");
              step.setAttribute("stroke-width", 2.5);
              step.setAttribute("opacity", 0.75);
              step.setAttribute("class", "staircase-line");
              staircaseGroup.appendChild(step);

              const verticalJump = document.createElementNS("http://www.w3.org/2000/svg", "line");
              verticalJump.setAttribute("x1", lineX);
              verticalJump.setAttribute("y1", maxY - cumulativeHeight);
              verticalJump.setAttribute("x2", lineX);
              verticalJump.setAttribute("y2", maxY - (cumulativeHeight + height));
              verticalJump.setAttribute("stroke", "blue");
              verticalJump.setAttribute("stroke-width", 2.5);
              verticalJump.setAttribute("opacity", 0.75);
              verticalJump.setAttribute("class", "staircase-vertical");
              staircaseGroup.appendChild(verticalJump);

              lastX = lineX;
              cumulativeHeight += height;
            }
          });

          const finalStep = document.createElementNS("http://www.w3.org/2000/svg", "line");
          finalStep.setAttribute("x1", lastX);
          finalStep.setAttribute("y1", maxY - cumulativeHeight);
          finalStep.setAttribute("x2", xSliderValue);
          finalStep.setAttribute("y2", maxY - cumulativeHeight);
          finalStep.setAttribute("stroke", "blue");
          finalStep.setAttribute("stroke-width", 2.5);
          finalStep.setAttribute("opacity", 0.75);
          finalStep.setAttribute("class", "staircase-line");
          staircaseGroup.appendChild(finalStep);
        }
      }

      function updateSegmentLabels() {
        while (labelsGroup.firstChild) {
          labelsGroup.removeChild(labelsGroup.firstChild);
        }

        verticalLines.forEach(line => {
          const label = document.createElementNS("http://www.w3.org/2000/svg", "text");
          label.setAttribute("x", line.x);
          label.setAttribute("y", maxY + 15);
          label.setAttribute("text-anchor", "middle");
          label.setAttribute("fill", "black");
          label.textContent = scaleXPosition(line.x).toFixed(2);
          labelsGroup.appendChild(label);
        });
      }

      function updateYAxisLabels() {
        while (yAxisLabelsGroup.firstChild) {
          yAxisLabelsGroup.removeChild(yAxisLabelsGroup.firstChild);
        }

        let totalCumulativeHeight = verticalLines.reduce((sum, line) => sum + line.height, 0);

        verticalLines.forEach(line => {
          const height = normalizeHeight(line.height, totalCumulativeHeight);
          const label = document.createElementNS("http://www.w3.org/2000/svg", "text");
          label.setAttribute("x", paddingLeft + 25);
          label.setAttribute("y", maxY - height + 5);
          label.setAttribute("text-anchor", "end");
          label.setAttribute("fill", "black");
          label.textContent = (line.height / totalCumulativeHeight).toFixed(2);
          yAxisLabelsGroup.appendChild(label);
        });
      }

      function updateExpectedValueLine() {
        const existingDashedLine = document.getElementById("mean-dashed-line");
        if (existingDashedLine) {
          existingDashedLine.remove();
        }

        if (verticalLines.length > 0) {
          const totalCumulativeHeight = verticalLines.reduce((sum, line) => sum + line.height, 0);
          let weightedSumX = 0;

          verticalLines.forEach(line => {
            const normalizedHeight = line.height / totalCumulativeHeight;
            weightedSumX += normalizedHeight * line.x;
          });

          const expectedValueX = weightedSumX;

          const dashedLine = document.createElementNS("http://www.w3.org/2000/svg", "line");
          dashedLine.setAttribute("id", "mean-dashed-line");
          dashedLine.setAttribute("x1", expectedValueX);
          dashedLine.setAttribute("y1", minY);
          dashedLine.setAttribute("x2", expectedValueX);
          dashedLine.setAttribute("y2", maxY);
          dashedLine.setAttribute("stroke", "black");
          dashedLine.setAttribute("stroke-width", 2);
          dashedLine.setAttribute("stroke-dasharray", "5,5");
          dashedLine.setAttribute("opacity", 0.5);
          svg.appendChild(dashedLine);
        }
      }

      svg.addEventListener("click", function(event) {
        if (isDragging || dragMoved) {
          dragMoved = false;
          return;
        }

        const pointX = event.offsetX;
        const id = Date.now();

        if (pointX >= paddingLeft && pointX <= paddingRight && event.button === 0) {
          const lineSegment = document.createElementNS("http://www.w3.org/2000/svg", "line");
          const segmentHeight = 50;
          lineSegment.setAttribute("x1", pointX);
          lineSegment.setAttribute("y1", maxY - circleRadius);
          lineSegment.setAttribute("x2", pointX);
          lineSegment.setAttribute("y2", maxY - segmentHeight + circleRadius);
          lineSegment.setAttribute("stroke", "blue");
          lineSegment.setAttribute("stroke-width", 2);
          lineSegment.setAttribute("opacity", 0.5);
          lineSegment.setAttribute("class", "segment-line");
          lineSegment.setAttribute("data-id", id);
          linesGroup.appendChild(lineSegment);

          verticalLines.push({ id, x: pointX, height: segmentHeight });

          const newPoint = document.createElementNS("http://www.w3.org/2000/svg", "circle");
          newPoint.setAttribute("cx", pointX);
          newPoint.setAttribute("cy", maxY);
          newPoint.setAttribute("r", circleRadius);
          newPoint.setAttribute("fill", "blue");
          newPoint.setAttribute("opacity", 0.5);
          pointsGroup.appendChild(newPoint);

          const verticalPoint = document.createElementNS("http://www.w3.org/2000/svg", "circle");
          verticalPoint.setAttribute("cx", pointX);
          verticalPoint.setAttribute("cy", maxY - segmentHeight);
          verticalPoint.setAttribute("r", circleRadius);
          verticalPoint.setAttribute("fill", "blue");
          verticalPoint.setAttribute("opacity", 0.5);
          verticalPoint.setAttribute("class", "draggable-vertical-point");
          verticalPoint.setAttribute("data-id", id);
          pointsGroup.appendChild(verticalPoint);

          normalizeSegmentHeights();
          updateStaircase(parseFloat(slider.value));
          updateSegmentLabels();
          updateYAxisLabels();
          updateExpectedValueLine();

          let isDraggingXAxisPoint = false;
          let isDraggingVerticalPoint = false;

          svg.addEventListener("mousemove", function(event) {
            if (isDraggingXAxisPoint) {
              dragMoved = true;
              const newX = event.offsetX;
              if (newX >= paddingLeft && newX <= paddingRight) {
                const pointIndex = verticalLines.findIndex(line => line.id === id);
                verticalLines[pointIndex].x = newX;

                newPoint.setAttribute("cx", newX);
                verticalPoint.setAttribute("cx", newX);
                lineSegment.setAttribute("x1", newX);
                lineSegment.setAttribute("x2", newX);
                normalizeSegmentHeights();
                updateStaircase(parseFloat(slider.value));
                updateSegmentLabels();
                updateYAxisLabels();
                updateExpectedValueLine();
              }
            }

            if (isDraggingVerticalPoint) {
              dragMoved = true;
              const newY = event.offsetY;
              if (newY >= minY && newY <= maxY) {
                const pointIndex = verticalLines.findIndex(line => line.id === id);
                const newHeight = maxY - newY;
                verticalLines[pointIndex].height = newHeight;

                verticalPoint.setAttribute("cy", newY);
                lineSegment.setAttribute("y2", newY + circleRadius);
                normalizeSegmentHeights();
                updateStaircase(parseFloat(slider.value));
                updateYAxisLabels();
                updateExpectedValueLine();
              }
            }
          });

          newPoint.addEventListener("mousedown", function(e) {
            if (e.button === 0) isDraggingXAxisPoint = true;
          });

          verticalPoint.addEventListener("mousedown", function(e) {
            if (e.button === 0) isDraggingVerticalPoint = true;
          });

          svg.addEventListener("mouseup", function() {
            isDraggingXAxisPoint = false;
            isDraggingVerticalPoint = false;
            isDragging = false;
          });

          svg.addEventListener("mouseleave", function() {
            isDraggingXAxisPoint = false;
            isDraggingVerticalPoint = false;
            isDragging = false;
          });

          newPoint.addEventListener("contextmenu", function(e) {
            e.preventDefault();
            newPoint.remove();
            verticalPoint.remove();
            lineSegment.remove();
            verticalLines = verticalLines.filter(line => line.id !== id);
            normalizeSegmentHeights();
            updateStaircase(parseFloat(slider.value));
            updateSegmentLabels();
            updateYAxisLabels();
            updateExpectedValueLine();
          });

          verticalPoint.addEventListener("contextmenu", function(e) {
            e.preventDefault();
            newPoint.remove();
            verticalPoint.remove();
            lineSegment.remove();
            verticalLines = verticalLines.filter(line => line.id !== id);
            normalizeSegmentHeights();
            updateStaircase(parseFloat(slider.value));
            updateSegmentLabels();
            updateYAxisLabels();
            updateExpectedValueLine();
          });
        }
      });

      slider.addEventListener("input", function(event) {
        const sliderValue = parseFloat(slider.value);
        updateStaircase(sliderValue);
      });

      resetButton.addEventListener("click", function() {
        staircaseGroup.innerHTML = '';
        labelsGroup.innerHTML = '';
        yAxisLabelsGroup.innerHTML = '';
        pointsGroup.innerHTML = '';
        linesGroup.innerHTML = '';
        verticalLines = [];
        normalizeSegmentHeights();
        updateStaircase(parseFloat(slider.value));
        updateExpectedValueLine();
      });
    </script>
    """)
end

# ╔═╡ 6e45e0e8-80aa-418a-9724-17a994235ddd
md"### Expected Values for Dice Rolls
---"

# ╔═╡ 933d9221-c2b3-46f6-ac10-a947b3fd72ac
DiceRolls = [i for i in 1:6]

# ╔═╡ 38794ab8-34b7-4b81-a478-0cf82f56f66b
begin
    data_values = DiceRolls

    unique_data, frequency_data = unique(data_values), countmap(data_values)
    rel_freq_data = [frequency_data[val] / length(data_values) for val in unique_data]

    sorted_indices = sortperm(unique_data)
    unique_data_sorted = unique_data[sorted_indices]
    rel_freq_data_sorted = rel_freq_data[sorted_indices]
	expected_value = sum(x * frequency_data[x] for x in unique(data_values)) / length(data_values)

    min_x_data = min(0, minimum(data_values)) - 0.5
    max_x_data = maximum(data_values) + 0.5
    plot_width_data = 500
    plot_height_data = 300
    bottom_margin_data = 30
    circle_radius_data = 5
    left_padding_data = 50
    slider_height_data = 30
    y_axis_range_data = plot_height_data - bottom_margin_data - 10
    half_bottom_margin_data = bottom_margin_data / 2

	scaled_expected_value = left_padding_data + (expected_value - min_x_data) / (max_x_data - min_x_data) * (plot_width_data - 2 * left_padding_data)

    @htl("""
    <svg width="$(plot_width_data)" height="$(plot_height_data)" style="background-color: white;" id="data-plot-svg">
      <g id="cdf-group"></g>
      <g id="x-labels-group"></g>
      <g id="y-labels-group"></g>
      <g id="point-group"></g>
      <g id="line-group"></g>
      <line x1="$(left_padding_data)" y1="$(plot_height_data-bottom_margin_data)" x2="$(plot_width_data-left_padding_data)" y2="$(plot_height_data-bottom_margin_data)" stroke="black" stroke-width="2" opacity="0.5"/>
      <line x1="$(left_padding_data)" y1="10" x2="$(left_padding_data)" y2="$(plot_height_data-bottom_margin_data)" stroke="black" stroke-width="2" opacity="0.5"/>
	  <line x1="$(scaled_expected_value)" y1="10" x2="$(scaled_expected_value)" y2="$(plot_height_data - bottom_margin_data)" stroke="black" stroke-width="2" stroke-dasharray="5, 5" opacity="0.5"/>
    </svg>

    <div style="background-color: grey; opacity: 0.75; width: $(plot_width_data)px; height: $(slider_height_data)px; position: relative; display: flex; justify-content: center; align-items: center;">
      <input type="range" id="cdf-slider" min="$(left_padding_data)" max="$(plot_width_data-left_padding_data)" value="$(left_padding_data)" style="width: calc(100% - 2 * $(left_padding_data)px);"/>
    </div>

    <script>
      const svgElementData = document.getElementById("data-plot-svg");
      const cdfSliderData = document.getElementById("cdf-slider");
      const cdfGroupData = document.getElementById("cdf-group");
      const xLabelsGroupData = document.getElementById("x-labels-group");
      const yLabelsGroupData = document.getElementById("y-labels-group");
      const pointGroupData = document.getElementById("point-group");
      const lineGroupData = document.getElementById("line-group");
      const plotMaxYData = $(plot_height_data - bottom_margin_data);
      const plotLeftPaddingData = $(left_padding_data);
      const plotRightPaddingData = $(plot_width_data) - plotLeftPaddingData;
      const plotCircleRadiusData = $(circle_radius_data);
      const plotMinXData = $(min_x_data);
      const plotMaxXData = $(max_x_data);
      const xScaleStartData = plotMinXData;
      const xScaleEndData = plotMaxXData;
      const scaleRangeXData = plotRightPaddingData - plotLeftPaddingData;
      const yAxisRangeData = $(y_axis_range_data);
      const relFreqsDataSorted = $(rel_freq_data_sorted);
      const uniqValsDataSorted = $(unique_data_sorted);

      function scaleXCoordData(x) {
        const relativeX = (x - xScaleStartData) / (xScaleEndData - xScaleStartData);
        return plotLeftPaddingData + relativeX * scaleRangeXData;
      }

      function normalizeYHeightData(freq) {
        return freq * yAxisRangeData;
      }

      function plotData() {
        lineGroupData.innerHTML = '';
        pointGroupData.innerHTML = '';
        xLabelsGroupData.innerHTML = '';
        yLabelsGroupData.innerHTML = '';

        uniqValsDataSorted.forEach((val, i) => {
          const xCoord = scaleXCoordData(val);
          const yHeight = normalizeYHeightData(relFreqsDataSorted[i]);

          const lineElement = document.createElementNS("http://www.w3.org/2000/svg", "line");
          lineElement.setAttribute("x1", xCoord);
          lineElement.setAttribute("y1", plotMaxYData - plotCircleRadiusData);
          lineElement.setAttribute("x2", xCoord);
          lineElement.setAttribute("y2", plotMaxYData - yHeight + plotCircleRadiusData);
          lineElement.setAttribute("stroke", "blue");
          lineElement.setAttribute("stroke-width", 2);
          lineElement.setAttribute("opacity", 0.5);
          lineGroupData.appendChild(lineElement);

          const topPointElement = document.createElementNS("http://www.w3.org/2000/svg", "circle");
          topPointElement.setAttribute("cx", xCoord);
          topPointElement.setAttribute("cy", plotMaxYData - yHeight);
          topPointElement.setAttribute("r", plotCircleRadiusData);
          topPointElement.setAttribute("fill", "blue");
          topPointElement.setAttribute("opacity", 0.5);
          pointGroupData.appendChild(topPointElement);

          const bottomPointElement = document.createElementNS("http://www.w3.org/2000/svg", "circle");
          bottomPointElement.setAttribute("cx", xCoord);
          bottomPointElement.setAttribute("cy", plotMaxYData);
          bottomPointElement.setAttribute("r", plotCircleRadiusData);
          bottomPointElement.setAttribute("fill", "blue");
          bottomPointElement.setAttribute("opacity", 0.5);
          pointGroupData.appendChild(bottomPointElement);

          const xLabel = document.createElementNS("http://www.w3.org/2000/svg", "text");
          xLabel.setAttribute("x", xCoord);
          xLabel.setAttribute("y", plotMaxYData + 15);
          xLabel.setAttribute("text-anchor", "middle");
          xLabel.setAttribute("fill", "black");
          xLabel.textContent = val.toFixed(0);
          xLabelsGroupData.appendChild(xLabel);

          const yLabel = document.createElementNS("http://www.w3.org/2000/svg", "text");
          yLabel.setAttribute("x", plotLeftPaddingData - 10);
          yLabel.setAttribute("y", plotMaxYData - yHeight + 5);
          yLabel.setAttribute("text-anchor", "end");
		  yLabel.setAttribute("font-size", 10);
          yLabel.setAttribute("fill", "black");
          yLabel.textContent = relFreqsDataSorted[i].toFixed(2);
          yLabelsGroupData.appendChild(yLabel);
        });
      }

      function updateCDFPlotData(sliderValue) {
        let cumulativeHeightData = 0;
        let lastXCoordData = plotLeftPaddingData;

        cdfGroupData.innerHTML = '';

        uniqValsDataSorted.forEach((val, i) => {
          const xCoord = scaleXCoordData(val);
          const yHeight = normalizeYHeightData(relFreqsDataSorted[i]);

          if (xCoord <= sliderValue) {
            const stepElement = document.createElementNS("http://www.w3.org/2000/svg", "line");
            stepElement.setAttribute("x1", lastXCoordData);
            stepElement.setAttribute("y1", plotMaxYData - cumulativeHeightData);
            stepElement.setAttribute("x2", xCoord);
            stepElement.setAttribute("y2", plotMaxYData - cumulativeHeightData);
            stepElement.setAttribute("stroke", "blue");
            stepElement.setAttribute("stroke-width", 2.5);
            stepElement.setAttribute("opacity", 0.75);
            cdfGroupData.appendChild(stepElement);

            const verticalStep = document.createElementNS("http://www.w3.org/2000/svg", "line");
            verticalStep.setAttribute("x1", xCoord);
            verticalStep.setAttribute("y1", plotMaxYData - cumulativeHeightData);
            verticalStep.setAttribute("x2", xCoord);
            verticalStep.setAttribute("y2", plotMaxYData - (cumulativeHeightData + yHeight));
            verticalStep.setAttribute("stroke", "blue");
            verticalStep.setAttribute("stroke-width", 2.5);
            verticalStep.setAttribute("opacity", 0.75);
            cdfGroupData.appendChild(verticalStep);

            lastXCoordData = xCoord;
            cumulativeHeightData += yHeight;
          }
        });

        const finalStepData = document.createElementNS("http://www.w3.org/2000/svg", "line");
        finalStepData.setAttribute("x1", lastXCoordData);
        finalStepData.setAttribute("y1", plotMaxYData - cumulativeHeightData);
        finalStepData.setAttribute("x2", sliderValue);
        finalStepData.setAttribute("y2", plotMaxYData - cumulativeHeightData);
        finalStepData.setAttribute("stroke", "blue");
        finalStepData.setAttribute("stroke-width", 2.5);
        finalStepData.setAttribute("opacity", 0.75);
        cdfGroupData.appendChild(finalStepData);
      }

      plotData();

      cdfSliderData.addEventListener("input", function(event) {
        const sliderValue = parseFloat(cdfSliderData.value);
        updateCDFPlotData(sliderValue);
      });

      cdfSliderData.addEventListener("change", function(event) {
        const sliderValue = parseFloat(cdfSliderData.value);
        updateCDFPlotData(sliderValue);
      });
    </script>
    """)
end

# ╔═╡ ef8aca5b-facc-404e-99b5-5b4631e95955
unique_values = unique(DiceRolls)

# ╔═╡ 254c0f93-97da-46a2-a72c-ff70bdea66ce
frequency_values = countmap(DiceRolls)

# ╔═╡ 32b45d46-bcf6-4b41-a16a-ecb2b6246813
ExpectedValue(f) = sum([f(x) * frequency_values[x] / length(DiceRolls) for x in unique_values])

# ╔═╡ 36c84bd8-bbab-46e0-875a-afbb036ff02c
f(x) = 1

# ╔═╡ 3f1a8f64-107f-4e2f-9873-4e8fe6e171c1
ExpectedValue(f)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"

[compat]
HypertextLiteral = "~0.9.5"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "c54366fb140bc93196c5e7f4da5af29b594c032c"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

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

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

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

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

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

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

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

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

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

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

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
# ╟─f72445a7-bf9c-4183-a7ee-5e90085233a9
# ╟─58180940-6fc7-11ef-0efb-532ff5cbfaba
# ╠═15af6187-bf68-44d5-a450-2cd6071d9c06
# ╟─820ea80f-664c-40c0-8934-12a8402a551c
# ╟─ad5c1d76-5c96-4693-9720-cd4c894aa1f5
# ╟─6e45e0e8-80aa-418a-9724-17a994235ddd
# ╠═933d9221-c2b3-46f6-ac10-a947b3fd72ac
# ╟─38794ab8-34b7-4b81-a478-0cf82f56f66b
# ╠═ef8aca5b-facc-404e-99b5-5b4631e95955
# ╠═254c0f93-97da-46a2-a72c-ff70bdea66ce
# ╠═32b45d46-bcf6-4b41-a16a-ecb2b6246813
# ╠═36c84bd8-bbab-46e0-875a-afbb036ff02c
# ╠═3f1a8f64-107f-4e2f-9873-4e8fe6e171c1
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
