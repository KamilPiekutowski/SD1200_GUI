#ifndef OSCCLIENT_H
#define OSCCLIENT_H

#include <iostream>
#include <vector>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>
#include <ctype.h>
#include <errno.h>
#include <limits.h>
#include <lo/lo.h>

class OSCClient
{
public:
    OSCClient();
    OSCClient(std::string hostname, std::string port, std::string address);

    //methods
    void addMessageType(char messageType);
    std::vector<char> getMessageTypesVector();
    void addMessage(std::string messageValue);
    std::vector<std::string> getMessageVector();
    void clearMessageTypesVector();
    void clearMessageVector();
    void sendMessage();

    //members
    std::string hostname;
    std::string port;
    std::string address;
    std::vector<char> messageTypesVector;
    std::vector<std::string> messageVector;
private:
    lo_message create_message();
};

#endif // OSCCLIENT_H
