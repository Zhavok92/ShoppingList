import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12
import Qt.labs.settings 1.1

Window {
    id: root
    visible: true
    width: 360
    height: 640

    Material.theme: Material.Normal

    property string datastore: ""

    Item {
        id: mainWindow
        anchors.fill: parent

        Image {
            source: "images/mainBackground.png"
            anchors.fill: parent
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: mainWindow.width * 0.05
            spacing: mainWindow.height * 0.08

            RowLayout {
                Layout.minimumWidth: parent.width

                ToolButton {
                    id: drawerButton
                    Layout.alignment: Qt.AlignLeft

                    Image {
                        id: drawerButtonIcon
                        anchors.fill: parent
                        source: "images/drawer.png"
                    }

                    DropShadow {
                        anchors.fill: drawerButtonIcon
                        horizontalOffset: 3
                        verticalOffset: 3
                        radius: 10
                        samples: 20
                        color: "#80000000"
                        source: drawerButtonIcon
                    }

                    onPressed: {
                        colorOverl.visible = true
                    }

                    onPressedChanged: {
                        colorOverl.visible = false
                    }

                    onClicked: {
                        infoDrawer.open()
                    }

                    ColorOverlay {
                        id: colorOverl
                        visible: false
                        anchors.fill: drawerButton
                        source: drawerButtonIcon
                        color: "grey"
                        opacity: 0.5
                    }
                }

                RoundButton {
                    id: addButton
                    Layout.alignment: Qt.AlignRight
                    Material.background: Material.Cyan

                    Image {
                        id: image
                        anchors.centerIn: parent
                        width: parent.width * 0.5
                        height: parent.height * 0.5
                        source: "images/add.png"
                    }

                    onClicked:  {
                        addItemWindow.open()
                    }
                }
            }

            Item  {
                Layout.fillWidth: true
                Layout.fillHeight: true

                ListView {
                    id: listV
                    anchors.fill: parent
                    Layout.fillWidth: true
                    Layout.maximumWidth: mainWindow * 0.7
                    Layout.fillHeight: true
                    model: listM
                    delegate: delegate
                    spacing: mainWindow.height * 0.02
                }
            }
        }

        Component {
            id: delegate

            Rectangle {
                id: rect
                width: mainWindow.width * 0.9
                height: mainWindow.height * 0.08
                color: "white"
                radius: mainWindow.height * 0.02
                opacity: 0.8

                Text {
                    id: test
                    text: name
                    anchors.left: parent.left
                    anchors.margins: parent.width * 0.1
                    anchors.verticalCenter: parent.verticalCenter
                    font {
                        family: "Serif"
                        pointSize: root.height * 0.03
                        italic: true
                    }
                }

                Text {
                    text: quantity
                    anchors.right: parent.right
                    anchors.margins: parent.width * 0.1
                    anchors.verticalCenter: parent.verticalCenter
                    font {
                        family: "Serif"
                        pointSize: root.height * 0.03
                        italic: true
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    drag.target: rect
                    drag.axis: Drag.XAxis
                    drag.minimumX: 0
                    drag.maximumX: mainWindow.width
                    onReleased: {
                        if(rect.x > mainWindow.width * 0.3) {
                            listM.removeItem(index)
                            save();
                        }
                        else {
                            anim.start()
                        }
                    }
                    onDoubleClicked: {
                        addItemWindow.open()
                        addItemWindow.iName = name
                        addItemWindow.iQuantity = quantity
                        addItemWindow.index = index
                    }
                }

                NumberAnimation {
                    id: anim
                    target: rect
                    property: "x"
                    to: listV.x
                    duration: 300
                }
            }
        }
    }

    AddItemPopup { id: addItemWindow }

    InformationDrawer { id: infoDrawer }

    OpacityAnimator {
        id: opacityAnim
        target: mainWindow
        from: 1
        to: 0.2
        duration: 700
    }

    function save() {
        datastore =  listM.getItemsAsJson()
        console.log("Save JSON Final: " + datastore)
    }

    function load() {
        if (datastore) {
            listM.clear()
            listM.setItemsByJson(datastore)
        }
    }

    Component.onCompleted: {
        load()
    }

    Settings {
        property alias datastore: root.datastore
    }
}
