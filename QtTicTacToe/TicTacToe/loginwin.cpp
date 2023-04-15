#include "loginwin.h"
#include "ui_loginwin.h"
#include <QCryptographicHash>

LoginWin::LoginWin(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::LoginWin)
{
    ui->setupUi(this);
    w.socket = new QTcpSocket(this);
    connect(w.socket, &QTcpSocket::disconnected, w.socket, &QTcpSocket::deleteLater);
}
/*
void LoginWin::readyRead()
{
    qDebug() << "huh...?";
    if (socket && socket->isOpen())
    {

    }
}
*/
LoginWin::~LoginWin()
{
    delete ui;
}

void LoginWin::on_loginButton_clicked()
{
    QList<QByteArray> dataList =  unifiedLogger("LOG").split('|');
    w.uID = dataList[0];
    w.username = dataList[1];
    w.rating = dataList[3].toInt();
    w.init();
    w.show();
    LoginWin::hide();
}


void LoginWin::on_registerButton_clicked()
{
    QList<QByteArray> dataList =  unifiedLogger("REG").split('|');
    w.uID = dataList[0];
    w.username = ui->loginEdit->text();
    w.rating = 0;
    w.init();
    w.show();
    LoginWin::hide();
}

QByteArray LoginWin::unifiedLogger(QString cntrlWord)
{
    if (w.socket->state() != QTcpSocket::ConnectedState)
        w.socket->connectToHost("127.0.0.1", 1234);
    qDebug() << "lol";
    Data.clear();
    QDataStream out(&Data, QIODevice::ReadWrite);
    out.setVersion(QDataStream::Qt_5_12);


    QString pswd = ui->passEdit->text();
    QByteArray hashPswd = QCryptographicHash::hash(pswd.toUtf8(), QCryptographicHash::RealSha3_256);
    QByteArray hashUser = QCryptographicHash::hash(ui->loginEdit->text().toUtf8(), QCryptographicHash::RealSha3_256);
    QByteArray salt = QCryptographicHash::hash(hashPswd.toBase64() + hashUser.toBase64(), QCryptographicHash::RealSha3_256);
    QByteArray message = "|"+cntrlWord.toUtf8()+"|" + ui->loginEdit->text().toUtf8() + "|" + hashPswd.toBase64() + "|" + salt.toBase64();
    out << message;
    qDebug() << message;
    w.socket->write(Data);

    if (w.socket->waitForReadyRead())
    {
        qDebug() << "YIPPIE :D";
        return(w.socket->readAll());
    }
    else
    {
        return(0);
    }
}

