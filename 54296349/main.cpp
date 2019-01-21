#include "connectudp.h"
#include "datasourceobject.h"
#include "dashsettings.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QDebug>

int main(int argc, char *argv[])
{

    QStringList gaugelist;

    //QStringList configfiles = dashsettings::readavailabledashfiles();
    for(const QString &filename : dashsettings::readavailabledashfiles())
    {
        gaugelist.append(dashsettings::readDashConfig(filename));
    }

    /*init of GUI*/
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    qmlRegisterType<ConnectUdp>("com.powertune", 2, 0, "ConnectUdpObject");
    qmlRegisterType<dashsettings>("com.powertune", 2, 0, "DashSettingsObject");

    QGuiApplication app(argc, argv);
    app.setOrganizationName("Power-Tune");
    app.setOrganizationDomain("power-tune.org");
    app.setApplicationName("PowerTune 2");

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("ConnectUdp", new ConnectUdp(&engine));
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;
    return app.exec();
}
