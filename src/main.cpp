#include <QtGui/qguiapplication.h>
#include <QtQml/qqmlapplicationengine.h>
#include <QQmlContext>
#include <QQuickStyle>
#include "gui/QmlClipboard.h"
#include "gui/models/listmodel.h"

int main(int argc, char* argv[]) {
    QGuiApplication app(argc, argv);
    QGuiApplication::setOrganizationName("CypeTech");
    QGuiApplication::setApplicationName("ShoppingList");

    QQuickStyle::setStyle("Material");

    ListModel model;
    QmlClipboard qmlClipboard;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("listM", &model);
    engine.rootContext()->setContextProperty("qmlClipboard", &qmlClipboard);

    engine.loadFromModule("ShoppingList.Gui", "Main");
    if(engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}