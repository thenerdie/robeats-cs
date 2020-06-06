local api_key = script.Parent["API-KEY"].Value
local wspc_id = script.Parent["WORKSPACE-ID"].Value
local base_url = script.Parent["BASE-URL"].Value
-------------------------------------------------------------------------------------------------------------
local HTTP = game:GetService("HttpService")

-------------------------------------------------------------------------------------------------------------
local docs = {
	["GlobalLeaderboard"] = "cb2af5e0-bbb9-460a-94d9-767884247121";
	["PlayerPlays"] = "dde05a86-6b97-4439-b765-c163be9c3340";
}

function encodeChar(chr)
	return string.format("%%%X",string.byte(chr))
end
 
function encodeString(str)
	local output, t = string.gsub(str,"[^%w]",encodeChar)
	return output
end

function decodeChar(hex)
	return string.char(tonumber(hex,16))
end
 
function decodeString(str)
	local output, t = string.gsub(str,"%%(%x%x)",decodeChar)
	return output
end

local api = {}
--[[**
**--]]
function api:Get(name)
	local doc_id = docs[name]
	print(doc_id)
	local doc_url = base_url .. doc_id .. "/"
	local headers = {
		["Content-Type"] = "application/json";
		["Authorization"] = api_key
	}
	local params = {
		Method = "GET";
		Url = doc_url;
		Headers=headers
	}
	local returnValue = nil
	local resp = nil
	local success, errorMessage = pcall(function()
		resp = HTTP:RequestAsync(params)
	end)
	if not success then
		warn(errorMessage)
	else
		if resp.StatusCode == 404 then
			return nil, 404
		elseif resp.StatusCode == 429 then
			wait(2)
		elseif resp.StatusCode == 200 then
			print("Request successful.")
		end
	end
	local self = {}
	--TABLE MANIPULATION
	--[[**
**--]]
	function self:Fetch(name_, allUpper, filter)
		local table_url = nil
		if allUpper then
			table_url = doc_url .. "tables/" .. string.upper(name_) .. "/data"
		else
			table_url = doc_url .. "tables/" .. name_ .. "/data"
		end
		
		if filter then
			table_url = table_url .. "?filter=" .. encodeString(filter)
		end
		
		local headers_ = {}
		headers = {
			["Content-Type"] = "application/json";
			["Authorization"] = api_key;
		}
		local params_ = {}
		params_ = {
			Method = "GET";
			Url = table_url;
			Headers=headers;
		}
		local returnValue = nil
		local resp_ = nil
		local success, errorMessage = pcall(function()
			resp_ = HTTP:RequestAsync(params_)
		end)
		if not success then
			warn(errorMessage)
		else
			if resp_.StatusCode == 404 then
				warn("Table '" .. name_ .. "' not found.")
				return nil, 404
			elseif resp_.StatusCode == 429 then
				return nil, 429
			elseif resp_.StatusCode == 400 or resp_.StatusCode == 500 then
				warn("Bad request, or something went wrong with the database. " .. tostring(resp_.StatusCode) .. " " .. resp_.Body)
			elseif resp.StatusCode == 200 then
				return HTTP:JSONDecode(resp_.Body), 200
			end
		end
	end
	--[[**
**--]]
	function self:CreateTable(name_, columns, allUpper)
		local n_ = nil
		if allUpper then
			n_ = string.upper(name_)
		else
			n_ = name_
		end
		local table_url = doc_url .. "apply"
		local colms = "["
		for i, v in pairs(columns) do
			if i == #columns then
				colms = colms .. '{"id": "' .. v .. '"}'
			else
				colms = colms .. '{"id": "' .. v .. '"},'
			end
		end
		local headers_ = {
			["Content-Type"] = "application/json";
			["Authorization"] = api_key;
		}
		local params_ = {
			Method = "POST";
			Url = table_url;
			Headers=headers;
			Body='[["AddTable", "' .. n_ .. '", ' .. colms .. ']]]'
		}
		local resp_ = nil
		local success, errorMessage = pcall(function()
			resp_ = HTTP:RequestAsync(params_)
		end)
		if resp_.StatusCode == 400 then
			warn("Developers of Grist likely changed the method of adding tables to a document. Investigate, or send a support ticket, immediately.")
			return "400e"
		elseif resp_.StatusCode == 500 then
			warn("Unknown server error.")
			return "500e"
		elseif resp_.StatusCode == 429 then
			warn("Too many requests to the server.")
			return nil
		elseif resp_.StatusCode == 200 then
			print("All good!")	
		end
		if not success then
			warn(errorMessage)
		end
		wait(1) -- this is to ensure that any actions that follow our table creation do not (hopefully) error due to the possiblity that the table wasn't created quick enough for any consecutive requests to it
	end
--[[**
**--]]
	function self:AddRows(name, data, allUpper)
		local table_url = nil
		if allUpper then
			table_url = doc_url .. "tables/" .. string.upper(name) .. "/data/"
		else
			table_url = doc_url .. "tables/" .. name .. "/data/"
		end
		local headers_ = {
			["Content-Type"] = "application/json";
			["Authorization"] = api_key;
		}
		local params_ = {
			Method = "POST";
			Url = table_url;
			Headers=headers;
			Body=HTTP:JSONEncode(data)
		}
		local resp_ = nil
		local success, errorMessage = pcall(function()
			resp_ = HTTP:RequestAsync(params_)
		end)
		if resp_.StatusCode == 400 or resp_.StatusCode == 500 then
			warn("Bad request, or something went wrong with the database. " .. tostring(resp_.StatusCode) .. " " .. resp_.Body)
			error(debug.traceback())
			return nil
		elseif resp_.StatusCode == 429 then
			warn("Too many requests to the server.")
			return nil
		elseif resp_.StatusCode == 200 then
			print("All good!")	
		end
		if not success then
			warn(errorMessage)
		end
	end
	--[[**
**--]]
	function self:ModifyRows(name, data, allUpper)
		local table_url = nil
		if allUpper then
			table_url = doc_url .. "tables/" .. string.upper(name) .. "/data/"
		else
			table_url = doc_url .. "tables/" .. name .. "/data/"
		end
		local headers = {
			["Content-Type"] = "application/json";
			["Authorization"] = api_key;
		}
		local params_ = {
			Method="PATCH";
			Url=table_url;
			Headers=headers;
			Body=HTTP:JSONEncode(data)
		}
		local resp = nil
		local success, errorMessage = pcall(function()
			resp = HTTP:RequestAsync(params_)
		end)
		if resp.StatusCode == 400 then
			warn("Row nonexistent, add the row instead...")
			return nil
		elseif resp.StatusCode == 429 then
			warn("Too many requests to the server.")
			return nil
		elseif resp.StatusCode == 200 then
			print("All good!")	
		end
		if not success then
			warn(errorMessage)
		end
	end
	--[[**
**--]]
	function self:TableExists(name_, allUpper)
		local ret = true
		local table_url = nil
		if allUpper then
			table_url = doc_url .. "tables/" .. string.upper(name_) .. "/data/"
		else
			table_url = doc_url .. "tables/" .. name_ .. "/data/"
		end
		local headers_ = {}
		headers = {
			["Content-Type"] = "application/json";
			["Authorization"] = api_key;
		}
		local params_ = {}
		params_ = {
			Method = "GET";
			Url = table_url;
			Headers=headers;
		}
		local resp_ = nil
		local success, errorMessage = pcall(function()
			resp_ = HTTP:RequestAsync(params_)
		end)
		if resp_.StatusCode == 404 then
			ret = false
		elseif resp_.StatusCode == 400 then
			return nil, 400
		end
		return ret, resp_.StatusCode
	end
	--[[**
**--]]
	function self:RowExists(name_, column, item, allUpper, filter)
		local ret = false
		local table_url = nil
		if allUpper then
			table_url = doc_url .. "tables/" .. string.upper(name_) .. "/data"
		else
			table_url = doc_url .. "tables/" .. name_ .. "/data"
		end
		if filter then
			table_url = table_url .. "?filter=" .. encodeString(filter)
			print(table_url)
		end
		local headers_ = {}
		headers = {
			["Content-Type"] = "application/json";
			["Authorization"] = api_key;
		}
		local params_ = {}
		params_ = {
			Method = "GET";
			Url = table_url;
			Headers=headers;
		}
		local resp_ = nil
		local success, errorMessage = pcall(function()
			resp_ = HTTP:RequestAsync(params_)
		end)
		local dec = HTTP:JSONDecode(resp_.Body)
		local id_ = 0
		if resp_.StatusCode ~= 404 then
			if dec[column] then
				for i, obj in pairs(dec[column]) do
					id_ = i
					if tostring(item) == tostring(obj) then
						ret = true
						break
					end
				end
			end
		end
		return ret, resp_.StatusCode, dec.id[id_], id_, dec
	end
	
	--------------------
	return self
end

return api