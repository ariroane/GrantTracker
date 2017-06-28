<!-- 
Project Input page
Features:
	Fields for entering in project infromation
	Upon submission, information is inserted into the project table in the database 
	
	The formal tile submission box can take large text pasted into it
-->
<?php
	session_start();
	$department = $_SESSION['department'];
	// echo "Your department is: " . $department;
?>

<?php
	// Check that all input fields are filled
	if (isset($_POST['submit1']) 
		&& !empty($_POST['spinput1']) 
		&& !empty($_POST['spinput2']) 
		&& !empty($_POST['spinput3']) 
		&& !empty($_POST['spinput4']) 
		&& !empty($_POST['spinput5']) 
		&& !empty($_POST['spinput6']) 
		&& !empty($_POST['spinput7']))
	{
			
		// Assign variables, spinput8 is the department code from the session superglobal
		// Need a if to test spinput and replace it with 0 if in All Departments
		require_once "DbConnection.php";
		$spinput1 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput1"]));
		$spinput2 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput2"]));
		$spinput3 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput3"]));
		$spinput4 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput4"]));
		$spinput5 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput5"]));
		$spinput6 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput6"]));
		$spinput7 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput7"]));
		if ($department == "REGEXP '[0-9]'")
		{
			$spinput8 = mysqli_real_escape_string($connection, htmlentities($_POST["departmentsel"]));
		} else {
		$spinput8 = $_SESSION['department'];
		$spinput8 = str_replace('=', '', $spinput8);
		}
	}
?>

<?php
	// Test if connection is active and form SQL query
	// Get result (cursor) 
	if(!empty($connection))
	{
		$query = "insert into project (ProjectName, PI, PrimeSite, FormalProjectTitle, ProjectStartDate, ProjectEndDate, ProjectStatusCd, idDepartment)
		values (" . '"' . $spinput1 . '"'. ',' . '"' . $spinput2 . '"' . ',' . '"' . $spinput3 . '"' . ',' . '"' . $spinput4 . '"' . ',' . 'STR_TO_DATE(' . '"' . $spinput5 . 
		'"' . ',' . '"%m/%d/%Y")' . ',' . 'STR_TO_DATE(' . '"' . $spinput6 . '"' . ',' . '"%m/%d/%Y")' . ',' . '"' . $spinput7 . '"' . ',' . '"' . $spinput8 . '")';
		
		//echo $query."<br/>";
		
		$result = mysqli_query($connection, $query);
		if (!$result)
		{
			echo $query;
			die("Database query failed.");
		}
	}		
?>

<!DOCTYPE html>
<html lang='en'>
<head>
	<meta charset="UTF-8" /> 
    <title>
        ProjectInput.php
    </title>
    <link rel="stylesheet" type="text/css" HREF="Style.css">
</head>
<body>
	<header>
		<p>Input Project</p>
	</header>
	<p>
		<div class=tool style="margin-left:50px; margin-top:80px;">
			<form name="form1" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" >
				<p>
					<input type="text" name="spinput1" placeholder="Project Name"/>
					<input type="text" name="spinput2" placeholder="Project PI"/>
					<input type="text" name="spinput3" placeholder="Prime Site"/>
					<textarea name="spinput4" cols="40" rows="20" placeholder="Copy Formal Title Here"></textarea>
					<input type="text" name="spinput5" placeholder="Start Date (m/d/YYYY)"/>
					<input type="text" name="spinput6" placeholder="End Date (m/d/YYYY)"/>
					<select name=spinput7>
						<option value=1>Active</option>
						<option value=2>Pending</option>
						<option value=0>Inactive</option>
					</select>
					<?php if ($department == "REGEXP '[0-9]'"): ?>
						<select name=departmentsel>
							<option value="">Select a department</option>
							<option value="=1">Ambulatory</option>
							<option value="=2">B & B</option>
							<option value="=3">B3 Core</option>
							<option value="=4">Cardiovascular</option>
							<option value="=5">Health Services</option>
							<option value="=6">MCRC</option>
							<option value="=7">NRH</option>
							<option value="=8">OCGM</option>
						</select>
					<?php endif ?>
				</p>
				<input type="submit" name="submit1" class="submit" value="Submit" /> 
			</form>
		</div>
	</p>
	<?php 
		// Successful input message
		if(!empty($connection))
		{
		if($result)
		{
		echo '<p>Input Sucess</p>';
		}}
	?>
	<input value="Go Back to Home Page" onclick="window.location.href='MainPage.php'" type="button">
</body>
</html>
<?php
	// close database connection
	if(!empty($connection))
	{
		mysqli_close($connection);
	}
?>