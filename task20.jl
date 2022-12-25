function next_square_recursive!(robot,side)
    if !isborder(robot,side)
        move!(robot,side)
    else
        move!(robot,right(side))
        next_square_recursive(robot,side)
        move!(robot,left(side))
    end
end
left(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side) + 3, 4))
right(side::HorizonSide)::HorizonSide = HorizonSide(mod(Int(side) + 1, 4))