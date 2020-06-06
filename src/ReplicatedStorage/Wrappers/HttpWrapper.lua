local HttpService = game:GetService("HttpService")
local auth = "token c1c9c6ce-1200-44e1-9dd9-1b0b219d6245"
-------------------------------------------------------------------------------------------------------------------------------
local HttpWrapper = {}

function HttpWrapper:SetAsync(name, table_, method)
	if not method then
		method = "POST"
	end
	local url = "https://jsonbin.org/thenerdie/" .. name
	local dataFields = {
		["authorization"] = auth;
	}
	local body = HttpService:JSONEncode(table_)
	local params = {Url=url, Method=method, Headers=dataFields, Body=body}
	local response = {}
	local suc, err = pcall(function()
		response = HttpService:RequestAsync(params)
	end)
	if not suc then
		error(err)
	end
	return response
end

function HttpWrapper:GetAsync(name)
	local url = "https://jsonbin.org/thenerdie/" .. name
	local method = "GET"
	local response = {}
	local decodedJSON = ""
	local dataFields = {
		["authorization"] = auth;
	}
	local params = {Url=url, Method=method, Headers=dataFields}
	local suc, err = pcall(function()
		response = HttpService:RequestAsync(params)
	end)
	if not suc then
		error(err)
		return 400
	end
	decodedJSON = HttpService:JSONDecode(response.Body)
	return decodedJSON
end

return HttpWrapper