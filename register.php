<?php
include "db.php";

if ($_SERVER["REQUEST_METHOD"] !== "POST") {
    echo "Invalid request";
    exit();
}

$username = isset($_POST['username']) ? trim($_POST['username']) : "";
$passwordRaw = isset($_POST['password']) ? $_POST['password'] : "";

if ($username === "" || $passwordRaw === "") {
    echo "Fields cannot be empty";
    exit();
}

if (strlen($username) < 3) {
    echo "Username too short";
    exit();
}

if (strlen($passwordRaw) < 6) {
    echo "Password too short";
    exit();
}

/* Check if username exists */
$stmt = $conn->prepare("SELECT id FROM users WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$res = $stmt->get_result();

if ($res->num_rows > 0) {
    echo "Username already exists";
    exit();
}

/* Hash password */
$password = password_hash($passwordRaw, PASSWORD_DEFAULT);

/* Insert user */
$stmt = $conn->prepare("INSERT INTO users (username, password) VALUES (?, ?)");
$stmt->bind_param("ss", $username, $password);

if ($stmt->execute()) {
    echo "Success";
} else {
    echo "Registration failed";
}
?>