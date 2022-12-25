using HorizonSideRobots

function mark_all!(r)
    num_vert = moves!(r, Sud) 
    num_hor = moves!(r, West)
    #Робот - в Юго-Западном углу

    putmarker!(r)
    putmarkers!(r,Nord)

    while isborder(r,Ost)==false 
        move!(r,Ost)
        putmarker!(r)
        if isborder(r, Nord)==false
            putmarkers!(r, Nord)
        else 
            putmarkers!(r, Sud)
        end
    end

    moves!(r,West)
    move_back!(r, Nord, num_vert)
    move_back!(r, Ost, num_hor)

end

function moves!(r,side)#передвигаем робота по стороне horizonside и возвращаем количество шагов  num_step
    num_steps=0#обнуляем счетчик шагов 
    while isborder(r,side)==false#пока не граница
        move!(r,side)#двигаем робота
        num_steps+=1#обновляем счётчик
    end
    return num_steps#возвращаем общее количество шагов
end


function move_back!(r,side,num_steps)#передвигаем робота по horizonside на количество шагов (num_steps)
        for _ in 1:num_steps # символ "_" заменяет фактически не используемую переменную и мы проходимся по шагам
            move!(r,side)#двигаем робота
        end
end

   
function putmarkers!(r, side)#ставим маркеры на стороне horizonSide
    while isborder(r,side)==false #пока не граница 
        move!(r,side) #двигаем робота
        putmarker!(r) #ставим маркер
    end
end

r=Robot("map.sit", animate=true)
mark_all!(r)