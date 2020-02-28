#ifndef OSCSERVER_H
#define OSCSERVER_H

#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "lo/lo.h"


class OSCServer
{
public:
    OSCServer(std::string port);
    ~OSCServer();
    int startServer();
    int quitServer();
private:
    static void error(int num, const char *msg, const char *path);
    static int generic_handler(const char *path, const char *types, lo_arg ** argv,
                        int argc, void *data, void *user_data);
    std::string port;
    lo_server_thread serverThread;
};

#endif // OSCSERVER_H
