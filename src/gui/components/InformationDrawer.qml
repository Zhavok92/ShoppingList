import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Controls.Material

Drawer {
    id: drawer
    property real fontSize: root.width * 0.03
    property string fontFamily: "Serif"
    width: parent.width * 0.75
    height: parent.height
    background: Rectangle {
        color: "#f5f5f0"
    }

    Image {
        id: background
        source: "../resources/images/drawerBackground.png"
        width: drawer.width
        height: drawer.height * 0.3
    }

    ColumnLayout {
        anchors.top: background.bottom
        anchors.topMargin: parent.height * 0.04
        anchors.horizontalCenter: parent.horizontalCenter
        width: parent.width * 0.8
        height: parent.height * 0.2

        Button {
            Layout.fillWidth: true
            text: "Einkaufsliste kopieren"
            font {
                family: fontFamily
                pointSize: fontSize
                capitalization: Font.MixedCase
            }
            Material.background: Material.Cyan
            onClicked: {
                qmlClipboard.setClipboard(listM.getItemsAsJson());
            }
        }

        Button {
            Layout.fillWidth: true
            text: "Einkaufsliste einfügen"
            font {
                family: fontFamily
                pointSize: fontSize
                capitalization: Font.MixedCase
            }
            Material.background: Material.Cyan
            onClicked: {
                listM.setItemsByJson(qmlClipboard.getClipboard());
                save();
            }
        }

        ToolSeparator {
            Layout.fillWidth: true
            orientation: Qt.Horizontal
        }

        Label {
            text: "Developed by: Marcel Schmidt"
            font {
                family: fontFamily
                pointSize: fontSize
            }
            wrapMode: Label.Wrap
        }

        Label {
            text: "Version: " + root.version
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
                text: "Backgrounds by <a href='https://pixabay.com'>Pixabay</a>"
                onLinkActivated: Qt.openUrlExternally(link)
                font {
                    family: fontFamily
                    pointSize: fontSize
                }
            }
            wrapMode: Label.Wrap
        }
    }
}
