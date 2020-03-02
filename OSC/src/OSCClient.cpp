#include "OSCClient.h"

OSCClient::OSCClient()
{

}

OSCClient::OSCClient(std::string hostname, std::string port, std::string address)
{
    this->hostname = hostname;
    this->port = port;
    this->address = address;
}

void OSCClient::addMessageType(char messageType)
{
    this->messageTypesVector.push_back(messageType);
}

std::vector<char> OSCClient::getMessageTypesVector()
{
    return messageTypesVector;
}

void OSCClient::clearMessageVector()
{
    messageVector.clear();
}

void OSCClient::clearMessageTypesVector()
{
    messageTypesVector.clear();
}

void OSCClient::addMessage(std::string messageValue)
{
    this->messageVector.push_back(messageValue);
}

std::vector<std::string> OSCClient::getMessageVector()
{
    return messageVector;
}

void OSCClient::sendMessage()
{
    lo_address target;
    lo_message message;
    int ret;

    target = lo_address_new(hostname.c_str(), port.c_str());
    if (target == NULL) {
        fprintf(stderr, "Failed to open %s:%s\n", hostname.c_str(), port.c_str());
        exit(1);
    }

    message = create_message();
    if (message == NULL) {
        fprintf(stderr, "Failed to create OSC message.\n");
        exit(1);
    }

    lo_address_set_ttl(target, 1);

    ret = lo_send_message(target, address.c_str(), message);
    if (ret == -1) {
        fprintf(stderr, "An error occurred: %s\n",
                lo_address_errstr(target));
        lo_message_free(message);
        exit(1);
    }

    lo_message_free(message);
}

lo_message OSCClient::create_message()
{
    if (messageTypesVector.size() == 0 || messageVector.size() == 0)
    {
        return NULL;
    }

    if (messageTypesVector.size() != messageVector.size())
    {
        return NULL;
    }

    lo_message message;
    const char *arg;

    message = lo_message_new();

    arg = NULL;

    std::vector<char>::iterator iterTypes = messageTypesVector.begin();
    std::vector<std::string>::iterator iterMessages;
    for (iterMessages = messageVector.begin(); iterMessages != messageVector.end(); iterMessages++)
    {
        switch(*iterTypes) {
        case LO_INT32:
        case LO_FLOAT:
        case LO_STRING:
        case LO_BLOB:
        case LO_INT64:
        case LO_TIMETAG:
        case LO_DOUBLE:
        case LO_SYMBOL:
        case LO_CHAR:
        case LO_MIDI:
            arg = (*iterMessages).c_str();
            //arg = argv[argi].c_str();
            if (arg == NULL) {
                fprintf(stderr, "Value is not given.\n");
                goto EXIT;
            }
            break;
        default:
            break;
        }
        switch (*iterTypes) {
        case LO_INT32:
            {
                char *endp;
                int64_t v;

                v = strtol(arg, &endp, 10);
                if (*endp != '\0') {
                    fprintf(stderr, "An invalid value was given: '%s'\n", arg);
                    goto EXIT;
                }
                if ((v == LONG_MAX || v == LONG_MIN) && errno == ERANGE) {
                    fprintf(stderr, "Value out of range: '%s'\n", arg);
                    goto EXIT;
                }
                if (v > INT_MAX || v < INT_MIN) {
                    fprintf(stderr, "Value out of range: '%s'\n", arg);
                    goto EXIT;
                }
                lo_message_add_int32(message, (int32_t) v);
                iterTypes++;
                break;
            }
        case LO_INT64:
            {
                char *endp;
                int64_t v;

                v = strtoll(arg, &endp, 10);
                if (*endp != '\0') {
                    fprintf(stderr, "An invalid value was given: '%s'\n",
                            arg);
                    goto EXIT;
                }
                if ((v == LONG_MAX || v == LONG_MIN) && errno == ERANGE) {
                    fprintf(stderr, "Value out of range: '%s'\n", arg);
                    goto EXIT;
                }
                lo_message_add_int64(message, v);
                iterTypes++;
                break;
            }
        case LO_FLOAT:
            {
                char *endp;
                float v;

                v = strtof(arg, &endp);

                if (*endp != '\0') {
                    fprintf(stderr, "An invalid value was given: '%s'\n",
                            arg);
                    goto EXIT;
                }
                lo_message_add_float(message, v);
                iterTypes++;
                break;
            }
        case LO_DOUBLE:
            {
                char *endp;
                double v;

                v = strtod(arg, &endp);
                if (*endp != '\0') {
                    perror(NULL);
                    fprintf(stderr, "An invalid value was given: '%s'\n",
                            arg);
                    goto EXIT;
                }
                lo_message_add_double(message, v);
                iterTypes++;
                break;
            }
        case LO_STRING:
            lo_message_add_string(message, arg);
            iterTypes++;
            break;
        case LO_SYMBOL:
            lo_message_add_symbol(message, arg);
            iterTypes++;
            break;
        case LO_CHAR:
            lo_message_add_char(message, arg[0]);
            iterTypes++;
            break;
        case LO_MIDI:
            {
                unsigned int midi;
                uint8_t packet[4];
                int ret;

                ret = sscanf(arg, "%08x", &midi);
                if (ret != 1) {
                    fprintf(stderr,
                            "An invalid hexadecimal value was given: '%s'\n",
                            arg);
                    goto EXIT;
                }
                packet[0] = (midi >> 24) & 0xff;
                packet[1] = (midi >> 16) & 0xff;
                packet[2] = (midi >> 8) & 0xff;
                packet[3] = midi & 0xff;
                lo_message_add_midi(message, packet);
                iterTypes++;
                break;
            }
        case LO_TRUE:
            lo_message_add_true(message);
            break;
        case LO_FALSE:
            lo_message_add_false(message);
            break;
        case LO_NIL:
            lo_message_add_nil(message);
            break;
        case LO_INFINITUM:
            lo_message_add_infinitum(message);
            break;
        default:
            fprintf(stderr, "Type '%c' is not supported or invalid.\n",
                    *iterTypes);
            goto EXIT;
            break;
        }
    }

    return message;
  EXIT:
    lo_message_free(message);
    return NULL;
}
