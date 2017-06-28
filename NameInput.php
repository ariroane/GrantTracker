<!-- 
Name input page
Features:
	Input name into the database
	Department code is implicit in the entry as long as user made selection at homepage
	If All Department is selected, will show an input selection form to put in what department
-->

<?php
	session_start();
	$department = $_SESSION['department'];
	// echo "Your department is: " . $department;
?>

<?php
	if (isset($_POST['submit1']) 
		&& !empty($_POST['spinput'])) 
	{
		require_once "DbConnection.php";
		$spinput = mysqli_real_escape_string($connection, htmlentities($_POST["spinput"]));
		if ($department == "REGEXP '[0-9]'")
		{
			$department = mysqli_real_escape_string($connection, htmlentities($_POST["departmentsel"]));
		} else {
		$department = $_SESSION['department'];
		}
	}
?>

<?php
	if(!empty($connection))
	{
		$query = "insert into person (LastFirstName, idDepartment) values (" . '"' . $spinput . '"' . ',' . '"' . str_replace('=', '', $department) . '")';
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
        NameInput.php
    </title>
    <link rel="stylesheet" type="text/css" HREF="Style.css">
</head>
<body>
	<header>
		<p>Input Name</p>
	</header>
	<p>
		<div class=tool style="margin-left:50px; margin-top:80px;">
			<form name="form1" method="POST" action="<?php echo $_SERVER['PHP_SELF']; ?>" >
				<p>Format: Last Name, First Name</p>
				<p>
					<input type="text" name="spinput" placeholder="Roane, Ariel"/>
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