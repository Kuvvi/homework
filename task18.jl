using HorizonSideRobots
function along_recursive!(r,side) 
    if !isborder(r,side)
        move!(r,side)
        along(r,side)
    end
end

