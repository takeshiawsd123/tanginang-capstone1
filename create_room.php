<?php
include "db.php";

header("Content-Type: application/json");

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    echo json_encode(["error" => "Invalid request"]);
    exit();
}

$name = isset($_POST['name']) ? trim($_POST['name']) : "";

if ($name === "") {
    echo json_encode(["error" => "Teacher name is required"]);
    exit();
}

/* Generate unique room code */
function generateCode($length = 5) {
    return substr(str_shuffle("ABCDEFGHJKLMNPQRSTUVWXYZ23456789"), 0, $length);
}

$code = "";

do {
    $code = generateCode();

    $check = $conn->prepare("SELECT id FROM rooms WHERE room_code = ?");
    $check->bind_param("s", $code);
    $check->execute();
    $result = $check->get_result();

} while ($result->num_rows > 0);

/* Insert room */
$stmt = $conn->prepare("INSERT INTO rooms (room_code, teacher_name) VALUES (?, ?)");
$stmt->bind_param("ss", $code, $name);

if ($stmt->execute()) {
    echo json_encode([
        "success" => true,
        "room_code" => $code
    ]);
} else {
    echo json_encode([
        "error" => "Failed to create room"
    ]);
}
?>
