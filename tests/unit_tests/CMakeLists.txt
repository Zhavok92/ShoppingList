add_executable(UnitTests)

set(APP_SOURCE_DIR ${PROJECT_SOURCE_DIR}/src)

target_include_directories(UnitTests PRIVATE ${APP_SOURCE_DIR})
target_sources(UnitTests    
    PRIVATE 
    testTemplate.cpp
)
target_link_libraries(UnitTests PRIVATE Catch2::Catch2WithMain)

catch_discover_tests(UnitTests
    PROPERTIES
        LABELS "UnitTests"
)