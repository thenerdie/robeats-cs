return function(func, ...)
	assert(type(func) == "function")

	local args = {...}
	local count = select("#", ...)

	local bindable = Instance.new("BindableEvent")
	bindable.Event:Connect(function()
		func(unpack(args, 1, count))
	end)

	bindable:Fire()
	bindable:Destroy()
end