function dubledist!(robot,side)
    if !isborder(robot,side)
        move!(robot,side)
        dubledist!(robot,side)
        for _ in 1:2
            if !isborder(robot,inverse(side))
                move!(robot,inverse(side))
 
            else
                return false

            end
        end
    end
    return true
end
inverse(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side) + 2, 4))