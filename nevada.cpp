#include "nevada.h"

nevada::nevada(QObject *parent) : QObject(parent)
{

}

QString nevada::OS()
{

#if defined(Q_OS_ANDROID)
    return QString("android");
#elif defined(Q_OS_BLACKBERRY)
    return QString("blackberry");
#elif defined(Q_OS_IOS)
    return QString("ios");
#elif defined(Q_OS_MAC)
    return QString("osx");
#elif defined(Q_OS_WINCE)
    return QString("wince");
#elif defined(Q_OS_WIN)
    return QString("windows");
#elif defined(Q_OS_LINUX)
    return QString("linux");
#elif defined(Q_OS_UNIX)
    return QString("unix");
#else
    return QString("unknown");
#endif

}
