project "Sandbox"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"src/**.h",
		"src/**.cpp"
	}

	includedirs
	{
		"%{wks.location}/Hazel/vendor/spdlog/include",
		"%{wks.location}/Hazel/src",
		"%{wks.location}/Hazel/vendor",
		"%{IncludeDir.glm}",
		-- "%{IncludeDir.entt}"
	}

	links
	{
		"Hazel"
	}
	filter "action:xcode4"
		xcodebuildsettings {  ['ALWAYS_SEARCH_USER_PATHS'] = 'YES' }
		sysincludedirs {
			"Hazel/src",
			"Hazel/vendor/spdlog/include",
			"vendor/GLFW/include",
			"vendor/Glad/include",
			"vendor/ImGui"
		}

	filter "system:windows"
		systemversion "latest"

	filter "system:macosx"
				systemversion "latest"
				links
				{
					"AppKit.framework",
					"Cocoa.framework",
					"CoreGraphics.framework",
					"OpenGL.framework",
					"IOKit.framework",
					"QuartzCore.framework"
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
