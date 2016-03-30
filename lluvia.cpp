#include "lluvia.h"

lluvia::lluvia(QObject *parent) : QObject(parent)
{
    historyIndex=0;
    setDirectory(QDir::homePath());
    QTimer *timer = new QTimer(this);
    connect(timer, SIGNAL(timeout()), this, SLOT(check()));
    timer->start(1000);


}

QString lluvia::info(int index, QString property)
{
    if(property == "fileName")return dir.entryInfoList()[index].fileName();
    if(property == "size")return QString::number(dir.entryInfoList()[index].size());
    else return "invalid info type";
}

QList<int> lluvia::imageInfo(QString path)
{
    QList<int> out;
    path=path.replace("file://","");
    QImageReader tmp(path);
    tmp.setAutoTransform(true);
    tmp.setFileName(path);
    QImage imgHandler=tmp.read();
    out << imgHandler.width() << imgHandler.height();
    return out;
}

QString lluvia::directory()
{
    return p_directory;
}

QList<QJsonObject> lluvia::filesList()
{
    return p_filesList;
}
QStringList lluvia::foldersList()
{
    return p_foldersList;
}
QList<QJsonObject> lluvia::imagesList()
{
    return p_imagesList;
}
QList<QJsonObject> lluvia::videosList()
{
    return p_videosList;
}
QList<QJsonObject> lluvia::documentsList()
{
    return p_documentsList;
}
void lluvia::setDirectory(QString path)
{
    p_directory = path;
    if(history.length()==historyIndex+1) history << p_directory;
    else
    {
        for(int i=history.length()-1;i>historyIndex;i--)
        {
            history.removeAt(i);
        }
        history << p_directory;
    }
    historyIndex = history.length()-1;
    if(path!=":MyHome:"){
        dir.setPath(path);
        updateList();
    }
    else{
        updateHome();
    }
    emit directoryChanged();
}

void lluvia::updateHome()
{
    p_filesList.clear();
    p_imagesList.clear();
    p_foldersList.clear();
    p_videosList.clear();
    p_documentsList.clear();
    foreach (const QStorageInfo &storage, QStorageInfo::mountedVolumes()){
        QJsonObject out{{"name",storage.displayName()},
                        {"index",0},
                        {"path",storage.rootPath()},
                        {"type","drive"},
                        {"thumbnail",storage.rootPath()},
                        {"ready",storage.isReady()},
                        {"freeSpace",storage.bytesFree()},
                        {"totalSpace",storage.bytesTotal()}
                       };
        p_filesList << out;

    }
    QJsonObject out{{"name","My Documents"},
                    {"index",0},
                    {"path",QDir::homePath()},
                    {"type","folder"},
                    {"thumbnail",QDir::homePath()}
                   };
    p_filesList << out;
    emit filesListChanged();
}

void lluvia::check()
{
    if(p_directory!=":MyHome:"){
        QStringList oldList = dir.entryList();
        dir.refresh();
        if(oldList.length() != dir.entryList().length())
        {
            updateList();
        }
    }

}

void lluvia::updateList()
{
    p_filesList.clear();
    p_imagesList.clear();
    p_foldersList.clear();
    p_videosList.clear();
    p_documentsList.clear();
    QMimeType type;
    QString absolutePath;
    QString thumbPath = "none";
    int index;
    foreach (QString name, dir.entryList(dir.Dirs))
    {
        if(name != "." && name != ".."){
            absolutePath = dir.path() + "/" + name;
            thumbWorker.setPath(absolutePath);
            index=0;
            foreach (QString nameThumb, thumbWorker.entryList(thumbWorker.Files))
            {
                thumbPath = thumbWorker.path() + "/" + nameThumb;
                type = db.mimeTypeForFile(thumbPath);
                if(type.genericIconName() == "image-x-generic")break;
                index++;if (index>3)break;

            }
            p_foldersList << name << thumbPath << absolutePath;
            thumbPath = "none";
        }
    }
    index=0;
    foreach (QString name, dir.entryList(dir.Files))
    {
            absolutePath = dir.path() + "/" + name;
            type = db.mimeTypeForFile(absolutePath);
#ifdef Q_OS_WIN
            thumbPath="file:///"+absolutePath;//windows
#else
            thumbPath="file://"+absolutePath;//unix
//            QUrl tmp(thumbPath);
//            tmp.setScheme("file");
//            qDebug() << tmp.toString(QUrl::FullyEncoded);
#endif
            QJsonObject out{{"name",name},
                            {"index",index},
                            {"path",absolutePath},
                            {"type",type.genericIconName()},
                            {"thumbnail",thumbPath}};
            p_filesList << out;
            if(type.genericIconName() == "image-x-generic")p_imagesList << out;
            else if(type.genericIconName() == "video-x-generic")p_videosList << out;
            else if(type.genericIconName() == "x-office-document")p_documentsList << out;
            index++;
    }

    emit filesListChanged();
}
QString lluvia::getProperty(int index, QString propertyName, QString types)
{
    if(types == "images")return p_imagesList[index][propertyName].toString();
    if(types == "videos")return p_videosList[index][propertyName].toString();
    if(types == "documents")return p_documentsList[index][propertyName].toString();
    else return p_filesList[index][propertyName].toString();
}

int lluvia::listNumber(QString types)
{
    if(types == "images")return p_imagesList.length();
    else if(types == "videos")return p_videosList.length();
    else if(types == "documents")return p_documentsList.length();
    else return p_filesList.length();
}

void lluvia::up()
{
    dir.cdUp();
    p_directory = dir.path();
    if(history.length()==historyIndex+1)history << p_directory;
    else
    {
        for(int i=history.length()-1;i>historyIndex;i--)
        {
            history.removeAt(i);
        }
        history << p_directory;
    }
    historyIndex = history.length()-1;
    updateList();

    emit directoryChanged();
}

void lluvia::back()
{
    if(historyIndex>0){
        QString path = history[historyIndex-1];
        p_directory = path;
        historyIndex--;
        if(path!=":MyHome:"){
        dir.setPath(path);
        updateList();}
        else updateHome();
        emit directoryChanged();
    }
}

void lluvia::forwad()
{
    if(historyIndex<history.length()-1){
        QString path = history[historyIndex+1];
        p_directory = path;
        historyIndex--;
        if(path!=":MyHome:"){
        dir.setPath(path);
        updateList();}
        else updateHome();
        emit directoryChanged();
    }
}
