#include "threadpooling.h"

ThreadPooling::ThreadPooling(QObject *parent) : QThread(parent)
{

}

void ThreadPooling::run()
{
    qDebug() << " Thread started";
    exec();
    //I GUESS THATS IT...?
}

void ThreadPooling::addSock(qintptr ID)
{
    ConnectedFellow* tempFellow = new ConnectedFellow(ID, &sockList);
    sockList.push_back(tempFellow);
}
