<!--
Project view page 
Gives all the people involved in a certain project
Features:
	Select department wide projects to generate
	view of people involved in project and their percentage effort 
	devoted to it
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
		}
?>

<?php
	if(!empty($connection))
	{
		$query = "call sp_project_info(" . '"' . $spinput . '")';
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
			<p>Project View</p>
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
									echo $row1["ProjectName"].'">'. $row1["ProjectName"] . '</option>';
								}
							}
						}
				?>
				</select>
				<input type="submit" name="Submit1" class="submit" value="Submit" />
			</form> 
			<?php
				if(!empty($connection))
				{
					$NumOfRows = mysqli_num_rows($result);
					$Index = 0;
					if ($NumOfRows == 0)
					{
						echo "No view found.";
					} else{
						echo '<table style="border: 1px solid black; font-size: 16px;">';
						echo '<caption>
						Project View: ';
						echo "</caption>";
						echo "<thead>
							<tr>";
						$row = mysqli_fetch_assoc($result);

						foreach($row as $k => $v ) 
						{       
							echo "<th>".$k."</th>";
						}
			
						echo "	</tr>
						</thead>
						<tbody>";

						$check = mysqli_data_seek($result, 0);
				
						while ($rownew = mysqli_fetch_assoc($result))
						{
							echo "<tr>";
							foreach($rownew as $k => $v)
							{
								echo "<td>".$v."</td>";
							}
							echo "</tr>";	
						}
				 
						echo "	</tbody>
						</table>";
					}
				}
			?>
		</div>
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