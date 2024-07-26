#ifndef QML_CLIPBOARD_H_INCLUDED
#define QML_CLIPBOARD_H_INCLUDED

#include <QClipboard>
#include <QObject>

class QmlClipboard : public QObject {
    Q_OBJECT

public:
    explicit QmlClipboard(QObject* parent = nullptr);

    Q_INVOKABLE void setClipboard(const QString& itemList);
    Q_INVOKABLE QString getClipboard();

signals:

public slots:

private:
    QClipboard* clipboard;
};

#endif
