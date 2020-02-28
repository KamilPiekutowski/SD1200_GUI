/*
 * oscsend - Send OpenSound Control message.
 *
 * Copyright (C) 2008 Kentaro Fukuchi <kentaro@fukuchi.org>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as
 * published by the Free Software Foundation; either version 2.1 of the
 * License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program; if not, write to the Free Software Foundation,
 * Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * TODO:
 * - support binary blob.
 * - support TimeTag.
 * - receive replies.
 */

#include "OSCClient.h"
#include "OSCServer.h"
#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "lo/lo.h"

int main(int argc, char *argv[])
{
    OSCServer oscs("7770");
    oscs.startServer();

    //hostname port address types values
    std::string args[6];
    args[0] = argv[0];
    args[1] = "127.0.0.1";
    args[2] =  "57120";
    args[3] = "/main/button";
    args[4] = "s";
    args[5] = "hello from Qt";

    OSCClient oscclient(args[1], args[2], args[3]);

    oscclient.addMessageType(args[4][0]);
    oscclient.addMessageType(args[4][0]);
    oscclient.addMessage(args[5]);
    oscclient.addMessage("testing multiple messages");
    oscclient.sendMessage();

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
