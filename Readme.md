#GraphCalculator

This is a simple calculator that can:
1. Evaluate arithmetic expressions containing a variable X
2. Graph the expression using X as an independent variable

The project initially started as a homework to Standford CS193P (iPhone apps development), which I was following on Itunes U.
In the first implementation you had to specify expressions using postfix notation. Then I added support for infix notation using 
the recursive descent method (I had earlier implemented it in Java in my Parser project) and improved the graphing module. Notice that
I am using DrawAxes class provided in Stanford CS193P course to draw the coordinate system.

##Usage
1. Press "Set X" to specify the value of X variable
2. Press "X" to add the variable to your expression
3. Press "=" to evaluate the expression
4. Press "Graph" to graph the expression

##Details
1. Uses auto-layout and looks properly on any iOS device in any orientation
2. Uses split-view controller to show the calculator and the grapher when running on iPad (and iPhone 6 Plus in landscape)
3. Uses the recursive descent algorithm to evaluate expressions
4. Uses DrawAxes class provided in Stanford CS193P course to draw the coordinate system. 