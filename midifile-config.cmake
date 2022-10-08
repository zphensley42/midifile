set(CMAKE_CXX_STANDARD_REQUIRED ON)

if(APPLE)
    set(CMAKE_OSX_DEPLOYMENT_TARGET "10.9" CACHE STRING "Minimum OS X deployment version")
endif()

if(MSVC)
    add_definitions(-D_CRT_SECURE_NO_WARNINGS)

    option(STATIC_CRT "Use static CRT libraries" OFF)

    # Rewrite command line flags to use /MT if necessary
    if(STATIC_CRT)
        foreach(flag_var
                CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
                CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
            if(${flag_var} MATCHES "/MD")
                string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
            endif(${flag_var} MATCHES "/MD")
        endforeach(flag_var)
    endif()
endif()

set(SRCS
    ${CMAKE_CURRENT_LIST_DIR}/src/Options.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/Binasc.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/MidiEvent.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/MidiEventList.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/MidiFile.cpp
    ${CMAKE_CURRENT_LIST_DIR}/src/MidiMessage.cpp
)

add_library(midifile STATIC)
target_sources(midifile PUBLIC ${SRCS})
target_include_directories(midifile PRIVATE ${CMAKE_CURRENT_LIST_DIR}/include)

set(midifile_INCLUDE_DIRS ${CMAKE_CURRENT_LIST_DIR}/include)
set(midifile_LIBRARIES midifile)
