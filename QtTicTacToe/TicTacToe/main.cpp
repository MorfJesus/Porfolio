#include "mainwindow.h"
#include "loginwin.h"

#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    //MainWindow w;
    LoginWin w;
    //MainWindow l;
    w.show();
    //l.show();
    return a.exec();
}
