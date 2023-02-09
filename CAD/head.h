#include <cmath>
#include <memory>
#include <algorithm>

const double PI = 3.14159265358979;
class IncorrectRadiusException: public std::exception
{
	public:
		const char* what() const throw()
		{
			return "Incorrect radius value (radii should be positive values)";
		}
};

struct Point3D
{
	double x{0};
	double y{0};
	double z{0};
	Point3D operator- (Point3D const &p2)
	{
		return(Point3D{x-p2.x, y-p2.y, z-p2.z});
	}
};

class Curve3D
{
	public:
		double radX;
		Curve3D(double rad)
		{
			if (rad <= 0.0)
				throw IncorrectRadiusException();
			radX = rad;
		}
		virtual Point3D getPoint(double t)
		{
			return(Point3D{});
		}
		virtual void printInfo()
		{
		}
		virtual Point3D getFrstDiv(double t)
		{
			return(Point3D{});
		}
		bool operator <(const Curve3D& crv)
		{
			return(radX<crv.radX);
		}
};

class Circle: public Curve3D
{
	public:
		Circle(double radx) : Curve3D{radx} 
		{
		}
		Point3D getPoint(double t) override
		{
			return(Point3D{radX*cos(t), radX*sin(t), 0});
		}
		Point3D getFrstDiv(double t) override
		{
			return(Point3D{-radX*sin(t), radX*cos(t), 0});
		}
		void printInfo() override;
		//{
		//	std::cout<<"Circle\tof\tradiusX = "<<radX<<'\n';
		//}
};

class Ellipse: public Curve3D
{
	public:
		double radY;
		Ellipse(double radx, double rady) : Curve3D{radx}
		{
			if (rady <= 0.0)
				throw IncorrectRadiusException();
			radY = rady;
		}
		Point3D getPoint(double t) override
		{
			return(Point3D{radX*cos(t), radY*sin(t), 0});
		}	
		Point3D getFrstDiv(double t) override
		{
			return(Point3D{-radX*sin(t), radY*cos(t), 0});
		}
		void printInfo() override;
		//{
		//	std::cout<<"Ellipse\tof\tradiusX = "<<radX<<",\t radiusY = "<<radY<<'\n';
		//}
};

class Helix: public Curve3D
{
	public:
		double step;
		Helix(double radx, double stp) : Curve3D{radx}
		{
			if (stp == 0.0)
				throw IncorrectRadiusException();
			step = stp;
		}
		Point3D getPoint(double t) override
		{
			return(Point3D{radX*cos(t), radX*sin(t), step*t/(2*PI)});
		}
		Point3D getFrstDiv(double t) override
		{
			return(Point3D{-radX*sin(t), radX*cos(t), step/(2*PI)});
		}
		void printInfo() override;
		//{
		//	std::cout<<"Helix\tof\tradiusX = "<<radX<<",\t step = "<<step<<'\n';
		//}	
};

		//Circle::void printInfo() override
		//{
		//	std::cout<<"Circle\tof\tradiusX = "<<radX<<'\n';
		//}
		//Ellipse::void printInfo() override
		//{
		//	std::cout<<"Ellipse\tof\tradiusX = "<<radX<<",\t radiusY = "<<radY<<'\n';
		//}
		//Helix::void printInfo() override
		//{
		//	std::cout<<"Helix\tof\tradiusX = "<<radX<<",\t step = "<<step<<'\n';
		//}	
bool custSrt(std::shared_ptr<Circle> crc1, std::shared_ptr<Circle> crc2)
{
	return((*crc1)<(*crc2));
}

