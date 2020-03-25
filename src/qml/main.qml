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
                    model: deleModel
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
                property int sourceIndex: -1
                property int destinationIndex: -1
                property var oldRect: rect

                width: mainWindow.width
                height: mainWindow.height * 0.08

                drag.target: held ? rect : undefined
                drag.axis: Drag.XAndYAxis
                onPressAndHold: {
                    held = true
                    sourceIndex = itemMouseA.DelegateModel.itemsIndex
                }

                onReleased: {
                    if(held) {
                        if(rect.x > mainWindow.width * 0.3) {
                            listM.removeItem(index)
                            save();
                        }
                        else {
                            destinationIndex = itemMouseA.DelegateModel.itemsIndex
                            console.log("Moved " + sourceIndex + " to " + destinationIndex)
                            listM.move(sourceIndex, destinationIndex)
                            save()
                        }
                    }
                    held = false
                }

                onDoubleClicked: {
                    addItemWindow.open()
                    addItemWindow.iName = name
                    addItemWindow.iQuantity = quantity
                    addItemWindow.index = index
                }

                DropArea {

                    property string oldColor: rect.color

                    width: mainWindow.width * 0.5
                    height: mainWindow.height
                    anchors.left: parent.right
                    anchors.top: parent.top

                    onEntered: {
                        //rect.color = "red"
                        itemMouseA.rect
                    }

                    onExited: {
                        rect.color = "white"
                    }
                }

                Rectangle {
                    id: rect
                    width: parent.width * 0.9
                    height: parent.height
                    anchors {
                        left: parent.left
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

                        AnchorChanges {
                            target: rect
                            anchors { left: undefined; verticalCenter: undefined }
                        }
                    }

                    Text {
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
                }

                DropArea {
                    anchors.fill: parent
                    anchors.margins: 10

                    onEntered: {
                        deleModel.items.move(drag.source.DelegateModel.itemsIndex, itemMouseA.DelegateModel.itemsIndex)
                    }
                }
            }
        }

        DelegateModel {
            id: deleModel
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
