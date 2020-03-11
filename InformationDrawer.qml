import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
import QtQuick.Controls.Material 2.12

Drawer {
    property real fontSize: root.width * 0.03
    property string fontFamily: "Serif"
    id: drawer
    width: parent.width * 0.75
    height: parent.height
    background: Rectangle {
        color: "#f5f5f0"
    }

    ColumnLayout {
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.04
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.8
        height: parent.height * 0.2

        Label {
            text: "Developed by: Marcel Schmidt"
            font {
                family: fontFamily
                pointSize: fontSize
            }
            wrapMode: Label.Wrap
        }

        Label {
            text: "Version: 1.1"
            font {
                family: fontFamily
                pointSize: fontSize
            }
            wrapMode: Label.Wrap
        }

        Label {
            Text {
                text: "Sourcecode available at <a href='https://github.com/Zhavok92/ShoppingList'>GitHub</a>"
                onLinkActivated: Qt.openUrlExternally(link)
                font {
                    family: fontFamily
                    pointSize: fontSize
                }
            }
            wrapMode: Label.Wrap
        }

        Label {
            Text {
                text: "Icons by <a href='https://www.iconfinder.com'>IconFinder</a>"
                onLinkActivated: Qt.openUrlExternally(link)
                font {
                    family: fontFamily
                    pointSize: fontSize
                }
            }
            wrapMode: Label.Wrap
        }

        Label {
            Text {
                text: "Backgounds by <a href='https://pixabay.com'>Pixabay</a> and <a href='https://www.pexels.com'>Pexels</a>"
                onLinkActivated: Qt.openUrlExternally(link)
                font {
                    family: fontFamily
                    pointSize: fontSize
                }
            }
            wrapMode: Label.Wrap
        }

        ToolSeparator {
            Layout.fillWidth: true
            orientation: Qt.Horizontal
        }

        Button {
            Layout.fillWidth: true
            text: "Einkaufsliste kopieren"
            font {
                family: fontFamily
                pointSize: fontSize
            }
            Material.background: Material.Cyan
        }

        Button {
            Layout.fillWidth: true
            text: "Einkaufsliste einfügen"
            font {
                family: fontFamily
                pointSize: fontSize
            }
            Material.background: Material.Cyan
        }
    }
}