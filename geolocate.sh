#!/bin/bash

# Author: Haitham Aouati
# GitHub: github.com/haithamaouati
# Description: Geolocate an IP address using the ip-api.com JSON API.

clear

# Load text formatting.
source ~/Geolocate/config/text.sh

echo -e "\n\n${RED}$(figlet -f config/pagga.flf Geolocate)\n"
sleep 1
echo -e "${RED_BOLD}Geolocate ${CLEAR}by Haitham Aouati"
echo -e " an IP address using JSON API.\n" | pv -qL 10
echo -e "GitHub: ${UNDERLINE}github.com/haithamaouati${CLEAR}\n"

# Fetch public IP address using ifconfig.me
public_ip=$(curl -s ifconfig.me)

if [ $# -ne 1 ]; then
  echo -e "Usage: $0 <IP address> [$public_ip]\n"
  exit 1
fi

ip_address=$1
api_url="http://ip-api.com/json/$ip_address"

# Use curl to fetch JSON response from the API
response=$(curl -s $api_url)

# Check if the request was successful
if [ "$(echo $response | jq -r '.status')" = "fail" ]; then
  echo "Failed to fetch geolocation information for IP: $ip_address"
  echo "Error: $(echo $response | jq -r '.message')"
else
  # Display all available geolocation information
  echo "IP: $(echo $response | jq -r '.query')"
  echo "City: $(echo $response | jq -r '.city')"
  echo "Region: $(echo $response | jq -r '.regionName')"
  echo "Country: $(echo $response | jq -r '.country')"
  echo "Country Code: $(echo $response | jq -r '.countryCode')"
  echo "ISP: $(echo $response | jq -r '.isp')"
  echo "Organization: $(echo $response | jq -r '.org')"
  echo "AS (Autonomous System): $(echo $response | jq -r '.as')"
  echo "Latitude: $(echo $response | jq -r '.lat')"
  echo "Longitude: $(echo $response | jq -r '.lon')"
  echo "ZIP Code: $(echo $response | jq -r '.zip')"
  echo "Time Zone: $(echo $response | jq -r '.timezone')"
  echo "ISP Location: $(echo $response | jq -r '.isp')"

  # Save geolocation information to a JSON file
  output_file="${ip_address}.json"
  echo $response > $output_file
  echo -e "\nSaved to: $output_file${NEW_LINE}"
fi
