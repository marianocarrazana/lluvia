#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "lluvia.cpp"
#include "nevada.cpp"



int main(int argc, char *argv[])
{

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    qmlRegisterType<lluvia>("com.nevada.lluvia", 1, 0, "Lluvia");
    //qmlRegisterSingletonType(QUrl("qrc:/lluvia.qml"), "Nevada.Lluvia", 1, 0, "files");//registrar imagen
    //qmlRegisterSingletonType<lluvia>("Nevada.Lluvia", 1, 0, "files",lluvia_provider);

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    /*QObject *object = engine.rootObjects().at(0);

    QQuickWindow *W = (QQuickWindow *)engine.rootObjects().first();
    if (W)
    W->setProperty("visibility", "Fullscreen");

    QObject *item = object->findChild<QObject*>("rec");
    item->setProperty("color","red");*/

    return app.exec();
}

