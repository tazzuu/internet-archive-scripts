# Internet Archive Scripts

Scripts to help with downloading files from the Internet Archive https://archive.org/

# Usage

## Pre-requisites

Install these deps if you dont already have them

```bash
sudo apt install parallel wget
```

## Save directory listings

Save the directory listing web pages that contain the files you want to download

Example; https://archive.org/download/CoolCatFunhouse2021

There are two methods to download this page.

- in your web browser, go to "Save Page As" > "Web Page Complete"
  - this will give you a HTML file in the format of 'CoolCatFunhouse2021 directory listing.html'

- in your terminal use `wget`

```bash
wget https://archive.org/download/CoolCatFunhouse2021
```

  - let the file download with the default filename `CoolCatFunhouse2021` and then rename it to `CoolCatFunhouse2021.html`
  - or use cli args to `wget` to change the output file name to the format `CoolCatFunhouse2021.html`

## Scrape URLs

Once you have all of the directory listing HTMLs for the pages that contain the links to the files you want to download, scrape the URL's out of the files with the included script

```bash
./urls.sh
```

This produces the file `urls.txt` which contains the URL's to the files to be downloaded. You should review the file to make sure the correct URL's are listed here.

## Download

