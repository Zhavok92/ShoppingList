#include "listmodel.h"
#include <QJsonObject>
#include <QJsonDocument>
#include <QJsonArray>
#include <QDebug>

ListModel::ListModel(QObject *parent) : QAbstractListModel(parent)
{

}

int ListModel::rowCount(const QModelIndex &parent) const {
    Q_UNUSED(parent)
    return list.size();
}

QVariant ListModel::data(const QModelIndex &index, int role) const {
    if(index.row() < 0 || index.row() >= list.count()) {
        return QVariant();
    }

    Item* listObj = list[index.row()];
    if(role == NamesRole) {

        return listObj->getItemName();
    }
    if(role == QuantityRole) {
        return listObj->getItemQuantity();
    }

    return QVariant();
}

bool ListModel::setData(const QModelIndex &index, const QVariant &value, int role) {
    Item* listObj = list[index.row()];
    bool somethingChanged = false;

    switch (role) {
    case NamesRole: {
        if(listObj->getItemName()!=value.toString()) {
            listObj->setItemName(value.toString());
            somethingChanged = true;
        }
        break;
    }
    case QuantityRole: {
        if(listObj->getItemQuantity()!=value.toString())
            listObj->setItemQuantity(value.toString());
        }
        somethingChanged = true;
        break;
    }

    if(somethingChanged) {
        emit dataChanged(index,index,QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags ListModel::flags(const QModelIndex &index) const {
    if(!index.isValid()) {
        return Qt::NoItemFlags;
    }
    return Qt::ItemIsEditable;
}

QHash<int, QByteArray> ListModel::roleNames() const {
    QHash<int, QByteArray> roles;
    roles[NamesRole] = "name";
    roles[QuantityRole] = "quantity";
    return roles;
}

void ListModel::addItem(const QString& itemName, const QString& itemQuantity) {
    const int index = list.size();
    beginInsertRows(QModelIndex(), index, index);
    Item* newListObj = new Item;
    newListObj->setItemName(itemName);
    newListObj->setItemQuantity(itemQuantity);
    list.append(newListObj);
    endInsertRows();
}

void ListModel::removeItem(const int index) {
    beginRemoveRows(QModelIndex(), index, index);
    list.removeAt(index);
    endRemoveRows();
}

void ListModel::editItem(const QString& newItemName, const QString& newItemQuantity, int index) {
    list.at(index)->setItemName(newItemName);
    list.at(index)->setItemQuantity(newItemQuantity);
    emit dataChanged(this->index(index,0),this->index(index,0));
}

void ListModel::clear() {
    list.clear();
}

int ListModel::count() {
    return list.size();
}

QString ListModel::getItemsAsJson() {
    QJsonArray jsonArr;
    for(int i = 0; i < list.size(); ++i) {
        QJsonObject json;
        json.insert("name", list.at(i)->getItemName());
        json.insert("quantity", list.at(i)->getItemQuantity());
        jsonArr.append(json);
    }
    QJsonDocument doc(jsonArr);
    return doc.toJson(QJsonDocument::Compact);
}

void ListModel::setItemsByJson(QString jsonStr) {
    QJsonDocument doc = QJsonDocument::fromJson(jsonStr.toUtf8());
    QJsonArray jsonArr = doc.array();
    foreach(const QJsonValue val, jsonArr) {
        addItem(val["name"].toString(), val["quantity"].toString());
        qDebug() << "Loaded Item:" << val["name"].toString() << "[" << val["quantity"].toString() << "]";
    }
}

void ListModel::move(int sourceIndex, int destinationIndex) {
    list.move(sourceIndex, destinationIndex);
}
