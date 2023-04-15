#include "timethread.h"
#include "mainwindow.h"

timeThread::timeThread(QObject *parent, bool global) : QThread(parent)
{
    this->global = global;
}

void timeThread::run()
{
    if (!global)
        connect(this, &timeThread::updateTime, (MainWindow*)parent(), &MainWindow::updateTime);
    else
        connect(this, &timeThread::updateTime, (MainWindow*)parent(), &MainWindow::updateGTime);
    gT.start();
    death = false;
    while(true)
    {
        if (death)
        {
            exit(0);
            break;
        }
        this->msleep(100);
        emit updateTime(gT.elapsed());
    }
    exec();
}

void timeThread::kill()
{
    disconnect(this, &timeThread::updateTime, (MainWindow*)parent(), &MainWindow::updateTime);
    death = true;
}

timeThread::~timeThread()
{
    this->kill();
}
