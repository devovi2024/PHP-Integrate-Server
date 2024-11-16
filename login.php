<?php
session_start();
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = trim($_POST['email']);
    $password = trim($_POST['password']);
    $role = trim($_POST['role']);

    // Validate role input
    $allowedRoles = ['patient', 'doctor', 'nurse', 'admin'];
    if (!in_array($role, $allowedRoles)) {
        echo "Invalid role selected!";
        exit;
    }

    // Fetch user
    $query = $conn->prepare("SELECT User.user_id, User.name, User.email, User_role.role_name 
                             FROM User 
                             INNER JOIN User_role ON User.user_id = User_role.user_id 
                             WHERE email = :email AND role_name = :role");
    $query->bindParam(':email', $email);
    $query->bindParam(':role', $role);
    $query->execute();

    $user = $query->fetch(PDO::FETCH_ASSOC);

    if ($user) {
        $_SESSION['user'] = $user;
        header('Location: dashboard.html');
        exit;
    } else {
        echo "Invalid email or role!";
    }
}
?>
