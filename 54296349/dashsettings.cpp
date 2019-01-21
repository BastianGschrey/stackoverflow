// Load and saving dash configurations


#include "dashsettings.h"

#include <QDir>
#include <QFile>
#include <QIODevice>
#include <QTextStream>

dashsettings::dashsettings(QObject *parent) : QObject(parent)
{

}

QStringList dashsettings::readavailabledashfiles()
{
    QDir directory(""); //for Windows
    //QDir directory("/home/pi/UserDashboards");
    QStringList dashfiles = directory.entryList(QStringList() << "*.txt",QDir::Files);
    return dashfiles;
}


QStringList dashsettings::readDashConfig(QString filename)
{
    QFile file(filename);
    QStringList gauge;
    QStringList gaugelist;

    if (file.open(QIODevice::ReadOnly))
    {
        QTextStream in(&file);
        while (!in.atEnd())
        {
            QString line = in.readLine();
            //gauge.append(line.split(QRegExp("\\,")));

            gaugelist.append(line);
        }
    }
return gaugelist;
}

void dashsettings::writeDashConfig(QStringList gaugeList)
{
    QString filename = "dashconfig.txt";
    QFile file(filename);
    if(file.open(QIODevice::ReadWrite | QIODevice::Truncate | QIODevice::Text))
    {
        QTextStream stream (&file);
        for(const QString &gauge : gaugeList)
        stream << gauge << endl;
    }

}
