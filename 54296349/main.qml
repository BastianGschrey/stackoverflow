import QtQuick 2.8
import QtQuick.Controls 2.3
import QtQuick.Window 2.2
import com.powertune 2.0
import QtQuick.Extras 1.4
import QtQml.Models 2.3
import Qt.labs.settings 1.0
import "qrc:/qml/gauges/createSquareGaugeScript.js" as CreateSquareGaugeScript


ApplicationWindow  {
    id: mainwindow
    visible: true
    width: 800
    height: 480
    minimumWidth: 800
    minimumHeight: 480
    title: qsTr("PowerTune 2.0")
    color: "black"
    Component.onCompleted: {


    }


    MouseArea {
        id: touchArea
        anchors.fill: parent


        Timer {
            id: pressAndHoldTimer
            interval: 1000
            onTriggered:
            {
                cbx_sources.visible = true;
                btnadd.visible = true;
                btncancel.visible = true
                btnsave.visible = true
            }
        }
        onPressed: pressAndHoldTimer.start()
        onReleased: pressAndHoldTimer.stop()
    }

    ComboBox {
        id: cbx_sources
        x: 600
        y: 0
        textRole: "name"
        width: 200;
        model: dataSourceModel
        Component.onCompleted: currentIndex = 1
        visible: false

    }
    Button {
        id: btnadd
        x: 600
        y: 46
        width: 80
        height: 40
        text: qsTr("Add")
        highlighted: false
        checkable: false
        autoExclusive: false
        checked: false
        visible: false
        onClicked: {
            CreateSquareGaugeScript.createSquareGauge(300,200,0,0,0,
                                                             dataSourceModel.data(dataSourceModel.index(cbx_sources.currentIndex,0),258),
                                                             dataSourceModel.data(dataSourceModel.index(cbx_sources.currentIndex,0),257),
                                                             true,false,false,
                                                             cbx_sources.currentIndex,
                                                             cbx_sources.currentIndex,
                                                             5000,-2000,"transparent","transparent","transparent","grey","white","blue");
            cbx_sources.visible = false;
            btnadd.visible = false;
            btncancel.visible = false;
            btnsave.visible = false;
        }
    }

    Button {
        id: btncancel
        x: 720
        y: 46
        width: 80
        text: "Cancel"
        visible: false
        onClicked:  {
            btnadd.visible = false
            btncancel.visible = false
            cbx_sources.visible = false
            btnsave.verticalCenter = false
        }
    }

    Button {
            id: btnsave
            x: 600
            y: 99
            width: 80
            text: qsTr("Save Dashboard")
            visible: false
        }


}

