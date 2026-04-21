<?php
include "db.php";

if (!isset($_POST['username']) || !isset($_POST['password'])) {
    echo "Missing fields";
    exit();
}

$username = trim($_POST['username']);
$password = $_POST['password'];

if ($username === "" || $password === "") {
    echo "Fields cannot be empty";
    exit();
}

/* Get user */
$stmt = $conn->prepare("SELECT id, username, password FROM users WHERE username = ?");
$stmt->bind_param("s", $username);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo "Invalid credentials";
    exit();
}

$user = $result->fetch_assoc();

/* Verify password */
if (password_verify($password, $user['password'])) {
    echo "Success";
} else {
    echo "Invalid credentials";
}
?>