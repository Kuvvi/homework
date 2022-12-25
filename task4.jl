using HorizonSideRobots

function cross!(r)
    for side in (West, Sud, Ost, Nord)
        n = numsteps_putmarkers!(r, side)
        along!(r, inverse(side), n)
    end
    putmarker!(r)
end

function numsteps_putmarkers!(r, side)
    num_steps=0
    while !isborder(r,side) && !isborder(r, next(side)) 
        move!(r,side)
        move!(r,next(side))
        num_steps += 1
        putmarker!(r)
    end
    return num_steps
end

function along!(r, side, num_steps)
    for _ in 1:num_steps
        move!(r,side)
        move!(r,next(side))
    end
end

inverse(side) = HorizonSide(mod(Int(side) +2, 4))
next(side) = HorizonSide(mod(Int(side) +1, 4))

r=Robot("map.sit", animate=true)
cross!(r)
