<?php
include "db.php";

header("Content-Type: application/json");

if ($_SERVER["REQUEST_METHOD"] !== "GET") {
    echo json_encode(["error" => "Invalid request"]);
    exit();
}

$code = isset($_GET['code']) ? trim($_GET['code']) : "";

if ($code === "") {
    echo json_encode(["error" => "Missing room code"]);
    exit();
}

/* Get room ID safely */
$stmt = $conn->prepare("SELECT id FROM rooms WHERE room_code = ?");
$stmt->bind_param("s", $code);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode(["error" => "Room not found"]);
    exit();
}

$row = $result->fetch_assoc();
$room_id = $row['id'];

/* Get questions */
$stmt = $conn->prepare("SELECT * FROM questions WHERE room_id = ?");
$stmt->bind_param("i", $room_id);
$stmt->execute();
$result = $stmt->get_result();

$data = [];

while ($r = $result->fetch_assoc()) {
    $data[] = $r;
}

echo json_encode([
    "success" => true,
    "questions" => $data
]);
?>
