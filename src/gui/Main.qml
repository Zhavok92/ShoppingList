import QtQuick
import QtQuick.Controls
import ShoppingList.Gui as ShoppingList

ApplicationWindow {
    id: root

    property string version: "v2.0.0"

    width: 420
    height: 760
    visible: true
    title: "ShoppingList"

    Material.theme: Material.Normal

    ShoppingList.Home {
        id: home
    }
}
