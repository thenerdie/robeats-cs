function CurrentDate(z)
    local z = math.floor(z / 86400) + 719468
    local era = math.floor(z / 146097)
    local doe = math.floor(z - era * 146097)
    local yoe = math.floor((doe - doe / 1460 + doe / 36524 - doe / 146096) / 365)
    local y = math.floor(yoe + era * 400)
    local doy = doe - math.floor((365 * yoe + yoe / 4 - yoe / 100))
    local mp = math.floor((5 * doy + 2) / 153)
    local d = math.ceil(doy - (153 * mp + 2) / 5 + 1)
    local m = math.floor(mp + (mp < 10 and 3 or -9))
    return y + (m <= 2 and 1 or 0), m, d
end
local DtHelper = {}

function DtHelper:CurrentTime(hoursOffset)
    local unixTime = math.floor(os.time()) - (60*60*(hoursOffset or 0))

    local hours = math.floor(unixTime / 3600 % 12)
    local minutes = math.floor(unixTime / 60 % 60)
    local seconds = math.floor(unixTime % 60)

    local year, month, day = CurrentDate(unixTime)

    return {
        year = year,
        month = month, 
        day = day,
        hours = hours,
        minutes = minutes < 10 and "0" .. minutes or minutes,
        seconds = seconds < 10 and "0" .. seconds or seconds
    }
end

function DtHelper:SubtractUnixToHours(unix1, unix2)
	return (unix1-unix2)/3600
end


return DtHelper 
