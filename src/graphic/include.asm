
include 'Main.asm'
include 'ThreadProcessMessages.asm'

include 'app/AppInit.asm'
include 'app/AppUpdate.asm'
include 'app/AppDrawInputLine.asm'
include 'app/AppDrawLogo.asm'

include 'console/ConsoleInit.asm'
include 'console/ConsoleAddCommand.asm'
include 'console/StringClone.asm'

include 'window/WindowSurfaceFlush.asm'
include 'window/WindowCreate.asm'
include 'window/WindowDcInit.asm'
include 'window/WindowProc.asm'

include 'input/InputBufferAddChar.asm'
include 'input/InputBufferRemoveChar.asm'
include 'input/InputBufferClear.asm'
include 'input/InputOnKeyDown.asm'
include 'input/InputSend.asm'

include 'draw/BufferCreate.asm'
include 'draw/DrawBuffer.asm'
include 'draw/DrawBufferScaled.asm'
include 'draw/DrawClear.asm'
include 'draw/DrawSetTarget.asm'
include 'draw/DrawPixel.asm'
include 'draw/DrawPixelChar.asm'
include 'draw/DrawPixelText.asm'
include 'draw/DrawLineHorizontal.asm'
include 'draw/DrawRectangle.asm'