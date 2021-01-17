### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 85148a4a-4a37-11eb-3f0a-b78496a7e0f1
using Luxor, PlutoUI, Colors

# ╔═╡ b109bd0a-4a37-11eb-3410-db2cdd7bcffe
@bind x Slider(0:0.1:12)

# ╔═╡ c1f3fe14-4a37-11eb-287d-dd7ac32f1dc1
@bind y Slider(1:12)

# ╔═╡ c7fdc588-4a37-11eb-08f5-ed6fcbd73d02
@svg begin
	setopacity(0.6)
	
	for i in 0:0.1:1
		sethue(HSB(360i, 70, 70))
		squircle(O, 100, 100*i, :fill, rt= x*i)
		rotate(2π/y)
	end
end 500 300

# ╔═╡ 829d8078-4a39-11eb-1920-27fcc0cabe34
@bind R Slider(10:1:150)

# ╔═╡ 89fe203c-4a39-11eb-055c-ef44930511f4
@bind r Slider(10:.5:50)

# ╔═╡ bfbd16a6-4a39-11eb-3e3a-a38bd45922bc
@bind d Slider(10:0.5:80)

# ╔═╡ 3cf38ff6-4a38-11eb-3145-5fa937476e49
@png begin 
	origin()
	background("grey15")
	sethue("antiquewhite")
	setline(1)
	p = hypotrochoid(R, r, d, :stroke, stepby=0.01, vertices=true)
	for i in 0:3:15
    	poly(offsetpoly(p, i), :stroke, close=true)
	end
end

# ╔═╡ b2aad1ac-4a38-11eb-0b22-1dcc050a3b31

hypotrochoid(R, r, d, :stroke, stepby=0.01, vertices=true)


# ╔═╡ Cell order:
# ╠═85148a4a-4a37-11eb-3f0a-b78496a7e0f1
# ╠═b109bd0a-4a37-11eb-3410-db2cdd7bcffe
# ╠═c1f3fe14-4a37-11eb-287d-dd7ac32f1dc1
# ╠═c7fdc588-4a37-11eb-08f5-ed6fcbd73d02
# ╠═829d8078-4a39-11eb-1920-27fcc0cabe34
# ╠═89fe203c-4a39-11eb-055c-ef44930511f4
# ╠═bfbd16a6-4a39-11eb-3e3a-a38bd45922bc
# ╠═3cf38ff6-4a38-11eb-3145-5fa937476e49
# ╠═b2aad1ac-4a38-11eb-0b22-1dcc050a3b31
