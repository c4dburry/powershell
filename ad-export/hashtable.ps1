$ldaphash = @{
    "employeeType"                  = "W1";
    "departmentnumber"              = "W2";
}

$ldaphash
$ldaphash.Count

foreach ($time in $($ldaphash.keys)) {
    $ldaphash[$time] = ""
 }

$ldaphash