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
#include <QDebug>
#include <QQuickView>
#include <QSettings>
#include <QQmlContext>
//#include <QtDeclarative>

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "lo/lo.h"
#include "OSCBinder.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    //OSCBinder oscbinder;
    //oscbinder.start();

    const QString mainQmlApp = QLatin1String("qrc:/main.qml");
    QQuickView view;
    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QQmlContext* context = view.engine()->rootContext();
    //context->setContextProperty("OSCBinder", QVariant::fromValue(&oscbinder));
    qmlRegisterType<OSCBinder>("People", 1, 0, "OSCBinder");

    view.setSource(QUrl(mainQmlApp));
    view.setResizeMode(QQuickView::SizeRootObjectToView);
    QObject::connect(view.engine(), SIGNAL(quit()), qApp, SLOT(quit()));

    view.show();
    
    QObject *object = view.rootObject();

    return app.exec();
}
