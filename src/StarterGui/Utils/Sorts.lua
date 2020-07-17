return {
    Leaderboard = function(a, b)
        if a.rating == 0 and b.rating == 0 then
            return a.score > b.score
        end
        return a.rating > b.rating
    end
}