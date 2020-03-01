#ifndef OSCBINDER_H
#define OSCBINDER_H

#include <QObject>
#include <QSettings>
#include <QDebug>
#include <QQuickItem>

class OSCBinder : public QObject
{
    Q_OBJECT
public:
    explicit OSCBinder(QObject *parent = nullptr);

    Q_INVOKABLE void test();

signals:

public slots:

};

#endif // OSCBINDER_H
