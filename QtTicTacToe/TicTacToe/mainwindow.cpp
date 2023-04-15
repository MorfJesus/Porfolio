#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QCryptographicHash>
#include <QDebug>
#include <QtSql>
#include <QElapsedTimer>
#include <QMessageBox>

//QElapsedTimer timer;
timeThread* tt;
timeThread* gTT;

void MainWindow::init()
{
    ui->setupUi(this);
    connect(socket, SIGNAL(readyRead()), this, SLOT(readyRead()), Qt::DirectConnection);
    ui->labelYourRating->setText(QString::number(rating));
    ui->labelYourName->setText(username);

    buttList[0] = ui->button00;
    buttList[1] = ui->button01;
    buttList[2] = ui->button02;
    buttList[3] = ui->button10;
    buttList[4] = ui->button11;
    buttList[5] = ui->button12;
    buttList[6] = ui->button20;
    buttList[7] = ui->button21;
    buttList[8] = ui->button22;

    tt = new timeThread(this);
    gTT = new timeThread(this, true);
}

void MainWindow::enableButts(bool fl)
{
    for (int i = 0; i < 9; i++)
    {
        //if (buttList[i]->text() == " ")
        //    buttList[i]->setEnabled(fl);
        if (buttList[i]->text() != "X" && buttList[i]->text() != "O")
            buttList[i]->setEnabled(fl);
    }
}

MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{

}



MainWindow::~MainWindow()
{
    delete ui;
    delete tt;
}


QString constructTime(quint64 time)
{
    QString res{};
    time /= 1000;
    if (time < 60)
        res = "00:";
    else
    {
        if (time < 600)
            res = "0"+QString::number(time/60)+":";
        else
            res = QString::number(time/60)+":";
    }

    if (time - (time/60)*60 < 10)
        res += "0";
    res += QString::number(time - (time/60)*60);
    return res;
}

void MainWindow::resetTimes()
{
    ui->dial->setValue(0);
    ui->lcdNumber->display(0);
}

void MainWindow::updateTime(int nT)
{
    //QString tm = constructTime(nT);
    double dtm = double(nT)/double(1000);
    ui->dial->setValue(dtm);
    ui->lcdNumber->display(dtm);
    //ui->labelTime->setText(tm);
}

void MainWindow::updateGTime(int nT)
{
    ui->labelTime->setText(constructTime(nT));
}

void MainWindow::on_button00_clicked()
{
    for (int i = 0; i <= 8; i++)
    {
        if (buttList[i]->isEnabled())
            buttList[i]->setText(" ");
    }
    ui->button00->setText(userLetter);
    mY = 0;
    mX = 0;
    choice = 0;
    ui->buttonConfirm->setEnabled(true);
    tt->kill();
    resetTimes();
}


void MainWindow::on_button01_clicked()
{
    tt->start();
    for (int i = 0; i <= 8; i++)
    {
        if (buttList[i]->isEnabled())
            buttList[i]->setText(" ");
    }
    ui->button01->setText(userLetter);
    mY = 0;
    mX = 1;
    choice = 1;
    ui->buttonConfirm->setEnabled(true);
}


void MainWindow::on_button02_clicked()
{
    for (int i = 0; i <= 8; i++)
    {
        if (buttList[i]->isEnabled())
            buttList[i]->setText(" ");
    }
    ui->button02->setText(userLetter);
    mY = 0;
    mX = 2;
    choice = 2;
    ui->buttonConfirm->setEnabled(true);
}


void MainWindow::on_button10_clicked()
{
    for (int i = 0; i <= 8; i++)
    {
        if (buttList[i]->isEnabled())
            buttList[i]->setText(" ");
    }
    ui->button10->setText(userLetter);
    mY = 1;
    mX = 0;
    choice = 3;
    ui->buttonConfirm->setEnabled(true);
}


void MainWindow::on_button11_clicked()
{
    for (int i = 0; i <= 8; i++)
    {
        if (buttList[i]->isEnabled())
            buttList[i]->setText(" ");
    }
    ui->button11->setText(userLetter);
    mY = 1;
    mX = 1;
    choice = 4;
    ui->buttonConfirm->setEnabled(true);
}


void MainWindow::on_button12_clicked()
{
    for (int i = 0; i <= 8; i++)
    {
        if (buttList[i]->isEnabled())
            buttList[i]->setText(" ");
    }
    ui->button12->setText(userLetter);
    mY = 1;
    mX = 2;
    choice = 5;
    ui->buttonConfirm->setEnabled(true);
}


void MainWindow::on_button20_clicked()
{
    for (int i = 0; i <= 8; i++)
    {
        if (buttList[i]->isEnabled())
            buttList[i]->setText(" ");
    }
    ui->button20->setText(userLetter);
    mY = 2;
    mX = 0;
    choice = 6;
    ui->buttonConfirm->setEnabled(true);
}


void MainWindow::on_button21_clicked()
{
    for (int i = 0; i <= 8; i++)
    {
        if (buttList[i]->isEnabled())
            buttList[i]->setText(" ");
    }
    ui->button21->setText(userLetter);
    mY = 2;
    mX = 1;
    choice = 7;
    ui->buttonConfirm->setEnabled(true);
}


void MainWindow::on_button22_clicked()
{
    for (int i = 0; i <= 8; i++)
    {
        if (buttList[i]->isEnabled())
            buttList[i]->setText(" ");
    }
    ui->button22->setText(userLetter);
    mY = 2;
    mX = 2;
    choice = 8;
    ui->buttonConfirm->setEnabled(true);
}


void MainWindow::on_buttonConfirm_clicked()
{
    socket->write("filler|GAME|"+QString::number(choice/3).toUtf8()+"|"+QString::number(choice%3).toUtf8()+"|"+userLetter.toUtf8());
    ui->buttonConfirm->setEnabled(false);
    moving = false;
}


void MainWindow::on_buttonSearch_clicked()
{
    socket->write("filler|SRCH");
}

void MainWindow::readyRead()
{
    QList<QByteArray> moveData = socket->readAll().split('|');
    //QMessageBox::about(this, "whateva", moveData[0]);
    if (moveData[0] == "GINFO")
    {
        //QTime t;
        //t.start();
        //qDebug("Time elapsed: %d ms", t.elapsed());

        ui->labelOppName->setText(moveData[1]);
        ui->labelOppRating->setText(moveData[2]);
        userLetter = moveData[3];
        if (moveData[4][0] == '0')
            moving = false;
        QString out{};
        if (moving)
        {
            out = moveData[0]+"\n"+moveData[1]+"\n"+moveData[2]+"\n"+moveData[3] + "\nGOOD JOB BROTHER";
            ui->labelYourName->setFrameShape(QFrame::WinPanel);
            ui->labelOppName->setFrameShape(QFrame::NoFrame);
        }
        else
        {
            out = moveData[0]+"\n"+moveData[1]+"\n"+moveData[2]+"\n"+moveData[3] + "\nLMFAOOOOOOOOOOOOO";
            ui->labelYourName->setFrameShape(QFrame::NoFrame);
            ui->labelOppName->setFrameShape(QFrame::WinPanel);
        }
        QMessageBox::about(this, "whateva", out);

        for (int i = 0; i < 9; i++)
            buttList[i]->setEnabled(moving);

        tt->start();
        gTT->start();
        ui->buttonSearch->setEnabled(false);
        //QMessageBox::about(this, "whateva", out);
    }
    else if (moveData[0] == "MOVE")
    {
        if (userLetter == "O")
            buttList[moveData[1].toInt()*3+moveData[2].toInt()]->setText("X");
        else
            buttList[moveData[1].toInt()*3+moveData[2].toInt()]->setText("O");
        buttList[moveData[1].toInt()*3+moveData[2].toInt()]->setEnabled(false);
        enableButts(true);
        moving = true;
        ui->labelYourName->setFrameShape(QFrame::WinPanel);
        ui->labelOppName->setFrameShape(QFrame::NoFrame);
        tt->start();
    }
    else if (moveData[0] == "OKIEDOKE")
    {
        tt->kill();
        resetTimes();
        buttList[choice]->setText(userLetter);
        buttList[choice]->setEnabled(false);
        enableButts(false);
        ui->labelYourName->setFrameShape(QFrame::NoFrame);
        ui->labelOppName->setFrameShape(QFrame::WinPanel);
    }

}

