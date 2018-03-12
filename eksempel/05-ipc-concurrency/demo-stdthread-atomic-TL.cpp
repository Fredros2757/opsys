/*	Std::threads and Atomic values
	Writen by Thomas E.Y. Lund

	Poenget med dette programmet er � vise hvordan vi kan bruke atomic for � passe p� at threads
	ikke komme i en race condition. Programmet bruker en par 'nye' metoder slik som atomic<variabel type>, thread() og thread.join()
	Disse er forklart unner.

    kompilerer p� Linux med g++ -Wall -std=c++11 -pthread -o demo-stdthread-atomic-TL demo-stdthread-atomic-TL.cpp
*/

#include <atomic>	//	std::atomic  Dette er c++ 11 sin atomic. 
#include <thread>	//	std::thread  Ett av c++ sitt beste tr�d library. c++ 11
#include <iostream>	//	standard IO


using namespace std;


//	Denne klassen brukes som en samling av nummeret og funksjonene.
class AtomicIncDec
{
private:
	//	Atomic verdier m� defnieres via atomic<variable type>.
	atomic<int> number;

public:
	//	Constructoren brukes for � sette nummeret til 0 som skal v�re sluttresultatet ogs�.
	AtomicIncDec()
	{
		number = 0;
	}
	//	Denne teller opp den atomiske verdien med 1.
	void operator++(int inc)
	{
		number++;
	}
	//	Denne reduserer den atomiske verdien med 1.
	void operator--(int dec)
	{
		number--;
	}
	//	Denne printer ut nummerets resultat. Den brukes p� slutten av en loop.
	void printSelf()
	{
		//	Bruker cout fordi printf() ikke takler atomic uten litt casting og slikt.
		cout << "My number is " << number.operator int() << '\n';
		
	}
}; 

//	Predefinerer funksjoner.
void increase();
void decrease();

//	Globale variabler.
AtomicIncDec incDec;
int COUNT = 10000000;
int ITERATIONS = 20;

int main()
{
	//	Looper for mengden iterasjoner man �nsker. Denne har ingen p�virkning p� selve increment/decrement
	for (int i = 0; i < ITERATIONS; i++)
	{
		//	std::thread defineres ved at man sender med en funksjon.  thread* navn = new thread(funksjon,variabel=NULL) Hvor variablen kan utelates
		thread *incThread = new thread(increase);
		thread *decThread = new thread(decrease);
		

		//	join() sier att programmet skal vente intil tr�den er ferdig � kj�re. Vi joiner begge tr�dene slik at vi er sikkre p� at tr�dene er ferdig.
		incThread->join();
		decThread->join();
		
		//	Vi printer s� ut summen og looper om igjen
		incDec.printSelf();
	}

	//	Disse er her for � stoppe programmet n�r det er ferdig.
	cin.get();
	cin.get();

	return 0;
}

//	�ker verdien, Denne blir sendt til incThread
void increase()
{
	for (int i = 0; i < COUNT; i++)
	{
		incDec++;
	}
}
//	reduserer verdien, Denne blir sendt til decThread
void decrease()
{
	for (int i = 0; i < COUNT; i++)
	{
		incDec--;
	}
}


