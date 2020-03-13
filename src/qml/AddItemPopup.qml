import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

Popup {
    property int index: -1
    property alias iName: itemName.text
    property alias iQuantity: itemQuantity.text

    id: addWindow
    anchors.centerIn: parent
    width: root.width * 0.9
    height: root.height * 0.4
    padding: root.width * 0.02

    onClosed: {
        opacityAnim.from = 0.4
        opacityAnim.to = 1
        opacityAnim.start()
        itemName.text = "";
        itemQuantity.text = "";
    }

    onOpened: {
        opacityAnim.from = 1
        opacityAnim.to = 0.4
        opacityAnim.start()
    }

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

                    onAccepted: {
                        itemQuantity.forceActiveFocus()
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

                    onAccepted: {
                        acceptButton.accepted()
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
                    addWindow.close()
                }
            }

            RoundButton {
                id: acceptButton
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
                    acceptButton.accepted()
                }

                function accepted() {
                    if(itemName.length > 0) {
                        if(index === -1) {
                        listM.addItem(iName, iQuantity)
                        }
                        else {
                            listM.editItem(iName, iQuantity, index)
                        }
                        save();
                    }
                    index = -1
                    addWindow.close()
                }
            }
        }
    }
}
