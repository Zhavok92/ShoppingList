import QtCore
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Popup {
    id: addWindow

    property int index: -1
    property alias iName: itemName.text
    property alias iQuantity: itemQuantity.text

    anchors.centerIn: parent
    width: root.width * 0.9
    height: root.height * 0.4
    padding: root.width * 0.02

    onClosed: {
        opacityAnim.from = 0.4;
        opacityAnim.to = 1;
        opacityAnim.start();
        itemName.text = "";
        itemQuantity.text = "";
    }

    onOpened: {
        opacityAnim.from = 1;
        opacityAnim.to = 0.4;
        opacityAnim.start();
    }

    Image {
        source: "../resources/images/addBackground.png"
        anchors.fill: parent
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: addWindow.width * 0.05

        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            color: "white"
            radius: addWindow.height * 0.02
            opacity: 0.8

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: addWindow.width * 0.05

                TextField {
                    id: itemName
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: "Artikel"
                    font {
                        family: "Serif"
                        pointSize: addWindow.height * 0.05
                        italic: true
                    }

                    onAccepted: {
                        itemQuantity.forceActiveFocus();
                    }
                }

                TextField {
                    id: itemQuantity
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    placeholderText: "Menge"
                    font {
                        family: "Serif"
                        pointSize: addWindow.height * 0.05
                        italic: true
                    }

                    onAccepted: {
                        acceptButton.accepted();
                    }
                }
            }
        }

        RowLayout {
            Layout.alignment: Qt.AlignHCenter
            spacing: addWindow.width * 0.4

            RoundButton {
                Material.background: Material.white

                Layout.preferredWidth: addWindow.height * 0.25
                Layout.preferredHeight: addWindow.height * 0.25

                Image {
                    anchors.centerIn: parent
                    width: parent.width * 0.5
                    height: parent.height * 0.5
                    source: "../resources/images/decline.png"
                }

                onClicked: {
                    addWindow.close();
                }
            }

            RoundButton {
                id: acceptButton
                Material.background: Material.white
                Layout.preferredWidth: addWindow.height * 0.25
                Layout.preferredHeight: addWindow.height * 0.25

                Image {
                    anchors.centerIn: parent
                    width: parent.width * 0.5
                    height: parent.height * 0.5
                    source: "../resources/images/accept.png"
                }

                onClicked: {
                    acceptButton.accepted();
                }

                function accepted() {
                    if (itemName.length > 0) {
                        if (index === -1) {
                            listM.addItem(iName, iQuantity);
                        } else {
                            listM.editItem(iName, iQuantity, index);
                        }
                        save();
                    }
                    index = -1;
                    addWindow.close();
                }
            }
        }
    }
}
