import QtQuick 2.8
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Controls 2.3
Rectangle {
    id: gauge
    width: 250
    height: 200
    color: "black"
    property alias mainvalueunittextfield: mainvalueunittextfield
    property alias title: gaugetextfield.text
    property alias mainunit: mainvalueunittextfield.text
    property alias vertgaugevisible: vertgauge.visible
    property alias horigaugevisible: horizgauge.visible
    property alias secvaluevisible: secondaryvaluetextfield.visible
    property alias maintextvalue: mainvaluetextfield.text
    property var mainvalue
    property var secvalue
    property int maxvalue
    property int warnvaluehigh: 20000
    property int warnvaluelow : -20000

    Drag.active: true

    MouseArea {
        id: touchArea
        anchors.fill: parent

        drag.target: parent

        Timer {
            id: pressAndHoldTimer
            interval: 1000
            onTriggered: popupmenu.popup(touchArea.mouseX, touchArea.mouseY);

        }
        onPressed: pressAndHoldTimer.start()
        onReleased: pressAndHoldTimer.stop();
    }




    Rectangle {
        id: titlebar
        width: parent.width - 4
        //height: (parent.height) * 0.2
        height: 30
        anchors.top : parent.top
        anchors.left: parent.left
        color: "#9f9f9f"
        clip: false
        visible: true
        anchors.topMargin: 2
        anchors.leftMargin: 2
        SequentialAnimation {
            id: anim
            loops: Animation.Infinite
            running: false
            PropertyAnimation {
                target: titlebar
                property: "color"
                from: "darkred"
                to: "red"
                duration: 500
            }
            PropertyAnimation {
                target: titlebar
                property: "color"
                from: "red"
                to: "darkred"
                duration: 500
            }
        }
        SequentialAnimation {
            id: anim2
            loops: Animation.Infinite
            running: false
            PropertyAnimation {
                target: gauge
                property: "color"
                from: "darkred"
                to: "red"
                duration: 500
            }
            PropertyAnimation {
                target: gauge
                property: "color"
                from: "red"
                to: "darkred"
                duration: 500
            }
        }

        Text {
            id: gaugetextfield
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 23
            font.bold: true
            font.family: "Eurostile"
            color: "white"

        }
    }

    Text {
        id: mainvaluetextfield
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        font.pixelSize: gauge.height/3
        font.family: "Eurostile"
        color: "white"
        onTextChanged: warningindication.warn()
        text: "0"
        Timer {
            interval: 16; running: true; repeat: true
            onTriggered: parent.text = dataSourceModel.data(dataSourceModel.index(mainvalue,0),259)
        }
    }

    Text {
        id: mainvalueunittextfield
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.verticalCenter: parent.verticalCenter

        font.pixelSize: gauge.height/10
        font.family: "Eurostile"
        font.bold: true
        color: "white"
    }


    Text {
        id: secondaryvaluetextfield
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        height: parent.height * 0.2
        font.pixelSize: 28
        font.family: "Eurostile"
        color: "white"
        text: "0"
        Timer {
            interval: 16; running: true; repeat: true
            onTriggered: parent.text = dataSourceModel.data(dataSourceModel.index(secvalue,0),259)
        }

    }

    Gauge {
        id: vertgauge
        height: parent.height - 50
        width: parent.width * 0.1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 10
        orientation: Qt.Vertical
        minorTickmarkCount: 0
        tickmarkAlignment: Qt.AlignRight
        value: mainvaluetextfield.text
        maximumValue: parent.warnvaluehigh * 1.2

        style: GaugeStyle {
            tickmarkLabel: Text {
                font.pixelSize: 14
                color: "transparent"
            }
            tickmark: Item {
                implicitWidth: 18
                implicitHeight: 1

                Rectangle {
                    color: "transparent"
                    anchors.fill: parent
                    anchors.leftMargin: 3
                    anchors.rightMargin: 3
                }
            }
            valueBar: Rectangle {
                implicitWidth: 25
                color: "lightsteelblue"
            }
        }

    }

    Gauge {
        id: horizgauge
        y: 0
        width: parent.width * 0.9
        height: 25
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.horizontalCenter: parent.horizontalCenter
        orientation: Qt.Horizontal
        minorTickmarkCount: 0
        tickmarkAlignment: Qt.AlignRight
        value: parent.mainvalue
        maximumValue: parent.warnvaluehigh * 1.2

        style: GaugeStyle {

            tickmarkLabel: Text {
                font.pixelSize: 14
                color: "transparent"
            }
            tickmark: Item {
                implicitWidth: 18
                implicitHeight: 1

                Rectangle {
                    color: "transparent"
                    anchors.fill: parent
                    anchors.leftMargin: 3
                    anchors.rightMargin: 3
                }
            }
            valueBar: Rectangle {
                implicitWidth: 25
                color: "lightsteelblue"
            }
        }

    }
    Item {
        //to change the warning
        id: warningindication
        function warn()
        {
            if (mainvaluetextfield.text > warnvaluehigh || mainvaluetextfield.text < warnvaluelow )anim.running = true,anim2.running = true;
            else anim.running = false,anim2.running = false,titlebar.color = "#808080" ,gauge.color = "black";
        }
    }

    Item {
        id: menustructure

        Menu {
            id: popupmenu
            MenuItem {
                text: "Change size"
                onClicked: sizemenu.popup(touchArea.mouseX, touchArea.mouseY)

            }
            MenuItem {
                text: "Change sec value"
                onClicked: {
                    cbxSecondary.visible = true;
                    btnSecSrc.visible = true;
                }

            }

            MenuItem {
                text: "toggle sec value"
                onClicked: {
                    if(secondaryvaluetextfield.visible === true){
                        secondaryvaluetextfield.visible = false;
                    }
                    else{
                        secondaryvaluetextfield.visible = true;
                    }
                }

            }


            MenuItem {
                text: "Set min warning"
                onClicked: {
                    txtMinValue.visible = true;
                    btnMinValue.visible = true;
                }
            }



            MenuItem {
                text: "Set max warning"
                onClicked: {
                    txtMaxValue.visible = true;
                    btnMaxValue.visible = true;
                }
            }
            MenuItem {
                text: "remove gauge"
                onClicked: gauge.destroy()
            }
        }

        Menu {
            id: sizemenu
            MenuItem {
                text: "small"
                onClicked: {

                    gauge.width = 160;
                    gauge.height = 120;
                }
            }
            MenuItem {
                text: "medium"
                onClicked: {

                    gauge.width = 300;
                    gauge.height = 200;
                }
            }
            MenuItem {
                text: "large"
                onClicked: {

                    gauge.width = 400;
                    gauge.height = 266;
                }
            }
        }



    }

    Item {
        id: secSourceSelector
        anchors.fill: parent

        ComboBox {
            id: cbxSecondary
            visible: false
            textRole: "name"
            model: dataSourceModel
        }

        Button {
            id: btnSecSrc
            x: 150
            visible: false
            text: "apply"
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            onClicked: {
                cbxSecondary.visible = false;
                btnSecSrc.visible = false;
                secondaryvaluetextfield.text = dataSourceModel.data(dataSourceModel.index(cbxSecondary.currentIndex,0),258);
                secondaryvaluetextfield.visible = true;

            }
        }

    }

    Item {
        id: minValueSelect
        anchors.fill: parent

        TextField {
            id: txtMinValue
            width: 94
            height: 40
            inputMask: "00000"
            visible: false
            text: warnvaluelow;
        }

        Button {
            id: btnMinValue
            x: 119
            text: qsTr("OK")
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            visible: false
            onClicked: {
                txtMinValue.visible = false;
                btnMinValue.visible = false;
                warnvaluelow = txtMinValue.text;
            }
        }

    }

    Item {
        id: maxValueSelect
        anchors.fill: parent

        TextField {
            id: txtMaxValue
            width: 94
            height: 40
            inputMask: "00000"
            visible: false
            text: warnvaluehigh
        }

        Button {
            id: btnMaxValue
            x: 119
            text: qsTr("OK")
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            visible: false
            onClicked: {
                txtMaxValue.visible = false;
                btnMaxValue.visible = false;
                warnvaluehigh = txtMaxValue.text;
            }
        }

    }




}


