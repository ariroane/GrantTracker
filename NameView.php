<!-- 
Name view page
Shows all the projects associated with a name
projects are color-coded by active status
Features:
	Select person from department (implicit)
	Shows all projects, past and current, of varying status 
	associated with the person 
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
		$query = "call sp_person_info(" . '"' . $spinput . '")';
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
			<p>View a Person's Projects</p>
		</header>
		<div class=personview>
			<form name="form" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" >
				<select name=spinput>
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
							$persons = "SELECT * FROM person where idDepartment " . $department;
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
						Current Effort Percentage: ';
						echo "</caption>";
						echo "<thead>
							<tr>";
						$row = mysqli_fetch_assoc($result);

						foreach($row as $k => $v ) 
						{       
							if($k != 'ProjectStatusCd')
							{
							echo "<th>".$k."</th>";
							}
						}
						echo "	</tr>
						</thead>
						<tbody>";

						$check = mysqli_data_seek($result, 0);
				
						while ($rownew = mysqli_fetch_assoc($result))
						{
							echo "<tr>";
							if($rownew['ProjectStatusCd'] == 1)
							{
								foreach($rownew as $k => $v)
								{
									if($v != 1)
									{
										echo "<td style=background-color:#91cfff;>".$v."</td>";
									}
								}
							}
							elseif($rownew['ProjectStatusCd'] == 2)
							{
								foreach($rownew as $k => $v)
								{
									if($v !=2)
									{
										echo "<td style=background-color:#feff7c;>".$v."</td>";
									}
								}
							}
							elseif($rownew['ProjectStatusCd'] == 0)
							{
								foreach($rownew as $k => $v)
								{
									if($v != '0')
									{
										echo "<td style=background-color:#fa8072;>".$v."</td>";
									}
								}
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