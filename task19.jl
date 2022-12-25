function alongg_putmarker_recursive(robot,side)
    if isborder(robot,side)
        putmarker!(robot)
    else
        move!(robot,side)
        alongg_putmarker_recursive(robot,side)
        move!(robot,inverse(side))
    end
end
inverse(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side) + 2,4))