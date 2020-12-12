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
			-- "vendor/Glad/include",
			-- "vendor/ImGui"
        }
    
    filter {}
        files {
            "src/Hazel/Core/Application.h",
            "src/Hazel/Core/Application.cpp",
            "src/Hazel/Core/Window.h",
            "src/Hazel/Core/Window.cpp",
            "src/Hazel/Core/EntryPoint.h",
            "src/Hazel/Core/Log.h",
            "src/Hazel/Core/Log.cpp",
            "src/Hazel/Core/Assert.h",
            "src/Hazel/Core/Base.h",
            "src/Hazel/Core/Layer.h",
            "src/Hazel/Core/Layer.cpp",
            "src/Hazel/Core/LayerStack.cpp",
            "src/Hazel/Core/LayerStack.h",
            "src/Hazel/Core/Base.h",
            "src/Hazel/Core/PlatformDetection.h",
            "src/Platform/Windows/WindowsWindow.cpp",
            "src/Platform/Windows/WindowsWindow.h",
            "src/Hazel.h",
            "src/Hazel/Events/*",
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
            -- "%{IncludeDir.Glad}",
            -- "%{IncludeDir.ImGui}",
            -- "%{IncludeDir.glm}",
            -- "%{IncludeDir.stb_image}",
            -- "%{IncludeDir.entt}",
            -- "%{IncludeDir.yaml_cpp}"
        }

        links
        {
            "GLFW",
            -- "Glad",
            -- "ImGui",
            -- "yaml-cpp",
            -- "opengl32.lib",
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
			"Cocoa.framework",
			"IOKit.framework",
			"QuartzCore.framework"
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
