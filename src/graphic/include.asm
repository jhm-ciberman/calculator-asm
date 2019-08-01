
include 'Main.asm'
include 'ThreadProcessMessages.asm'

include 'app/AppInit.asm'
include 'app/AppUpdate.asm'
include 'app/AppDrawInputLine.asm'
include 'app/AppDrawLogo.asm'
include 'app/AppRecalculateWindowSize.asm'

include 'console/ConsoleInit.asm'
include 'console/ConsoleClear.asm'
include 'console/ConsoleAddCommand.asm'

include 'console/ConsoleInputHandle.asm'

include 'window/WindowSurfaceFlush.asm'
include 'window/WindowCreate.asm'
include 'window/WindowProc.asm'

include 'input/InputBufferAddChar.asm'
include 'input/InputBufferRemoveChar.asm'
include 'input/InputBufferClear.asm'
include 'input/InputOnKeyDown.asm'

include 'draw/BufferCreate.asm'
include 'draw/BufferResize.asm'
include 'draw/DrawBuffer.asm'
include 'draw/DrawBufferScaled.asm'
include 'draw/DrawClear.asm'
include 'draw/DrawSetTarget.asm'
include 'draw/DrawPixel.asm'
include 'draw/DrawPixelChar.asm'
include 'draw/DrawPixelText.asm'
include 'draw/DrawPixelTextOutline.asm'
include 'draw/DrawLineHorizontal.asm'
include 'draw/DrawRectangle.asm'