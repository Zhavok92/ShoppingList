#ifndef CLIPBOARD_H
#define CLIPBOARD_H

#include <QObject>
#include <QClipboard>

class Clipboard : public QObject
{
    Q_OBJECT

public:
    explicit Clipboard(QObject *parent = nullptr);

    Q_INVOKABLE void setClipboard(const QString& itemList);
    Q_INVOKABLE QString getClipboard();

signals:

public slots:

private:
    QClipboard* clipboard;
};

#endif // CLIPBOARD_H
