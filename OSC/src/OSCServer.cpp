#include "OSCServer.h"
#include <QString>

int OSCServer::__DONE__;
QVector<QString> OSCServer::listOfFX;

OSCServer::OSCServer(std::string port)
{
    this->port = port;
    serverThread = NULL;
    __DONE__ = 1;
}

OSCServer::~OSCServer()
{
    lo_server_thread_free(serverThread);
}

int OSCServer::startServer()
{
    /* start a new server on port 7770 */
    lo_server_thread serverThread = lo_server_thread_new(port.c_str(), error);

    /* add method that will match any path and args */
    lo_server_thread_add_method(serverThread, NULL, NULL, generic_handler, NULL);

    /* add method that will match the path /foo/bar, with two numbers, coerced
     * to float and int */
    //lo_server_thread_add_method(st, "/foo/bar", "fi", foo_handler, NULL);

    /* add method that will match the path /blobtest with one blob arg */
    lo_server_thread_add_method(serverThread, "/fx_list", "s", receive_FX_list_handler, NULL);

    /* add method that will match the path /quit with no args */
    lo_server_thread_add_method(serverThread, "/done", "", done_handler, NULL);

    lo_server_thread_start(serverThread);

    return 0;
}

int OSCServer::get__DONE__()
{
    return __DONE__;
}

int OSCServer::set__DONE__(int val)
{
    __DONE__ = val;
}

QVector<QString>  OSCServer::getListOfFX()
{
    return listOfFX;
}

void OSCServer::error(int num, const char *msg, const char *path)
{
    printf("liblo server error %d in path %s: %s\n", num, path, msg);
    fflush(stdout);
}

int OSCServer::generic_handler(const char *path, const char *types, lo_arg **argv, int argc, void *data, void *user_data)
{
    int i;

    printf("path: <%s>\n", path);
    for (i = 0; i < argc; i++) {
        printf("arg %d '%c' ", i, types[i]);
        lo_arg_pp((lo_type)types[i], argv[i]);
        printf("\n");
    }
    printf("\n");
    fflush(stdout);

    return 1;
}

int OSCServer::done_handler(const char *path, const char *types, lo_arg **argv, int argc, void *data, void *user_data)
{
    __DONE__ = 1;
    printf("quiting\n\n");
    fflush(stdout);

    return 0;
}

int OSCServer::receive_FX_list_handler(const char *path, const char *types, lo_arg **argv, int argc, void *data, void *user_data)
{
    if(argc)
    {
        listOfFX.push_back((char*) argv[0]);
    }
}
