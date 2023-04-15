#include "myserver.h"
#include "mythread.h"
#include "threadpooling.h"

MyServer::MyServer(QObject *parent) :
    QTcpServer(parent)
{
    qDebug() << QThread::idealThreadCount();
}

void MyServer::startServer()
{
    int port = 1234;

    if(!this->listen(QHostAddress::Any,port))
    {
        qDebug() << "Could not start server";
    }
    else
    {
        qDebug() << "Listening to port " << port << "...";
    }

    thread = new ThreadPooling();
    connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));
    //connect(thread, SIGNAL(finished()), this, SLOT(deleteThread(thread)));
    thread->start();
}

void MyServer::incomingConnection(qintptr socketDescriptor)
{
    // We have a new connection
    qDebug() << socketDescriptor << " Connecting... on thread..." <<this->thread->currentThreadId();

    //MyThread *thread = new MyThread(socketDescriptor, nullptr, &clients);
    //clients.append(thread);

    thread->addSock(socketDescriptor);
    // connect signal/slot
    // once a thread is not needed, it will be deleted later
    //connect(thread->socket,SIGNAL(connected()),this,SLOT(onConnected()),Qt::DirectConnection);
}

/*
MyServer::MyServer(QObject *parent) :
    QTcpServer(parent)
{
    qDebug() << QThread::idealThreadCount();
    if (this->parent())
        qDebug() << "PARENTS???";
    else
        qDebug() << "wha...";
}

void MyServer::startServer()
{
    int port = 1234;

    if(!this->listen(QHostAddress::Any,port))
    {
        qDebug() << "Could not start server";
    }
    else
    {
        qDebug() << "Listening to port " << port << "...";
    }
}

void MyServer::incomingConnection(qintptr socketDescriptor)
{
    // We have a new connection
    qDebug() << socketDescriptor << " Connecting... on thread..." <<this->thread()->currentThreadId();

    MyThread *thread = new MyThread(socketDescriptor, nullptr, &clients);
    clients.append(thread);

    // connect signal/slot
    // once a thread is not needed, it will be deleted later
    //connect(thread->socket,SIGNAL(connected()),this,SLOT(onConnected()),Qt::DirectConnection);
    connect(thread, SIGNAL(finished()), thread, SLOT(deleteLater()));
    connect(thread, SIGNAL(finished()), this, SLOT(deleteThread(thread)));

    thread->start();
}

void MyServer::deleteThread(MyThread *thread)
{
    qDebug() << "HEH";
    clients.removeOne(thread);
}

void MyServer::getReadies(MyThread* thread)
{
    if (!queued)
        queued = thread;
    else
    {
        emit thread->cock("GINFO|username1|0|O");
        emit thread->cock("GINFO|username2|0|O");
    }
}

void MyServer::test()
{
    qDebug()<<"fuck off";
}

void MyServer::passMess(qintptr socketDescriptor, QByteArray mess)
{
    qDebug() << "oh hey this works yippie" << socketDescriptor << ' ' << mess;
}
*/
