local items = game:GetDescendants()

local forbidden = {
    "/","?","*","|",'"',"'",":",">","<"
}

local function deb(str, forb)
	local found = string.find(str,forb)
	if found ~= nil then
		print("Invalid char", forb, "found! Old name:", str, "New name:", string.gsub(str, forb, ""))
	end
end


for itr, ob in pairs(items) do
	--local suc, err  = pcall(function()
	    local newname = ""
	    for i, forb in pairs(forbidden) do
			local n =  ob.Name
	        newname = string.gsub(n, forb, "")
			deb(n, forb)
	    end
	    ob.Name = newname
		print("Succeeded!")
	--end)
	--if not suc then
		--warn(err)
	--end
end