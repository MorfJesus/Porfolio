#ifndef LOGINWIN_H
#define LOGINWIN_H

#include <QMainWindow>
#include <QTcpSocket>
#include "mainwindow.h"

namespace Ui {
class LoginWin;
}

class LoginWin : public QMainWindow
{
    Q_OBJECT

public:
    explicit LoginWin(QWidget *parent = nullptr);
    ~LoginWin();

private slots:
    void on_loginButton_clicked();

    void on_registerButton_clicked();
    //void readyRead();

private:
    QByteArray unifiedLogger(QString cntrlWord);
    Ui::LoginWin *ui;
    MainWindow w;
    QByteArray Data;
    //QTcpSocket *socket;
};

#endif // LOGINWIN_H
