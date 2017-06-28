<!--
Main page for the project effort web app. 
Features:
	User selects department, this gets added to $_SESSION['department'] superglobal variable 
	that will be active the rest of the time that the browswer is open
	
	Upon selection, the selection form will not show
	Upon selection, a current view of the current project efforts of that department will
	show, along with links to the other portions of the web app, including data entry, views,
	and percentage testing
-->

<?php
	// Connection profile in DbConnection.php file
	// Connection needed to show current effort view
	require_once "DbConnection.php";
	// Start session 
	session_start();
?>

<?php
	// If the department selection form has been submitted then assign the session superglobal
	if (!empty($_POST['submit1']))
	{
		$_SESSION['department'] = $_POST['department'];
	}
?>

<!DOCTYPE html>
<html lang='en'>
	<head>
		<meta charset="UTF-8" />
		<title>Percent Effort Tracker</title>
		<link rel="stylesheet" type="text/css" href="Style.css"/>
		<style>
		header {
			background-repeat: no-repeat, repeat;
			background-position: right, center;
			background-size: 300px 160px, 2000px 120px;
		}
		</style>
	</head>
	<body>
		<header>
			<h1>Percent Effort Tracker</h1>
			<p>Date: <?php echo date("m/d/Y"); ?></p>
			<?php 
				// Check if variable is assigned
				if(!empty($_SESSION['department'])): 
			?>
			<a style="width:120px; height:auto;" href="SiteHelp.php">Site Instructions</a>
			<div class="linkbar">
			<h2 class=decbtn>Views, Inputs, and Tests</h2>
			<a href="NameInput.php">Person Input</a>
			<a href="ProjectInput.php">Project Input</a>
			<a href="AssignProject.php">Assign Projects</a>
			<a href="DeleteData.php">Remove Data</a>
			<a href="TestInput.php">Test Percentages</a>
			<a href="NameView.php">Person View</a>
			<a href="ProjectView.php">Project View</a>
			<a href="ProjectDetails.php">Project Information</a>
			<a href="StatusChange.php">Change Project Status</a>
			</div>
			<?php endif ?>
		</header>
		<?php 
			// Check is variable is empty, if so, show department form
			if(empty($_SESSION['department'])): 
		?>
		<!-- The only place the department code value definitions are currently is here 
		did not model them into the backend
		-->
		<form name="form1" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" >
		<p>
		<select name=department>
		<option value="">Select a department</option>
		<option value="=1">Ambulatory</option>
		<option value="=2">B & B</option>
		<option value="=3">B3 Core</option>
		<option value="=4">Cardiovascular</option>
		<option value="=5">Health Services</option>
		<option value="=6">MCRC</option>
		<option value="=7">NRH</option>
		<option value="=8">OCGM</option>
		<option value="REGEXP '[0-9]'">All Department View</option>
		</select>
		</p>
		<input type="submit" name="submit1" class="submit" value="Submit" /> 
		</form>
		<?php endif ?>
		<?php
			// Check if session variable is not empty
			if(!empty($_SESSION['department'])): 
		?>
		<div class=currentview>
			<?php
				// Create view table
				if(!empty($connection))
				{
					$query = "select * from vw_current_total_effort where `Last, First Name` in (select LastFirstName from person where idDepartment " . $_SESSION['department'] . ")";
					$result = mysqli_query($connection, $query);
					$NumOfRows = mysqli_num_rows($result);
					$Index = 0;
					if ($NumOfRows == 0){
						echo "No view found.";
					} else{
						echo '<table style="border: 1px solid black; font-size: 16px;">';
						echo '<caption><b>
						Current Effort Percentage: ';
						echo "</b></caption>";
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
								echo "<td style=background:white;>".$v."</td>";
							}
							echo "</tr>";	
						}
				 
						echo "	</tbody>
						</table>";
					}
				}
			?>
			</div>
		<?php endif ?>
	</body>
</html>
<?php
	// close database connection
	if(!empty($connection))
	{
		mysqli_close($connection);
	}
?>