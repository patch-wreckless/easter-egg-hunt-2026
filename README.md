# Easter Egg Hunt

## Download The Source

_If you're already familiar with Git and GitHub, download the source using your preferred method._

1. Go to the [project homepage](https://github.com/patch-wreckless/easter-egg-hunt-2026)
2. Click `<> Code` then `Download ZIP`
3. Extract the `easter-egg-hunt-2026-main.zip` file

## Create Your Content

Create and update the following files to define the intro message, clues, and success messages:

**content/images/\***

The images referenced by the clues.

**content/clues.json**

This file defines the list of clues.

Each clue is a piece of text that looks like this:

```json
{
    "heading": "<the optional text to show>",
    "image": "<the name of the image file to show>",
    "password": "<the password to unlock the next clue>"
}
```

The file is a list of clues, separated by commas, and surrounded by `[` and `]` characters. Here's an example of a complete file:

```json
[
    {
        "heading": "spring clue",
        "image": "spring.jpg",
        "password": "spring"
    },
    {
        "heading": "jelly beans clue",
        "image": "jelly-beans.jpg",
        "password": "jelly beans"
    },
    {
        "heading": "basket clue",
        "image": "basket.jpg",
        "password": "basket"
    }
]
```

**content/intro.txt**

A text file the welcome message and instructions to show when the website loads.

**content/success.json**

This file defines the messages the player sees when they solve all the clues.

```json
{
    "successMessage": "You did it!",
    "finalClueLabel": "Easter basket unlock code",
    "finalClueValue": "1234"
}
```

## A Web Server

_If you're already familiar with web servers, use which ever server you like._

Web browsers will open HTML files directly from your computer but generally don't like to load the other files they reference so you'll need to run a web server to serve this site.

1. Download and install [`python3`](https://www.python.org/downloads/)
2. Open a terminal
    - `Windows Powershell` or `Command Prompt` on Windows
3. In the terminal, navigate to the `www` folder in the extracted source folder
    - e.g. `cd ~/Downloads/easter-egg-hunt-2026-main/www`
4. In the terminal, run `python3 -m http.server 8000`
5. Open http://localhost:8000/ in your browser
