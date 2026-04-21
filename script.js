let roomCode = "";
let questions = [];
let current = 0;
let score = 0;

function createRoom() {
    let name = document.getElementById("teacherName").value;

    fetch("create_room.php", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: "name=" + name
    })
    .then(res => res.json())
    .then(data => {
        if (data.success) {
            roomCode = data.room_code;
            localStorage.setItem("roomCode", roomCode);
            document.getElementById("roomCode").innerText = "Room Code: " + roomCode;
        } else {
            alert("Failed to create room");
        }
    });
}

function addQuestion() {
    let roomCode = localStorage.getItem("roomCode");

    let q = document.getElementById("question").value.trim();
    let a = document.getElementById("a").value.trim();
    let b = document.getElementById("b").value.trim();
    let c = document.getElementById("c").value.trim();
    let d = document.getElementById("d").value.trim();
    let correct = document.getElementById("correct").value.trim().toUpperCase();

    // 🔥 VALIDATION (THIS FIXES YOUR ISSUE)
    if (!roomCode || !q || !a || !b || !c || !d || !correct) {
        alert("Fill all fields first!");
        return;
    }

    fetch("add_question.php", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: new URLSearchParams({
            room_code: roomCode,
            question: q,
            a: a,
            b: b,
            c: c,
            d: d,
            correct: correct
        })
    })
    .then(res => res.text())
    .then(data => {
        console.log(data);

        if (data.includes("Success")) {
            alert("Question Added!");

            // 🔥 CLEAR INPUTS AFTER SUCCESS
            document.getElementById("question").value = "";
            document.getElementById("a").value = "";
            document.getElementById("b").value = "";
            document.getElementById("c").value = "";
            document.getElementById("d").value = "";
            document.getElementById("correct").value = "";
        } else {
            alert("Error: " + data);
        }
    });
}

function joinRoom() {
    let studentName = document.getElementById("studentName").value;
    let code = document.getElementById("roomCodeInput").value.trim();

    fetch("join_room.php", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded"},
        body: `name=${studentName}&code=${code}`
    })
    .then(res => res.text())
    .then(data => console.log(data));

    fetch("get_questions.php?code=" + code)
    .then(res => res.json())
    .then(data => {
        questions = data;
        current = 0;
        score = 0;
        showQuestion();
    });
}

function showQuestion() {
    if (questions.length === 0) {
        document.getElementById("quiz").innerHTML = "<h3>No questions found</h3>";
        return;
    }

    if (current >= questions.length) {
        document.getElementById("quiz").innerHTML = `<h2>Finished! Score: ${score}</h2>`;
        return;
    }

    let q = questions[current];

    document.getElementById("quiz").innerHTML = `
        <h3>${q.question}</h3>
        <button onclick="checkAnswer('A')">${q.option_a}</button>
        <button onclick="checkAnswer('B')">${q.option_b}</button>
        <button onclick="checkAnswer('C')">${q.option_c}</button>
        <button onclick="checkAnswer('D')">${q.option_d}</button>
    `;
}

function checkAnswer(choice) {
    let correct = questions[current].correct_answer;

    if (choice === correct) {
        score++;
        alert("Correct!");
    } else {
        alert("Wrong!");
    }

    nextQuestion();
}

function nextQuestion() {
    current++;
    showQuestion();
}

