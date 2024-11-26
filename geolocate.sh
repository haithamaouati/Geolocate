#!/bin/bash

# Author: Haitham Aouati
# GitHub: github.com/haithamaouati
# Geolocate an IP address using the ip-api.com JSON API.

clear

# Text formatting
normal="\e[0m"
bold="\e[1m"
faint="\e[2m"
italics="\e[3m"
underlined="\e[4m"

# Check for dependencies
for dep in figlet curl jq; do
  if ! command -v "$dep" &> /dev/null; then
    echo "Error: $dep is not installed. Please install it before running the script."
    exit 1
  fi
done

# ASCII Art
figlet -f standard "Geolocate"
echo -e "Geolocate an IP address using the ip-api.com JSON API.${normal}\n"
echo -e "Author: Haitham Aouati"
echo -e "GitHub: ${underlined}github.com/haithamaouati${normal}\n"

# Default public IP
public_ip=$(curl -s ifconfig.me)

# Parse arguments
save_to_file=false
while [[ "$1" =~ ^- ]]; do
  case "$1" in
    -h|--help)
      echo -e "Usage: $0 [OPTIONS] <IP address>\n"
      echo -e "Options:"
      echo -e "  -h, --help            Show this help message"
      echo -e "  -i, --ip <IP>         Specify an IP address to geolocate (default: public IP)"
      echo -e "  -f, --file            Save geolocation info to a JSON file"
      echo -e "\nExample usage: $0 -i $public_ip -f\n"
      exit 0
      ;;
    -i|--ip)
      shift
      ip_address=$1
      ;;
    -f|--file)
      save_to_file=true
      ;;
    *)
      echo "Invalid option: $1. Use -h or --help for usage."
      exit 1
      ;;
  esac
  shift
done

# Default IP if not provided
if [ -z "$ip_address" ]; then
  ip_address=$public_ip
fi

# Validate IP address format
if ! [[ "$ip_address" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: Invalid IP address format: $ip_address"
  exit 1
fi

# API URL
api_url="http://ip-api.com/json/$ip_address"

# Fetch geolocation data
response=$(curl -s "$api_url")

# Check for errors in response
status=$(echo "$response" | jq -r '.status')
if [ "$status" = "fail" ]; then
  echo "Error: Failed to fetch geolocation information for IP: $ip_address"
  echo "Message: $(echo "$response" | jq -r '.message')"
  exit 1
fi

# Display geolocation info
echo "IP: $(echo "$response" | jq -r '.query')"
echo "City: $(echo "$response" | jq -r '.city')"
echo "Region: $(echo "$response" | jq -r '.regionName')"
echo "Country: $(echo "$response" | jq -r '.country')"
echo "Country Code: $(echo "$response" | jq -r '.countryCode')"
echo "ISP: $(echo "$response" | jq -r '.isp')"
echo "Organization: $(echo "$response" | jq -r '.org')"
echo "AS (Autonomous System): $(echo "$response" | jq -r '.as')"
echo "Latitude: $(echo "$response" | jq -r '.lat')"
echo "Longitude: $(echo "$response" | jq -r '.lon')"
echo "ZIP Code: $(echo "$response" | jq -r '.zip')"
echo "Time Zone: $(echo "$response" | jq -r '.timezone')"

# Save to a file if requested
if [ "$save_to_file" = true ]; then
  output_file="${ip_address}.json"
  echo "$response" > "$output_file"
  echo -e "\nGeolocation saved to: $output_file\n"
fi
