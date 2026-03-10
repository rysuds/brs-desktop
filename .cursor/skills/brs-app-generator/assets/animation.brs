sub Main()
    screen = CreateObject("roScreen", true, 1280, 720)
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)

    titleFont = CreateObject("roFont", "default", 36, true, false)
    smallFont = CreateObject("roFont", "default", 18, false, false)

    colors = [&hF54E00FF, &h2EC4B6FF, &hE71D36FF, &h6C63FFFF, &hFFD166FF, &h06D6A0FF]
    x = [100, 400, 700, 250, 550, 900]
    y = [100, 300, 200, 450, 150, 400]
    dx = [3, -2, 4, -3, 2, -4]
    dy = [2, 3, -2, 1, -3, 2]
    sizes = [60, 80, 50, 70, 45, 55]

    while true
        screen.Clear(&h14120BFF)

        for i = 0 to 5
            screen.DrawRect(x[i], y[i], sizes[i], sizes[i], colors[i])
            x[i] = x[i] + dx[i]
            y[i] = y[i] + dy[i]
            if x[i] <= 0 or x[i] >= 1280 - sizes[i] then dx[i] = -dx[i]
            if y[i] <= 60 or y[i] >= 720 - sizes[i] then dy[i] = -dy[i]
        end for

        screen.DrawRect(0, 0, 1280, 56, &h1D1B15FF)
        screen.DrawText("APP_TITLE", 40, 8, &hF54E00FF, titleFont)
        screen.DrawText("Press BACK to exit", 1060, 696, &h666666FF, smallFont)

        screen.SwapBuffers()

        msg = wait(16, port)
        if msg <> invalid
            if type(msg) = "roUniversalControlEvent"
                if msg.GetInt() = 0 then exit while
            end if
        end if
    end while
end sub
