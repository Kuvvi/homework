using HorizonSideRobots
function undergap!(r :: Robot)
    base=BaseRobot(r)
    shuttle!((x...)->isborder(r,Nord),base,Ost)
end

function shuttle!(cond :: Function, robot :: Union{SampleRobot, Robot}, side :: HorizonSide) 
    steps = 1
    while cond(robot,side)
        along!(robot,side,steps); side=inverse(side); steps+=1
    end
end

along!(cond :: Function, robot :: Union{SampleRobot, Robot} , side :: HorizonSide) = while cond(robot,side) && !isborder(r,side) move!(robot,side) en
inverse(side :: HorizonSide) = HorizonSide(mod(Int(side)+2,4))

r=Robot("map7.sit", animate=true)
undergap!(r)
