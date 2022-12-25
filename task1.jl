using HorizonSideRobots

function mark_kross!(r) # - главная функция  
    for side in (Nord,West,Sud,Ost) # - перебор всех направлений Nord, West, Sud, Ost
        putmarkers!(r,side) # - ставим макеры по стороне side
        move_by_markers(r,inverse(side)) #перемещаем робота по стороне противоположной side
    end
    putmarker!(r)#ставим маркер
end

# Всюду в заданном направлении ставит маркеры вплоть до перегородки, но в исходной клетке маркер не ставит
function putmarkers!(r,side) 
    while isborder(r,side)==false #пока не граница поля
        move!(r,side)#двигаем по стороне
        putmarker!(r)#ставим маркер
    end
end   

# Перемещает робота в заданном направлении пока, пока он находится в клетке с маркером (в итоге робот окажется в клетке без маркера)
function move_by_markers(r,side) 
    while ismarker(r)==true #пока клетка на которой находится робот закрашена
        move!(r,side) #двигаемся
    end
end

# Возвращает направление, противоположное заданному
inverse(side) = HorizonSide(mod(Int(side)+2, 4))

r=Robot("map.sit", animate=true)
mark_kross!(r)
