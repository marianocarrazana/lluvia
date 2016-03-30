#ifndef NEVADA_H
#define NEVADA_H
#include <QObject>

class nevada : public QObject
{
    Q_OBJECT
public:
    explicit nevada(QObject *parent = 0);
    Q_INVOKABLE QString OS();

};

#endif // NEVADA_H
