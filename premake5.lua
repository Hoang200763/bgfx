local BX_DIR = "%{wks.location}/bx"
local BIMG_DIR = "%{wks.location}/bimg"
local BGFX_DIR = "%{wks.location}/bgfx"

project "bgfx"
    kind "StaticLib"
    language "C++"
    cppdialect "C++14"
    exceptionhandling "Off"
    rtti "Off"
    defines "__STDC_FORMAT_MACROS"
    files
    {
        BGFX_DIR .. "/include/bgfx/**.h",
        BGFX_DIR .. "/src/*.cpp",
        BGFX_DIR .. "/src/*.h",
    }
    excludes
    {
        BGFX_DIR .. "/src/amalgamated.cpp",
    }
    includedirs
    {
        BX_DIR .. "/include",
        BIMG_DIR .. "/include",
        BGFX_DIR .. "/include",
        BGFX_DIR .. "/3rdparty",
        BGFX_DIR .. "/3rdparty/dxsdk/include",
        BGFX_DIR .. "/3rdparty/khronos",
    }
    filter "configurations:Debug"
        defines "BGFX_CONFIG_DEBUG=1"
    filter "action:vs*"
        defines "_CRT_SECURE_NO_WARNINGS"
        excludes
        {
            BGFX_DIR .. "/src/glcontext_glx.cpp",
            BGFX_DIR .. "/src/glcontext_egl.cpp",
        }
    filter "system:macosx"
        files
        {
            BGFX_DIR .. "/src/*.mm",
        }
    filter "action:vs*"
        includedirs { BX_DIR .. "/include/compat/msvc" }

    filter { "system:windows", "action:gmake" }
        includedirs { BX_DIR .. "/include/compat/mingw" }
        
    filter { "system:macosx" }
        includedirs { BX_DIR .. "/include/compat/osx" }
        buildoptions { "-x objective-c++" }