#include "connectedfellow.h"
#include <QtSql>

ConnectedFellow::ConnectedFellow(qintptr ID, QList<ConnectedFellow*> *clients)
{
    qDebug() << "New socket started";
    this->socketDescriptor = ID;
    socket = new QTcpSocket();

    if(!socket->setSocketDescriptor(this->socketDescriptor))
    {
        // something's wrong, we just emit a signal
        //emit error(socket->error());
        return;
    }

    connect(socket, SIGNAL(readyRead()), this, SLOT(readyRead()), Qt::DirectConnection);
    connect(socket, SIGNAL(disconnected()), this, SLOT(disconnected()));

    this->clients = clients;
    qDebug() << socketDescriptor << " Client connected";
}

bool addVal(QString username, QByteArray pass, QByteArray salt)
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

bool ConnectedFellow::attemptRegister(QByteArray login, QByteArray pass, QByteArray salt)
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
    if(addVal(QString(login), hashPswd, salt))
    {
        username = login;
        return(true);
    }
    else
    {
        return(false);
    }
}

bool ConnectedFellow::attemptLogin(QByteArray login, QByteArray pass, QByteArray salt, QString &logData)
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

bool checkCol(QString field[3], int j, QString let)
{
    return(field[0][j] == let && field[1][j] == let && field[2][j] == let);
}

bool checkRow(QString line, QString let)
{
    return(line[0] == let && line[1] == let && line[2] == let);
}

bool checkDiag(QString field[3], QString let)
{
    return(field[0][0] == let && field[1][1] == let && field[2][2] == let);
}

bool checkAntiDiag(QString field[3], QString let)
{
    return(field[0][2] == let && field[1][1] == let && field[2][0] == let);
}

QString checkEndGame(QString field[3], QString let, int i, int j)
{
    //QString tester(3, let);
    if (checkRow(field[i], let))
        return ("ROW|"+QString::number(i));
    if (checkCol(field, j, let))
        return ("COL|"+QString::number(j));
    if (i == j && checkDiag(field, let))
        return ("DIAG");
    if (i + j == 2 && checkAntiDiag(field, let))
        return ("ADIAG");
    return("");
}

void ConnectedFellow::readyRead()
{
    qDebug() << socketDescriptor << " reading on thread ";
    QByteArray Data = socket->readAll();
    qDebug() << socketDescriptor << " Data in: " << Data;
    QList<QByteArray>DataSheet = Data.split('|');
    qDebug() << socketDescriptor << DataSheet[1]; //REG

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
            //disconnected();
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
            //disconnected();
        }
    }
    else if (DataSheet[1] == "SRCH")
    {
        searching = true;
        for (auto it = clients->begin(); it != clients->end(); it++)
        {
            if ((*it)->searching && (*it)->uID != uID)
            {
                opp  = (*it);
                qDebug() << uID << "VS" << (*it)->uID;
                searching = false;
                opp->searching = false;

                field[0] = "000";
                field[1] = "000";
                field[2] = "000";

                opp->field[0] = "000";
                opp->field[1] = "000";
                opp->field[2] = "000";

                opp->opp = this;
                socket->write("GINFO|"+opp->username.toUtf8()+'|'+opp->rating.toUtf8()+"|X|0");
                opp->socket->write("GINFO|"+username.toUtf8()+'|'+rating.toUtf8()+"|O|1");
                break;
            }
        }
    }
    else if (DataSheet[1] == "GAME")
    {
        qDebug() << DataSheet[2];
        qDebug() << DataSheet[3];
        qDebug() << DataSheet[4];
        int i = DataSheet[2].toInt();
        int j = DataSheet[3].toInt();
        field[i][j] = DataSheet[4][0];
        opp->field[i][j] = DataSheet[4][0];
        qDebug()<<field[0]<<'\n'<<field[1]<<'\n'<<field[2];
        qDebug() << username << i << j;
        opp->socket->write("MOVE|"+QString::number(i).toUtf8()+'|'+QString::number(j).toUtf8());
        socket->write("OKIEDOKE");
        //checkEndGame(field, uLetter, i, j);
    }

}
