#ifndef QML_ITEM_H_INCLUDED
#define QML_ITEM_H_INCLUDED

#include <QObject>

class QmlItem : public QObject {
    Q_OBJECT

    Q_PROPERTY(QString name READ getName WRITE setName NOTIFY nameChanged)
    Q_PROPERTY(QString quantity READ getQuantity WRITE setQuantity NOTIFY quantityChanged)
public:
    explicit QmlItem(QObject* parent = nullptr);
    QString getName() const;
    QString getQuantity() const;
    void setName(QString newName);
    void setQuantity(QString newQuantity);

signals:
    void nameChanged(QString newName);
    void quantityChanged(QString newQuantity);

private:
    QString name;
    QString quantity;
};

#endif
