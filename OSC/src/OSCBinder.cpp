#include "OSCBinder.h"

OSCBinder::OSCBinder(QObject *parent) : QObject(parent) , oscs("7770")
{
   oscs.startServer();
}

QVector<QString> OSCBinder::getListOfFX()
{
    oscs.set__DONE__(0); // this allows to receive message unti sclang is done sending
    requestListOfFX();
    QVector<QString> items = oscs.getListOfFX();

    return  items;
}

void OSCBinder::requestListOfFX()
{
    /**********  sending message to sclang **********/
    OSCClient oscclient("127.0.0.1", "57120", "/get_fx_list");

    oscclient.addMessageType('s');
    oscclient.addMessage("");
    oscclient.sendMessage();

    /**********  setup server and listen for __DONE__ message **********/
    waitFor__DONE__Message();
}

void OSCBinder::waitFor__DONE__Message()
{
    while (!oscs.get__DONE__()) {
        usleep(50);
    }
}
