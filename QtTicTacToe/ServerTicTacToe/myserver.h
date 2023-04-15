#ifndef MYSERVER_H
#define MYSERVER_H

#include <QTcpServer>
#include "mythread.h"
#include "threadpooling.h"

class MyServer : public QTcpServer
{
    Q_OBJECT
public:
    explicit MyServer(QObject *parent = 0);
    void startServer();
    QList<MyThread*> clients{};
    QList<MyThread*> readyClients{};
    MyThread* queued = nullptr;
    ThreadPooling *thread = nullptr;
signals:
    void cock(QByteArray mess);

public slots:
    //void deleteThread(MyThread *thread);
    //void passMess(qintptr socketDescriptor, QByteArray mess);
    //void test();
    //void getReadies(MyThread* thread);
protected:
    void incomingConnection(qintptr socketDescriptor);

};

#endif // MYSERVER_H
