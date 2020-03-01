#include "OSCBinder.h"

OSCBinder::OSCBinder(QObject *parent) : QObject(parent)
{

}

void OSCBinder::test()
{
    qDebug() << "Hello from C++";
}
