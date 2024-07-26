#ifndef LISTMODEL_H
#define LISTMODEL_H

#include <QAbstractListModel>
#include "../QmlItem.h"

class ListModel : public QAbstractListModel {
    Q_OBJECT

    enum ListModelRoles { NamesRole = Qt::UserRole + 1, QuantityRole };

public:
    explicit ListModel(QObject* parent = nullptr);
    int rowCount(const QModelIndex& parent = QModelIndex()) const;
    QVariant data(const QModelIndex& index, int role) const;
    bool setData(const QModelIndex& index, const QVariant& value, int role);
    Qt::ItemFlags flags(const QModelIndex& index) const;
    QHash<int, QByteArray> roleNames() const;

    Q_INVOKABLE void addItem(const QString& itemName, const QString& itemQuantity);
    Q_INVOKABLE void removeItem(const int index);
    Q_INVOKABLE void editItem(const QString& newItemName, const QString& newItemQuantity, int index);
    Q_INVOKABLE void clear();
    Q_INVOKABLE int count();
    Q_INVOKABLE QString getItemsAsJson();
    Q_INVOKABLE void setItemsByJson(QString jsonStr);

signals:

public slots:

private:
    QList<QmlItem*> list;
};

#endif
