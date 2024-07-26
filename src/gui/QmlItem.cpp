#include "QmlItem.h"

QmlItem::QmlItem(QObject* parent) : QObject(parent) {}

QString QmlItem::getName() const {
    return name;
}

QString QmlItem::getQuantity() const {
    return quantity;
}

void QmlItem::setName(QString newName) {
    if(newName == name) {
        return;
    }
    name = newName;
    emit nameChanged(name);
}

void QmlItem::setQuantity(QString newQuantity) {
    if(newQuantity == quantity) {
        return;
    }
    quantity = newQuantity;
    emit quantityChanged(quantity);
}
