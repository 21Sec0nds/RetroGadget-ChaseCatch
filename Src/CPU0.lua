
--Variables
--Joy
local joy = gdt.DPad0
--Vid
local vid = gdt.VideoChip0
--Ball
local ballX = 30
local ballY = 34
--AudioChip
local chip = gdt.AudioChip0
local aud:AudioChip = gdt.AudioChip0
local snd:AudioSample = gdt.ROM.User.AudioSamples["Snak"]
--
local disp = gdt.SegmentDisplay0
local score = 0
--Screen scales
local screenWidth = 62
local screenHeight = 62
---------------------------
local ranX = math.random(0, screenWidth )
local ranY = math.random(0, screenHeight)

local rad = 5
function update()
    if gdt.Led0.State == true then 
        aud:Play(snd, 1)
    end

    local x = joy.X
    local y = joy.Y
    vid.Clear(vid, color.black)

    print(math.floor(x) .. ":" .. math.floor(y))

  
    ballX = ballX + x / 100
    ballY = ballY - y / 100
		
    if ballX < 0 then
        ballX = screenWidth - 1  
    elseif ballX >= screenWidth then
        ballX = 0 
    end

    if ballY < 0 then
        ballY = screenHeight - 1  
    elseif ballY >= screenHeight then
        ballY = 0  
    end
		

    if ballX == screenWidth - 1 or ballY == screenHeight - 1 then
        gdt.Led0.State = true
    else
        gdt.Led0.State = false
    end


    if math.abs(ballX - ranX) <= rad and math.abs(ballY - ranY) <= rad then
        ranX = math.random(0, screenWidth)
        ranY = math.random(0, screenHeight)
        score = score + 1
    end
		 if score > 99 then
        score = 99
    end

    
    disp:ShowDigit(2, score % 10)              
    disp:ShowDigit(1, math.floor(score / 10))  
	

    vid.DrawCircle(vid, vec2(ballX, ballY), 2, color.white)
    vid.DrawCircle(vid, vec2(ranX, ranY), 2, color.white)
end