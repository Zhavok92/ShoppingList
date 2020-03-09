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
            spacing: mainWindow.height * 0.04

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
                    addWindow.open();
                    opacityAnim.from = 1
                    opacityAnim.to = 0.4
                    opacityAnim.start()
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

    Popup {
        id: addWindow
        anchors.centerIn: parent
        width: root.width
        height: root.height * 0.4

        Image {
            source: "images/addBackground.png"
            anchors.fill: parent
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: addWindow.width * 0.05

            Rectangle {
                id: rect1
                color: "white"
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: addWindow.height * 0.02
                opacity: 0.8

                RowLayout {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: addWindow.width * 0.1

                    Label {
                        text: "Artikel"
                        font {
                            family: "Serif"
                            pointSize: addWindow.height * 0.05
                        }
                    }

                    TextField {
                        id: itemName
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        Layout.minimumWidth: rect1.width * 0.6
                        font {
                            family: "Serif"
                            pointSize: addWindow.height * 0.05
                            italic: true
                        }
                    }
                }
            }

            Rectangle {
                id: rect2
                color: "white"
                Layout.fillWidth: true
                Layout.fillHeight: true
                radius: addWindow.height * 0.02
                opacity: 0.8

                RowLayout {
                    anchors.left: parent.left
                    anchors.leftMargin: parent.width * 0.05
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: addWindow.width * 0.1

                    Label {
                        text: "Menge"
                        font {
                            family: "Serif"
                            pointSize: addWindow.height * 0.05
                        }
                    }

                    TextField {
                        id: itemQuantity
                        Layout.fillWidth: true
                        Layout.minimumWidth: rect2.width * 0.6
                        Layout.fillHeight: true
                        font {
                            family: "Serif"
                            pointSize: addWindow.height * 0.05
                            italic: true
                        }
                    }
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: addWindow.width * 0.4

                RoundButton {
                    Material.background: Material.white
                    Layout.minimumWidth: height
                    Layout.fillHeight: true
                    Layout.maximumHeight: addWindow.height * 0.3

                    Image {
                        anchors.centerIn: parent
                        width: parent.width * 0.5
                        height: parent.height * 0.5
                        source: "images/decline.png"
                    }

                    onClicked: {
                        addWindow.visible = false
                        addWindow.close()
                        opacityAnim.from = 0.4
                        opacityAnim.to = 1
                        opacityAnim.start()
                        itemName.text = "";
                        itemQuantity.text = "";
                    }
                }

                RoundButton {
                    Material.background: Material.white
                    Layout.minimumWidth: height
                    Layout.fillHeight: true
                    Layout.maximumHeight: addWindow.height * 0.3

                    Image {
                        anchors.centerIn: parent
                        width: parent.width * 0.5
                        height: parent.height * 0.5
                        source: "images/accept.png"
                    }

                    onClicked: {
                        if(itemName.length > 0) {
                            listM.addItem(itemName.text, itemQuantity.text)
                            save();
                        }
                        addWindow.close()
                        opacityAnim.from = 0.4
                        opacityAnim.to = 1
                        opacityAnim.start()
                        itemName.text = "";
                        itemQuantity.text = "";
                    }
                }
            }
        }
    }

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
