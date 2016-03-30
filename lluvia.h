#ifndef LLUVIA_H
#define LLUVIA_H

#include <QObject>
#include <QDir>
#include <QTimer>
#include <QImage>
#include <QImageReader>
#include <QMimeDatabase>
#include <QPlaceImage>
#include <QStorageInfo>

class lluvia : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString directory READ directory WRITE setDirectory NOTIFY directoryChanged)
    Q_PROPERTY(QList<QJsonObject> filesList READ filesList)
    Q_PROPERTY(QList<QJsonObject> imagesList READ imagesList)
    Q_PROPERTY(QList<QJsonObject> videosList READ videosList)
    Q_PROPERTY(QList<QJsonObject> documentsList READ documentsList)
    Q_PROPERTY(QStringList foldersList READ foldersList)
public:
    explicit lluvia(QObject *parent = 0);
    QString directory();
    QList<QJsonObject> filesList();
    QList<QJsonObject> imagesList();
    QList<QJsonObject> videosList();
    QList<QJsonObject> documentsList();
    QStringList foldersList();
    Q_INVOKABLE QString getProperty(int index, QString propertyName, QString types);
    Q_INVOKABLE int listNumber(QString types);



signals:
    void filesListChanged();
    void directoryChanged();

public slots:
    QString info(int index, QString property);
    QList<int> imageInfo(QString path);
    void setDirectory(QString path);
    void check();
    void updateList();
    void up();
    void back();
    void forwad();
    void updateHome();

private:
    QDir dir;
    QDir thumbWorker;
    QTimer *timer;
    QMimeDatabase db;
    QString p_directory;
    QList<QJsonObject> p_filesList;
    QStringList p_foldersList;
    QList<QJsonObject> p_imagesList;
    QList<QJsonObject> p_videosList;
    QList<QJsonObject> p_documentsList;
    QStringList history;
    int historyIndex;
};

#endif // LLUVIA_H
