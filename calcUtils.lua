local calcUtils = {}

function calcUtils.score(scorePoint)

    if (tonumber(scorePoint) == 16) then
        return "0"
    elseif (tonumber(scorePoint) > 0) then
        return tostring(tonumber(scorePoint) - 12)
       
    end
  

end

return calcUtils