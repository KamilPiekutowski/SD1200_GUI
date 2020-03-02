#ifndef OSCSERVER_H
#define OSCSERVER_H

#include <QVector>
#include <QString>

#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "lo/lo.h"


class OSCServer
{
public: //methods
    OSCServer(std::string port);
    ~OSCServer();
    int startServer();
    int quitServer();
    int get__DONE__(); //this allows to check if SClang stopped sending messages
    int set__DONE__(int val);
    QVector<QString>  getListOfFX();
private: //methods
    static void error(int num, const char *msg, const char *path);
    static int generic_handler(const char *path, const char *types, lo_arg ** argv,
                        int argc, void *data, void *user_data);
    static int done_handler(const char *path, const char *types, lo_arg ** argv,
                     int argc, void *data, void *user_data);
    static int receive_FX_list_handler(const char *path, const char *types, lo_arg ** argv,
                        int argc, void *data, void *user_data);
    std::string port;
    lo_server_thread serverThread;
public: //members
private: //memebrs
    static int __DONE__;
    static QVector<QString> listOfFX;
};

#endif // OSCSERVER_H
