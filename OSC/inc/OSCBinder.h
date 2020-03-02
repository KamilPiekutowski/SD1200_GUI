#ifndef OSCBINDER_H
#define OSCBINDER_H

#include <QObject>
#include <QSettings>
#include <QDebug>
#include <QQuickItem>
#include <QVector>

#include "OSCClient.h"
#include "OSCServer.h"

class OSCBinder : public QObject
{
    Q_OBJECT
public: //methods
    explicit OSCBinder(QObject *parent = nullptr);

    Q_INVOKABLE QVector<QString> getListOfFX();
private: //methods
    void requestListOfFX();
    void waitFor__DONE__Message(); //End Of List Message "__EOL__"
public: //members
    OSCServer oscs;
public: //methods
signals:

public slots:

};

#endif // OSCBINDER_H
