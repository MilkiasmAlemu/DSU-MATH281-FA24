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

# ╔═╡ fb5cc82a-60fb-4587-85f3-e7e4f70f4276
using PlutoUI,HypertextLiteral,Printf

# ╔═╡ b5d0500e-6e28-11ef-2199-2308296d79ee
@htl("<h1>Lecture 4</h1>")

# ╔═╡ a5796b24-521e-4e33-88a3-23e1aea2b532
begin
    function hexagon(x, y, size, index)
    return @htl("""
    <polygon points="$(join([@sprintf("%f,%f", x + size * sin(π/3 * i), y + size * cos(π/3 * i)) for i in 0:5], " "))"
             stroke="gray" fill="white" stroke-width="1"
             id="hex-$index"
             onmouseover="if (!this.classList.contains('clicked') && !this.classList.contains('saved')) {
                           this.setAttribute('fill', 'rgba(128, 128, 128, 0.2)');
                           this.style.transition = 'fill 0.25s';
                         }"
             onmouseout="if (!this.classList.contains('clicked') && !this.classList.contains('saved')) {
                          this.setAttribute('fill', 'white');
                          this.style.transition = 'fill 0.25s';
                        }"
             onclick="if (!this.classList.contains('saved')) {
                      this.classList.toggle('clicked');
                      this.setAttribute('fill', this.classList.contains('clicked') 
                                         ? 'rgba(128, 128, 128, 0.3)' 
                                         : 'rgba(128, 128, 128, 0.2)');
                      }"
             onmousedown="window.dragging = true;"
             onmousemove="if (window.dragging && !this.classList.contains('saved')) {
                          this.classList.add('clicked');
                          this.setAttribute('fill', 'rgba(128, 128, 128, 0.3)');
                          }"
             onmouseup="window.dragging = false;"
             style="cursor: pointer;" />
    """)
end

    function hex_grid(rows, cols, size, hex_values)
        hexagons = []
        dx = sqrt(3) * size
        dy = 1.5 * size
        for row in 0:rows-1
            for col in 0:cols-1
                x_offset = col * dx + (row % 2) * (dx / 2)
                y_offset = row * dy
                push!(hexagons, hexagon(x_offset, y_offset, size, length(hexagons) + 1))
            end
        end
        return hexagons
    end

    function update_hexagons!(hex_values, selected_hexagons, input_value)
        for hex in selected_hexagons
            hex_values[hex] = input_value
        end
        empty!(selected_hexagons)
    end

	md"---"
end

# ╔═╡ d86dfafa-76be-4c4d-89e3-067748f5bb3c
begin
    @htl("""
    <div style="display: flex; align-items: center;">
        <div style="margin-right: 20px;">
            <h4 style="display:inline">Assigned Value:&nbsp;&nbsp;</h4>
            <span id="assigned-value">$(@bind input_value confirm(@htl("""
                <input type="number" min="0" max="360" value="0">&nbsp;&nbsp;
            """), label="Choose Assigned Value\nfor Selected Hexagons"))</span>
        </div>
    </div>
    """)
end

# ╔═╡ b5f722e7-732d-425b-84bf-ef2951eba724
begin
    @bind selected_hexagons @htl("""
    <div id="selected-hexagons"></div>
    <script>
    var selected_hexagons = [];
    const container = document.getElementById('selected-hexagons');

    updateSelectedHexagons();

    function updateSelectedHexagons() {
        const svg = document.getElementById('hex-grid');
        const polygons = svg.querySelectorAll('polygon');
        selected_hexagons = [];

        polygons.forEach((polygon, index) => {
            if (polygon.classList.contains('clicked') && !polygon.classList.contains('saved')) {
                selected_hexagons.push(index + 1);
                polygon.classList.remove('clicked');
                polygon.classList.add('saved');
                polygon.style.transition = 'fill 0.1s';
                let color = `hsla(\${$(input_value)}, 75%, 50%, 0.5)`;
                polygon.setAttribute('fill', color);
            }
        });

        container.value = selected_hexagons;
        container.dispatchEvent(new CustomEvent("input"));
    }
    </script>
    """)
end

# ╔═╡ 5c97d0b1-8db0-4f4a-9d97-d257ed91a1c2
begin
    @htl("""
    <div style="display: flex; align-items: center;">
        <div style="margin-right: 20px;">
            <h4 style="display:inline">Number of Samples:&nbsp;&nbsp;</h4>
            <span id="assigned-value">$(@bind number_of_samples confirm(Slider(0:100, show_value=true, default=0), label="Start Sampling"))</span>
        </div>
    </div>
    """)
end

# ╔═╡ 0a025487-06bc-41f1-bc8c-8e4895198584
@bind reset_hex Button("Reset the Hexagons")

# ╔═╡ 9e67d11c-e0fe-42e6-a803-9aa1584f39b2
begin
	reset_hex
    hex_values = Dict{Int, Float64}()
	md"---"
end

# ╔═╡ e0005409-b6d5-41b4-a6f4-0458b8bee342
begin
	begin
	    if !(selected_hexagons === missing || selected_hexagons === nothing)
	        update_hexagons!(hex_values, selected_hexagons, input_value)
	    end
	end
md"### Sampling a Random Variable
---"
end

# ╔═╡ 1281d1b6-caf7-4c6c-afd4-5b481ef93427
begin
    reset_hex
    rows = 25
    cols = 25
    size = 8
	@htl("""
	    <div style="width: 100%; height: 100%;">
		    <svg id="hex-grid" width="$(sqrt(3) * cols * size)" height="$(1.5 * rows * size)" style="background-color:white">
		    	$(hex_grid(rows + 1, cols, size, hex_values)...)
		    </svg>
	    </div>
    """)
end

# ╔═╡ 9022e898-1b92-44d0-8a55-defcb6de59dd
begin
    function generate_sample_circles(number_of_samples, run_number)
        return @htl("""
		<div id="sample-container-$(run_number)"></div>
        $(
            [@htl("""
            <script>
            async function sampleHexagon() {
                const svg = document.getElementById('hex-grid');
                const polygons = svg.querySelectorAll('polygon');
                const sampleContainer = document.getElementById('sample-container-$(run_number)');

                // Initialize or retrieve the current counts dictionary
                let hexCounts = sampleContainer.value || {};

                // Sample a random hexagon
                const sampledIndex = Math.floor(Math.random() * polygons.length);
                const sampledPolygon = polygons[sampledIndex];

                // Get the bounding box for positioning the circle
                const bbox = sampledPolygon.getBBox();
                const cx = bbox.x + bbox.width / 2;
                const cy = bbox.y + bbox.height / 2;

                // Get the hex-value of the sampled polygon from hex_values (or default to 0)
                let hexValue = $(hex_values)[sampledIndex + 1] || 0;

                // Increment the hex-value count in the dictionary
                if (hexCounts[hexValue]) {
                    hexCounts[hexValue] += 1;
                } else {
                    hexCounts[hexValue] = 1;
                }

                // Update the sample container value with the new dictionary
                sampleContainer.value = hexCounts;
                sampleContainer.dispatchEvent(new CustomEvent("input"));

                // Create the circle element and animate it
                const circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
                circle.setAttribute('cx', cx);
                circle.setAttribute('cy', cy);
                circle.setAttribute('r', 0);
                circle.setAttribute('fill', 'white');
                circle.setAttribute('stroke', 'black');
                circle.setAttribute('stroke-width', 5);
                circle.style.opacity = 0.5;
                circle.style.transition = 'r 0.25s ease-in, opacity 0.25s ease-in-out';

                svg.appendChild(circle);

                await new Promise(resolve => {
                    setTimeout(() => {
                        circle.setAttribute('r', 5);  // Grow the circle
                        resolve();
                    }, $(i) * 500);  // Delay increases with each iteration
                });

                await new Promise(resolve => {
                    setTimeout(() => {
                        circle.style.opacity = 0;
                        circle.setAttribute('r', 0);  // Shrink the circle
                        resolve();
                    }, 500);
                });

                setTimeout(() => {
                    svg.removeChild(circle);  // Remove the circle from the DOM
                }, 750);
            }
            sampleHexagon();
            </script>
            """) for i in 1:number_of_samples]...)
        """)
    end
	md"---"
end

# ╔═╡ ccee3127-fca5-4ff1-acec-fec30603d3ea
@bind reset_count Button("Reset the Count")

# ╔═╡ ac26a771-1c03-4993-8ba5-82725ea2a128
begin
	reset_hex
	reset_count
    bar_values = Dict{Float64, Float64}()
	sample_count = Dict(:count=>0)
	md"---"
end

# ╔═╡ 1bbd6fd0-2bf5-493a-a5b8-c6348858b190
begin
	sample_count[:count] += 1
	@bind sample generate_sample_circles(number_of_samples,sample_count[:count])
end

# ╔═╡ b246b7a8-264c-420f-84ea-b1bc8f830b68
begin
	if !(sample === missing || sample === nothing)
		for (key, value) in sample
		    key_found = false
		    for k in keys(bar_values)
		        if isapprox(k, parse(Float64, key); atol=1e-4)
		            bar_values[k] += value
		            key_found = true
		            break
		        end
		    end
		
		    if !key_found
		        bar_values[parse(Float64, key)] = value
		    end
		end
		run_bar = 1
	end
	md"---"
end

# ╔═╡ ffd27845-eab5-4823-b754-3d08c676a13f
begin
	@isdefined(run_bar)
    total_sum = sum(values(bar_values))

    @htl("""
    <div style="width: 100%; height: 100%;">
    <div id="histogram" style="width: 100%; height: 100%;"></div>
    <script src="https://d3js.org/d3.v7.min.js"></script>
    
    <script>
        const histogramDiv = document.getElementById("histogram");

        const width = 200;
        const height = 150;

        const margin = { top: 20, right: 30, bottom: 40, left: 40 };

        const svg = d3.select("#histogram")
            .append("svg")
            .attr("width", width)
            .attr("height", height)
            .style("background-color", "white");

        const barValues = $(bar_values);

        const totalSum = $(total_sum);
        const data = Object.keys(barValues).map(function(key) {
            return {
                label: parseFloat(key).toFixed(1),
                value: (barValues[key] / totalSum) * height / 3,
                color: parseFloat(key).toFixed(0) == 0 ? 'hsla(0,0%,0%,0.1)' : `hsla(\${key}, 75%, 50%, 0.5)`
            };
        });

        const yScale = d3.scaleLinear()
            .domain([0, 100])
            .range([height - margin.bottom, margin.top]);

        const xScale = d3.scaleBand()
            .domain(data.map(d => d.label))
            .range([margin.left, width - margin.right])
            .padding(0.5);

        svg.selectAll(".bar")
            .data(data)
            .enter()
            .append("rect")
            .attr("class", "bar")
            .attr("x", d => xScale(d.label))
            .attr("y", d => yScale(d.value))
            .attr("width", xScale.bandwidth())
            .attr("height", d => height - margin.bottom - yScale(d.value))
            .attr("fill", d => d.color);

        const xAxis = d3.axisBottom(xScale);

        svg.append("g")
            .attr("transform", `translate(0,\${height - margin.bottom})`)
            .call(xAxis);
    </script>
    </div>
    """)
end

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Printf = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[compat]
HypertextLiteral = "~0.9.5"
PlutoUI = "~0.7.60"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "2a09a4777715541f8a27b9d8ff618271c7e661e3"

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

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

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

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"
version = "1.10.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.10.0"

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
# ╟─b5d0500e-6e28-11ef-2199-2308296d79ee
# ╟─fb5cc82a-60fb-4587-85f3-e7e4f70f4276
# ╟─e0005409-b6d5-41b4-a6f4-0458b8bee342
# ╟─1281d1b6-caf7-4c6c-afd4-5b481ef93427
# ╟─ac26a771-1c03-4993-8ba5-82725ea2a128
# ╟─d86dfafa-76be-4c4d-89e3-067748f5bb3c
# ╟─0a025487-06bc-41f1-bc8c-8e4895198584
# ╟─9e67d11c-e0fe-42e6-a803-9aa1584f39b2
# ╟─ffd27845-eab5-4823-b754-3d08c676a13f
# ╟─a5796b24-521e-4e33-88a3-23e1aea2b532
# ╟─5c97d0b1-8db0-4f4a-9d97-d257ed91a1c2
# ╟─ccee3127-fca5-4ff1-acec-fec30603d3ea
# ╟─b246b7a8-264c-420f-84ea-b1bc8f830b68
# ╟─b5f722e7-732d-425b-84bf-ef2951eba724
# ╟─9022e898-1b92-44d0-8a55-defcb6de59dd
# ╟─1bbd6fd0-2bf5-493a-a5b8-c6348858b190
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
