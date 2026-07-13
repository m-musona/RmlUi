group "RML UI Dependencies"
include "Dependencies/rlottie"
include "Dependencies/lunasvg"
group "Dependencies"

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
		"../msdf-atlas-gen/msdfgen/freetype/include", 
		"../msdf-atlas-gen/msdfgen/freetype/include/freetype",
		"Dependencies/rlottie/inc",
		"Dependencies/lunasvg/include", -- Path to lunasvg.h
		"Dependencies/lua-5.4.2/include"
	}

	links 
	{
		"Dependencies/lua-5.4.2/lua54.lib",
		"freetype",
		"rlottie",
		"lunasvg",
		"plutovg"
	}

	defines 
	{
        "RMLUI_STATIC_LIB",    -- <-- key fix here
		"RMLUI_NO_FONT_INTERFACE_DEFAULT", -- Disable default font engine
    	"RMLUI_NO_DEFAULT_RENDER_INTERFACE", -- Use your custom renderer
		"RMLUI_LOTTIE_PLUGIN",
		"RMLUI_SVG_PLUGIN",
		"LUNASVG_BUILD_STATIC",
        "PLUTOVG_BUILD_STATIC",
		"RLOTTIE_STATIC",
        "_CRT_SECURE_NO_WARNINGS"
    }

	filter "system:windows"
		systemversion "latest"

	filter "configurations:Debug"
        runtime "Debug"
        symbols "on"
        defines {
            "_DEBUG",
            "RMLUI_DEBUG",
			"RLOTTIE_STATIC"
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
