#include "QmlClipboard.h"

QmlClipboard::QmlClipboard(QObject* parent) : QObject(parent) {}

void QmlClipboard::setClipboard(const QString& itemList) {
    clipboard->setText(itemList, QClipboard::Clipboard);
}

QString QmlClipboard::getClipboard() {
    return clipboard->text();
}
