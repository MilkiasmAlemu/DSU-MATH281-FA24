### A Pluto.jl notebook ###
# v0.20.3

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    #! format: off
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
    #! format: on
end

# ╔═╡ c51ba1bf-0bf1-438f-9087-85c4b1c7c626
#Packages for Formatting
begin
	using UUIDs, HypertextLiteral, PlutoUI, PlutoTeachingTools, CommonMark
end

# ╔═╡ 4ee2d099-3d04-4e24-ad83-44040d44afb3
using Distributions, StatsBase, Random

# ╔═╡ b475bbb5-c688-4598-910f-e4baa884adb4
@htl("""
	<h1>Julia Day 10</h1>
""")

# ╔═╡ b3582819-ec31-49df-b8dd-57658f948158
TableOfContents(depth=4)

# ╔═╡ 2d90749c-604f-4d8d-9492-b1394e55a4ab
@htl("""
	<h5>These are the different packages being used for today.</h5>
""")

# ╔═╡ 8598f5c6-f923-4a07-b487-bf0dfbc0b44b
@htl("""
	<hr>
""")

# ╔═╡ 304c3f84-d44d-4bb3-945c-945d01eff5e2
@htl("""
	<hr>
""")

# ╔═╡ 150bae99-49da-4741-b11d-835511c77224
@htl("""
	<h3>Does Drinking Green Tea Improve Memory?</h3>
""")

# ╔═╡ e9c68913-44b7-4a98-9194-5c59a3ceb001
begin
	n = 1000
	local p_green = 0.4
	local p_no_green = 0.4
	n_green = floor(Int64, 0.5 * n * (rand() + 0.5))
	n_no_green = n - n_green
	local X_green = Bernoulli(p_green)
	local X_no_green = Bernoulli(p_no_green)
	sample_green = (x -> x ? "Improvement" : "No Improvement").(rand(X_green, n_green))
	sample_no_green = (x -> x ? "Improvement" : "No Improvement").(rand(X_no_green, n_no_green))
	α_slider = @bindname α Slider(0.01:0.01:1, show_value=true, default=0.05)
	n_slider = @bindname subset_number Slider(50:10:n, show_value=true, default=50)
end;

# ╔═╡ c2765073-efed-4e09-8163-8a1dc2872b07
countmap(sample_green)

# ╔═╡ 80873855-a22a-45d2-81c0-d8382f44c7dc
Y₁ = countmap(sample_green)["Improvement"]

# ╔═╡ e014168a-7df0-4ef0-a3a3-e7a15d4bfe65
n₁ = length(sample_green)

# ╔═╡ 8affa227-dd42-418d-8a0c-eeb4f79a7caa
p̂₁ = Y₁ / n₁

# ╔═╡ cf275f04-f6dd-486a-a862-4a2e21d4c61f
countmap(sample_no_green)

# ╔═╡ 3f5e6e4d-ebe2-4a0f-b151-9c7d0e8d5a5b
Y₂ = countmap(sample_no_green)["Improvement"]

# ╔═╡ 9149c7c9-2c32-438e-9731-b7dc199c1c64
n₂ = length(sample_no_green)

# ╔═╡ 5f8eead8-0557-4d0a-8053-32584bf99ffd
p̂₂ = Y₂ / n₂

# ╔═╡ 23ed5415-6dd3-4e3d-b15e-d62fa236f17e
p̂ = ( Y₁ + Y₂ ) / ( n₁ + n₂ )

# ╔═╡ fea46129-46ae-406f-8915-fdbe0450c507
Z = ( p̂₁ - p̂₂ ) / sqrt( p̂ * ( 1 - p̂ ) * ( 1 / n₁ + 1 / n₂ ) )

# ╔═╡ e1d0cc67-48fb-44f9-b65c-d386f211b63e
p_value = ccdf( Normal( 0, 1 ) , Z )

# ╔═╡ 71de79a3-7026-4dc1-9bf7-99d986c844bc
α_slider

# ╔═╡ 370e1ed8-6254-476b-bcc5-446d77bf66ce
@htl("""
	<hr>
	<h3>The Pinterest Switch</h3>
""")

# ╔═╡ db8d6ed3-ea8a-4be5-91a9-483b0034651b
@htl("""
	<h4 style="margin-left: 20px;"><i>What–If:</i> &nbsp;&nbsp;Fashion Week</h4>
""")

# ╔═╡ 2f63e13c-66d3-4648-8672-ead456d02298
@htl("""
	<h4 style="margin-left: 20px;"><i>What–If:</i> &nbsp;&nbsp;Peek–a–boo!</h4>
""")

# ╔═╡ b198f438-acce-4f62-af13-288b9202af2c
n_slider

# ╔═╡ da16cb1b-c6b8-4553-a5f4-fe0f0d217628
n_slider

# ╔═╡ 01312cc0-785d-4811-8af5-01cb19a1b945
begin
	random_order = shuffle(vcat([true for i in 1:n_green], [false for i in 1:n_no_green]))
	sub_green = countmap(random_order .&& [i ≤ subset_number for i in 1:1000])[true]
	sub_no_green = countmap(.!random_order .&& [i ≤ subset_number for i in 1:1000])[true]
	local res = 75
	local sort_green = vcat([sort(sample_green[((res * j + 1) : min(res * j + res, n_green))]) for j in 0:floor(Int, n_green / res)]...)
	local sort_no_green = vcat([sort(sample_no_green[((res * j + 1) : min(res * j + res, n_no_green))], rev=true) for j in 0:floor(Int, n_no_green / res)]...)
	subsample_green = first(sort_green, sub_green)
	subsample_no_green = first(sort_no_green, sub_no_green)
end;

# ╔═╡ 279305d9-8883-40e0-8637-f1e317292ff5
countmap(subsample_green)

# ╔═╡ 3a47a108-94f2-4700-be63-3aaf18537d56
subsample_Y₁ = try
	countmap(subsample_green)["Improvement"]
catch
	0
end

# ╔═╡ 63f7a3a4-493e-4b44-9ce0-9f3b8c591da6
subsample_n₁ = length(subsample_green)

# ╔═╡ 3bd61b69-3f31-4d94-9c97-4e305fc8d7d0
subsample_p̂₁ = subsample_Y₁ / subsample_n₁

# ╔═╡ e4fa9e1f-93f2-4544-99f0-669f00ac6a63
countmap(subsample_no_green)

# ╔═╡ 2de0579f-a2f1-438c-8026-9f8313f6c529
subsample_Y₂ = try
	countmap(subsample_no_green)["Improvement"]
catch
	0
end

# ╔═╡ df1ab268-d70a-4919-b3c6-294b318a3a96
subsample_n₂ = length(subsample_no_green)

# ╔═╡ 628e49e1-3747-4a0a-a0fb-2f229d638e13
subsample_p̂₂ = subsample_Y₂ / subsample_n₂

# ╔═╡ 0cd0c3f3-62e1-4943-acfd-81b643f6d19a
subsample_p̂ = ( subsample_Y₁ + subsample_Y₂ ) / ( subsample_n₁ + subsample_n₂ )

# ╔═╡ 1ab86564-70e7-4f7e-837d-c894c44584f7
subsample_Z = ( subsample_p̂₁ - subsample_p̂₂ ) / sqrt( subsample_p̂ * ( 1 - subsample_p̂ ) * ( 1 / subsample_n₁ + 1 / subsample_n₂ ) )

# ╔═╡ 2f6f6868-2dd9-480d-8c20-01fbdbea6208
subsample_p_value = ccdf( Normal( 0, 1 ) , subsample_Z )

# ╔═╡ 754309ae-9eb3-4b82-9a93-18eb5c53820e
@htl("""
	<h4 style="margin-left: 20px;"><i>What–If:</i> &nbsp;&nbsp;Pick–and–Choose</h4>
""")

# ╔═╡ b9d57d03-8c58-4327-8c3a-566bb84aa048
begin
	local p_short_green = 0.3;
	local p_short_no_green = 0.1;
	short_sample_green = (x -> x ? "Short–Term Improvement" : "No Short–Term Improvement").((sample_green .== "Improvement") .|| rand(Bernoulli(p_short_green), n_green))
	short_sample_no_green = (x -> x ? "Short–Term Improvement" : "No Short–Term Improvement").((sample_no_green .== "Improvement") .|| rand(Bernoulli(p_short_no_green), n_no_green))
end;

# ╔═╡ b423798d-db14-4cb8-9c3b-d0d315ad34ac
countmap(short_sample_green)

# ╔═╡ acd1fa5d-891f-481a-ab2c-68161de3bd14
short_sample_Y₁ = countmap(short_sample_green)["Short–Term Improvement"]

# ╔═╡ b3653d1c-0341-4bc7-abb2-49a840509697
short_sample_n₁ = length(short_sample_green)

# ╔═╡ 5e66285a-5d68-4c3d-804a-ba18fe2258e4
short_sample_p̂₁ = short_sample_Y₁ / short_sample_n₁

# ╔═╡ ecd0f063-160b-4b78-a2fd-44cbda171ffe
countmap(short_sample_no_green)

# ╔═╡ 15595691-3cc2-41ae-99ac-935c11e28a28
short_sample_Y₂ = countmap(short_sample_no_green)["Short–Term Improvement"]

# ╔═╡ 35c7f784-7123-4a26-b9c5-ea637a813537
short_sample_n₂ = length(short_sample_no_green)

# ╔═╡ 0dc76d5e-dcd2-4826-bfad-0b437dfc3ef2
short_sample_p̂₂ = short_sample_Y₂ / short_sample_n₂

# ╔═╡ bbeaa01d-f58a-4dc0-bbca-a8118a2c6799
short_sample_p̂ = ( short_sample_Y₁ + short_sample_Y₂ ) / ( short_sample_n₁ + short_sample_n₂ )

# ╔═╡ f4d86d50-4baf-4aff-9761-caf7625913fc
short_sample_Z = ( short_sample_p̂₁ - short_sample_p̂₂ ) / sqrt( short_sample_p̂ * ( 1 - short_sample_p̂ ) * ( 1 / short_sample_n₁ + 1 / short_sample_n₂ ) )

# ╔═╡ 03e1a992-4227-40c6-b4ef-34ccd05926d0
short_sample_p_value = ccdf( Normal( 0, 1 ) , short_sample_Z )

# ╔═╡ d8638ec1-14f3-4077-8352-c41b1223e5be
@htl("""
	<h4 style="margin-left: 20px;"><i>What–If:</i> &nbsp;&nbsp;No Taxation without Representation</h4>
""")

# ╔═╡ 77a6becd-5405-41cc-9272-5caa3f7e6d5b
begin
	local n_success = countmap(vcat(sample_green, sample_no_green))["Improvement"]
	local n_fail = n - n_success
	n_cat = rand(Binomial(n, 0.15))
	n_no_cat = n - n_cat
	local n_cat_success = rand(Binomial(n_cat, 0.75))
	local n_cat_fail = n_cat - n_cat_success
	local n_no_cat_success = n_success - n_cat_success
	local n_no_cat_fail = n_no_cat - n_no_cat_success
	sample_cat = vcat(["Improvement" for i in 1:n_cat_success], ["No Improvement" for i in 1:n_cat_fail])
	sample_no_cat = vcat(["Improvement" for i in 1:n_no_cat_success], ["No Improvement" for i in 1:n_no_cat_fail])
	shuffle!(sample_cat)
	shuffle!(sample_no_cat)
end;

# ╔═╡ b1ae120a-58e9-4753-9b19-3ce0ac8cbb26
countmap(sample_cat)

# ╔═╡ 7e8e63bb-b4f2-4c30-a0ea-ce4e54ff00ef
countmap(sample_no_cat)

# ╔═╡ 5e727aac-5b53-4cfa-80b5-5d5253f32fe1
cat_Y₁ = countmap(sample_cat)["Improvement"]

# ╔═╡ cdcf2edd-3836-495c-badd-455e858792f0
cat_n₁ = length(sample_cat)

# ╔═╡ b3d96511-0119-4672-998d-9bf2b90fba26
cat_p̂₁ = cat_Y₁ / cat_n₁

# ╔═╡ 5dbd1f6f-be34-41e3-b658-61bb6115ea57
countmap(sample_no_cat)

# ╔═╡ 4b69ffcc-91c5-41eb-acd1-8a7ab4a805ee
cat_Y₂ = countmap(sample_no_cat)["Improvement"]

# ╔═╡ 48bf55df-8b47-450d-9468-06eaaaa344e6
cat_n₂ = length(sample_no_cat)

# ╔═╡ 81c4d2d0-1216-43d8-b191-2a14c7b37ab0
cat_p̂₂ = cat_Y₂ / cat_n₂

# ╔═╡ 1275e375-f939-4b15-a5a8-b5a93fe4a0d5
cat_p̂ = ( cat_Y₁ + cat_Y₂ ) / ( cat_n₁ + cat_n₂ )

# ╔═╡ dd13ccc8-9617-4f3a-a823-2830d3d6fcb3
cat_Z = ( cat_p̂₁ - cat_p̂₂ ) / sqrt( cat_p̂ * ( 1 - cat_p̂ ) * ( 1 / cat_n₁ + 1 / cat_n₂ ) )

# ╔═╡ b9fb3f4b-1d62-476e-9027-6096166b3068
cat_p_value = ccdf( Normal( 0, 1 ) , cat_Z )

# ╔═╡ 80a77f94-f608-4d24-8447-a67aaadb041d
@htl("""
	<hr>
""")

# ╔═╡ 486b4044-1270-449e-a2a3-fa5300256f14
@htl("""
	<div style="text-align:center;">
		$(Resource("https://imgs.xkcd.com/comics/significant.png", :width=>300))
	</div>
""")

# ╔═╡ 664baec0-fa64-4797-a8a8-9c011bc8e8a9
@htl("""
	<hr>
""")

# ╔═╡ 31902105-c511-455c-8038-748e91b0a45f
#Some Helper Functions for LaTeX
begin
	commonmark_parser = CommonMark.Parser()
	enable!(commonmark_parser, MathRule())
	macro LC(str, latex_UUID)
		return @htl("""
					<div id=$(latex_UUID) class="LaTeXContainer" style="display:inline;">$(commonmark_parser(str))</div>
					""")
	end
	
	function mdInlineLaTeX()
		return @htl("""
					<script>
						const container = document.querySelector('.LaTeXContainer');
						
						const style = document.createElement('style');
						style.textContent = `
							.LaTeXContainer p {
								display: inline;
								margin: auto;
							}
							.LaTeXContainer ul {
								margin: auto;
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
							.LaTeXContainer p {
								display: inline;
								margin: auto;
							}
							.LaTeXContainer ul {
								margin: auto;
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

# ╔═╡ e7ea8d6f-ce6b-42c6-bb7d-2c042c01cdb9
@htl("""
	<h2>Hypothesis Tests and $(lmd("``p``–values"))</h2>
""")

# ╔═╡ 9a12c078-b063-4d6e-830c-03720b33fff6
@htl("""
	<h2>$(lmd("Data–Dredging and ``p``–hacking"))</h2>
""")

# ╔═╡ 9de077c9-5a4b-4448-b588-84b33a28e9d5
@htl("""
	<hr>
	<h3>The Pinterest and the $(lmd("``p``"))–value</h3>
""")

# ╔═╡ f0c3c9b2-46ab-42ed-be85-b44a2a363dc4
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
	        title_html = @htl("<$("h"*string(title_size)) style='color: white; margin-left: 10px; margin-top: 10px;'>$(lmd(box.title_text))</$("h"*string(title_size))>")
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

	function note_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(title_text=title_text, body_text=body_text, title_size=title_size))
	end
	
	function go_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, title_text=title_text, body_text=body_text, title_size=title_size))
	end

	function caution_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=55.5, outer_box_saturation=64, outer_box_lightness=62.9, inner_box_hue=54.2, inner_box_saturation=47.7, inner_box_lightness=25.5, title_text=title_text, body_text=body_text, title_size=title_size))
	end

	function stop_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=7.3, outer_box_saturation=100, outer_box_lightness=69.2, inner_box_hue=7.9, inner_box_saturation=43.9, inner_box_lightness=27.3, title_text=title_text, body_text=body_text, title_size=title_size))
	end

	function black_box(title_text::String, body_text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=30.0, outer_box_saturation=10.0, outer_box_lightness=15.0, inner_box_hue=30.0, inner_box_saturation=5.0, inner_box_lightness=5.0, title_text=title_text, body_text=body_text, title_size=title_size))
	end

	function note_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(body_text=text, title_size=title_size))
	end
	
	function go_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=127, outer_box_saturation=32, outer_box_lightness=63, inner_box_hue=113.8, inner_box_saturation=47.5, inner_box_lightness=24, body_text=text, title_size=title_size))
	end

	function caution_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=55.5, outer_box_saturation=64, outer_box_lightness=62.9, inner_box_hue=54.2, inner_box_saturation=47.7, inner_box_lightness=25.5, body_text=text, title_size=title_size))
	end

	function stop_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=7.3, outer_box_saturation=100, outer_box_lightness=69.2, inner_box_hue=7.9, inner_box_saturation=43.9, inner_box_lightness=27.3, body_text=text, title_size=title_size))
	end

	function black_box(text::String; title_size::Int=2)
		return render_infobox(InfoBox(outer_box_hue=30.0, outer_box_saturation=10.0, outer_box_lightness=25.0, inner_box_hue=30.0, inner_box_saturation=5.0, inner_box_lightness=15.0, body_text=text, title_size=title_size))
	end
end;

# ╔═╡ fb9acc09-d4ca-46f7-a49a-4ff5171cef0f
black_box("""A <u>**Hypothesis Test**</u> is a systematic decision making process for judging whether to go with an initial Null Hypothesis ``H_0`` or a secondary Alternative Hypothesis ``H_1`` in order to decide between values for a statistical measure(s) based off of collected data.  
&nbsp;  
The likelihood of a **Type I Error** (<span style="color: red;">Reject</span>ing the Null Hypothesis, when we should <span style="color: green;">Not Reject</span>) is artificially set to be some predetermined value ``\\alpha`` by choosing to <span style="color: red;">Reject</span> when our (standardized) test statistic is past some threshold which depends on ``\\alpha``, ``\\left(z_{\\alpha} &lt; Z \\text{ for example}\\right)``. Here ``z_\\alpha`` is chosen to make this **Type I Error** probability equal to ``\\alpha``.  
&nbsp;  
If we have a Hypothesis Test for the statistical measure standardized to a ``Z``–score for which we have the observed (standardized) test statistic ``Z_0``, we can define the corresponding <u>**``\\underline{p}``–value**</u> to be the probability ``p = \\operatorname{Prob}\\left(Z &gt; Z_0 | H_0 \\text{ is True} \\right)``. We can then choose to <span style="color: red;">Reject</span> when ``p &lt; \\alpha``.""")

# ╔═╡ 6db61745-784f-4782-8b39-46f10b31b4db
go_box("""Choosing to <span style="color: red;">Reject</span> if the ``Z``–score is past the value ``z_\\alpha`` gives one method for making a decision between hypotheses. Choosing to <span style="color: red;">Reject</span> if the ``p``–value is less than ``\\alpha`` gives another method.  
&nbsp;  
Explain why these two different methods are actually the same method worded in different ways.""")

# ╔═╡ 656982fa-c9e3-4efc-b140-c56010cf1b57
note_box("You are a sales consultant working for Pinterest. A sales manager is convinced that their memory has gotten better after starting to drink green tea regularly. They task you with proving this for them.")

# ╔═╡ f3c2ca98-4fe9-4cc9-b852-7eda66765f06
go_box("Form a Null and Alternative Hypothesis for this setup. These do not need to be symbolic, you can write them in words. How could you go about collecting data for deciding whether to reject or not? Make sure to consider control and test groups.")

# ╔═╡ 545dbafa-e247-4f9e-bf85-d0fb695a2fe4
note_box("For testing your hypotheses, you have ``1000`` people first take a comprehensive cognitive test, wait a month, and then take another test. You record whether people regularly drink green tea or not and then see whether their cognitive value improved between tests.")

# ╔═╡ ceffe527-3a9e-4957-a82e-fdd43f6cd76f
go_box("What does this ``p``–value suggest about the effect of green tea on memory? What is the likelihood of seeing this ``Z``–score if the Null Hypothesis is true?")

# ╔═╡ 211672cf-c795-458e-b116-36974000f647
go_box("Given the ``\\alpha`` value of ``0.05``, what conclusion might you take? What are the implications of choosing this value for ``\\alpha``? Why might researchers choose this value?")

# ╔═╡ 794879a1-48d3-404f-bc6f-0576dd2827da
note_box("Oh no <span style=\"font-size:125%\">😨</span>! In running this experiment a few times, you found no statistically significant evidence showing green tea does anything impactful to memory. Your boss is insisting you look more to see if you can show something impactful.  
&nbsp;  
They suggest the following variations in your study:  
* Try having three different versions of the cognitive test   
* Try only looking at specific age groups  
* Try taking the test at different times of the day")

# ╔═╡ 9bd86d6c-b21a-417d-9ce9-852c11fc65ae
go_box("Multiple Models", "What might go wrong if we start to include more and more different testing conditions without adjusting our Null and Alternative Hypotheses? How might a researcher avoid this in general?", title_size=5)

# ╔═╡ 9b30ec81-c8ae-4d88-81b5-0044543ffdc3
note_box("You convinced your boss that introducing new places for error to occur might not be the best idea if we want the sample to be fairly distributed.  
&nbsp;  
They ask what you notice if you only look at a subset of the people that you tested. What happens if you just look at the first ``50`` respondents? What about the first ``100``? ``200``?")

# ╔═╡ 59f1438e-4881-45ef-af58-47c80ae70e13
go_box("Data–Dredging/``p``–hacking/Peeking", "What do you notice happens to the ``p``–value for this subset as you change the number of participants at which you are looking? If you really wanted to please your boss, what might you suggest doing (if your morals were a bit flexible)? How might you suggest researchers avoid this in the real world?", title_size=5)

# ╔═╡ 931f8559-35f2-4863-b0b2-75ed98180ec5
note_box("Okay, your boss says that maybe the data doesn't show what they know is true, but, if you look at just the *short–term* memory component of the cognitive exam, there was an increase in performance among green tea drinkers!")

# ╔═╡ 5af3ee01-bb5f-4748-a421-0265c7122b3a
go_box("Selective Reporting", "Should you go and report to the sales team that green tea is good for short–term memory? What are potential problems with doing this in general? How should researchers avoid this in general?", title_size=5)

# ╔═╡ e222d3f9-489c-4118-9581-f67bfc3160ac
note_box("Maybe it is not the best idea to choose specific parts of your test on which to focus. You boss accepts that is is probably best to leave the test alone. So maybe green tea is not all that it was cracked up to be.  
<span style=\"font-size:125%\">🍵 = 😢</span>  
&nbsp;  
There needs to be a story here! In order to find a story, your boss decides to look more deeply at the people from the cognitive testing to see what the connection is. After looking at the data, they notice that there are quite a few people who performed better cognitively that also own cats over the age of five!  
<span style=\"font-size:125%\">🐱 = 😄</span>  
&nbsp;  
So now you are tasked with studying this connection!")

# ╔═╡ f73b94b0-1f42-44a1-9f5b-1c7f13b1e167
go_box("Non–Representative Data", "Wowza! This seems convincing! Should we accept this as true? What might go wrong with rejecting this hypothesis? What might happen if you were to run a sample of ``1000`` new people with this same cognitive testing setup to check this test? How can researchers deal with this in general?", title_size=5)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
CommonMark = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
Distributions = "31c24e10-a181-5473-b8eb-7969acd0382f"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
PlutoTeachingTools = "661c6b06-c737-4d37-b85c-46df65de6f69"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
Random = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
StatsBase = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
UUIDs = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[compat]
CommonMark = "~0.8.15"
Distributions = "~0.25.113"
HypertextLiteral = "~0.9.5"
PlutoTeachingTools = "~0.3.1"
PlutoUI = "~0.7.60"
StatsBase = "~0.34.3"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "a78e1332a4535140cba9c999c9a12b942716e425"

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

[[deps.CommonMark]]
deps = ["Crayons", "PrecompileTools"]
git-tree-sha1 = "3faae67b8899797592335832fccf4b3c80bb04fa"
uuid = "a80b9123-70ca-4bc0-993e-6e3bcb318db6"
version = "0.8.15"

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
git-tree-sha1 = "3101c32aab536e7a27b1763c0797dba151b899ad"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.113"

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
git-tree-sha1 = "b1c2585431c382e3fe5805874bda6aea90a95de9"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.25"

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
git-tree-sha1 = "fc8504eca188aaae4345649ca6105806bc584b70"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.37"

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
git-tree-sha1 = "834aedb1369919a7b2026d7e04c2d49a311d26f4"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.6.3"

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
# ╟─c51ba1bf-0bf1-438f-9087-85c4b1c7c626
# ╟─b475bbb5-c688-4598-910f-e4baa884adb4
# ╟─b3582819-ec31-49df-b8dd-57658f948158
# ╟─2d90749c-604f-4d8d-9492-b1394e55a4ab
# ╠═4ee2d099-3d04-4e24-ad83-44040d44afb3
# ╟─8598f5c6-f923-4a07-b487-bf0dfbc0b44b
# ╟─e7ea8d6f-ce6b-42c6-bb7d-2c042c01cdb9
# ╟─fb9acc09-d4ca-46f7-a49a-4ff5171cef0f
# ╟─6db61745-784f-4782-8b39-46f10b31b4db
# ╟─304c3f84-d44d-4bb3-945c-945d01eff5e2
# ╟─9a12c078-b063-4d6e-830c-03720b33fff6
# ╟─150bae99-49da-4741-b11d-835511c77224
# ╟─656982fa-c9e3-4efc-b140-c56010cf1b57
# ╟─f3c2ca98-4fe9-4cc9-b852-7eda66765f06
# ╟─9de077c9-5a4b-4448-b588-84b33a28e9d5
# ╟─545dbafa-e247-4f9e-bf85-d0fb695a2fe4
# ╠═c2765073-efed-4e09-8163-8a1dc2872b07
# ╠═80873855-a22a-45d2-81c0-d8382f44c7dc
# ╠═e014168a-7df0-4ef0-a3a3-e7a15d4bfe65
# ╠═8affa227-dd42-418d-8a0c-eeb4f79a7caa
# ╠═cf275f04-f6dd-486a-a862-4a2e21d4c61f
# ╠═3f5e6e4d-ebe2-4a0f-b151-9c7d0e8d5a5b
# ╠═9149c7c9-2c32-438e-9731-b7dc199c1c64
# ╠═5f8eead8-0557-4d0a-8053-32584bf99ffd
# ╠═23ed5415-6dd3-4e3d-b15e-d62fa236f17e
# ╠═fea46129-46ae-406f-8915-fdbe0450c507
# ╠═e1d0cc67-48fb-44f9-b65c-d386f211b63e
# ╟─ceffe527-3a9e-4957-a82e-fdd43f6cd76f
# ╟─71de79a3-7026-4dc1-9bf7-99d986c844bc
# ╟─211672cf-c795-458e-b116-36974000f647
# ╟─e9c68913-44b7-4a98-9194-5c59a3ceb001
# ╟─370e1ed8-6254-476b-bcc5-446d77bf66ce
# ╟─db8d6ed3-ea8a-4be5-91a9-483b0034651b
# ╟─794879a1-48d3-404f-bc6f-0576dd2827da
# ╟─9bd86d6c-b21a-417d-9ce9-852c11fc65ae
# ╟─2f63e13c-66d3-4648-8672-ead456d02298
# ╟─9b30ec81-c8ae-4d88-81b5-0044543ffdc3
# ╟─b198f438-acce-4f62-af13-288b9202af2c
# ╠═279305d9-8883-40e0-8637-f1e317292ff5
# ╟─3a47a108-94f2-4700-be63-3aaf18537d56
# ╠═63f7a3a4-493e-4b44-9ce0-9f3b8c591da6
# ╠═3bd61b69-3f31-4d94-9c97-4e305fc8d7d0
# ╠═e4fa9e1f-93f2-4544-99f0-669f00ac6a63
# ╟─2de0579f-a2f1-438c-8026-9f8313f6c529
# ╠═df1ab268-d70a-4919-b3c6-294b318a3a96
# ╠═628e49e1-3747-4a0a-a0fb-2f229d638e13
# ╠═0cd0c3f3-62e1-4943-acfd-81b643f6d19a
# ╟─1ab86564-70e7-4f7e-837d-c894c44584f7
# ╠═2f6f6868-2dd9-480d-8c20-01fbdbea6208
# ╟─da16cb1b-c6b8-4553-a5f4-fe0f0d217628
# ╟─59f1438e-4881-45ef-af58-47c80ae70e13
# ╟─01312cc0-785d-4811-8af5-01cb19a1b945
# ╟─754309ae-9eb3-4b82-9a93-18eb5c53820e
# ╟─931f8559-35f2-4863-b0b2-75ed98180ec5
# ╠═b423798d-db14-4cb8-9c3b-d0d315ad34ac
# ╠═acd1fa5d-891f-481a-ab2c-68161de3bd14
# ╠═b3653d1c-0341-4bc7-abb2-49a840509697
# ╠═5e66285a-5d68-4c3d-804a-ba18fe2258e4
# ╠═ecd0f063-160b-4b78-a2fd-44cbda171ffe
# ╠═15595691-3cc2-41ae-99ac-935c11e28a28
# ╠═35c7f784-7123-4a26-b9c5-ea637a813537
# ╠═0dc76d5e-dcd2-4826-bfad-0b437dfc3ef2
# ╠═bbeaa01d-f58a-4dc0-bbca-a8118a2c6799
# ╠═f4d86d50-4baf-4aff-9761-caf7625913fc
# ╠═03e1a992-4227-40c6-b4ef-34ccd05926d0
# ╟─5af3ee01-bb5f-4748-a421-0265c7122b3a
# ╟─b9d57d03-8c58-4327-8c3a-566bb84aa048
# ╟─d8638ec1-14f3-4077-8352-c41b1223e5be
# ╟─e222d3f9-489c-4118-9581-f67bfc3160ac
# ╠═b1ae120a-58e9-4753-9b19-3ce0ac8cbb26
# ╠═7e8e63bb-b4f2-4c30-a0ea-ce4e54ff00ef
# ╠═5e727aac-5b53-4cfa-80b5-5d5253f32fe1
# ╠═cdcf2edd-3836-495c-badd-455e858792f0
# ╠═b3d96511-0119-4672-998d-9bf2b90fba26
# ╠═5dbd1f6f-be34-41e3-b658-61bb6115ea57
# ╠═4b69ffcc-91c5-41eb-acd1-8a7ab4a805ee
# ╠═48bf55df-8b47-450d-9468-06eaaaa344e6
# ╠═81c4d2d0-1216-43d8-b191-2a14c7b37ab0
# ╠═1275e375-f939-4b15-a5a8-b5a93fe4a0d5
# ╠═dd13ccc8-9617-4f3a-a823-2830d3d6fcb3
# ╠═b9fb3f4b-1d62-476e-9027-6096166b3068
# ╟─f73b94b0-1f42-44a1-9f5b-1c7f13b1e167
# ╟─77a6becd-5405-41cc-9272-5caa3f7e6d5b
# ╟─80a77f94-f608-4d24-8447-a67aaadb041d
# ╟─486b4044-1270-449e-a2a3-fa5300256f14
# ╟─664baec0-fa64-4797-a8a8-9c011bc8e8a9
# ╟─f0c3c9b2-46ab-42ed-be85-b44a2a363dc4
# ╟─31902105-c511-455c-8038-748e91b0a45f
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
