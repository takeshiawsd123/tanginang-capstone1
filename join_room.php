<?php
include "db.php";

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    echo "Invalid request";
    exit();
}

$name = isset($_POST['name']) ? trim($_POST['name']) : "";
$code = isset($_POST['code']) ? trim($_POST['code']) : "";

if ($name === "" || $code === "") {
    echo "Fields cannot be empty";
    exit();
}

if (strlen($name) < 2) {
    echo "Name too short";
    exit();
}

/* Check if room exists */
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

/* Insert student */
$stmt = $conn->prepare("INSERT INTO students (room_id, name) VALUES (?, ?)");
$stmt->bind_param("is", $room_id, $name);

if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Failed to join room";
}
?>