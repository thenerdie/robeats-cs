-- Get Date function
-- Crazyman32
-- October 16, 2014

--[[	USAGE:
	
	
	local GetDate = require(somewhere.GetDate)
	
	local date = GetDate()
		-- Returns a table containing the following:
			- total: seconds since Jan. 1, 1970
			- seconds: current seconds relative to minute
			- minutes: current minute relative to hour
			- hours: current hour (0-23) relative to day
			- hoursPm: current hour (1-12) relative to day
			- year: current year (2014)
			- yearShort: current year (14)
			- isLeapYear: true or false, indicating if current year is a leap year
			- isAm: true if morning, false if afternoon
			- month: numerical month of year (3)
			- monthWord: month of year (March)
			- day: day of the month
			- dayOfYear: day of the year
	
	
	Formatting dates:
		date:format(str)
		
		Where 'str' is a string formatter:
		
			#s  seconds
			#m  minutes
			#h  hours
			#H  hours AM/PM
			#Y  year
			#y  year short
			#a  AM/PM marker
			#W  month word
			#M  month numerical
			#d  day of month
			#D  day of year
			#t  total seconds
			
		Examples:
		
			local today = date:format("#W #d, #Y)
			print(today)
					> October 16, 2014
			
			local currentTime = date:format("#H:#m #a")
			print(currentTime)
					> 11:46 AM
	
	
--]]

local dt = {}

function dt:GetTickFromISO(iso)
	--2020-07-13T02:40:23.647Z
	local datetime = DateTime.fromIsoDate(iso):ToLocalTime()
	return os.time({year=datetime.Year, month=datetime.Month, day=datetime.Day, hour=datetime.Hour, min=datetime.Minute, sec=datetime.Second})
end

function dt:GetDateTime(t_)
	local date = {}
	local months = {
		{"January", 31};
		{"February", 28};
		{"March", 31};
		{"April", 30};
		{"May", 31};
		{"June", 30};
		{"July", 31};
		{"August", 31};
		{"September", 30};
		{"October", 31};
		{"November", 30};
		{"December", 31};
	}
	local t = t_ or tick()
	date.total = t
	date.seconds = math.floor(t % 60)
	date.minutes = math.floor((t / 60) % 60)
	date.hours = math.floor((t / 60 / 60) % 24)
	date.year = (1970 + math.floor(t / 60 / 60 / 24 / 365.25))
	date.yearShort = tostring(date.year):sub(-2)
	date.isLeapYear = ((date.year % 4) == 0)
	date.isAm = (date.hours < 12)
	date.hoursPm = (date.isAm and date.hours or (date.hours == 12 and 12 or (date.hours - 12)))
	
	if (date.hoursPm == 0) then date.hoursPm = 12 end
	if (date.isLeapYear) then
		months[2][2] = 29
	end
	do
		date.dayOfYear = math.floor((t / 60 / 60 / 24) % 365.25)
		local dayCount = 0
		for i,month in pairs(months) do
			dayCount = (dayCount + month[2])
			if (dayCount > date.dayOfYear) then
				date.monthWord = month[1]
				date.month = i
				date.day = (date.dayOfYear - (dayCount - month[2]) + 1)
				break
			end
		end
	end
	function date:format(str)
		str = str
			:gsub("#s", ("%.2i"):format(self.seconds))
			:gsub("#m", ("%.2i"):format(self.minutes))
			:gsub("#h", tostring(self.hours))
			:gsub("#H", tostring(self.hoursPm))
			:gsub("#Y", tostring(self.year))
			:gsub("#y", tostring(self.yearShort))
			:gsub("#a", (self.isAm and "AM" or "PM"))
			:gsub("#W", self.monthWord)
			:gsub("#M", tostring(self.month))
			:gsub("#d", tostring(self.day))
			:gsub("#D", tostring(self.dayOfYear))
			:gsub("#t", tostring(self.total))
		return str
	end
	local mdate = {}
	mdate.__index = function(self, a)
		
	end
	mdate.__add = function(a, b)
		return dt:GetDateTime(a.total+b.total)
	end;
	mdate.__sub = function(a, b)
		return dt:GetDateTime(math.abs(b.total-a.total))
	end
	return setmetatable(date, mdate)
end

return dt
