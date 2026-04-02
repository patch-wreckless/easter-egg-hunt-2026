# Easter Egg Hunt

## Download The Website

_If you're already familiar with Git and GitHub, download the source using your preferred method._

1. Go to the [project homepage](https://github.com/patch-wreckless/easter-egg-hunt-2026).
2. Click `<> Code` then `Download ZIP`.
3. Extract the `easter-egg-hunt-2026-main.zip` file.
    - On Windows, right-click `easter-egg-hunt-2026-main.zip` and select `Extract all...`.
    - On Mac, double-click `easter-egg-hunt-2026-main.zip`.

## Create Your Content

Use the following files in the extracted website folder to configure the introduction message, clues, and success messages for the egg hunt:

**www/content/images/\***

Put the images you want to use in this folder.

**www/content/clues.json**

Use this file to define the list of clues.

Each clue is a piece of text that looks like this:

```json
{
    "heading": "<the optional text to show>",
    "image": "<the name of the image file to show>",
    "password": "<the password to unlock the next clue>"
}
```

The file is a list of clues, separated by commas, and surrounded by `[` and `]` characters. The website will show the clues in the order they appear in this file.

This is an example of a complete file with three clues:

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

![spring clue](./docs/images/spring-clue.png)

![jelly beans clue](./docs/images/jelly-beans-clue.png)

![basket clue](./docs/images/basket-clue.png)

**www/content/intro.txt**

Use this file to configure the welcome message and instructions to show at the beginning of the egg hunt.

![intro page](./docs/images/intro.png)

**www/content/success.json**

Use this file to define the messages to show when the egg hunt is successfully completed.

```json
{
    "successMessage": "You did it!",
    "finalClueLabel": "Easter basket unlock code",
    "finalClueValue": "1234"
}
```

![success page](./docs/images/success.png)

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
