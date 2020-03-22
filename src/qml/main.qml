import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12
import QtGraphicalEffects 1.12
import Qt.labs.settings 1.1
import QtQml.Models 2.12

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
                    model: visualModel
                    delegate: delegate
                    spacing: mainWindow.height * 0.02
                }
            }
        }

        Component {
            id: delegate


            MouseArea {
                id: itemMouseA

                property bool held: false

                width: mainWindow.width * 0.9
                height: mainWindow.height * 0.08

                drag.target: held ? rect : undefined
                drag.axis: Drag.YAxis
                onPressAndHold: {
                    held = true
                    console.log("now")
                }
                onReleased: held = false

                //drag.target: rect
                //drag.axis: Drag.XAxis
                //drag.minimumX: 0
                //drag.maximumX: mainWindow.width
                //onReleased: {
                    //if(rect.x > mainWindow.width * 0.3) {
                    //   listM.removeItem(index)
                    //    save();
                    //}
                    //else {
                    //    anim.start()
                    //}
                //}
                onDoubleClicked: {
                    addItemWindow.open()
                    addItemWindow.iName = name
                    addItemWindow.iQuantity = quantity
                    addItemWindow.index = index
                }

                Rectangle {
                    id: rect
                    width: parent.width
                    height: parent.height
                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        verticalCenter: parent.verticalCenter
                    }
                    //color: "white"
                    color: itemMouseA.held ? "lightsteelblue" : "white"
                    radius: mainWindow.height * 0.02
                    opacity: 0.8

                    Drag.active: itemMouseA.held
                    Drag.source: itemMouseA
                    Drag.hotSpot.x: width / 2
                    Drag.hotSpot.y: height / 2
                    states: State {
                        when: itemMouseA.held

                        ParentChange { target: rect
                                        //parent: listV
                        }
                        AnchorChanges {
                            target: rect
                            anchors { horizontalCenter: undefined; verticalCenter: undefined }
                        }
                    }

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

                    NumberAnimation {
                        id: anim
                        target: rect
                        property: "x"
                        to: listV.x
                        duration: 300
                    }
                }

                DropArea {
                    anchors { fill: parent; margins: 10 }

                    onEntered: {
                        visualModel.items.move(
                                drag.source.DelegateModel.itemsIndex,
                                itemMouseA.DelegateModel.itemsIndex)
                    }
                }
            }
        }

        DelegateModel {
            id: visualModel

            model: listM
            delegate: delegate
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
