<!-- 
Delete data page
Features:
	Select department wide project and person
	Unlink selected project person
	Deletes project if person is unlinked and was last to hold project
	Person remains in database 
-->
<?php
	session_start();
	$department = $_SESSION['department'];
	// echo "Your department is: " . $department;
?>

<?php
	if (isset($_POST['submit1']) 
		&& !empty($_POST['spinput1']) 
		&& !empty($_POST['spinput2']))
	{
		require_once "Dbconnection.php";
		$spinput1 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput1"]));
		$spinput2 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput2"]));
	}
?>

<?php
	if(!empty($connection))
	{
		$query = "call sp_remove_record(" . '"' . $spinput1 . '"' . ',' . '"' . $spinput2 . '")';
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
        CalcDeleteData.php
    </title>
    <link rel="stylesheet" type="text/css" HREF="Style.css">
</head>
<body>
	<header>
		<p>Delete a Record</p>
	</header>
	<p>
		<div class=tool style="margin-left:50px; margin-top:80px;">
			<form name="form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" >
				<select name=spinput1>
					<option value="">Select a Person</option>
					<?php 
						$dbhost ="localhost:3306";
						$dbuser = "genentry";
						$dbpass = "dogFrisby2";
						$dbname = "grantcalcdb";
						$connection2 = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
					?>
					
					<?php
						if (!empty($connection2))
						{
							$persons = "SELECT * FROM person WHERE idDepartment " . $department;
							$result1 = mysqli_query($connection2, $persons);
							if (!$result1)
							{
								echo $persons;
								die("Database query failed.");
							}
							$NumOfRows = mysqli_num_rows($result1);
							$Index = 0;
							if ($NumOfRows == 0)
							{
								echo "No people in database";
							} 
							else{
								while ($row1 = mysqli_fetch_assoc($result1))
								{
									echo '<option value="';
									echo $row1["LastFirstName"].'">'. $row1["LastFirstName"] . '</option>';
								}
							}
						}
					?>
					
				</select>
				<select name=spinput2>
					<option value="">Select a Project</option>
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
							$NumOfRows = mysqli_num_rows($result1);
							$Index = 0;
							if ($NumOfRows == 0)
							{
								echo "No projects in database";
							} 
							else{
								while ($row1 = mysqli_fetch_assoc($result1))
								{
									echo '<option value="';
									echo $row1["ProjectName"].'">'. $row1["ProjectName"] . '</option>';
								}
							}
						}
					?>
					
					<?php
					// close database connection
					if(!empty($connection2))
					{
						mysqli_close($connection2);
					}
					?>
					
				</select>
				<p style=font-size:12px;>Delete a record. If last person to have record, project will be deleted</p>
				<input type="submit" name="submit1" class="submit" value="Submit" /> 
			</form>
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
	</p>
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