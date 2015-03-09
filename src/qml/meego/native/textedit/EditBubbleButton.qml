/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the Qt Components project.
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
**   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
**     the names of its contributors may be used to endorse or promote
**     products derived from this software without specific prior written
**     permission.
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
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 1.1
// import "." 1.0
import com.nokia.meego 1.1

BorderImage {
    id: button

    signal clicked()
    property alias text: label.text
    property bool selected: false

    property Style platformStyle: EditBubbleButtonStyle {}

    width: label.width + platformStyle.buttonPaddingLeft +
           platformStyle.buttonPaddingRight +
           platformStyle.backgroundMarginLeft +
           platformStyle.backgroundMarginRight
    height: platformStyle.buttonHeight +
            platformStyle.backgroundMarginTop +
            platformStyle.backgroundMarginBottom

    source: {
        if (mouseArea.pressed)
            return platformStyle.pressedBackground;

        // XXX: meegotouch-text-editor-selected image is missing
        if (selected && platformStyle.position != "")
            return platformStyle.checkedBackground;
        else
            return platformStyle.background;
    }

    border {
        left: platformStyle.backgroundMarginLeft
        top: platformStyle.backgroundMarginTop
        right: platformStyle.backgroundMarginRight
        bottom: platformStyle.backgroundMarginBottom
    }

    Text {
        id: label
        anchors.centerIn: parent

        color: platformStyle.textColor

        font.family: platformStyle.fontFamily
        font.weight: platformStyle.fontWeight
        font.pixelSize: platformStyle.fontPixelSize
        font.capitalization: platformStyle.fontCapitalization

        style: platformStyle.textStyle
        styleColor: platformStyle.textStyleColor
    }

    MouseArea {
        id: mouseArea
        enabled: button.enabled
        anchors {
            fill: parent
            leftMargin: platformStyle.mouseMarginLeft
            topMargin: platformStyle.mouseMarginTop
            rightMargin: platformStyle.mouseMarginRight
            bottomMargin: platformStyle.mouseMarginBottom
        }
    }
    Component.onCompleted: mouseArea.clicked.connect(clicked)
}
