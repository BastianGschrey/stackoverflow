//Creates instances of SquaregaugeRaceDash, usable at runtime

var component;
var gauge;

function createSquareGauge(setWidth,setHeight,setX,setY,setDecPlace,setUnit,setID,setVertGaugeVis,setHoriGaugeVis,setSecValueVis,SetValuePropertyMain,SetValuePropertySec,Setwarnvaluehigh,Setwarnvaluelow,Setframeclolor,Setbackroundcolor,Settitlecolor,Settitletextcolor,Settextcolor,Setbarcolor) {
    component = Qt.createComponent("squaregauge.qml");
    if (component.status === Component.Ready){
        finishCreation(setWidth,setHeight,setX,setY,setDecPlace,setUnit,setID,setVertGaugeVis,setHoriGaugeVis,setSecValueVis,SetValuePropertyMain,SetValuePropertySec,Setwarnvaluehigh,Setwarnvaluelow,Setframeclolor,Setbackroundcolor,Settitlecolor,Settitletextcolor,Settextcolor,Setbarcolor);
    }
    else {
        component.statusChanged.connect(finishCreation);
        console.log("component not ready!");
    }
}

function finishCreation(setWidth,setHeight,setX,setY,setDecPlace,setUnit,setID,setVertGaugeVis,setHoriGaugeVis,setSecValueVis,SetValuePropertyMain,SetValuePropertySec,Setwarnvaluehigh,Setwarnvaluelow,Setframeclolor,Setbackroundcolor,Settitlecolor,Settitletextcolor,Settextcolor,Setbarcolor) {
    if (component.status === Component.Ready) {
        gauge = component.createObject(mainwindow, {"id": setID, "title":setID, "width": setWidth, "height": setHeight,
                                           "mainvalue": SetValuePropertyMain,
                                           "secvalue": SetValuePropertySec,
                                           "warnvaluehigh": Setwarnvaluehigh,
                                           "warnvaluelow":Setwarnvaluelow,
                                           "mainunit": setUnit,
                                           "titlecolor":Settitlecolor,
                                           "resettitlecolor":Settitlecolor,
                                           "framecolor":Setframeclolor,
                                           "resetbackroundcolor":Setbackroundcolor,
                                           "textcolor":Settextcolor,
                                           "titletextcolor":Settitletextcolor,
                                           "barcolor":Setbarcolor,
                                           "vertgaugevisible": setVertGaugeVis,
                                           "horigaugevisible": setHoriGaugeVis,
                                           "secvaluevisible": setSecValueVis,
                                           "x": setX, "y": setY});
        if (gauge === null) {
            // Error Handling
            console.log("Error creating object");
        }

    } else if (component.status === Component.Error) {
        // Error Handling
        console.log("Error loading component:", component.errorString());
    }
}
