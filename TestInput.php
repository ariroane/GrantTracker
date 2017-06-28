<!-- 
Test input page
Takes in a test project, person association with a percentage
along with a date that the user wants tested and 
generates the person's percent effort with that new association
ON that given date for a year ahead of that date (monthly)
Features:
	Select department wide project and person
	enter in percentage and test date 
	When estimation is over 100 percent, 
	the table row cell is generated red
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
	&& !empty($_POST['spinput3']) 
	&& !empty($_POST['spinput4'])) 
	{
		require_once "DbConnection.php";
		$spinput1 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput1"]));
		$spinput2 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput2"]));
		$spinput3 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput3"]));
		$spinput4 = mysqli_real_escape_string($connection, htmlentities($_POST["spinput4"]));
	}
?>

<?php
	if(!empty($connection))
	{
		$query = "call sp_test_input(" . '"' . $spinput1 . '"'. ',' . '"' . $spinput2 . '"' . ',' . '"' . $spinput3 . '"' . ',' . '"' . $spinput4 . '")';
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
        CalcTestInput.php
    </title>
    <link rel="stylesheet" type="text/css" HREF="Style.css">
</head>
<body>
	<header>
		<p>Input TEST Record (Name/Project/Percent Effort/Date)</p>
	</header>
	<p>
		<p>NOTE: Will test on input date for each month ahead</p>
			<div class=tool style="margin-left:50px; margin-top:80px;">
				<form name="form1" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" >
					<p>
						<select name=spinput1>
							<option value="">Select a Person</option>
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
								$persons = "SELECT * FROM person WHERE idDepartment " . $department;
								$result1 = mysqli_query($connection2, $persons);
								if (!$result1)
								{
									echo $persons;
									die("Database query failed.");
								}
								$NumOfRows1= mysqli_num_rows($result1);
								$Index1 = 0;
								if ($NumOfRows1 == 0)
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
						<input type="text" name="spinput3" placeholder="54"/>
						<input type="text" name="spinput4" placeholder="10/21/1992"/>
					</p>
					<input type="submit" name="submit1" class="submit" value="Submit" /> 
				</form>
			</div>
		</p>
		<?php
			if (!empty($connection))
			{	
				$NumOfRows = mysqli_num_rows($result);
				$Index = 0;
				if ($NumOfRows == 0)
				{
					echo "No view found.";
				} else{
					echo '<table style="border: 1px solid black; font-size: 16px;">';
					echo '<caption>
					Year from Date Percentage TEST: ';
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
							if($v <= 100)
							{
								echo "<td style=background:white;>".$v."</td>";
							}
							elseif($v > 100)
							{
								echo "<td style=background:#fa8072>".$v."</td>";
							}
						}
					}
					echo "</tr>";	
				}
				 
				echo "	</tbody>
					</table>";
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