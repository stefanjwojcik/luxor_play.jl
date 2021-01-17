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

# ╔═╡ 7609dc76-5351-11eb-1459-9bcb6358dcfd
begin
	####### County Polygons 
	using JSON
	using Luxor
	using Pluto 
	using PlutoUI
	using Colors
end

# ╔═╡ 8fc4f184-5351-11eb-2f1c-b930acfcc343
counties = JSON.parsefile("/home/swojcik/Downloads/us-county-boundaries.json")

# ╔═╡ aac09ffe-5351-11eb-3829-5300ac0595ae
function specific_flatten(a::AbstractArray)
   while any(x->typeof(x[1])<:AbstractArray, a)
       a = collect(Iterators.flatten(a))
   end
   return a
end

# ╔═╡ bc7c3f8c-5351-11eb-36e9-13a6863dbd31
# how to unparse the counties 
parse_counties = function(jsonfile)
   out = []
   for county in jsonfile
      array_of_points = [Point(x,y) for (x,y) in specific_flatten(county["fields"]["geo_shape"]["coordinates"])]
      #reverse the x value to get the mirror image 
      array_of_points .= [x * (-1, 1) for x in array_of_points]
      name_of_county = county["fields"]["name"]
      push!(out, array_of_points)
   end
   return out
end

# ╔═╡ bc7c6610-5351-11eb-1ba8-8fe56c755275
mich = parse_counties(filter(x-> x["fields"]["state_name"]=="Michigan", counties));

# ╔═╡ bc7d028c-5351-11eb-188b-6977a50b557a
wisc = parse_counties(filter(x-> x["fields"]["state_name"]=="West Virginia", counties));

# ╔═╡ cfe726b8-5351-11eb-11f6-0d719e643885
@bind y Slider(-42:1:-34)

# ╔═╡ f6f82ce0-5351-11eb-1a95-f9b8c72fb20a
@bind x Slider(-85:.5:-75)

# ╔═╡ 7fc98f02-5353-11eb-16d5-33711eb21478
@bind mscale Slider(1:1:80)

# ╔═╡ d7731edc-5351-11eb-3702-477456491bf0
@png begin
   setopacity(.6)
   background("black")
   rotate(π)
   scale(mscale)
   sethue("antiquewhite")
   translate(x, y)
	for county in wisc
		randomhue()		#poly(county, :stroke, close=false)
		poly(county .- .99, :stroke, close=false)
		poly(county .- .90, :stroke, close=false)
		poly(county .- .80, :stroke, close=false)
	end
end

# ╔═╡ f0a5400a-5384-11eb-34f5-d10c3793e215
y

# ╔═╡ 7afea1be-5395-11eb-2352-a52214c6dc7a


# ╔═╡ bf53791a-5387-11eb-2fd6-eff7a8987d4b


# ╔═╡ d1ee0bb4-5353-11eb-1d3c-93ad22e974cf
@png begin
	maxmin = maximum([x[1][1] for x in wisc]), minimum([x[1][1] for x in wisc])
   setopacity(.6)
	local counter = 1
   background("black")
   rotate(π)
   scale(mscale)
   sethue("antiquewhite")
   translate(x, y)
	for county in wisc
		counter += 1
		myred = counter/55
		myblue = 1-(counter/55)
		scale(1.0001)
		sethue(myred, 0, myblue)		#poly(county, :stroke, close=false)
		poly(county .- .99, :stroke, close=false)
		#poly(county .* .96, :stroke, close=false)
		#poly(county .- .80, :stroke, close=false)
	end
end

# ╔═╡ 17d81ca8-5388-11eb-1145-fbb57775f150


# ╔═╡ 715e1ec0-5387-11eb-2fca-a51d3b52e21a


# ╔═╡ 576ff832-5387-11eb-2d70-95486fc1a2aa


# ╔═╡ Cell order:
# ╠═7609dc76-5351-11eb-1459-9bcb6358dcfd
# ╠═8fc4f184-5351-11eb-2f1c-b930acfcc343
# ╠═aac09ffe-5351-11eb-3829-5300ac0595ae
# ╠═bc7c3f8c-5351-11eb-36e9-13a6863dbd31
# ╠═bc7c6610-5351-11eb-1ba8-8fe56c755275
# ╠═bc7d028c-5351-11eb-188b-6977a50b557a
# ╠═cfe726b8-5351-11eb-11f6-0d719e643885
# ╠═f6f82ce0-5351-11eb-1a95-f9b8c72fb20a
# ╠═7fc98f02-5353-11eb-16d5-33711eb21478
# ╠═d7731edc-5351-11eb-3702-477456491bf0
# ╠═f0a5400a-5384-11eb-34f5-d10c3793e215
# ╠═7afea1be-5395-11eb-2352-a52214c6dc7a
# ╠═bf53791a-5387-11eb-2fd6-eff7a8987d4b
# ╠═d1ee0bb4-5353-11eb-1d3c-93ad22e974cf
# ╠═17d81ca8-5388-11eb-1145-fbb57775f150
# ╠═715e1ec0-5387-11eb-2fca-a51d3b52e21a
# ╠═576ff832-5387-11eb-2d70-95486fc1a2aa
