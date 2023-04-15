#include "mythread.h"
#include <QtSql>
#include "myserver.h"

MyThread* MyThread::self()
{
    return(this);
}

void MyThread::test(QList<MyThread*> *clients)
{
    qDebug() << "testing TEST test";
    for (auto it = clients->begin(); it != clients->end(); it++)
    {
        qDebug() << (*it)->socketDescriptor;
    }
}

MyThread::MyThread(qintptr ID, QObject *parent, QList<MyThread*> *clients) :
    QThread(parent)
{
    this->socketDescriptor = ID;
    this->clients = clients;
    this->parent = parent;

    if (this->parent)
        qDebug() << "PARENTS???";
    else
        qDebug() << "wha...";
}

void MyThread::run()
{
    // thread starts here
    qDebug() << " Thread started";

    socket = new QTcpSocket();

    // set the ID
    if(!socket->setSocketDescriptor(this->socketDescriptor))
    {
        // something's wrong, we just emit a signal
        emit error(socket->error());
        return;
    }

    // connect socket and signal
    // note - Qt::DirectConnection is used because it's multithreaded
    //        This makes the slot to be invoked immediately, when the signal is emitted.

    connect(socket, SIGNAL(readyRead()), this, SLOT(readyRead()), Qt::DirectConnection);
    //connect(socket, SIGNAL(oppMess(qintptr, QByteArray)), (MyServer*)parent, SLOT(passMess(qintptr, QByteArray)), Qt::DirectConnection);
    connect(socket, SIGNAL(disconnected()), this, SLOT(disconnected()));
    //connect(this, &MyThread::cock, (MyServer*)parent, &MyServer::test, Qt::QueuedConnection);
    //connect((MyServer*)parent, &MyServer::cock, this, &MyThread::balls, Qt::QueuedConnection);
    connect(this, &MyThread::cock, this, &MyThread::balls, Qt::QueuedConnection);
    //connect(this, &MyThread::readyGaming, (MyServer*)parent, &MyServer::getReadies, Qt::QueuedConnection);

    // We'll have multiple clients, we want to know which is which
    qDebug() << socketDescriptor << " Client connected";

    // make this thread a loop,
    // thread will stay alive so that signal/slot to function properly
    // not dropped out in the middle when thread dies

    exec();
}

bool addVal1(QString username, QByteArray pass, QByteArray salt)
{
    QSqlQuery qry;

    qry.prepare("INSERT INTO users (Username,Pass,Salt,PFP,Rating)"
                "VALUES (?, ?, ?, 0, 0);");
    qry.addBindValue(username);
    qry.addBindValue(QString(pass.toBase64()));
    qry.addBindValue(QString(salt.toBase64()));


    if (!qry.exec())
    {
        qDebug() << qry.lastError().text();
        return(false);
    }
    return(true);
}

bool MyThread::attemptRegister(QByteArray login, QByteArray pass, QByteArray salt)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("C:/test.sqlite");
    if (!db.open())
    {
        qDebug() << "damn...";
        return(false);
    }

    qDebug() << "trynna register " << login;

    QSqlQuery qry;

    qry.exec("SELECT Username FROM users");
    while (qry.next())
    {
        if (qry.value(0).toString() == QString(login))
        {
            qDebug() << "A user with such a username already exists";
            return(false);
        }
    }
    QByteArray hashPswd = QCryptographicHash::hash(pass+salt, QCryptographicHash::RealSha3_256);
    if(addVal1(QString(login), hashPswd, salt))
    {
        username = login;
        return(true);
    }
    else
    {
        return(false);
    }
}

bool MyThread::attemptLogin(QByteArray login, QByteArray pass, QByteArray salt, QString &logData)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("C:/test.sqlite");
    if (!db.open())
    {
        qDebug() << "damn...";
        return(false);
    }
    qDebug() << "trynna login " << login;

    QSqlQuery qry;

    qry.exec("SELECT Username,Pass,Salt,PFP,Rating FROM users");
    qDebug() << "BAKANE...";
    while (qry.next())
    {
        //qDebug() << qry.value(0).toString();
        if (qry.value(0).toString() == QString(login))
        {
            qDebug() << "Found user " << login << " with pass " << qry.value(1).toString() << " salt "<< qry.value(2).toString();
            qDebug() << "BTW,,, ON THREAD NUMBER " << this->thread()->currentThreadId();
            QByteArray hashPswd = QCryptographicHash::hash(pass+salt, QCryptographicHash::RealSha3_256).toBase64();
            //qDebug() << hashPswd;
            //qDebug() << salt.toBase64();
            if (qry.value(1).toString() == QString(hashPswd) && qry.value(2).toString() == QString(salt.toBase64()))
            {
                username = qry.value(0).toString();
                rating = qry.value(4).toString();

                logData = qry.value(0).toString()+'|'+qry.value(3).toString() + '|' + qry.value(4).toString();
                return (true);
            }
            return(false);
            //return(qry.value(1).toString() == QString(hashPswd)
            //    && qry.value(2).toString() == QString(salt.toBase64()));
        }
    }
    //QByteArray hashPswd = QCryptographicHash::hash(pass+salt, QCryptographicHash::RealSha3_256);
    db.close();
    return (false);
}

void MyThread::readyRead()
{
    qDebug() << socketDescriptor << " reading on thread " << this->currentThreadId();
    // get the information
    QByteArray Data = socket->readAll();

    // will write on server side window
    qDebug() << socketDescriptor << " Data in: " << Data;

    QList<QByteArray>DataSheet = Data.split('|');
    //qDebug() << DataSheet[0];
    qDebug() << socketDescriptor << DataSheet[1]; //REG or LOG or SRCH or GAME
    //qDebug() << DataSheet[2]; //LOGIN
    //qDebug() << DataSheet[3].toBase64(); //PASS
    //qDebug() << DataSheet[4].toBase64(); //SALT


    if (DataSheet[1] == "REG")
    {
        if (attemptRegister(DataSheet[2], DataSheet[3], DataSheet[4]))
        {
            uID = QCryptographicHash::hash(DataSheet[2]+DataSheet[3]+DataSheet[4], QCryptographicHash::RealSha3_256).toBase64();
            qDebug() << "OkieDokie "<<uID;
            socket->write(uID.toBase64()+"|0|0");
        }
        else
        {
            qDebug() << "KILLYOSELF";
            socket->write("0|Fucked up");
            disconnected();
        }
    }
    else if (DataSheet[1] == "LOG")
    {
        QString logData{};
        if (attemptLogin(DataSheet[2], DataSheet[3], DataSheet[4], logData))
        {
            qDebug() << "Your login data: "<<logData;
            uID = QCryptographicHash::hash(DataSheet[2]+DataSheet[3]+DataSheet[4], QCryptographicHash::RealSha3_256).toBase64();
            qDebug() << "OkieDokie "<<uID.toBase64()+'|'+logData.toUtf8();
            socket->write(uID.toBase64()+'|'+logData.toUtf8());
        }
        else
        {
            qDebug() << "KILLYOSELF";
            socket->write("KILLYOSELF");
            disconnected();
        }
    }
    else if (DataSheet[1] == "SRCH")
    {
        //auto lmao = this;

        //emit readyGaming(this);

        searching = true;
        for (auto it = clients->begin(); it != clients->end(); it++)
        {
            if ((*it)->searching && (*it)->uID != uID)
            {
                opp  = (*it);
                qDebug() << uID << "VS" << (*it)->uID;
                //this->moveToThread(opp->thread());
                searching = false;
                opp->searching = false;

                field[0] = "000";
                field[1] = "000";
                field[2] = "000";

                opp->field[0] = "000";
                opp->field[1] = "000";
                opp->field[2] = "000";

                opp->opp = this;
                //QByteArray gameID = QCryptographicHash::hash(uID + "VS" + opp->uID, QCryptographicHash::RealSha3_256).toBase64();
                socket->write("GINFO|"+opp->username.toUtf8()+'|'+opp->rating.toUtf8()+"|X|0");
                opp->opp = this;
                this->gaming = true;
                //connect(this, SIGNAL(oppMess(QByteArray)), opp, SLOT(oppMSLT(QByteArray)),Qt::DirectConnection);


                //emit oppMess(opp->socketDescriptor, "GINFO|"+username.toUtf8()+'|'+rating.toUtf8()+"|O");
                qDebug() << this->username << " COCK " << "NON opp thread numbah is: " << this->currentThreadId();
                //emit this->cock("GINFO|"+username.toUtf8()+'|'+rating.toUtf8()+"|O");
                //opp->moveToThread(this->thread());
                //opp->socket->moveToThread(this->thread());
                //opp->socket->write("GINFO|"+username.toUtf8()+'|'+rating.toUtf8()+"|O");
                break;
            }
        }
        //qDebug()<< "MY NAME IS " << username <<" AND IM STUCK NOW";
        while(true && !gaming)
        {
            //qDebug()<< "MY NAME IS " << username <<" AND IM STUCK";
            if (opp)
            {
                qDebug()<< "MY NAME IS " << username <<" AND IM NOT STUCK ANYMORE";
                socket->write("GINFO|"+opp->username.toUtf8()+'|'+opp->rating.toUtf8()+"|O|1");
                opp->gaming = true;
                break;
            }
        }
        //socket->write("wait for players);

    }
    else if (DataSheet[1] == "GAME")
    {
        qDebug() << DataSheet[2];
        qDebug() << DataSheet[3];
        qDebug() << DataSheet[4];
        int i = DataSheet[2].toInt();
        int j = DataSheet[3].toInt();
        //field[i][j] = DataSheet[4][0];
        qDebug() << username << i << j;
        emit opp->self()->cock("MOVE|"+QString::number(i).toUtf8()+'|'+QString::number(j).toUtf8());
        socket->write("MOVE|"+QString::number(i).toUtf8()+'|'+QString::number(j).toUtf8());
    }
    //socket->write(Data);
}
//TODO::: FUCK IT, PLAY BY SQL
//NO ACTUALLY, JUST REMAKE THE SOCKETS maybe?
void MyThread::oppMSLT(qintptr socketDescriptor, QByteArray mess)
{
    qDebug() << username << "wait...";
    socket->write(mess);
}

void MyThread::balls(QByteArray mess)
{
    qDebug() << this->username << " BALLS" << "opp thread numbah is: " << this->currentThreadId();
    socket->write(mess);
}

void MyThread::disconnected()
{
    qDebug() << socketDescriptor << " Disconnected";
    clients->removeOne(this);
    uID = NULL;

    socket->deleteLater();
    exit(0);
}
