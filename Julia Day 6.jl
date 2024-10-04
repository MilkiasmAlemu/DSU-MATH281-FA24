### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# ╔═╡ aee22efb-f3cf-4e28-849b-510e16a41490
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools
end

# ╔═╡ 8b6125a3-17b7-4306-95ef-19133c195b97
using StatsBase, RDatasets, CSV, HTTP

# ╔═╡ ca4cf769-7e6c-4af8-8c36-99709bbd6a75
@htl("""
	<h1>Correlation Lab</h1>
""")

# ╔═╡ 14c31f09-e1f1-45d5-9b90-cdfe75cfd0d1
TableOfContents()

# ╔═╡ 0b9c0c14-408b-47c4-b522-2fd2237cbc5a
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ f22fc5fa-55cb-4d54-82c8-72dcc5a8d2b3
@htl("""
	<hr>
""")

# ╔═╡ 652d075d-d9aa-4b8d-a299-91aca6c03198
@htl("""
	<h2>Properties of Covariance and Correlation</h2>
""")

# ╔═╡ 00acc74d-6448-4ccf-9a75-1d2892993885
@htl("""
	<hr>
""")

# ╔═╡ 20b77f45-36a4-493d-b390-f187a6c132bd
@htl("""
	<hr>
""")

# ╔═╡ 1e424980-4ecf-48e6-9842-f00ad8df0950
@htl("""
	<hr>
""")

# ╔═╡ 200b0d5b-a2e8-48a6-b3a6-d9182c9c2f20
@htl("""
	<h2>Heights and Weights</h2>
""")

# ╔═╡ 9eff6d3a-35f7-442a-83b7-0712b38017f8
HeightsAndWeights = dropmissing(RDatasets.dataset("car", "Davis"))

# ╔═╡ 942e32cf-3103-4c31-9686-df3845d77cdf
Heights = HeightsAndWeights[!,"Height"]

# ╔═╡ ef38e8a5-e088-4671-9b3b-f45d4a8c9321
Weights = HeightsAndWeights[!,"Weight"]

# ╔═╡ 9553ead0-3f1b-4f3a-a8e4-7423c5992967
ReportedHeights = HeightsAndWeights[!,"RepHt"]

# ╔═╡ e5b5c7b9-d3ae-46ed-b618-9d6a1219fc89
ReportedWeights = HeightsAndWeights[!,"RepWt"]

# ╔═╡ 592ed063-3dde-4954-ac8b-3700f27597ff
HeightsAndWeights2 = filter(row -> row."Weight" < 150, HeightsAndWeights)

# ╔═╡ 6742edc1-e682-4f37-aef6-240d98732dc3
Heights2 = HeightsAndWeights2[!,"Height"]

# ╔═╡ 4d04bc7a-d536-46bd-876f-0bd47eaeed88
Weights2 = HeightsAndWeights2[!,"Weight"]

# ╔═╡ 8a2cac7e-545e-4174-aa53-fb6aca962b79
ReportedHeights2 = HeightsAndWeights2[!,"RepHt"]

# ╔═╡ 7a147e53-8149-4292-9f5a-f1eb1d8204d9
ReportedWeights2 = HeightsAndWeights2[!,"RepWt"]

# ╔═╡ fbcc4bdf-5212-4891-a802-579f4345f8e4
PredictedHeight(weight) = mean(Heights2) + cor(Weights2, Heights2) * std(Heights2) / std(Weights2) * (weight - mean(Weights2))

# ╔═╡ eabcb500-d00f-448f-9fb0-1f7337a66056
PredictedHeight(100)

# ╔═╡ a1518615-ed9b-4a6b-88a5-7d653fdfcd5a
@htl("""
	<hr>
""")

# ╔═╡ 91d33d8b-b27f-407d-b471-3dbdbd22716d
@htl("""
	<h2>Anscombe's Quartet</h2>
""")

# ╔═╡ d9ae605e-eaa0-438b-89aa-fec62fd03624
Anscombe = DataFrame("Data1 - x" => [10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5], "Data1 - y" => [8.04, 6.95, 7.58, 8.81, 8.33, 9.96, 7.24, 4.26, 10.84, 4.82, 5.68], "Data2 - x" => [10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5], "Data2 - y" => [9.14, 8.14, 8.74, 8.77, 9.26, 8.1, 6.13, 3.1, 9.13, 7.26, 4.74], "Data3 - x" => [10, 8, 13, 9, 11, 14, 6, 4, 12, 7, 5], "Data3 - y" => [7.46, 6.77, 12.74, 7.11, 7.81, 8.84, 6.08, 5.39, 8.15, 6.42, 5.73], "Data4 - x" => [8, 8, 8, 8, 8, 8, 8, 19, 8, 8, 8], "Data4 - y" => [6.58, 5.76, 7.71, 8.84, 8.47, 7.04, 5.25, 12.5, 5.56, 7.91, 6.89])

# ╔═╡ 3c901fd0-26e9-4c95-96dc-1bcb6588e60f
XDatas = [Anscombe[!, "Data1 - x"], Anscombe[!, "Data2 - x"], Anscombe[!, "Data3 - x"], Anscombe[!, "Data4 - x"]]

# ╔═╡ 5474aae7-f2a1-4a91-b27c-afb465d9edd1
YDatas = [Anscombe[!, "Data1 - y"], Anscombe[!, "Data2 - y"], Anscombe[!, "Data3 - y"], Anscombe[!, "Data4 - y"]]

# ╔═╡ ebb993cd-e4c5-40a9-a680-f135c4f2ee44
X_means = mean.(XDatas)

# ╔═╡ 90c4b8ea-553e-4eda-a518-bfe999cc7aef
Y_means = mean.(YDatas)

# ╔═╡ 61391abb-2101-4971-87d3-2f448d1e8b1d
X_variances = var.(XDatas)

# ╔═╡ dcda2cfc-9a77-4bc5-8590-dc5faaf489ce
Y_varances = var.(YDatas)

# ╔═╡ 37b3d994-359c-4f12-a9f4-93b3ec96f418
Correlation_Coefficients = (xy -> cor(xy...)).(zip(XDatas, YDatas))

# ╔═╡ 07740c24-40d5-47fe-b5fb-9608f14b8872
Slopes = (xy -> cor(xy...) * std(xy[2]) / std(xy[1])).(zip(XDatas,YDatas))

# ╔═╡ 8c2fd46a-8dc4-4afc-9078-1072640de7b9
Intercepts = (xy -> mean(xy[2]) - cor(xy...) * std(xy[2]) / std(xy[1]) * mean(xy[1])).(zip(XDatas,YDatas))

# ╔═╡ 20d27f30-dec1-4fa9-a080-2d02669e3d2f
@htl("""
	<hr>
""")

# ╔═╡ 709c2c51-758e-4229-80b0-f3439c9fa5ec
@htl("""
	<h2>Datasaurus Dozen</h2>
""")

# ╔═╡ 6f621c33-2c08-412f-9e6e-f5788e98aa71
begin
	DatasaurusCSV = HTTP.get("https://raw.githubusercontent.com/plevanDSU/DSU-MATH281-FA24/refs/heads/main/data/datasaurus.csv")
	DatasaurusDF = CSV.File(IOBuffer(DatasaurusCSV.body)) |> DataFrame
	DatasaurusGroups = groupby(DatasaurusDF, :dataset)
	DatasaurusTitles = (df -> df[!, :dataset][1]).(collect(DatasaurusGroups))
end;

# ╔═╡ 29f03657-65f3-4760-8345-fa53c0a06ab4
DatasaurusDF

# ╔═╡ d160270b-14eb-452f-80f0-3bd13921a2dc
XDatas_Datasaurus = (df -> collect(df[!, :x])).(collect(DatasaurusGroups))

# ╔═╡ a4908cf7-af04-422d-afae-9162c278e6c3
YDatas_Datasaurus = (df -> collect(df[!, :y])).(collect(DatasaurusGroups))

# ╔═╡ 07a37960-e5f2-4f03-bd41-831ce522fdc8
X_means_Datasaurus = mean.(XDatas_Datasaurus)

# ╔═╡ 4d6b5a60-601c-4b42-8b31-8c5399925fab
Y_means_Datasaurus = mean.(YDatas_Datasaurus)

# ╔═╡ 6e3f07af-eda5-47a6-9335-815dbffe4ebc
X_variances_Datasaurus = var.(XDatas_Datasaurus)

# ╔═╡ 1350544c-8897-4f66-909b-170bc942763e
Y_varances_Datasaurus = var.(YDatas_Datasaurus)

# ╔═╡ 98609de2-d22c-4d21-93f8-798d1ac3ad14
Correlation_Coefficients_Datasaurus = (xy -> cor(xy...)).(zip(XDatas_Datasaurus, YDatas_Datasaurus))

# ╔═╡ 55f5cb75-4a81-41c4-9366-f185dbdd78ae
Slopes_Datasaurus = (xy -> cor(xy...) * std(xy[2]) / std(xy[1])).(zip(XDatas_Datasaurus,YDatas_Datasaurus))

# ╔═╡ 10f468ae-a12d-45bc-af45-4b0dc45973c9
Intercepts_Datasaurus = (xy -> mean(xy[2]) - cor(xy...) * std(xy[2]) / std(xy[1]) * mean(xy[1])).(zip(XDatas_Datasaurus,YDatas_Datasaurus))

# ╔═╡ dc25027c-9014-4b28-8398-3814e748d417
@htl("""
	<hr>
""")

# ╔═╡ c445d10c-76cc-494a-8a27-02d29a736801
#Function for plotting a Regression Plot
function plotRegression(X::AbstractArray, Y::AbstractArray; height = 500, width = 500, radius=5, opacity=-1)
	local m = cor(X,Y) * std(Y) / std(X)
	local b = mean(Y)
	local a = mean(X)

	local maxX = max(X...)
	local minX = min(X...)
	local maxY = max(Y...)
	local minY = min(Y...)

	local horizontal_padding = width / 10
	local vertical_padding = height / 10

	local xmin = horizontal_padding
	local xmax = width - horizontal_padding
	local ymin = vertical_padding
	local ymax = height - vertical_padding

	local xscale = (width - 2 * horizontal_padding) / (maxX - minX)
	local yscale = (height - 2 * vertical_padding) / (maxY - minY)

	local RegressUUID = string(uuid1())
	
	return @htl("""
	<svg id=$(RegressUUID*"-plot") width="$(width)" height="$(height)" style="background:white; border:1px solid black;">
	  <!-- <line x1="$(xmin)" y1="$(ymax)" x2="$(xmax)" y2="$(ymax)" stroke="black" stroke-width="2"></line>
	  <line x1="$(xmin)" y1="$(ymax)" x2="$(xmin)" y2="$(ymin)" stroke="black" stroke-width="2"></line> -->
	</svg>
	
	<script>
	  const xs = $(X);
	  const ys = $(Y);
	  const m = $(m);
	  const b = $(b);
	  const a = $(a)
	  const opacity = $((opacity > 0) ? opacity : 1.0 / cbrt(length(X)));
	  const radius = $(radius);
	  const minX = $(minX);
	  const maxX = $(maxX);
	  const minY = $(minY);
	  const maxY = $(maxY);
	  const xmin = $(xmin);
	  const xmax = $(xmax);
	  const ymin = $(ymin);
	  const ymax = $(ymax);
	  const xscale = $(xscale);
	  const yscale = $(yscale);
	  
	  const svg = document.getElementById($(RegressUUID*"-plot"));
	
	  function mapX(x) {
	    return xmin + xscale * (x - minX);
	  }
	
	  function mapY(y) {
	    return ymax - yscale * (y - minY);
	  }
	
	  for (let i = 0; i < xs.length; i++) {
	    let cx = mapX(xs[i]);
	    let cy = mapY(ys[i]);
	    let circle = document.createElementNS("http://www.w3.org/2000/svg", "circle");
	    circle.setAttribute("cx", cx);
	    circle.setAttribute("cy", cy);
	    circle.setAttribute("r", radius);
	    circle.setAttribute("fill", `rgba(0,0,255,\${opacity})`);
	    svg.appendChild(circle);
	  }
	
	  let x1 = minX;
	  let x2 = maxX;
	  let y1 = m * (x1 - a) + b;
	  let y2 = m * (x2 - a) + b;
	  
	  let line = document.createElementNS("http://www.w3.org/2000/svg", "line");
	  line.setAttribute("x1", mapX(x1));
	  line.setAttribute("y1", mapY(y1));
	  line.setAttribute("x2", mapX(x2));
	  line.setAttribute("y2", mapY(y2));
	  line.setAttribute("stroke", "red");
	  line.setAttribute("stroke-width", 2);
	  svg.appendChild(line);
	</script>
	""")
end;

# ╔═╡ 43d3f8b0-8707-4a5e-82bf-a1ff7a20b620
plotRegression(-1:0.01:1, (x->x^2).(-1:0.01:1))

# ╔═╡ f9f7acb8-f33d-4eb7-afdf-7f308bab17b2
plotRegression(Weights, Heights)

# ╔═╡ d3595822-ec68-4217-95b9-321e9c61a6e8
plotRegression(Weights2, Heights2)

# ╔═╡ f213c0df-73ae-4366-9578-811ee507251d
@htl("""
<div style="display: grid; grid-template-columns: repeat(2, 1fr); grid-gap: 10px; justify-items: center;">
    <div style="text-align: center;">
        $(plotRegression(XDatas[1], YDatas[1], height=200, width=300))
        <div style="margin-top: 10px; font-size: 16px;">Dataset 1</div>
    </div>
    <div style="text-align: center;">
        $(plotRegression(XDatas[2], YDatas[2], height=200, width=300))
        <div style="margin-top: 10px; font-size: 16px;">Dataset 2</div>
    </div>
    <div style="text-align: center;">
        $(plotRegression(XDatas[3], YDatas[3], height=200, width=300))
        <div style="margin-top: 10px; font-size: 16px;">Dataset 3</div>
    </div>
    <div style="text-align: center;">
        $(plotRegression(XDatas[4], YDatas[4], height=200, width=300))
        <div style="margin-top: 10px; font-size: 16px;">Dataset 4</div>
    </div>
</div>
""")

# ╔═╡ 082d1927-f6e0-4c45-91cb-6d0465dcdd6a
begin
	local DatasaurusSVGS = (i -> plotRegression(XDatas_Datasaurus[i], YDatas_Datasaurus[i]; height=150, width = 170, radius = 2.5, opacity = 0.5)).(1:length(DatasaurusTitles))
	
	@htl("""
	<div style="display: grid; grid-template-columns: repeat(4, 1fr); grid-row-gap: 20px; justify-items: center;">
	    $(
		    ((i -> @htl("""<div style="text-align: center;">
		        $(DatasaurusSVGS[i])
		        <div style="margin-top: 10px; font-size: 16px;">$(DatasaurusTitles[i])</div>
		    </div>""")).(1:length(DatasaurusTitles)))...
		)
	</div>
	""")
end

# ╔═╡ 58066811-3964-472f-893f-dd47c99f7b51
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

# ╔═╡ 552c3893-51bf-4a72-a8bb-b40a43f89395
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

# ╔═╡ 7f89e8a6-6a0a-4fa4-9ddb-1e76ddb9e877
render_infobox(InfoBox(title_text="Covariance with Oneself", body_text="Given a random variable ``X``, we have that ``\\text{Cov}(X,X) = \\sigma_X^2 = \\text{Var}(X)``. Similarly, ``\\rho(X,X) = 1``."))

# ╔═╡ a22e2e74-a37b-4e9f-b8f2-3f7aa66c91c5
render_infobox(InfoBox(title_text="Independence implies No Correlation", body_text="If ``X`` and ``Y`` are **independent**, meaning ``f(x,y) = f_X(x) \\cdot f_Y(y)``, then they are also **uncorrelated**, meaning ``\\rho(X,Y)=0``."))

# ╔═╡ b6b288d3-7970-4411-9a41-072e2964e862
render_infobox(InfoBox(title_text="No Correlation does not imply Independence", body_text="If ``X`` is a **uniformly distributed** random variable in the range ``[-1,1]`` and ``Y = X^2`` (meaning that measurements ``x`` give measurements ``y=x^2``), then ``\\rho(X,Y) = 0``, but the probability functions do **not** multiply as if they were independent."))

# ╔═╡ a81c9aa8-1ac6-4c59-8b69-6587042b4b92
render_infobox(InfoBox(html_body=@htl("""
<h5>Below is the regression plot of <b>Weight</b> versus <b>Height</b>.</h5>
<ul>
	<li> <h6>What do you notice about the relationship between measured heights and weights?</h6>
	<li> <h6>Try replacing Heights and Weights with ReportedHeights and ReportedWeights. What do you notice?</h6>
	<li> <h6>Does it seem like any data points are bad? Try looking at row $(lmd("``\\#12``")) in the table of HeightsAndWeights. What do you think happened to this data point?</h6>
</ul>""")))

# ╔═╡ 31f0d0a1-d1bd-4677-a265-83691c716804
render_infobox(InfoBox(html_body=@htl("""
<h5>Below is the regression plot of <b>Weight</b> versus <b>Height</b> with this bad datapoint removed.</h5>
<ul>
	<li> <h6>What do you notice about the relationship between measured heights and weights now?</h6>
	<li> <h6>Try replacing Heights2 and Weights2 with ReportedHeights2 and ReportedWeights2. What do you notice?</h6>
	<li> <h6>Try plotting Heights2 and ReportedHeights2 or Weights2 and ReportedWeights2. What do you notice?</h6>
	<li> <h6>The idea behind the regression line is that we should be able to use it for predictive purposes. Using the predictive function below, what do you notice? Are there any limitations? When do you think that this prediction tool might break down? For instance, if the measured weight is very small, what does this predict for the height?</h6>
</ul>""")))

# ╔═╡ 81c8863a-2597-4d6d-9f8a-ab1786114b75
render_infobox(InfoBox(html_body=@htl("""
<h5>Below are four datasets of $(lmd("``x``")) and $(lmd("``y``")) measurements, as well as the statistical measures of the measured data and the correlation coefficient of each dataset and the slope and intercept of the linear regression lines.</h5>""")))

# ╔═╡ d6e3b466-29b5-4d88-8206-2dbf6b377413
render_infobox(InfoBox(html_body=@htl("""
<h5>Notice that all of these values look basically the same! If we are going just off of these numbers, we might expect the data to all be basically the same. If we plot these out, however, we see the following.</h5>""")))

# ╔═╡ a87c7c45-06d4-437a-a143-b6c38e6ff26d
render_infobox(InfoBox(html_body=@htl("""
<h5>The point is that these descriptive statistical measures can tell you a lot about your data, but they alone do not guarantee what your data really looks like or how it behaves.</h5>""")))

# ╔═╡ 27de4f93-4a55-450b-a04d-b546b57bf391
render_infobox(InfoBox(html_body=@htl("""
<h5>As a bit of a sillier example, here is another collection of thirteen datasets with pretty similar statistical measures.</h5>""")))

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CSV = "336ed68f-0bac-5ca0-87d4-7b16caf5d00b"
HTTP = "cd3eb016-35fb-5094-929b-558a96fad6f3"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
RDatasets = "ce6b1742-4840-55fa-b093-852dadbb1d8b"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
CSV = "~0.10.14"
HTTP = "~1.10.8"
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
project_hash = "e2565e775d9326a1ec3b4cdf7d88494639ef4ae9"

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

[[deps.BitFlags]]
git-tree-sha1 = "0691e34b3bb8be9307330f88d1a3c3f25466c24d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.9"

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

[[deps.StringManipulation]]
deps = ["PrecompileTools"]
git-tree-sha1 = "a04cabe79c5f01f4d723cc6704070ada0b9d46d5"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.4"

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
# ╟─aee22efb-f3cf-4e28-849b-510e16a41490
# ╟─ca4cf769-7e6c-4af8-8c36-99709bbd6a75
# ╟─14c31f09-e1f1-45d5-9b90-cdfe75cfd0d1
# ╟─0b9c0c14-408b-47c4-b522-2fd2237cbc5a
# ╠═8b6125a3-17b7-4306-95ef-19133c195b97
# ╟─f22fc5fa-55cb-4d54-82c8-72dcc5a8d2b3
# ╟─652d075d-d9aa-4b8d-a299-91aca6c03198
# ╟─7f89e8a6-6a0a-4fa4-9ddb-1e76ddb9e877
# ╟─00acc74d-6448-4ccf-9a75-1d2892993885
# ╟─a22e2e74-a37b-4e9f-b8f2-3f7aa66c91c5
# ╟─20b77f45-36a4-493d-b390-f187a6c132bd
# ╟─b6b288d3-7970-4411-9a41-072e2964e862
# ╟─43d3f8b0-8707-4a5e-82bf-a1ff7a20b620
# ╟─1e424980-4ecf-48e6-9842-f00ad8df0950
# ╟─200b0d5b-a2e8-48a6-b3a6-d9182c9c2f20
# ╠═9eff6d3a-35f7-442a-83b7-0712b38017f8
# ╠═942e32cf-3103-4c31-9686-df3845d77cdf
# ╠═ef38e8a5-e088-4671-9b3b-f45d4a8c9321
# ╠═9553ead0-3f1b-4f3a-a8e4-7423c5992967
# ╠═e5b5c7b9-d3ae-46ed-b618-9d6a1219fc89
# ╟─a81c9aa8-1ac6-4c59-8b69-6587042b4b92
# ╟─f9f7acb8-f33d-4eb7-afdf-7f308bab17b2
# ╟─592ed063-3dde-4954-ac8b-3700f27597ff
# ╠═6742edc1-e682-4f37-aef6-240d98732dc3
# ╠═4d04bc7a-d536-46bd-876f-0bd47eaeed88
# ╠═8a2cac7e-545e-4174-aa53-fb6aca962b79
# ╠═7a147e53-8149-4292-9f5a-f1eb1d8204d9
# ╟─31f0d0a1-d1bd-4677-a265-83691c716804
# ╠═d3595822-ec68-4217-95b9-321e9c61a6e8
# ╠═fbcc4bdf-5212-4891-a802-579f4345f8e4
# ╠═eabcb500-d00f-448f-9fb0-1f7337a66056
# ╟─a1518615-ed9b-4a6b-88a5-7d653fdfcd5a
# ╟─91d33d8b-b27f-407d-b471-3dbdbd22716d
# ╟─81c8863a-2597-4d6d-9f8a-ab1786114b75
# ╟─d9ae605e-eaa0-438b-89aa-fec62fd03624
# ╟─3c901fd0-26e9-4c95-96dc-1bcb6588e60f
# ╟─5474aae7-f2a1-4a91-b27c-afb465d9edd1
# ╟─ebb993cd-e4c5-40a9-a680-f135c4f2ee44
# ╟─90c4b8ea-553e-4eda-a518-bfe999cc7aef
# ╟─61391abb-2101-4971-87d3-2f448d1e8b1d
# ╟─dcda2cfc-9a77-4bc5-8590-dc5faaf489ce
# ╟─37b3d994-359c-4f12-a9f4-93b3ec96f418
# ╟─07740c24-40d5-47fe-b5fb-9608f14b8872
# ╟─8c2fd46a-8dc4-4afc-9078-1072640de7b9
# ╟─d6e3b466-29b5-4d88-8206-2dbf6b377413
# ╟─f213c0df-73ae-4366-9578-811ee507251d
# ╟─a87c7c45-06d4-437a-a143-b6c38e6ff26d
# ╟─20d27f30-dec1-4fa9-a080-2d02669e3d2f
# ╟─709c2c51-758e-4229-80b0-f3439c9fa5ec
# ╟─27de4f93-4a55-450b-a04d-b546b57bf391
# ╟─6f621c33-2c08-412f-9e6e-f5788e98aa71
# ╠═29f03657-65f3-4760-8345-fa53c0a06ab4
# ╟─d160270b-14eb-452f-80f0-3bd13921a2dc
# ╟─a4908cf7-af04-422d-afae-9162c278e6c3
# ╟─07a37960-e5f2-4f03-bd41-831ce522fdc8
# ╟─4d6b5a60-601c-4b42-8b31-8c5399925fab
# ╟─6e3f07af-eda5-47a6-9335-815dbffe4ebc
# ╟─1350544c-8897-4f66-909b-170bc942763e
# ╟─98609de2-d22c-4d21-93f8-798d1ac3ad14
# ╟─55f5cb75-4a81-41c4-9366-f185dbdd78ae
# ╟─10f468ae-a12d-45bc-af45-4b0dc45973c9
# ╠═082d1927-f6e0-4c45-91cb-6d0465dcdd6a
# ╟─dc25027c-9014-4b28-8398-3814e748d417
# ╟─c445d10c-76cc-494a-8a27-02d29a736801
# ╟─552c3893-51bf-4a72-a8bb-b40a43f89395
# ╟─58066811-3964-472f-893f-dd47c99f7b51
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
