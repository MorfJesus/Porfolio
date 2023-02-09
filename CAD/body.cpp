#include <iostream>
#include <vector>
#include <random>
#include "head.h"

std::ostream& operator<<(std::ostream& os, const Point3D pnt)
{
	os<<"X: "<<pnt.x<<" Y: "<<pnt.y<<" Z: "<<pnt.z;
	return(os);
}


void Circle::printInfo()
{
	std::cout<<"Circle\tof\tradiusX = "<<radX<<'\n';
}
void Ellipse::printInfo()
{
	std::cout<<"Ellipse\tof\tradiusX = "<<radX<<",\t radiusY = "<<radY<<'\n';
}
void Helix::printInfo()
{
	std::cout<<"Helix\tof\tradiusX = "<<radX<<",\t step = "<<step<<'\n';
}	

int main()
{
	std::random_device rd;
	std::mt19937 gen(rd());
	int min_size = 1;
	int max_size = 30;
	std::uniform_int_distribution<int> unif_size(min_size, max_size);
	int size = unif_size(gen);
	std::vector<std::shared_ptr<Curve3D>> curves(size);
	
	double d_min = 1E-15;
	double d_max = 10.0;
	std::uniform_real_distribution<double> unif_d(d_min, d_max);
	std::uniform_int_distribution<int> unif_el(0, 2);
	std::vector<std::shared_ptr<Circle>> circles;
	std::cout<<"First container's curves:\n";
	for (int i = 0; i < size; i++)
	{
		switch(unif_el(gen))
		{
			case 0:
				curves[i] = std::make_shared<Circle>(unif_d(gen));
				break;
			case 1:
				curves[i] = std::make_shared<Ellipse>(unif_d(gen), unif_d(gen));
				break;
			case 2:
				curves[i] = std::make_shared<Helix>(unif_d(gen), unif_d(gen));
				break;
		}
		curves[i]->printInfo();
		std::cout<<'\t'<<"at t = PI/4:\tpoint: "<<(curves[i]->getPoint(PI/4))<<"\n\t\t\tfirst derivative: "<<(curves[i]->getFrstDiv(PI/4))<<'\n';	
		auto potCircle = std::dynamic_pointer_cast<Circle>(curves[i]);
		if (potCircle)
			circles.push_back(potCircle);
	}
	double sum = 0;
	if (!circles.empty())
	{	
		std::sort(circles.begin(), circles.end(), custSrt);
		std::cout<<"Second container, containing only circles from the first one:\n";
		for (auto it = circles.begin(); it != circles.end(); it++) 
			(*it)->printInfo();
		
		#pragma omp parallel for reduction(+:sum)
		for (auto it = circles.begin(); it != circles.end(); it++)
			sum+=(*it)->radX;
	}
	else
		std::cout<<"No circles found in the first container\n";
	std::cout<<"The sum of 2nd container's radii = "<<sum<<'\n';
}
