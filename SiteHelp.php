<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<title>Help Page</title>
		<link rel="stylesheet" type="text/css" href="Style.css"/>
	</head>
	<body>
		<header>
			<h1>Site Help</h1>
		</header>
		<input value="Go Back to Home Page" onclick="window.location.href='MainPage.php'" type="button">
		<div class="helpsection">
			<a href="#difdept"><h3>Entering Different Department Views</h3></a>
			<a href="#insertpeople"><h3>Inserting People Into the Tracker</h3></a>
			<a href="#insertproject"><h3>Inserting Projects Into the Tracker</h3></a>
			<a href="#assignproject"><h3>Assigning Projects to People</h3></a>
			<a href="#removeassc"><h3>Removing People from Projects</h3></a>
			<a href="#testposs"><h3>Testing Possible Project Assignments</h3></a>
			<a href="#viewinfo"><h3>Viewing Person and Project Information</h3></a>
			<a href="#changestatus"><h3>Changing a Project's Status</h3></a>
			<a href="Grant Percentage Tracker Docs.docx" download>Click To Download Full Docs</a>
			<h4 id="difdept">Selecting Department</h4>
			<img src="images/help11.JPG"/>
			<p>Select a department from the drop down menu on the home page. The selected
			department will continue to apply through the rest of the session (as long as the browser
			window is open). This means that any name or project entered will be entered under that 
			department. If a multi-departmental view is wanted, select "All Department View". This will
			allow entering of people/projects to any department desired and will show all information in
			the database. 
			</p>
			<h4 id="insertpeople">Inserting People Into the Tracker</h4>
			<img src="images/help1.JPG"/>
			<p>To insert a person into the percent effort tracker. Click on "Person Input"
			This will take you to a page to insert a person's name. The name can be inserted
			in any format, but a standard should be followed throughout departments. To enter
			the name, click Submit. 
			</p>
			<h4 id="insertproject">Inserting Projects Into the Tracker</h4>
			<img src="images/help2.JPG"/>
			<p>Inserting a Project into the tracker is also simple. Click on "Project Input" on
			the main page and insert the project information in the form provided. The large text box
			is for the formal project title, that can be copy-and-pasted from the source. The start
			and end dates for the project should be entered in US (mm/dd/YYYY) format. Project status
			can also be selected at time of entry.
			</p>
			<p>Notes: For assigning purposes, it may work best to enter a project as active, test the project
			percentages on the "Test Percentages" page, and then change the project status later.
			Projects entered have no limit on start or stop dates, but can only have one percentage assigned
			to them. If a multi-year project within differing percentages needs to be assigned, the project can
			be broken down and entered multiple times, and then these parts of the project can be assigned 
			percentages.</p>
			<h4 id="assignproject">Assigning Projects to People</h4>
			<img src="images/help3.JPG"/>
			<p>Assign entered projects to a person by clicking on the "Assign Projects" link. Select the
			person and project, then enter in the effort percentage for that association. 
			</p>
			<h4 id="removeassc">Removing People From Projects</h4>
			<img src="images/help4.JPG"/>
			<p>To remove an association between a person and a project, click on the "Remove Data" link.
			This will take you to a page where you can select the person/project association you wish to remove.
			</p>
			<p>Note: If a person is the last to be associated with a specific project, removing that association
			through this page will delete the project. If you want to keep a project with a person but not have the 
			percentage be counted, change the project status to pending or inactive. 
			</p>
			<h4 id="testposs">Testing Possible Project Assignments</h4>
			<img src="images/help5.JPG"/>
			<p>The "Test Percentages" page allows testing of different possible percent efforts for projects already
			entered into the site. No new data is entered into the site from this page, so one can freely test different
			percentages. Select the person and project you wish to test, then enter in the percentage you want to test 
			with that association. Also enter a date which will be used as the starting point for viewing a year in advance.
			</p>
			<img src="images/help6.JPG"/>
			<p>Upon submission, a table is generated that shows percentages on the year from the given date, separated into
			monthly sections. The projects the person is involved with on that date will be shown to the right. If the test 
			percentage puts a person over 100%, the box will be highlighted red. 
			</p>
			<h4 id="viewinfo">Viewing Person and Project Information</h4>
			<img src="images/help7.JPG"/>
			<p>To view a person's project load, click on the "Person View" link. Select a project from the drop down menu.
			The table generated shows all the projects that have ever been assigned to that person, regardless of active status,
			and the percent associated with that assignment. The projects are color-coded based on status with blue being active, 
			yellow being pending, and red being inactive.
			</p>
			<img src="images/help8.JPG"/>
			<p>To see a view of all the people working on a project and their associated percentages, click "Project View". Select
			a project from the drop down form. The table shows the name of the person assigned to the project, and the percentage assigned. 
			</p>
			<img src="images/help9.JPG" style=width:800px;height:auto;/>
			<p>Select "Project Information" to see all information associated with a project, including the PI, Prime Site, and Formal Project
			Title.
			</p>
			<h4 id="changestatus">Changing a Project's Status</h4>
			<img src="images/help10.JPG"/>
			<p>Changing a project's status is done through the "Change Project Status" page. Here select the project whose status you want to 
			change, and tick the project status you want to change to. Projects that are marked pending or inactive do not show up in the percentage 
			calculations of the current effort view or testing view, and are marked by their colors on the person view. However, information about 
			the project can still be seen, including the assigned percentages, even if a project is pending or inactive. 
			</p>
		</div>
	</body>
</html>