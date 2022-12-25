using HorizonSideRobots


function perrimeters!(robot)
    n_steps_Sud,n_steps_West = go_corner!(robot)
    find_frame!(robot)
    perimeter_of_frame!(robot)
    go_to_corner!(robot)
    perimeter!(robot)
    go_home!(robot,n_steps_Sud,n_steps_West)
end

function along!(robot,side)
    n_steps = 0
    while !isborder(robot,side)
        move!(robot,side)
        n_steps += 1
    end
    return n_steps
end
function along_nsteps!(robot,side)
    n_steps = 0
    while !isborder(robot,side)
        move!(robot,side)
        n_steps += 1
    end
    return n_steps
end
function along_putmarker!(robot,side)

    while !isborder(robot,side)
        move!(robot,side)
        putmarker!(robot)
    end
end
function go_to_border!(robot,side,n_steps)
    for _ in 1:n_steps
        move!(robot,side)
    end
end
function try_move!(robot,side)
    if !isborder(robot,side)
        move!(robot,side)
        return true
    else
        return false
    end
end
function find_frame!(robot) #Ищем рамку
    while !isborder(robot,Nord)
        while !isborder(robot,Ost)
            if !isborder(robot,Nord)
                move!(robot,Ost)
            else
                return
            end
        end
        move!(robot,Nord)
        while !isborder(robot,West)
            if !isborder(robot,Nord)
                move!(robot,West)
            else
                return
            end
        end
        move!(robot,Nord)
    end
end
function perimeter_of_frame!(robot)#Расставляем маркеры по периметру внутренней рамки
    for side in((Nord,Ost),(West,Nord),(Sud,West),(Ost,Sud),(Nord,Ost))
        side_with_border = side[1]
        side_without_border = side[2]
        while isborder(robot,side_with_border)
            move!(robot,side_without_border)
            putmarker!(robot)
        end
        move!(robot,side_with_border)
        putmarker!(robot)
    end
end
function perimeter!(robot) #Расставляем маркеры по периметру внешней рамки
    for side in(Ost,Nord,West,Sud)
        along_putmarker!(robot,side)
    end
end
function go_corner!(robot) # Робот идет в Юго-Западный уголь, считая количество шагов
    n_steps_Sud_border = along_nsteps!(robot,Sud)
    go_to_border!(robot,Nord,n_steps_Sud_border)
    n_steps_West_border = along_nsteps!(robot,West)
    go_to_border!(robot,Ost,n_steps_West_border)
    n_steps_Sud = 0
    n_steps_West = 0
    if n_steps_Sud_border > n_steps_West_border
        n_steps_Sud = along_nsteps!(robot,Sud)
        n_steps_West = along_nsteps!(robot,West)
    else
        n_steps_West = along_nsteps!(robot,West)
        n_steps_Sud = along_nsteps!(robot,Sud)
    end

    return n_steps_Sud, n_steps_West
end
function go_to_corner!(robot) #Робот идет в Юго-Западный угол, но не считая шаги
    while !(isborder(robot,Sud) && isborder(robot,West))
        while try_move!(robot,Sud)
            try_move!(robot,Sud)
        end
        while try_move!(robot,West)
            try_move!(robot,West)
        end
    end
    return n_steps_Sud,n_steps_West
end
function go_home!(robot,n_steps_Sud,n_steps_West)#Робот возвращается в исходную позицию на основе шагов из функции go_corner!(robot)
    if n_steps_West < n_steps_Sud
        go_to_border!(robot,Nord,n_steps_Sud)
        go_to_border!(robot,Ost,n_steps_West)
    else
        go_to_border!(robot,Ost,n_steps_West)
        go_to_border!(robot,Nord,n_steps_Sud)
    end  
    
end

inverse(side::HorizonSide) = HorizonSide((Int(side) +2)% 4)

r=Robot("map5.sit", animate=true)
perrimeters!(r)