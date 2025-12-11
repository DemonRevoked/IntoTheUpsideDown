<?php
// Define the allowed User-Agent string
$allowedUserAgent = "Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101 Firefox/128.0";

// Get the User-Agent and X-Forwarded-For headers
$userAgent = $_SERVER['HTTP_USER_AGENT'] ?? '';
$forwardedFor = $_SERVER['HTTP_X_FORWARDED_FOR'] ?? '';

// Improved Security Check (Moderate Difficulty)
// Requires both a specific User-Agent AND an internal IP via X-Forwarded-For
if ($userAgent === $allowedUserAgent && $forwardedFor === '127.0.0.1') {
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Into the Upside Down - Inner Circle</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-image: url('3.png'); /* Path to your themed background image */
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
	.download-btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: #fff;
            background-color: #b30000;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .download-btn:hover {
            background-color: #ff0000;
        }
        /* Additional styling as needed */
    </style>
</head>
<body>
    <div class="success-container">
        <h1>Hawkins Lab - Inner Circle</h1>
        <p>Only those with the highest clearance—or the most powerful psionic abilities—can see this page. You have successfully spoofed your identity to the system.</p>
        <p>The experiments here are dangerous. Do not let them open the gate again.</p>
        <p>You've established your foundation in this digital dimension. This is the first layer of the Upside Down's digital manifestation.</p>
        <p class="flag">CTCFlag{foundation_level_base}</p>
        <a href="secret.zip" class="download-btn" download>Download Project MKUltra Files</a>
	<!-- needed key: /key1.txt-->
    </div>
</body>
</html>
<?php
} else {
    // Redirect to a custom 403 Forbidden page
    header("HTTP/1.1 403 Forbidden");
    include("custom_403.php");
    exit;
}
?>
