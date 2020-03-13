#include "clipboard.h"

Clipboard::Clipboard(QObject *parent) : QObject(parent) {

}

void Clipboard::setClipboard(const QString& itemList) {
    clipboard->setText(itemList, QClipboard::Clipboard);
}

QString Clipboard::getClipboard() {
    return clipboard->text();
}
