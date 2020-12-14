project "Hazel"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "hzpch.h"
    pchsource "src/hzpch.cpp"

    filter "action:vs*"
		pchheader "hzpch.h"
        pchsource "Hazel/src/hzpch.cpp"

	filter "action:xcode4"
		pchheader "src/hzpch.h"
        pchsource "Hazel/src/hzpch.cpp"
        xcodebuildsettings {  ['ALWAYS_SEARCH_USER_PATHS'] = 'YES' }
        sysincludedirs {
			"src",
			"vendor/spdlog/include",
			"vendor/GLFW/include",
			"vendor/Glad/include",
            "vendor/ImGui",
        }
    
    filter {}
        files {
            "src/Hazel/Core/*",
            "src/Platform/Windows/WindowsWindow.cpp",
            "src/Platform/Windows/WindowsWindow.h",
            "src/Platform/OpenGL/OpenGLContext.h",
            "src/Platform/OpenGL/OpenGLContext.cpp",
            "src/Hazel/Renderer/GraphicsContext.h",
            "src/Hazel/Renderer/GraphicsContext.cpp",
            "src/Hazel.h",
            "src/Hazel/Events/*",
            "src/Hazel/imGui/*",
            -- "vendor/stb_image/**.h",
            -- "vendor/stb_image/**.cpp",
            -- "vendor/glm/glm/**.hpp",
            -- "vendor/glm/glm/**.inl",
        }

        defines {
            "_CRT_SECURE_NO_WARNINGS",
            "GLFW_INCLUDE_NONE"
        }

        includedirs
        {
            "src",
            "%{IncludeDir.GLFW}",
            "%{IncludeDir.Glad}",
            "%{IncludeDir.ImGui}",
            -- "%{IncludeDir.glm}",
            -- "%{IncludeDir.stb_image}",
            -- "%{IncludeDir.entt}",
            -- "%{IncludeDir.yaml_cpp}"
        }

        links
        {
            "GLFW",
            "Glad",
            "ImGui",
            -- "yaml-cpp",
            -- "opengl32.lib",
            -- "glfw3.lib"
        }

    filter "system:macosx"
        systemversion "latest"
		defines
		{
			"HZ_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}
		links
		{
            "AppKit.framework",
            "Cocoa.framework",
            "CoreVideo.framework",
            "CoreGraphics.framework",
			"OpenGL.framework",
			"IOKit.framework",
            "QuartzCore.framework",
		}

	filter "system:windows"
		systemversion "latest"
		defines
		{
        }


	filter "configurations:Debug"
		defines "HZ_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "HZ_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		defines "HZ_DIST"
		runtime "Release"
		optimize "on"
