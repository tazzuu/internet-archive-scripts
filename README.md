# Internet Archive Scripts

Scripts to help with downloading files from the Internet Archive https://archive.org/

The purpose of these scripts is to be able to download large amounts of files from the Internet Archive based on the pages' directory listings. By default the Internet Archive will only let you download multiple files at once from a single index page, and it has a limit to the total filesize it will support. You can get around this by simply initiating direct download of each file based on its URL, which you can scrape from the HTML of the directory listing pages. The included script will scrape all the .html pages it finds so you can concatenate the list of download URLs from multiple different pages and queue them up for download all at once.

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

- not all files will be included, only video files and .torrent files; you can modify this in the script

## Download

Use the included download script to download files in parallel

```bash
./download.sh
```

The script will attempt to download multiple files in parallel based on the contents of urls.txt. It runs in the foreground by default. If you want to monitor progress you should open another session and do `tail -f download.log`. Modify the args to `wget` and `parallel` as needed for your desired download behavior. By default `wget` will attempt to download in a resume-able manner so that you should be able to cancel the script and restart as needed to resume downloads. And `parallel` will keep a lot of the downloaded files too.
