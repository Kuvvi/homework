
using HorizonSideRobots

function try_move!(r, side)
    if isborder(r, side)
        return false
    else 
        move!(r, side)
        return true
    end
end


function along!(r, side)
    while try_move!(r, side) # - в этом логическом выражении порядок аргументов важен!
    end
end

function snake!(r, (move_side, next_row_side)::NTuple{2,HorizonSide} = (Nord, Ost)) # - это обобщенная функция
    # Робот - в (inverse(next_row_side), inverse(move_side))-углу поля
    along!(r, move_side)
    while try_move!(r, next_row_side)
        move_side = inverse(move_side)
        along!(r, move_side)
    end
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)

r=Robot("map14.sit", animate=true)
snake!(r)