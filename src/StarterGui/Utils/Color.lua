local Color = {}

function Color:validateIsColor(clr)
    for k, v in pairs(clr) do
        if k ~= "Hue" and k ~= "Saturation" and k ~= "Value" then
            return false
        end
    end
    return true
end

function Color:newHSV()
    return {
        Hue = 1,
        Saturation = 1,
        Value = 1
    };
end

function Color:changeHSV(origin, props)
    assert(Color:validateIsColor(origin), "You did not pass in a valid origin color! Please check your code.");
    assert(Color:validateIsColor(props), "You did not pass in a valid modification table! Please check your code.");
    for i, v in pairs(props) do
        origin[i] = v
    end
    return origin
end

function Color:convertHSV(clr)
    assert(Color:validateIsColor(clr), "You did not pass in a valid HSV color! Please check your code.");
    return Color3.fromHSV(clr.Hue or 1, clr.Saturation or 1, clr.Value or 1)
end

return Color