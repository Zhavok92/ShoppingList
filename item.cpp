#include "item.h"

Item::Item(QObject *parent) : QObject(parent) {}

QString Item::getItemName() const {
    return itemName;
}

QString Item::getItemQuantity() const {
    return itemQuantity;
}

void Item::setItemName(QString newItemName) {
    if(newItemName == itemName) {
        return;
    }
    itemName = newItemName;
    emit itemNameChanged(itemName);
}

void Item::setItemQuantity(QString newItemQuantity) {
    if(newItemQuantity == itemQuantity) {
        return;
    }
    itemQuantity = newItemQuantity;
    emit itemQuantityChanged(itemQuantity);
}
