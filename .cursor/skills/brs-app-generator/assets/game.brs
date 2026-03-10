sub Main()
    screen = CreateObject("roScreen", true, 1280, 720)
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)

    titleFont = CreateObject("roFont", "default", 36, true, false)
    font = CreateObject("roFont", "default", 28, false, false)
    bigFont = CreateObject("roFont", "default", 72, true, false)
    smallFont = CreateObject("roFont", "default", 20, false, false)

    paddleX = 540
    paddleW = 200
    paddleH = 16
    paddleY = 660
    ballX = 640
    ballY = 360
    ballSize = 16
    ballDX = 5
    ballDY = -4
    score = 0
    gameOver = false

    while true
        screen.Clear(&h14120BFF)

        ' Header
        screen.DrawRect(0, 0, 1280, 50, &h1D1B15FF)
        screen.DrawText("APP_TITLE", 40, 6, &hF54E00FF, titleFont)
        screen.DrawText("Score: " + str(score), 1040, 12, &hEDECECFF, font)

        if not gameOver
            ' Move ball
            ballX = ballX + ballDX
            ballY = ballY + ballDY

            ' Wall bounce
            if ballX <= 0 or ballX >= 1280 - ballSize then ballDX = -ballDX
            if ballY <= 50 then ballDY = -ballDY

            ' Paddle bounce
            if ballDY > 0 and ballY + ballSize >= paddleY and ballY + ballSize <= paddleY + paddleH
                if ballX + ballSize >= paddleX and ballX <= paddleX + paddleW
                    ballDY = -ballDY
                    score = score + 10
                end if
            end if

            ' Ball lost
            if ballY > 720
                gameOver = true
            end if

            ' Draw play area border
            screen.DrawRect(0, 50, 1280, 2, &h26241EFF)

            ' Draw paddle
            screen.DrawRect(paddleX, paddleY, paddleW, paddleH, &h2EC4B6FF)

            ' Draw ball
            screen.DrawRect(ballX, ballY, ballSize, ballSize, &hF54E00FF)

            ' Instructions
            screen.DrawText("LEFT / RIGHT arrow keys to move paddle", 430, 696, &h444444FF, smallFont)
        else
            ' Game over screen
            screen.DrawText("GAME OVER", 420, 260, &hE71D36FF, bigFont)
            screen.DrawText("Final Score: " + str(score), 500, 380, &hEDECECFF, font)
            screen.DrawRect(480, 440, 320, 50, &hF54E00FF)
            screen.DrawText("Press OK to restart", 510, 450, &hFFFFFFFF, font)
            screen.DrawText("Press BACK to exit", 510, 520, &h666666FF, smallFont)
        end if

        screen.SwapBuffers()

        ' Handle input
        msg = wait(16, port)
        if msg <> invalid
            if type(msg) = "roUniversalControlEvent"
                key = msg.GetInt()
                if key = 0 then exit while
                if not gameOver
                    if key = 4 then paddleX = paddleX - 40
                    if key = 5 then paddleX = paddleX + 40
                    if paddleX < 0 then paddleX = 0
                    if paddleX > 1280 - paddleW then paddleX = 1280 - paddleW
                else
                    if key = 6
                        ballX = 640
                        ballY = 360
                        ballDX = 5
                        ballDY = -4
                        score = 0
                        gameOver = false
                    end if
                end if
            end if
        end if
    end while
end sub
