#include "OSCBinder.h"
#include <QDebug>

OSCBinder::OSCBinder(QObject *parent) : QObject(parent) , oscs("7770")
{
   oscs.startServer();
   oscs.set__DONE__(0); // this allows to receive message unti sclang is done sending
   requestListOfFX();
   timerId = startTimer(500);
}

QVector<QString> OSCBinder::getListOfFX()
{
    oscs.set__DONE__(0); // this allows to receive message unti sclang is done sending
    requestListOfFX();
    QVector<QString> items = oscs.getListOfFX();
    return  items;
}

void OSCBinder::sendQMLGuiCtrl(QString x, QString y, QChar activate)
{
    char a =  (char) activate.toLatin1();
    OSCClient oscclient("127.0.0.1", "57120", "/qml_gui_ctrl");

    oscclient.addMessageType('f');
    oscclient.addMessage(x.toStdString());
    oscclient.addMessageType('f');
    oscclient.addMessage(y.toStdString());
    oscclient.addMessageType(a);
    oscclient.addMessage("");

    oscclient.sendMessage();

}

void OSCBinder::run()
{
    getListOfFX();
}

void OSCBinder::requestListOfFX()
{
    /**********         sending message to sclang            **********/
    OSCClient oscclient("127.0.0.1", "57120", "/get_fx_list");

    oscclient.addMessageType('s');
    oscclient.addMessage("");
    oscclient.sendMessage();

    qDebug() << "Retrieved FX list from OSC";
}
