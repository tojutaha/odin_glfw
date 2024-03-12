package main

import "opengl"
import "core:fmt"
import "core:c"
import gl "vendor:OpenGL"
import "vendor:glfw"

GL_MAJOR_VERSION : c.int : 4
GL_MINOR_VERSION :: 6

running : b32 = true

main :: proc() {

    opengl.GenBuffers()

    glfw.WindowHint(glfw.RESIZABLE, 1)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MAJOR, GL_MAJOR_VERSION)
    glfw.WindowHint(glfw.CONTEXT_VERSION_MINOR, GL_MINOR_VERSION)
    glfw.WindowHint(glfw.OPENGL_PROFILE, glfw.OPENGL_CORE_PROFILE)

    if ! cast(bool) glfw.Init() {
        fmt.println("Failed to initialize GLFW")
        return
    }

    defer glfw.Terminate()

    window := glfw.CreateWindow(512, 512, "Odin", nil, nil)
    defer glfw.DestroyWindow(window)

    if window == nil {
        fmt.println("Unable to create window")
        return
    }

    glfw.MakeContextCurrent(window)
    glfw.SwapInterval(1)
    glfw.SetKeyCallback(window, key_callback)
    glfw.SetFramebufferSizeCallback(window, size_callback)

    gl.load_up_to(int(GL_MAJOR_VERSION), GL_MINOR_VERSION, glfw.gl_set_proc_address)

    init()

    for(!glfw.WindowShouldClose(window) && running) {
        glfw.PollEvents()

        update()
        draw()

        glfw.SwapBuffers((window))
    }

    exit()
}

init :: proc() {
}

update :: proc() {
}

draw ::proc() {
    gl.ClearColor(0.2, 0.3, 0.3, 1.0)
    gl.Clear(gl.COLOR_BUFFER_BIT)
}

exit :: proc() {
}

key_callback :: proc "c" (window: glfw.WindowHandle, key, scancode, action, mods: i32) {
    if key == glfw.KEY_ESCAPE {
        running = false
    }
}

size_callback :: proc "c" (window: glfw.WindowHandle, width, height: i32) {
    gl.Viewport(0, 0, width, height)
}
