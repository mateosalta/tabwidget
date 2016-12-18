/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.4
import QtQuick 2.4
import Ubuntu.Web 0.2
import Ubuntu.Components 1.3
import com.canonical.Oxide 1.15 as Oxide
import Ubuntu.Content 1.1
import QtMultimedia 5.0
import QtFeedback 5.0
import Ubuntu.Unity.Action 1.1 as UnityActions

Item {


        id: tabWidget

        // Setting the default property to stack.children means any child items
        // of the TabWidget are actually added to the 'stack' item's children.
        // See the "Property Binding"
        // documentation for details on default properties.
        default property alias content: stack.children


        property int current: 0
    property string myUrl


            function selectAll() {
            textField.selectAll()
        }

        onCurrentChanged: setOpacities()
        Component.onCompleted: setOpacities()

        function setOpacities() {
            for (var i = 0; i < stack.children.length; ++i) {
                stack.children[i].opacity = (i == current ? 1 : 0)
            }
        }

        Row {
            id: header

            Repeater {


                ///
            //property alias text: textField.text


        ///
                model: stack.children.length
                delegate: Rectangle {
                    width: tabWidget.width / stack.children.length; height: units.gu(5)

                    Rectangle {
                        width: parent.width; height: 1
                        anchors { bottom: parent.bottom; bottomMargin: 1 }
                        color: "#acb2c2"


                    }
                    ActionBar {
                               height: units.gu(4.7)
                               id: nav
    z: 10000
                        anchors {
                        top: parent.top
                                       horizontalCenter: parent.horizontalLeft
                                       }

                        width: units.gu(7)
                 numberOfSlots: 2
                 actions: [
                     Action {
                        iconName: "go-next"
                        text: "Foward"
                         onTriggered: {
                                   webview.goFoward()
                                }
                    },
                      Action {
                         iconName: "back"
                         text: "Back"
                          onTriggered: {
                                     webview.goBack()
                                 }
                     }

                 ]
             }
                    TextField {

                    id: textField
            objectName: "addressBarTextField"
                        horizontalAlignment: Qt.AlignHCenter; verticalAlignment: Qt.AlignVCenter
                        anchors.fill: parent

     //////////////////////              //Text box text here?
                       text: "Google"
                        font.bold: tabWidget.current == index
                        inputMethodHints : Qt.ImhUrlCharactersOnly
                        renderType : Text.NativeRendering


                    }


                    MouseArea {
                        anchors.fill: parent


                        enabled: !TextField.activeFocus
            onClicked: {
                textField.forceActiveFocus()
                textField.selectAll()
                 tabWidget.current = index
            }
                    }

                    Keys.onReturnPressed: {
webview.url = 'http://' + textField.text
                        textField.text = textField.text
                    textField.accepted()
                 }

                }
            }
        }

        Item {
            id: stack
            width: tabWidget.width
            anchors.top: header.bottom; anchors.bottom: tabWidget.bottom







    Rectangle {
    id: url
//property string myUrl: textField


        property string title: "Google"
        anchors.fill: parent
        color: "#e3e3e3"

        Rectangle {
            anchors.fill: parent




                WebView {
                          id: webview

                          anchors {
                              fill: parent
                              bottom: parent.bottom
                          }
                          width: parent.width
                          height: parent.height

    //////////////////////////////URL here
                         //  url: textField.text
                          url: "https://www.google.com"

                          preferences.localStorageEnabled: true
                          preferences.allowFileAccessFromFileUrls: true
                          preferences.allowUniversalAccessFromFileUrls: true
                          preferences.appCacheEnabled: true
                          preferences.javascriptCanAccessClipboard: true
                          filePicker: filePickerLoader.item
                }


        }
    }

 }
}
