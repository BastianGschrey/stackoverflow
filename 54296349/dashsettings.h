// Load and saving dash configurations

#ifndef DASHSETTINGS_H
#define DASHSETTINGS_H

#include <QObject>

class dashsettings : public QObject
{
    Q_OBJECT
public:

    dashsettings(QObject *parent = nullptr);

    static QStringList readavailabledashfiles();
    static Q_INVOKABLE QStringList readDashConfig(QString);
    static Q_INVOKABLE void writeDashConfig(QStringList);

};

#endif // DASHSETTINGS_H
