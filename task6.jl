using HorizonSideRobots

function six!(r)
    back_path = move_to_angle!(r)
    perimeter!(r)
    move!(r,back_path::Vector{NamedTuple{(:side, :num_steps), Tuple{HorizonSide,Int}}})
    
end

function move_to_angle!(robot, angle=(Sud,West))
    back_path = NamedTuple{(:side, :num_steps), Tuple{HorizonSide,Int}}[] # - пустой вектор типа Tuple{HorizonSide, Int}
    while !isborder(robot,angle[1]) || !isborder(robot, angle[2])
        push!(back_path, (side = inverse(angle[1]), num_steps = numsteps_along!(robot, angle[1])))
        push!(back_path, (side = inverse(angle[2]), num_steps = numsteps_along!(robot, angle[2])))  
    end
    return back_path
end
function HorizonSideRobots.move!(robot, back_path::Vector{NamedTuple{(:side, :num_steps), Tuple{HorizonSide,Int}}})
    back_path = reverse!(back_path)
    for next in back_path
        along!(robot, next.side, next.num_steps)
    end
end
function perimeter!(r)
    for side in (Ost,Nord,West,Sud)
        along_putm!(r,side)
    end
    
end

function along_putm!(r,side)
    while !isborder(r,side)
        move!(r,side)
        putmarker!(r)
    end
end
function numsteps_along!(r,side)
    n_steps = 0
    while !isborder(r,side)
        move!(r,side) 
        n_steps+=1       
    end
    return n_steps
end
function along!(r,side,n)
    for _ in 1:n
        move!(r,side)
    end
end
inverse(side) = HorizonSide(mod(Int(side)+2, 4))

r=Robot("map6.sit", animate=true)
six!(r)
