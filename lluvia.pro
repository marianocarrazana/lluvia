TEMPLATE = app

QT += qml quick core location
CONFIG += c++11

SOURCES += main.cpp \
    lluvia.cpp \
    nevada.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    lluvia.h \
    nevada.h

executable.path = /usr/local/bin
executable.files = lluvia

icon.path = /usr/share/pixmaps
icon.files = lluvia.png

link.path = /usr/share/applications
link.files = lluvia.desktop

INSTALLS += executable icon link

DISTFILES += \
    lluvia.png \
    lluvia.desktop \
    README.md
