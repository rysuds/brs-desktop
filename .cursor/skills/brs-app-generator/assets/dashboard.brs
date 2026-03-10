sub Main()
    screen = CreateObject("roScreen", true, 1280, 720)
    port = CreateObject("roMessagePort")
    screen.SetMessagePort(port)

    titleFont = CreateObject("roFont", "default", 40, true, false)
    labelFont = CreateObject("roFont", "default", 28, false, false)
    smallFont = CreateObject("roFont", "default", 20, false, false)
    heroFont = CreateObject("roFont", "default", 48, true, false)

    screen.Clear(&h14120BFF)

    ' Header bar
    screen.DrawRect(0, 0, 1280, 64, &h1D1B15FF)
    screen.DrawText("APP_TITLE", 40, 10, &hF54E00FF, titleFont)

    ' Hero banner
    screen.DrawRect(40, 84, 800, 300, &hF54E00FF)
    screen.DrawRect(40, 84, 800, 6, &hFF6B35FF)
    screen.DrawText("Featured Content", 80, 140, &hFFFFFFFF, heroFont)
    screen.DrawText("A brand new original series", 80, 210, &hFFFFFFDD, labelFont)
    screen.DrawRect(80, 300, 180, 44, &hFFFFFFFF)
    screen.DrawText("Watch Now", 100, 308, &hF54E00FF, labelFont)

    ' Side panels
    screen.DrawRect(860, 84, 380, 144, &h2EC4B6FF)
    screen.DrawText("Top Picks", 880, 110, &hFFFFFFFF, labelFont)
    screen.DrawText("Curated for you", 880, 155, &hFFFFFFCC, smallFont)

    screen.DrawRect(860, 240, 380, 144, &h6C63FFFF)
    screen.DrawText("Live TV", 880, 266, &hFFFFFFFF, labelFont)
    screen.DrawText("200+ channels", 880, 311, &hFFFFFFCC, smallFont)

    ' Content row
    screen.DrawText("Continue Watching", 40, 410, &hEDECECFF, labelFont)

    cardColors = [&hE71D36FF, &hF54E00FF, &h2EC4B6FF, &h6C63FFFF, &hFFD166FF]
    cardLabels = ["Ep. 5", "Ep. 12", "Movie", "Docu.", "Finale"]
    for i = 0 to 4
        cx = 40 + (i * 245)
        cy = 450
        screen.DrawRect(cx, cy, 225, 140, &h26241EFF)
        screen.DrawRect(cx, cy, 225, 4, cardColors[i])
        screen.DrawRect(cx + 10, cy + 15, 205, 80, &h1B1913FF)
        screen.DrawText(cardLabels[i], cx + 10, cy + 108, &h999999FF, smallFont)
    end for

    ' Footer
    screen.DrawRect(0, 680, 1280, 40, &h1D1B15FF)
    screen.DrawText("Arrow keys: Navigate    Enter: Select    Backspace: Back", 350, 690, &h666666FF, smallFont)

    screen.SwapBuffers()
    wait(0, port)
end sub
