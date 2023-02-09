#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <vector>
#include <map>
#include <list>
#include <thread>
#include <condition_variable>
#include <queue>

//#include <functional>



class piece
{
    public:
        std::string el;
        int locExecPr;

        piece(std::string str, int val)
        {
            el = str;
            locExecPr = val;
        }

        piece(std::string str)
        {
            el = str;
            locExecPr = 0;
        }

        piece(char c, int val)
        {
            el = std::string{c};
            locExecPr = val;
        }
};




using OPFunc = void (*)(std::list<piece>&, std::list<piece>::iterator);
using SolverFunc = void (*)(std::vector<std::list<piece>>&, int, bool);

//using OPFunc2 = void (*)();

const char* FILENAME = "Intro.txt";
//std::map<char, int, std::function<void>> OPERATORS;
std::map<char, std::pair<int, OPFunc>> OPERATORS;
//std::map<char, std::function<void>>;

const int MAX_OP_PRIORITY = 3;

class ThreadPool
{
    public:

    ThreadPool(unsigned int n = std::thread::hardware_concurrency())
    {
        start(n);
    }
    ~ThreadPool()
    {
        end();
    }

    void destroy()
    {
        end();
    }

    void enqueue(SolverFunc fun, std::vector<std::list<piece>>& eq, int id)
    {
        {
            std::unique_lock<std::mutex> lock{eventMTX};
            tasks.emplace(std::move(fun));
            tEq = eq;
            tId = id;
        }
        eventVar.notify_one();
    }
    private:

    std::vector<std::list<piece>> placeholder;
    std::vector<std::list<piece>>& tEq = placeholder;
    int tId;

    std::queue<SolverFunc> tasks;
    std::mutex eventMTX;
    std::condition_variable eventVar;
    std::vector<std::thread> tPool;
    bool stopping = false;
    
    void start(unsigned int n)
    {
        for (unsigned int i = 0; i < n; i++)
        {
            tPool.emplace_back([=]
            {
                while(true)
                {
                    SolverFunc task;
                    {
                        std::unique_lock<std::mutex> lock{eventMTX};

                        eventVar.wait(lock, [=]{return stopping || !tasks.empty(); });

                        if (stopping)
                            break;
                        task = std::move(tasks.front());
                        tasks.pop();
                    }
                    task(tEq, tId, true);
                }
            });
        }
    }

    void end()
    {
        {
            std::unique_lock<std::mutex> lock{eventMTX};
            stopping = true;
        }

        eventVar.notify_all();
        for (auto &thread : tPool)
        {
            std::cout<<"trying to stop\n";
            if (thread.joinable())
                thread.join();
            else
                thread.detach();
            std::cout<<"stopped successfully\n";
        }
    }
    
};

void binaryDelete(std::list<piece>& eq, std::list<piece>::iterator it)
{
    eq.erase(next(it));
    eq.erase(prev(it));
}

void plus(std::list<piece>& eq, std::list<piece>::iterator it)
{
    it->el = std::to_string(atof(prev(it)->el.c_str())+atof(next(it)->el.c_str()));
    binaryDelete(eq, it);
}

void minus(std::list<piece>& eq, std::list<piece>::iterator it)
{
    it->el = std::to_string(atof(prev(it)->el.c_str())-atof(next(it)->el.c_str()));
    binaryDelete(eq, it);
}

void multiply(std::list<piece>& eq, std::list<piece>::iterator it)
{
    it->el = std::to_string(atof(prev(it)->el.c_str())*atof(next(it)->el.c_str()));
    binaryDelete(eq, it);
}

void divide(std::list<piece>& eq, std::list<piece>::iterator it)
{
    it->el = std::to_string(atof(prev(it)->el.c_str())/atof(next(it)->el.c_str()));
    binaryDelete(eq, it);
}

void fillUpOp()
{
    OPERATORS.emplace('+', std::make_pair(1, (OPFunc)plus));
    OPERATORS.emplace('-', std::make_pair(1, (OPFunc)minus));
    OPERATORS.emplace('*', std::make_pair(2, (OPFunc)multiply));
    OPERATORS.emplace('/', std::make_pair(2, (OPFunc)divide));
    OPERATORS.emplace('^', std::make_pair(3, (OPFunc)plus));
}

class introExcept: public std::exception
{
    virtual const char* what() const throw()
    {
        return "Something happened to the intro file dawg";
    }
} introEx;

class formatExcept: public std::exception
{
    virtual const char* what() const throw()
    {
        return "You fucked up the formatting dawg";
    }
} formatEx;

void Intro()
{
    std::fstream file;
    file.open(FILENAME, std::ios::in);
    if (file.is_open())
    {
        std::string line;
        std::getline(file, line);
        std::replace(line.begin(), line.end(), '|', '\n');
        std::cout<<line;
        file.close();
    }
    else
    {
        throw(introEx);
    }
}


int interesting(char c)
{
    auto it = OPERATORS.find(c);
    if (it != OPERATORS.end())
        return(it->second.first);
    else
        return(0);
}

int InternalManager(std::string &eq, int end, int start, int id, std::vector<std::list<piece>> &equation)
{
    int lastPos = start;

    for (int i = start; i < end; i++)
    {
        if (i == end-1 && eq[i] != ')')
            equation[id].push_back(piece{eq.substr(lastPos, i-lastPos+1)});

        if ((eq[i] >= '0' && eq[i] <= '9')||(eq[i] >= 'a' && eq[i] <= 'z')||(eq[i] >= 'A' && eq[i] <= 'Z')||eq[i] == '_' || eq[i] == '.')
            continue;
        
        if (eq[i]=='(')
        {
            int temp = equation.size();
            equation[id].push_back(piece{"#"+std::to_string(temp)});
            equation.push_back(std::list<piece>());
            i = InternalManager(eq, end, i+1, temp, equation);
            lastPos=i+1;
            continue;
        }
        
        if (eq[i] == ')')
        {
            equation[id].push_back(piece{eq.substr(lastPos, i-lastPos)});
            return(i);
            continue;
        }

        if (int in = interesting(eq[i]))
        {
            if (eq[i-1] != ')')
                equation[id].push_back(piece{eq.substr(lastPos, i-lastPos)});
            equation[id].push_back(piece{eq[i], in});
            lastPos = i+1;
        }
        else
        {
            throw(formatEx);
        }
    }
    return(lastPos);
}

std::vector<std::list<piece>> EquationManager(std::string &eq, int end)
{
    std::vector<std::list<piece>> equation(1);
    InternalManager(eq, end, 0, 0, equation);
    return(equation);
}

void simpleSolver(std::vector<std::list<piece>> &eq, int id, bool init = true)
{
    int workPriority = MAX_OP_PRIORITY;
    
    //std::vector<std::list<piece>::iterator> hashs;

    while (workPriority > 0)
    {
        //std::cout<<std::this_thread::get_id<<"::"<<workPriority<<'\n';
        std::list<piece>::iterator it = eq[id].begin();
        std::list<piece>::iterator end = eq[id].end();
        while (it != end)
        {
            //if (init && it->el[0] == '#')
           // {
            //    if (std::find(hashs.begin(), hashs.end(), it) == hashs.end())
            //        hashs.push_back(it);
           // }
            
            if (it->locExecPr == workPriority && prev(it)->el[0] != '#' && next(it)->el[0] != '#')
            {
                //CHECK NEAR #
                if (((next(it, 3) != end && next(it, 3)->el[0] == '#') && (it->locExecPr < next(it, 2) ->locExecPr)) ||
                ((std::distance(eq[id].begin(), it) >= 3 && prev(it, 3)->el[0] == '#') && (it->locExecPr < prev(it, 2) ->locExecPr)))
                {
                    it++;
                    continue;
                    //std::cout<<"I LOVE BALLS "<<next(it, 3)->el<<' '<<it->el<<'\n';
                }

                //CHECK COMPLETE

                auto temp = OPERATORS.find(it->el[0]);
                if (temp != OPERATORS.end())
                    temp->second.second(eq[id], it);
                else
                {
                    std::cout<<"IDK WTF HAPPENED DAWG\n";
                    throw(formatEx);
                }
                //opWorker(it);
                //std::cout<<it->el;
            }
            it++;
        }
        workPriority--;
    }
    /*
    if (init && !hashs.empty())
    {
        while(true)
        {
            int i = 0;
            while(i < hashs.size())
            {
                if (hashs[i]->el[0]=='#' && eq[stoi(hashs[i]->el.substr(1, hashs[i]->el.size()-1))].size() == 1)
                {
                    std::cout<<"Trying to change "<<hashs[i]->el<<" in "<<id<<'\n';
                    hashs[i]->el = (eq[stoi(hashs[i]->el.substr(1, hashs[i]->el.size()-1))]).begin()->el;
                    std::cout<<"success?"<<'\n';
                    //__outputEq2(eq);
                    std::cout<<"size before erase: "<<hashs.size()<<'\n';
                    hashs.erase(hashs.begin()+i);
                    std::cout<<"size after erase: "<<hashs.size()<<'\n';
                    i = 0;
                    continue;
                }
                i++;
            }
            if (hashs.size() == 0)
            {
                std::cout<<"well then\n";
                simpleSolver(eq, id, false);
                break;
            }
        }
    }
    */
}

void __outputEq(std::vector<std::list<piece>> eq)
{
    int n = eq.size();
    for (int i = 0; i < n; i++)
    {
        for (auto it = eq[i].begin(); it != eq[i].end(); it++)
        {
            std::cout<<i<<"::"<<it->el<<"::"<<it->locExecPr<<'\n';
        }
    }
}

void __outputEq2(std::vector<std::list<piece>> eq, int i = 0)
{
    for (auto it = eq[i].begin(); it != eq[i].end(); it++)
    {
        if (it->el[0] == '#')
        {
            std::cout<<'(';
            __outputEq2(eq, std::stoi(it->el.substr(1, it->el.size()-1)));
            std::cout<<')';
            continue;
        }
        std::cout<<it->el;
    }
    if (i==0)
        std::cout<<'\n';
}

void poopoo(std::list<piece>& eq, std::list<piece>::iterator it)
{
    std::cout<<"DOING "<<std::this_thread::get_id()<<'\n';
}

int main()
{
    Intro();
    int h;
    
    
    fillUpOp();

    std::vector<std::list<piece>> eqPcs;

    { //scope created to not drag std::string eq around during computation
        std::string eq;
        std::getline(std::cin, eq);
        //FOR DEBUGGING PURPOSES
        //eq = "2*(15+30*(45-7)-6)-3+(5*5)";
        std::cout<<eq<<'\n';
        int n = std::distance(eq.begin(), std::remove_if(eq.begin(), eq.end(), [](unsigned char x) { return std::isspace(x); }));
        eqPcs = EquationManager(eq, n);
    }
    
    for (int i = eqPcs.size() - 1; i >= 0; i--)
    {
        simpleSolver(eqPcs, i);
        __outputEq2(eqPcs);
    }
    
    return(0);
}