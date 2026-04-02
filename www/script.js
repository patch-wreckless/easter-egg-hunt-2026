const loading = document.getElementById("loading");

const intro = document.getElementById("intro");
const introText = document.getElementById("intro-text");
const startBtn = document.getElementById("start-btn");

const game = document.getElementById("game");
const clueHeading = document.getElementById("clue-heading");
const clueImage = document.getElementById("clue-image");
const passwordInput = document.getElementById("password-input");
const submitBtn = document.getElementById("submit-btn");

const congratulations = document.getElementById("congratulations");
const successText = document.getElementById("success-text");
const finalClueLabel = document.getElementById("final-clue-label");
const finalClueValue = document.getElementById("final-clue-value");

let index = 0;
let clues = [];

function showIntro() {
    intro.classList.remove("hidden");
    game.classList.add("hidden");
    congratulations.classList.add("hidden");
}

function showGame() {
    intro.classList.add("hidden");
    game.classList.remove("hidden");
    congratulations.classList.add("hidden");
}

function showCongratulations() {
    intro.classList.add("hidden");
    game.classList.add("hidden");
    congratulations.classList.remove("hidden");
}

function renderClue() {
    const clue = clues[index];
    clueHeading.innerText = clue.heading;
    clueImage.src = "content/images/" + clue.image;
    passwordInput.value = "";
    passwordInput.classList.remove("error");
}

function markWrong() {
    passwordInput.classList.add("error");
    submitBtn.classList.add("shake");

    setTimeout(() => {
        submitBtn.classList.remove("shake");
    }, 250);
}

function handleStart() {
    showGame();
    renderClue();
}

startBtn.addEventListener("click", handleStart);

startBtn.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
        e.preventDefault();
        handleStart();
    }
});

passwordInput.addEventListener("input", () => {
    passwordInput.classList.remove("error");
});

function handleSubmit() {
    const guess = passwordInput.value.trim().toLowerCase();
    const correct = clues[index].password.toLowerCase();

    if (guess !== correct) {
        markWrong();
        return;
    }

    index++;
    if (index < clues.length) {
        renderClue();
        return;
    }

    showCongratulations();
}

submitBtn.addEventListener("click", handleSubmit);

passwordInput.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
        e.preventDefault();
        handleSubmit();
    }
});

submitBtn.addEventListener("keydown", (e) => {
    if (e.key === "Enter") {
        e.preventDefault();
        handleSubmit();
    }
});

(async function init() {

    const introRes = await fetch("content/intro.txt");
    introText.textContent = await introRes.text();

    const cluesRes = await fetch("content/clues.json");
    clues = await cluesRes.json();

    const successRes = await fetch("content/success.json");
    const success = await successRes.json();
    successText.textContent = success.successMessage;
    finalClueLabel.textContent = success.finalClueLabel;
    finalClueValue.textContent = success.finalClueValue;

    loading.classList.add("hidden");
    showIntro();
})();
