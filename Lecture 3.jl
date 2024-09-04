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

# ╔═╡ 5102fdb0-6a16-11ef-24df-d9e42c71786f
using PlutoUI,HypertextLiteral

# ╔═╡ 767702ab-dd89-4e62-aee4-0ae444e4aa83
@htl("<h1>Lecture 3</h1>")

# ╔═╡ a0495dda-98d6-4e81-bee9-6558ec58d073
@htl("""
<div style="display:flex">
	<div style="flex:1">
		<p>Portion of Screen for A: $(@bind lengthA RangeSlider(0.0:0.01:1.0, show_value=true))</p>
	</div>
	<div style="flex:1">
		<p>Portion of Screen for B: $(@bind lengthB RangeSlider(0.0:0.01:1.0, show_value=true))</p>
	</div>
</div>
""")

# ╔═╡ c8b3dfff-a9b6-4be1-9b1e-e27326a889c0
@htl("""
<div style="display:flex">
	<div style="flex:1">
		<h6>Drop Frequency = $(@bind n Slider(0:10, show_value=true, default=0))</h6>
	</div>
	<div style="flex:1">
		<h6>Drop View = $(@bind view Slider(["U", "A", "B"], show_value=true, default="U"))</h6>
	</div>
</div>
""")

# ╔═╡ d11cefb0-c1f3-461d-9911-1681dce5180e
@bind circCounts @htl("""
<div id="svgContainer" style="width: 100%; height: 50vh; background-color: lightgray;">
</div>

<script>
    const container = document.getElementById('svgContainer');
    container.innerHTML = '';

    const containerWidth = container.clientWidth;
    const containerHeight = container.clientHeight;

    const svg = document.createElementNS('http://www.w3.org/2000/svg', 'svg');
    svg.setAttribute('width', '100%');
    svg.setAttribute('height', '100%');
    svg.setAttribute('style', 'background-color: white;');
    container.appendChild(svg);

    var n = $(n);
    var view = $(view);
    var [circA, circB, circAB, circTotal] = [0, 0, 0, 0];

    const rect1 = createRectangle('red', 0.35, $(100 * lengthA[1]), $(100 * (1 - lengthA[end])), 10, containerHeight);
    const rect2 = createRectangle('blue', 0.35, $(100 * lengthB[1]), $(100 * (1 - lengthB[end])), 50, containerHeight);

    svg.appendChild(rect1.element);
    svg.appendChild(rect2.element);
    svg.appendChild(createLabel(rect1, 'A', 'red', 0.25));
    svg.appendChild(createLabel(rect2, 'B', 'blue', 0.25));

	if (view === "A") {
        applyOverlay(svg, rect1.x, rect1.width);
    } else if (view === "B") {
        applyOverlay(svg, rect2.x, rect2.width);
    }

    setInterval(() => {
        for (let i = 0; i < n; i++) {
            createFallingCircle();
        }
    }, 1000);

    function createRectangle(color, opacity, startPercent, endPercent, topPercent, containerHeight) {
        const rect = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
        const x = percentToPixels(startPercent, containerWidth);
        const width = containerWidth - percentToPixels(startPercent + endPercent, containerWidth);
        const y = percentToPixels(topPercent, containerHeight);
        const height = percentToPixels(5, containerHeight);

        rect.setAttribute('x', x);
        rect.setAttribute('y', y);
        rect.setAttribute('width', width);
        rect.setAttribute('height', height);
        rect.setAttribute('rx', 10);
        rect.setAttribute('ry', 10);
        rect.setAttribute('fill', color);
        rect.setAttribute('fill-opacity', opacity);

        return { element: rect, x: x, width: width, y: y, height: height };
    }

    function createLabel(rect, text, color, opacity) {
        const label = document.createElementNS('http://www.w3.org/2000/svg', 'text');
        label.setAttribute('x', rect.x + rect.width / 2);
        label.setAttribute('y', rect.y + rect.height + 20);
        label.setAttribute('text-anchor', 'middle');
        label.setAttribute('font-size', '16px');
        label.setAttribute('fill', color);
        label.setAttribute('fill-opacity', opacity);
        label.textContent = text;
        return label;
    }

    function percentToPixels(percent, total) {
        return (percent / 100) * total;
    }

	function applyOverlay(svg, rectX, rectWidth) {
        const leftOverlay = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
        leftOverlay.setAttribute('x', 0);
        leftOverlay.setAttribute('y', 0);
        leftOverlay.setAttribute('width', rectX);
        leftOverlay.setAttribute('height', containerHeight);
        leftOverlay.setAttribute('fill', 'black');
        leftOverlay.setAttribute('fill-opacity', '0.25');
        
        const rightOverlay = document.createElementNS('http://www.w3.org/2000/svg', 'rect');
        rightOverlay.setAttribute('x', rectX + rectWidth);
        rightOverlay.setAttribute('y', 0);
        rightOverlay.setAttribute('width', containerWidth - (rectX + rectWidth));
        rightOverlay.setAttribute('height', containerHeight);
        rightOverlay.setAttribute('fill', 'black');
        rightOverlay.setAttribute('fill-opacity', '0.25');
        
        svg.appendChild(leftOverlay);
        svg.appendChild(rightOverlay);
    }

    function updateCounts() {
        circCounts = [circA, circB, circAB, circTotal];
        container.value = circCounts;
        container.dispatchEvent(new CustomEvent("input"));
    }

    function createFallingCircle() {
        let randomX = getRandomX(view, rect1, rect2);
        const radius = 5;
        const acceleration = 0.05;
        let speed = 0;
        let currentY = radius;
        let isRed = false;
        let hasBouncedRed = false;
        let hasBouncedBlue = false;
        let bouncesLeft = 3;

        const circle = document.createElementNS('http://www.w3.org/2000/svg', 'circle');
        circle.setAttribute('cx', randomX);
        circle.setAttribute('cy', currentY);
        circle.setAttribute('r', radius);
        circle.setAttribute('fill', 'gray');
        circle.setAttribute('fill-opacity', '0.5');
        svg.appendChild(circle);

        function animateCircle() {
            speed += acceleration;
            currentY += speed;


            if (currentY > rect1.y && currentY < rect1.y + rect1.height && randomX > rect1.x && randomX < rect1.x + rect1.width && !hasBouncedRed) {
                speed = -Math.abs(speed) * 0.5;
                hasBouncedRed = true;
                if (!isRed) {
                    circle.setAttribute('fill', 'red');
                    circle.setAttribute('fill-opacity', '0.5');
                    isRed = true;
                }
            }

            if (currentY > rect1.y && currentY < rect1.y + rect1.height && hasBouncedRed) {
                speed *= 0.9;
            }

            if (currentY > rect2.y && currentY < rect2.y + rect2.height && randomX > rect2.x && randomX < rect2.x + rect2.width && !hasBouncedBlue) {
                speed = -Math.abs(speed) * 0.5;
                hasBouncedBlue = true;
                if (isRed) {
                    circle.setAttribute('fill', 'purple');
                    circle.setAttribute('fill-opacity', '0.5');
                } else {
                    circle.setAttribute('fill', 'blue');
                    circle.setAttribute('fill-opacity', '0.5');
                }
            }

			if (currentY > rect2.y && currentY < rect2.y + rect2.height && hasBouncedBlue) {
                speed *= 0.9;
            }

            circle.setAttribute('cy', currentY);

            // Bouncing at the bottom of the screen
            if (currentY > containerHeight - radius) {
                if (bouncesLeft > 0) {
                    speed = -Math.abs(speed) * 0.5;
                    bouncesLeft -= 1;
                } else {
                    speed += acceleration;
                }
            }

            if (currentY > containerHeight + radius) {
                removeCircle(circle);
            } else {
                requestAnimationFrame(animateCircle);
            }
        }

        requestAnimationFrame(animateCircle);
    }

    function getRandomX(view, rect1, rect2) {
        if (view === "U") {
            return Math.random() * containerWidth;
        } else if (view === "A") {
            return rect1.x + Math.random() * rect1.width;
        } else if (view === "B") {
            return rect2.x + Math.random() * rect2.width;
        }
    }

    function removeCircle(circle) {
        svg.removeChild(circle);
        circTotal += 1;
        const fill = circle.getAttribute('fill');
        if (fill === 'red') circA += 1;
        if (fill === 'blue') circB += 1;
        if (fill === 'purple') circAB += 1;
        updateCounts();
    }
</script>
""")

# ╔═╡ 75ccb89a-445b-4de9-9393-bd30b67c1153
begin
	macro LC(str)
		return @htl("<div class=\"LaTeXContainer\" style=\"display:inline;\">$(Markdown.parse(str))</div>")
	end
	
	function mdInlineLaTeX()
		return @htl("<script>
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
					</script>")
	end
	
	function lhtl(str)
		return eval(:(@htl("$(@htl($(str))) $(mdInlineLaTeX())")))
	end

	md"---"
end

# ╔═╡ 56efe119-6917-454d-b5f3-67cd928de0e7
begin
	ProbA = round(lengthA[end]-lengthA[begin],digits=2)
	ProbB = round(lengthB[end]-lengthB[begin],digits=2)
	ProbAB = round((min(lengthA[end],lengthB[end]) > max(lengthA[begin],lengthB[begin])) ? min(lengthA[end],lengthB[end]) - max(lengthA[begin],lengthB[begin]) : 0 ,digits=2)
	lhtl("""
	<style>
		.containerProb {
			display: flex;
			width: 100%;
			gap: 20px;
		}
	
		.column-40 {
			flex: 0 0 40%;
			display: flex;
			flex-direction: column;
			gap: 10px;
		}
	
		.column-40 > div {
			flex: 1;
			#background-color: lightgray;
			#border: 1px solid #ccc;
		}
	
		.column-60 {
			flex: 0 0 60%;
			display: flex;
			flex-direction: column;
			gap: 10px;
		}
	
		.column-60 > div {
			flex: 1;
			#background-color: lightblue;
			#border: 1px solid #ccc;
		}
	</style>
	
	<div>
		<!-- Adapted off of Victor Powell https://setosa.io/ev/conditional-probability/ -->
		<!-- Probabilities -->
		<div class="containerProb">
			<!-- Sliders -->
			<div class="column-40">
				<!-- Probability of A -->
				<div>
					<div>
						<p>$(@LC"``\\operatorname{Prob}(A) = ``") $(ProbA) $(@LC"``=``") $(round(Int64, 100 * ProbA))%</p>
					</div>
				</div>
	
				<!-- Probability of B -->
				<div>
					<div>
						<p>$(@LC"``\\operatorname{Prob}(B) = ``") $(ProbB) $(@LC"``=``") $(round(Int64, 100 * ProbB))%</p>
					</div>
				</div>
	
				<!-- Probability of A ∩ B -->
				<div>
					<div>
						<p>$(@LC"``\\operatorname{Prob}(A\\cap B) = ``") $(ProbAB) $(@LC"``=``") $(round(Int64, 100 * ProbAB))%</p>
					</div>
				</div>
			</div>
	
			<!-- Conditional Calculations -->
			<div class="column-60">
				<!-- Probability of B given A -->
				<div>
					<p>$(@LC"``\\operatorname{Prob}(B \\mid A) = ``") $(round((ProbA > 0) ? ProbAB / ProbA : 0,digits=2)) $(@LC"``=``") $(round(Int64, (ProbA > 0) ? 100 * ProbAB / ProbA : 0))%</p>
				</div>
				<div>
					<p style="display:inline">If a ball passed through <p style="display:inline; color:red">A</p>, there is a $(round(Int64, (ProbA > 0) ? 100 * ProbAB / ProbA : 0))% chance it passes through <p style="display:inline; color:rgb(128, 128, 255)">B</p></p>
				</div>

				<!-- Probability of A given B -->
				<div>
					<p>$(@LC"``\\operatorname{Prob}(A \\mid B) = ``") $(round((ProbB > 0) ? ProbAB / ProbB : 0, digits=2)) $(@LC"``=``") $(round(Int64, (ProbB > 0) ? 100 * ProbAB / ProbB : 0))%</p>
				</div>
				<div>
					<p style="display:inline">If a ball passed through <p style="display:inline; color:rgb(128, 128, 255)">B</p>, there is a $(round(Int64, (ProbA > 0) ? 100 * ProbAB / ProbA : 0))% chance it passed through <p style="display:inline; color:red">A</p></p>
				</div>
			</div>
		</div>
	
		<div>
		</div>
	
		<div>
		</div>
	</div>
	""")
end

# ╔═╡ 9fccbcdd-80af-4947-879e-c028a78ca6e9
@htl("""
	<style>
        .containerBar {
            display: flex;
            flex-direction: column;
            width: 100%;
            height: 400px;
            border: 1px solid #ccc;
        }
        
        .inner-div {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            border: 1px solid #ccc;
            padding: 10px;
            box-sizing: border-box;
        }
        
        .svg-container {
            width: 100%;
            height: 100%;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: rgba(255,255,255,0.1);
        }

        .svg-container svg {
            width: 100%;
            height: 25%;
        }

        .svg-container rect {
            stroke: black;
            stroke-width: 3;
            fill-opacity: 1;
        }
    </style>

    <div class="containerBar">
        <!-- Experimental Probability Bar -->
        <div class="inner-div">
            <p>Experimental Probability</p>
        </div>
        <div class="inner-div svg-container">
            <svg>
                <rect x="0" y="0" width="$(circCounts != nothing ? 100 * circCounts[1] / circCounts[end] : 0)%" height="100%" fill="rgb(255,200,200)"></rect>
                <rect x="$(circCounts != nothing ? 100 * circCounts[1] / circCounts[end] : 0)%" y="0" width="$(circCounts != nothing ? 100 * circCounts[3] / circCounts[end] : 0)%" height="100%" fill="rgb(255,200,255)"></rect>
                <rect x="$(circCounts != nothing ? 100 * (circCounts[1] + circCounts[3]) / circCounts[end] : 0)%" y="0" width="$(circCounts != nothing ? 100 * circCounts[2] / circCounts[end] : 0)%" height="100%" fill="rgb(200,200,255)"></rect>
                <rect x="$(circCounts != nothing ? 100 * (circCounts[1] + circCounts[3] + circCounts[2]) / circCounts[end] : 0)%" y="0" width="$(circCounts != nothing ? 100 - 100 * (circCounts[1] + circCounts[3] + circCounts[2]) / circCounts[end] : 100)%" height="100%" fill="grey" fill-opacity="0.5"></rect>
            </svg>
        </div>

        <!-- Theoretical Probability Bar -->
        <div class="inner-div">
            <p>Theoretical Probability</p>
        </div>
        <div class="inner-div svg-container">
            <svg>
                <rect x="0" y="0" width="$(100 * (ProbA - ProbAB))%" height="100%" fill="rgb(255,200,200)"></rect>
                <rect x="$(100 * (ProbA - ProbAB))%" y="0" width="$(100 * ProbAB)%" height="100%" fill="rgb(255,200,255)"></rect>
                <rect x="$(100 * (ProbA))%" y="0" width="$(100 * (ProbB - ProbAB))%" height="100%" fill="rgb(200,200,255)"></rect>
                <rect x="$(100 * (ProbA + ProbB - ProbAB))%" y="0" width="$(100 - 100 * (ProbA + ProbB - ProbAB))%" height="100%" fill="grey" fill-opacity="0.5"></rect>
            </svg>
        </div>
    </div>
""")

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
HypertextLiteral = "~0.9.5"
PlutoUI = "~0.7.60"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.5"
manifest_format = "2.0"
project_hash = "d6ab3bdc3888fd8a982d15cc116b0392788040e9"

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
# ╟─767702ab-dd89-4e62-aee4-0ae444e4aa83
# ╟─5102fdb0-6a16-11ef-24df-d9e42c71786f
# ╟─56efe119-6917-454d-b5f3-67cd928de0e7
# ╟─a0495dda-98d6-4e81-bee9-6558ec58d073
# ╟─d11cefb0-c1f3-461d-9911-1681dce5180e
# ╟─c8b3dfff-a9b6-4be1-9b1e-e27326a889c0
# ╟─9fccbcdd-80af-4947-879e-c028a78ca6e9
# ╟─75ccb89a-445b-4de9-9393-bd30b67c1153
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
