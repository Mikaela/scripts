<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<!-- <meta http-equiv="refresh" content="60" /> -->
<meta name="description" content="This is simple PHP script to convert email address into Libravatar link and show the result. This is inspired by those which inspired gravatar.php and gravatar.php itself." />
<title>Email --> Libravatar</title>
</head>
<body>

<p>
<form action="libravatar.php" method="post">
*Email address: <input type="text" name="email"><br>
Size: <input type="text" name="size">
<input type="submit">
</form>
</p>

<p>* marks required field. Only email address is required.</p>

<p>Size can be anything from 1 to 2048. If it's empty, size is 80.</p>

<p>For Steam profile pictures, set size as 184.</p>

</body>
</html>

<?php

$email = trim( $_REQUEST["email"] );
$size = $_REQUEST["size"];

echo "<p>Email<br> $email<br></p>";

$email = strtolower( $email );

$md5email = md5( $email );

// Do nothing if our md5 is an empty string!
if($md5email != "d41d8cd98f00b204e9800998ecf8427e") {

echo "<p>md5<br> $md5email</p>";

echo "<p>Link<br>";
$libravatar = "https://seccdn.libravatar.org/avatar/$md5email?s=$size.jpeg";
echo "$libravatar</p>";
echo "<p>";
echo "<img src=$libravatar>";
echo "</p>";
}

echo '<hr/>
<p><a href="https://github.com/Mkaysi/mkaysi.github.io/blob/master/php/libravatar.php">Source: https://github.com/Mkaysi/mkaysi.github.io/blob/master/php/libravatar.php</a></p>
<hr/>'

?>
