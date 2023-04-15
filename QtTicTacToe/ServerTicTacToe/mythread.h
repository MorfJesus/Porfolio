#ifndef MYTHREAD_H
#define MYTHREAD_H

#include <QThread>
#include <QTcpSocket>
#include <QDebug>

class MyThread : public QThread
{
    Q_OBJECT
public:
    explicit MyThread(qintptr ID, QObject *parent = nullptr, QList<MyThread*> *clients = nullptr);
    void run();
    MyThread* self();
    QString username;
    QString rating= "0";

    bool searching = false;
    QByteArray uID;
    QTcpSocket *socket;
    QString field[3] = {"000", "000", "000"};

signals:
    void error(QTcpSocket::SocketError socketerror);
    void oppMess(qintptr socketDescriptor, QByteArray mess);
    void cock(QByteArray mess);
    void readyGaming(MyThread* thread);

public slots:
    void readyRead();
    void disconnected();
    void oppMSLT(qintptr socketDescriptor, QByteArray mess);
    void balls(QByteArray mess);

private:
    bool attemptRegister(QByteArray login, QByteArray pass, QByteArray salt);
    bool attemptLogin(QByteArray login, QByteArray pass, QByteArray salt, QString &logData);
    void test(QList<MyThread*> *clients);
    qintptr socketDescriptor;
    QList<MyThread*> *clients;
    MyThread* opp = nullptr;
    QObject *parent;
    bool oppFound = false;
    bool gaming = false;
};

#endif // MYTHREAD_H
