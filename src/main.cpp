#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include "listmodel.h"
#include "clipboard.h"

int main(int argc, char *argv[]) {
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    app.setOrganizationName("E-Ware");
    app.setOrganizationDomain("example.com");
    app.setApplicationName("ShoppingList");

    QQuickStyle::setStyle("Material");

    ListModel model;
    Clipboard clipboard;

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("listM", &model);
    engine.rootContext()->setContextProperty("clipboard", &clipboard);

    const QUrl url(QStringLiteral("qrc:/qml/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
