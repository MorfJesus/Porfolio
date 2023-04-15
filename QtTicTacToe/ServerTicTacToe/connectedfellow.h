#ifndef CONNECTEDFELLOW_H
#define CONNECTEDFELLOW_H

#include <QTcpSocket>
#include <QDebug>

class ConnectedFellow : public QObject
{
    Q_OBJECT
public:
    explicit ConnectedFellow(qintptr ID, QList<ConnectedFellow*> *clients);

    QString username;
    QString rating= "0";

    bool searching = false;
    QByteArray uID;
    QTcpSocket *socket;
    QString uLetter = "X";
    QString oppLetter = "O";
    QString field[3] = {"000", "000", "000"};

signals:
    void error(QTcpSocket::SocketError socketerror);

public slots:
    void readyRead();
    //void disconnected();

private:
    bool attemptRegister(QByteArray login, QByteArray pass, QByteArray salt);
    bool attemptLogin(QByteArray login, QByteArray pass, QByteArray salt, QString &logData);
    //void test(QList<MyThread*> *clients);
    qintptr socketDescriptor;
    //QList<MyThread*> *clients;
    ConnectedFellow* opp = nullptr;
    //QObject *parent;
    bool oppFound = false;
    bool gaming = false;
    QList<ConnectedFellow*> *clients;
};

#endif // CONNECTEDFELLOW_H
