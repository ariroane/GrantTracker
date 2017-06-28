<!-- 
Assign Projects page
Projects need to already be entered into the database
Features:
	Allows selection of department wide people and and projects and establishes a link 
	between them in the projecteffort table; percentage for that link is entered as well
-->

<?php
	session_start();
	$department = $_SESSION['department'];
	// echo "Your department is: " . $department;
?>

<?php
	if (isset($_POST['submit1']) 
		&& !empty($_POST['spinput1']) 
		&& !empty($_POST['spinput2']) 
		&& !empty($_POST['spinput3'])) 
	{
		require_once "DbConnection.php";
		$spinput1 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput1"]));
		$spinput2 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput2"]));
		$spinput3 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput3"]));
	}
?>

<?php
	if(!empty($connection))
	{
		$query = "call sp_insert_rel(" . '"' . $spinput1 . '"'. ',' . '"' . $spinput2 . '"' . ','  . $spinput3 . ')';
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
        CalcInput.php
    </title>
    <link rel="stylesheet" type="text/css" HREF="Style.css">
</head>
<body>
	<header>
		<p>Link a Person to a Project</p>
	</header>
	<p>
		<div class=tool style="margin-left:50px; margin-top:80px;">
			<form name="form1" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" >
				<p>
					<select name=spinput1>
						<option value="">Select a Person</option>
						<?php 
						# Took out user credentials
							$dbhost ="";
							$dbuser = "";
							$dbpass = "";
							$dbname = "grantcalcdb";
							$connection2 = mysqli_connect($dbhost, $dbuser, $dbpass, $dbname);
						?>
						<?php
							if (!empty($connection2))
							{
							$persons = "SELECT * FROM person where idDepartment " . $department;
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
							$projects = "SELECT * FROM project where idDepartment " . $department;
							$result2 = mysqli_query($connection2, $projects);
							if (!$result2)
							{
								echo $projects;
								die("Database query failed.");
							}
							$NumOfRows = mysqli_num_rows($result2);
							$Index = 0;
							if ($NumOfRows == 0)
							{
								echo "No people in database";
							} 
							else{
								while ($row1 = mysqli_fetch_assoc($result2))
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
					<input type="text"  name="spinput3" placeholder="54"/>
				</p>
				<input type="submit" name="submit1" class="submit" value="Submit" /> 
			</form>
		</div>
	</p>
	<?php 
		if(!empty($connection))
		{
			if($result)
			{
				echo '<p>Input Sucess</p>';
			}
		}
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