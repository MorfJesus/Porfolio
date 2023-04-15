#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include <QPushButton>
#include <QTcpSocket>
#include "timethread.h"

QT_BEGIN_NAMESPACE
namespace Ui { class MainWindow; }
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    void init();


    QString userLetter = "X";

    QByteArray uID;
    QString username;
    int rating;
    bool choicePending = false;
    QPushButton* buttList[9];
    QTcpSocket *socket;
    int mY, mX;
    int choice;
    ~MainWindow();

public slots:
    void updateTime(int nT);
    void updateGTime(int nT);

signals:
    void startGUITIMER();

private slots:
    void on_button00_clicked();

    void on_button01_clicked();

    void on_button02_clicked();

    void on_button10_clicked();

    void on_button11_clicked();

    void on_button12_clicked();

    void on_button20_clicked();

    void on_button21_clicked();

    void on_button22_clicked();

    void on_buttonConfirm_clicked();

    void on_buttonSearch_clicked();

    void readyRead();

private:
    Ui::MainWindow *ui;
    bool moving = true;
    void enableButts(bool fl);
    void resetTimes();
    //timeThread* tt = new timeThread(this);

};
#endif // MAINWINDOW_H
