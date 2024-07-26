qt_add_executable(ShoppingList 
    main.cpp
)

message(STATUS ${PROJECT_SOURCE_DIR}/android)

if(ANDROID)
    set_property(TARGET ShoppingList PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR ${PROJECT_SOURCE_DIR}/android)
endif()


qt_add_qml_module(ShoppingList 
    URI ShoppingList.Gui
    VERSION 1.0
    QML_FILES
        gui/Main.qml
        gui/views/Home.qml
        gui/components/AddItemPopup.qml
        gui/components/InformationDrawer.qml

    SOURCES
        gui/QmlClipboard.cpp
        gui/QmlClipboard.h
        gui/QmlItem.cpp
        gui/QmlItem.h
        gui/models/listmodel.cpp
        gui/models/listmodel.h

    RESOURCES
        gui/resources/images/accept.png
        gui/resources/images/add.png
        gui/resources/images/addBackground.png
        gui/resources/images/burger_menu.png
        gui/resources/images/decline.png
        gui/resources/images/drawerBackground.png
        gui/resources/images/mainBackground.png
)

target_link_libraries(ShoppingList 
    PRIVATE
        Qt::Core
        Qt::Gui
        Qt::Quick
        Qt6::QuickControls2
)