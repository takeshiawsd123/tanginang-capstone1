<?php
include "db.php";

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    echo "Invalid request";
    exit();
}

$code = isset($_POST['room_code']) ? trim($_POST['room_code']) : "";
$q = isset($_POST['question']) ? trim($_POST['question']) : "";
$a = isset($_POST['a']) ? trim($_POST['a']) : "";
$b = isset($_POST['b']) ? trim($_POST['b']) : "";
$c = isset($_POST['c']) ? trim($_POST['c']) : "";
$d = isset($_POST['d']) ? trim($_POST['d']) : "";
$correct = isset($_POST['correct']) ? trim($_POST['correct']) : "";

if ($code === "" || $q === "" || $a === "" || $b === "" || $c === "" || $d === "" || $correct === "") {
    echo "Missing fields";
    exit();
}

$correct = strtoupper($correct);

if (!in_array($correct, ["A", "B", "C", "D"])) {
    echo "Invalid correct answer";
    exit();
}

/* Get room ID safely */
$stmt = $conn->prepare("SELECT id FROM rooms WHERE room_code = ?");
$stmt->bind_param("s", $code);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo "Room not found";
    exit();
}

$row = $result->fetch_assoc();
$room_id = $row['id'];

/* Insert question */
$stmt = $conn->prepare("
    INSERT INTO questions 
    (room_id, question, option_a, option_b, option_c, option_d, correct_answer)
    VALUES (?, ?, ?, ?, ?, ?, ?)
");

$stmt->bind_param("issssss", $room_id, $q, $a, $b, $c, $d, $correct);

if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Error: failed to add question";
}
?>
