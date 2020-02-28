#include "OSCServer.h"

OSCServer::OSCServer(std::string port)
{
    this->port = port;
    serverThread = NULL;
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
    //lo_server_thread_add_method(st, "/blobtest", "b", blobtest_handler, NULL);

    /* add method that will match the path /quit with no args */
    //lo_server_thread_add_method(st, "/quit", "", quit_handler, NULL);

    lo_server_thread_start(serverThread);

    return 0;
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
