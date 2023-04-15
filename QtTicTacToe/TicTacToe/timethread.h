#ifndef TIMETHREAD_H
#define TIMETHREAD_H

#include <QThread>
#include <QTime>

class timeThread : public QThread
{
    Q_OBJECT
public:
    explicit timeThread(QObject *parent = nullptr, bool global = false);
    void run();
    void kill();
    bool death = false;
    QTime gT;
    ~timeThread();

signals:
    void updateTime(int nT);

public slots:
    //void Go();

private:
    bool global = false;
};

#endif // TIMETHREAD_H
