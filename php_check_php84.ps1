param(
  [string]$PhpPath = "php",
  [string]$ComposerPath = "composer"
)

Write-Host "Running PHP 8.4 compatibility checks for workspace..."

if (-not (Test-Path "vendor")) {
  Write-Host "Installing composer dependencies (dev)..."
  & $ComposerPath install
}

Write-Host "Running PHPCompatibility (phpcs) against ./webspace..."
& "$PWD/vendor/bin/phpcs" -p "$PWD/webspace" --standard=PHPCompatibility --runtime-set testVersion 8.4

Write-Host "Running PHPStan (level 5) against ./webspace..."
& "$PWD/vendor/bin/phpstan" analyse "$PWD/webspace" --level=5

Write-Host "Done. Review the output above for issues."
