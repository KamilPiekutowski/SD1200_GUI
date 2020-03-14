#ifndef OSCBINDER_H
#define OSCBINDER_H

#include <QObject>
#include <QSettings>
#include <QDebug>
#include <QQuickItem>
#include <QVector>
#include <QThread>

#include "OSCClient.h"
#include "OSCServer.h"

class OSCBinder : public QObject
{

    Q_OBJECT
public: //methods
    explicit OSCBinder(QObject *parent = nullptr);

    Q_INVOKABLE QVector<QString> getListOfFX();
    Q_INVOKABLE void sendQMLGuiCtrl(QString x, QString y, QChar activate);
    Q_INVOKABLE void sendQMLGuiSetSynthDef(QString synthdefName);

    void timerEvent(QTimerEvent *e) {
      if(oscs.get__DONE__())
      {
        killTimer(timerId);
        fxList = oscs.getListOfFX();
        emit fxListReceived(fxList);
      }
      else
      {
         //make another request
         requestListOfFX();
      }
      qDebug() << "Timer Event";
     }
private: //methods
    void run();
    void requestListOfFX();
private: //members
    OSCServer oscs;
    QVector<QString> fxList;
    int timerId;
public: //methods
signals:
void fxListReceived(QVector<QString>  fxList);
public slots:

};

#endif // OSCBINDER_H
