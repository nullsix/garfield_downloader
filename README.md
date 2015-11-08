## Garfield Downloader

This is a script used to download the back catalog of Garfield comic strips.

## Usage

```
ruby garfield_downloader.rb
```

## Details

It'll start by downloading today's Garfield comic strip. It'll then work it's
way back, day by day, and download each of those. It'll sleep for a random
amount of time between 0 and 1 second between each image. To keep from being a
resource hog on Garfield's servers.

The images are stored in the `strips` subdirectory.

If you run the script multiple times, it'll skip strips already downloaded.

You'll see status in the console as it progresses:

```
Total: 3944; Downloaded: 1751; Skipped: 2193
```

