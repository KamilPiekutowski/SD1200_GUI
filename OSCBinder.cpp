#include "OSCBinder.h"

OSCBinder::OSCBinder(QObject *parent) : QObject(parent)
{

}

void OSCBinder::Test()
{
    qDebug() << "Hello from C++";
}
