project "RmlUi"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "off"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files 
	{
		"Include/**.h",
        "Source/**.h",
        "Source/**.cpp"
    }
	includedirs
	{
		"Include",             -- RmlUi public headers
        "Source",              -- RmlUi source headers
		"../freetype/include", 
		"../freetype/include/freetype",
		"../rlottie/inc",
		"../lunasvg/include", -- Path to lunasvg.h
		"Dependencies/lua-5.4.2/include"
	}

	links 
	{ 
		"../freetype/build/Release/freetype.lib",
		"../rlottie/build/Release/rlottie.lib",
		"../lunasvg/build/Release/lunasvg.lib",
		"../lunasvg/build/plutovg/Release/plutovg.lib",
		"Dependencies/lua-5.4.2/lua54.lib" 
	}

	defines 
	{
        "RMLUI_STATIC_LIB",    -- <-- key fix here
		"RMLUI_NO_FONT_INTERFACE_DEFAULT", -- Disable default font engine
    	"RMLUI_NO_DEFAULT_RENDER_INTERFACE", -- Use your custom renderer
		"RMLUI_LOTTIE_PLUGIN",
		"RMLUI_SVG_PLUGIN",
		"LUNASVG_BUILD_STATIC",
        "_CRT_SECURE_NO_WARNINGS"
    }

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
        runtime "Debug"
        symbols "on"
        defines {
            "_DEBUG",
            "RMLUI_DEBUG"
        }

    filter "configurations:Release"
        runtime "Release"
        optimize "on"
        defines {
            "NDEBUG"
        }

    filter "configurations:Dist"
        runtime "Release"
        optimize "on"
        symbols "off"
        defines {
            "NDEBUG"
        }
