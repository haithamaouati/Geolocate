# Geolocate

**Geolocate** an IP address using the ip-api.com JSON API. The script displays various details such as city, region, country, ISP, and more. Additionally, it saves the fetched information to a JSON file.

![screenshot]()

## Usage

To use the Geolocate script, follow these steps:

1. Clone the repository:

    ```bash
    git clone https://github.com/haithamaouati/Geolocate.git
    ```

2. Navigate to the Geolocate directory:

    ```bash
    cd Geolocate
    ```

3. Run the script with a specified IP address:

    ```bash
    ./geolocate.sh <IP address>
    ```

   Replace `<IP address>` with the actual IP address you want to geolocate.

## Dependencies

The script requires the following dependencies:

- [figlet](http://www.figlet.org/): Program for making large letters out of ordinary text
- [curl](https://curl.se/): Command line tool for transferring data with URL syntax
- [jq](https://stedolan.github.io/jq/): Command-line JSON processor
- [pv](http://www.ivarch.com/programs/pv.shtml): Terminal-based tool for monitoring the progress of data through a pipeline

Make sure to install these dependencies before running the script.

## Author

- **Haitham Aouati**
  - GitHub: [github.com/haithamaouati](https://github.com/haithamaouati)

## License

This Geolocate Bash script is open-source and available under the [MIT License](LICENSE).

Feel free to contribute or report issues on the [GitHub repository](https://github.com/haithamaouati/Geolocate).
