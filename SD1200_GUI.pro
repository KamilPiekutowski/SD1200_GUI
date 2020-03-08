QT += quick

CONFIG += c++11

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Refer to the documentation for the
# deprecated API to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        OSC/src/OSCBinder.cpp \
        OSC/src/OSCClient.cpp \
        OSC/src/OSCServer.cpp \
        main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /home/pi/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../usr/local/lib/release/ -llo
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../usr/local/lib/debug/ -llo
#else:unix: LIBS += -L$$PWD/../../../usr/local/lib/ -llo

#INCLUDEPATH += $$PWD/../../../usr/local/include
INCLUDEPATH += $$PWD/OSC/inc

#DEPENDPATH += $$PWD/../../../usr/local/include

HEADERS += \
    OSC/inc/OSCBinder.h \
    OSC/inc/OSCClient.h \
    OSC/inc/OSCServer.h \
    OSCClient.h \
    OSCServer.h

#win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../../usr/local/lib/release/ -llo
#else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../../usr/local/lib/debug/ -llo
#else:unix: LIBS += -L$$PWD/../../../../usr/local/lib/ -llo

#INCLUDEPATH += $$PWD/../../../../usr/local/include
#DEPENDPATH += $$PWD/../../../../usr/local/include

DISTFILES +=

linux-rasp-pi-g++: LIBS += -L$$PWD/../../raspi/sysroot/usr/local/lib/ -llo
else:unix: LIBS += -L$$PWD/../../../../usr/local/lib/ -llo

INCLUDEPATH += $$PWD/../../raspi/sysroot/usr/local/include
DEPENDPATH += $$PWD/../../raspi/sysroot/usr/local/include
