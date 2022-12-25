using HorizonSideRobots

inverse(side) = HorizonSide(mod(Int(side)+2,4))


function under_gap!(r)
    steps=1
    side=West
    while isborder(r,Nord)
        step=steps
        while !isborder(r,side) && step>0 && isborder(r,Nord)
            move!(r,side)
            step-=1
        end
        side=inverse(side)
        steps+=1
    end
end

r=Robot("map7.sit", animate=true)
under_gap!(r)