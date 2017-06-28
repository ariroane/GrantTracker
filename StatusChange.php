<!--
Activate Project page
Allows updating the ProjectStatusCd in project records to
reflect changes in the status of the project (active, inactive, pending)
Features:
	Select department wide projects
-->
<?php
	session_start();
	$department = $_SESSION['department'];
	// echo "Your department is: " . $department;
?>

<?php
	if (isset($_POST['Submit1']) 
		&& !empty($_POST['spinput']))
		{
			require_once "Dbconnection.php";
			$spinput = mysqli_real_escape_string($connection, htmlentities($_POST["spinput"]));
			$status = mysqli_real_escape_string($connection, htmlentities($_POST["statuscode"]));
		}
?>

<?php
	if(!empty($connection))
	{
		$query = "UPDATE project SET ProjectStatusCd =" . $status . " WHERE idProject =" . $spinput;
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
		<title>Percent Effort Tracker</title>
		<link rel="stylesheet" type="text/css" href="Style.css"/>
	</head>
	<body>
		<header>
			<p>Change Project Status</p>
		</header>
			<div class=personview>
				<form name="form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" >
					<select name=spinput>
						<option value="">Select a Project</option>
						<?php 
						# Took out user information
							$dbhost ="";
							$dbuser = "";
							$dbpass = "";
							$dbname = "grantcalcdb";
							$connection2 = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
						?>
						<?php
							if (!empty($connection2))
							{
								$projects = "SELECT * FROM project WHERE idDepartment " . $department;
								$result1 = mysqli_query($connection2, $projects);
								if (!$result1)
								{
									echo $projects;
									die("Database query failed.");
								}
								$NumOfRows1= mysqli_num_rows($result1);
								$Index1 = 0;
								if ($NumOfRows1 == 0)
								{
									echo "No projects in database";
								} 
								else{
									while ($row1 = mysqli_fetch_assoc($result1))
									{
										echo '<option value="';
										echo $row1["idProject"].'">'. $row1["ProjectName"] . '</option>';
									}
								}
							}
					?>
					</select>
					<br>
					<input type="radio" name="statuscode" id="status1" value="1" checked>Active</input>
					<input type="radio" name="statuscode" id="status1" value="2">Pending</input>
					<input type="radio" name="statuscode" id="status1" value="0">Inactive</input>
					<input type="submit" name="Submit1" class="submit" value="Submit" />
				</form> 
			<input value="Go Back to Home Page" onclick="window.location.href='MainPage.php'" type="button">
			<?php 
				if(!empty($connection))
				{
					if($result)
					{
						echo '<p>Input Sucess</p>';
					}
				}
			?>
		</div>
	</body>
</html>
<?php
	// close database connection
	if(!empty($connection))
	{
		mysqli_close($connection);
	}
	if(!empty($connection2))
	{
		mysqli_close($connection2);
	}
?>