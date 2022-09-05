<?php
    include 'connectDB.php';

    $period_ID = $_POST['period_ID'];
  

    $sql = "DELETE FROM `period` WHERE period_ID = '$period_ID'";

 
    if($con->query($sql)){
        echo json_encode("Success");
    }
    else{
        echo "Delete Failed";
    }
