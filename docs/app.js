const els = {
  score: document.getElementById("score"),
  time: document.getElementById("time"),
  lives: document.getElementById("lives"),
  combo: document.getElementById("combo"),
  question: document.getElementById("question"),
  status: document.getElementById("status"),
  answerForm: document.getElementById("answerForm"),
  answerInput: document.getElementById("answerInput"),
  submitBtn: document.getElementById("submitBtn"),
  startBtn: document.getElementById("startBtn"),
  difficulty: document.getElementById("difficulty"),
  leaderboard: document.getElementById("leaderboard"),
  resetScores: document.getElementById("resetScores"),
};

const config = {
  easy: { max: 20, ops: ["+", "-"], time: 70, lives: 4 },
  medium: { max: 40, ops: ["+", "-", "*"], time: 60, lives: 3 },
  hard: { max: 90, ops: ["+", "-", "*", "/"], time: 55, lives: 2 },
};

let state = {
  running: false,
  score: 0,
  time: 60,
  lives: 3,
  combo: 1,
  answer: null,
  timer: null,
};

const createQuestion = () => {
  const mode = config[els.difficulty.value];
  const op = mode.ops[Math.floor(Math.random() * mode.ops.length)];

  let a = Math.ceil(Math.random() * mode.max);
  let b = Math.ceil(Math.random() * mode.max);

  if (op === "-") {
    if (a < b) [a, b] = [b, a];
    state.answer = a - b;
  } else if (op === "+") {
    state.answer = a + b;
  } else if (op === "*") {
    a = Math.ceil(Math.random() * (mode.max / 2));
    b = Math.ceil(Math.random() * 12);
    state.answer = a * b;
  } else {
    b = Math.ceil(Math.random() * 12);
    state.answer = Math.ceil(Math.random() * 12);
    a = b * state.answer;
  }

  els.question.textContent = `${a} ${op} ${b}`;
};

const render = () => {
  els.score.textContent = state.score;
  els.time.textContent = state.time;
  els.lives.textContent = state.lives;
  els.combo.textContent = `x${state.combo}`;
};

const setStatus = (msg, klass = "") => {
  els.status.className = klass;
  els.status.textContent = msg;
};

const saveScore = () => {
  const data = JSON.parse(localStorage.getItem("matarena-scores") || "[]");
  data.push({ score: state.score, date: new Date().toLocaleString("tr-TR") });
  data.sort((a, b) => b.score - a.score);
  localStorage.setItem("matarena-scores", JSON.stringify(data.slice(0, 5)));
};

const renderLeaderboard = () => {
  const data = JSON.parse(localStorage.getItem("matarena-scores") || "[]");
  els.leaderboard.innerHTML = "";
  if (!data.length) {
    els.leaderboard.innerHTML = "<li>Henüz skor yok. İlk efsane sen ol!</li>";
    return;
  }

  data.forEach((entry) => {
    const li = document.createElement("li");
    li.textContent = `${entry.score} puan - ${entry.date}`;
    els.leaderboard.appendChild(li);
  });
};

const stopGame = (message) => {
  clearInterval(state.timer);
  state.running = false;
  els.answerInput.disabled = true;
  els.submitBtn.disabled = true;
  els.startBtn.disabled = false;
  saveScore();
  renderLeaderboard();
  setStatus(message);
};

const startGame = () => {
  const mode = config[els.difficulty.value];
  state = {
    running: true,
    score: 0,
    time: mode.time,
    lives: mode.lives,
    combo: 1,
    answer: null,
    timer: null,
  };

  els.answerInput.disabled = false;
  els.submitBtn.disabled = false;
  els.startBtn.disabled = true;
  els.answerInput.value = "";
  els.answerInput.focus();

  createQuestion();
  render();
  setStatus("Hadi başla! Doğru cevaplarla komboyu büyüt 🔥");

  state.timer = setInterval(() => {
    state.time -= 1;
    if (state.time <= 0) {
      state.time = 0;
      render();
      stopGame(`Süre bitti! Toplam skorun: ${state.score}`);
      return;
    }
    render();
  }, 1000);
};

els.startBtn.addEventListener("click", startGame);

els.answerForm.addEventListener("submit", (event) => {
  event.preventDefault();
  if (!state.running) return;

  const value = Number(els.answerInput.value);
  if (Number.isNaN(value)) return;

  if (value === state.answer) {
    const gain = 10 * state.combo;
    state.score += gain;
    state.combo = Math.min(state.combo + 1, 8);
    setStatus(`Mükemmel! +${gain} puan`, "feedback-good");
  } else {
    state.lives -= 1;
    state.combo = 1;
    setStatus(`Yanlış! Doğru cevap ${state.answer}.`, "feedback-bad");

    if (state.lives <= 0) {
      state.lives = 0;
      render();
      stopGame(`Canlar bitti! Toplam skorun: ${state.score}`);
      return;
    }
  }

  els.answerInput.value = "";
  createQuestion();
  render();
});

els.resetScores.addEventListener("click", () => {
  localStorage.removeItem("matarena-scores");
  renderLeaderboard();
  setStatus("Skor tablosu sıfırlandı.");
});

render();
renderLeaderboard();
