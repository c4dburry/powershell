$ldaphash = @{
    "employeeType"                  = "W1";
    "departmentnumber"              = "W2";
    "wilderwester"                  = $null;
}

$ldaphash

$keysToRemoveldap = $ldaphash.keys | Where-Object { 
    !$ldaphash[$_] 
}

$keysToRemoveldap | foreach-object {
    $ldaphash[$keysToRemoveldap] = " " 
}

foreach ($time in $($ldaphash.keys)) {
    $ldaphash[$time] = "2"
 }


$ldaphash