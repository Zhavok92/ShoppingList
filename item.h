#ifndef ITEM_H
#define ITEM_H

#include <QObject>

class Item : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString itemName READ getItemName WRITE setItemName NOTIFY itemNameChanged)
    Q_PROPERTY(QString itemQuantity READ getItemQuantity WRITE setItemQuantity NOTIFY itemQuantityChanged)
public:
    explicit Item(QObject *parent = nullptr);
    QString getItemName() const;
    QString getItemQuantity() const;
    void setItemName(QString newItemName);
    void setItemQuantity(QString newItemQuantity);

signals:
    void itemNameChanged(QString newItemName);
    void itemQuantityChanged(QString newItemQuantity);

private:
    QString itemName;
    QString itemQuantity;
};

#endif // ITEM_H
