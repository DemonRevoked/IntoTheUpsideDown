<?php
session_start(); // Start the session

// Check if the session variable is set
if (!isset($_SESSION['authenticated']) || $_SESSION['authenticated'] !== true) {
    // Redirect to login page if not authenticated
    header("Location: login.php");
    exit;
}

// Unset the session variable to prevent re-access without logging in again
unset($_SESSION['authenticated']);
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Into the Upside Down - Access Granted</title>
    <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-image: url('2.png'); /* Path to your themed background image */
            background-size: cover;
            background-position: center;
            color: #fff;
            text-align: center;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0;
        }
        .success-container {
            background: rgba(0, 0, 0, 0.8);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(255,0,0,0.5);
            width: 700px;
        }
        h1 {
            color: #ff0000; /* Red color */
            text-shadow: 0 0 10px #ff0000;
            margin-bottom: 20px;
        }
        p {
            font-size: 1.2em;
            margin-top: 20px;
        }
        .flag {
            margin-top: 20px;
            font-size: 1.5em;
            color: #ff0000;
            font-weight: bold;
        }
        .home-link {
            display: block;
            margin-top: 20px;
            font-size: 1.2em;
            color: #FFD700;
            text-decoration: none;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <h1>Access Granted: Hawkins Lab</h1>
        <p>Congratulations. You have bypassed the perimeter security of Hawkins National Laboratory. You are now deep within the restricted zone. The gate is near, but the Mind Flayer knows you are here.</p>
        <p>You've reached the secondary level of access. The truth is hidden in plain sight, and you're making progress. But the deeper you go, the more you realize how extensive this breach truly is.</p>
        <div class="flag">CTCFlag{secondary_level_access}</div>
        <!-- <a href="./usernames.txt" download="usernames.txt" class="home-link">Secret Files</a> -->
     </div>
</body>
</html>
