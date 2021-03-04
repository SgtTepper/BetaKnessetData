### Referenced from https://blog.netnerds.net/2015/01/powershell-high-performance-techniques-for-importing-csv-to-sql-server/ ###

# Database variables
$sqlserver = "<SERVER>"
$database = "<DATABASE>"
$table = "<TABLE>"
$userid = "<USER_ID>"
$password = "<PASSWORD>"

# CSV variables
$csvfile = "CSV_FILE_PATH"
$csvdelimiter = "$"
$firstRowColumnNames = $true

Write-Host "Script started..."
$elapsed = [System.Diagnostics.Stopwatch]::StartNew() 
[void][Reflection.Assembly]::LoadWithPartialName("System.Data")
[void][Reflection.Assembly]::LoadWithPartialName("System.Data.SqlClient")

$batchsize = 50000

# Build the sqlbulkcopy connection, and set the timeout to infinite
$connectionstring = "Data Source=$sqlserver;Integrated Security=false;Initial Catalog=$database;User ID=$userid;Password=$password;"
$bulkcopy = New-Object Data.SqlClient.SqlBulkCopy($connectionstring, [System.Data.SqlClient.SqlBulkCopyOptions]::TableLock)
$bulkcopy.DestinationTableName = $table
$bulkcopy.bulkcopyTimeout = 0
$bulkcopy.batchsize = $batchsize
 
# Create the datatable, and autogenerate the columns.
$datatable = New-Object System.Data.DataTable

# Open the text file from disk
$reader = New-Object System.IO.StreamReader($csvfile)
$columns = (Get-Content $csvfile -First 1).Split($csvdelimiter)
if ($firstRowColumnNames -eq $true) { $null = $reader.readLine() }

foreach ($column in $columns) { 
	$null = $datatable.Columns.Add()
}

# Read in the data, line by line
while (($line = $reader.ReadLine()) -ne $null)  {
	$null = $datatable.Rows.Add($line.Split($csvdelimiter))
	$i++; if (($i % $batchsize) -eq 0) { 
		$bulkcopy.WriteToServer($datatable)
		Write-Host "$i rows have been inserted in $($elapsed.Elapsed.ToString())."
		$datatable.Clear() 
	} 
} 

# Add in all the remaining rows since the last clear
if($datatable.Rows.Count -gt 0) {
	$bulkcopy.WriteToServer($datatable)
	$datatable.Clear()
}

# Clean Up
$reader.Close(); $reader.Dispose()
$bulkcopy.Close(); $bulkcopy.Dispose()
$datatable.Dispose()

Write-Host "Script complete. $i rows have been inserted into the database."
Write-Host "Total Elapsed Time: $($elapsed.Elapsed.ToString())"
# Sometimes the Garbage Collector takes too long to clear the huge datatable.
[System.GC]::Collect()