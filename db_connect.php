<?php
$host = 'localhost';
$dbname = 'COMP1044_Database';
$username = 'root'; // Update with your DB username
$password = '';     // Update with your DB password

try {
    $pdo = new PDO("mysql:host=$host;dbname=$dbname", $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
} catch (PDOException $e) {
    die("Could not connect to the database: " . $e->getMessage());
}
?>

<?php
session_start();

// Check if the user is logged in
if (!isset($_SESSION['user_id'])) {
    header("Location: login.php");
    exit();
}

/**
 * Optional: Function to restrict access by role
 * Usage: checkRole('Admin');
 */
function checkRole($requiredRole) {
    if ($_SESSION['role'] !== $requiredRole) {
        header("Location: unauthorized.php"); // Or back to their respective dashboard
        exit();
    }
}
?>

<?php
session_start();
require 'db_connect.php';

$error = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $password = $_POST['password'];

    if (!empty($username) && !empty($password)) {
        // Fetch user from database
        $stmt = $pdo->prepare("SELECT id, password, role FROM users WHERE username = ?");
        $stmt->execute([$username]);
        $user = $stmt->fetch();

        // Verify password (assuming you used password_hash during registration)
        if ($user && password_verify($password, $user['password'])) {
            $_SESSION['user_id'] = $user['id'];
            $_SESSION['role'] = $user['role'];
            $_SESSION['username'] = $username;

            // Role-based redirection
            if ($user['role'] === 'Admin') {
                header("Location: admin_dashboard.php");
            } elseif ($user['role'] === 'Assessor') {
                header("Location: assessor_dashboard.php");
            }
            exit();
        } else {
            $error = "Invalid username or password.";
        }
    } else {
        $error = "Please fill in all fields.";
    }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Login - Internship Management System</title>
</head>
<body>
    <h2>Login</h2>
    <?php if ($error) echo "<p style='color:red;'>$error</p>"; ?>
    
    <form method="POST" action="">
        <label>Username:</label><br>
        <input type="text" name="username" required><br><br>
        
        <label>Password:</label><br>
        <input type="password" name="password" required><br><br>
        
        <button type="submit">Login</button>
    </form>
</body>
</html>
