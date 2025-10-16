<?php
include("dbcon.php");
$CategoryName = $CategoryDesc = $CategoryImageName = ""; 
$CategoryNameErr = $CategoryDescErr = $CategoryImageNameErr = ""; 

if(isset($_POST['addCategory'])){
    $CategoryName = $_POST['cName'];
    $CategoryDesc = $_POST['cDesc']; 
    $CategoryImageName = $_FILES['cImage']['name'];
    $CategoryImageTmpName = $_FILES['cImage']['tmp_name'];
    $destination = "images/".$CategoryImageName; 
    
    $extension = pathinfo($CategoryImageName , PATHINFO_EXTENSION);
    
    if(empty($CategoryName)){
        $CategoryNameErr = "Category Name is Required";
    }
    if(empty($CategoryDesc)){
        $CategoryDescErr = "Category Desc is Required";
    }
    if(empty($CategoryImageName)){
        $CategoryImageNameErr = "Category Image is Required";
    } else {
        $AllowedExtensionArray = ["png","svg","jpg","jpeg","webp"];
        if(!in_array(strtolower($extension), $AllowedExtensionArray)){ 
            $CategoryImageNameErr = "Invalid Extension";
        }
    }

    if(empty($CategoryNameErr) && empty($CategoryDescErr) && empty($CategoryImageNameErr)){
        if(move_uploaded_file($CategoryImageTmpName, $destination)){
            $query = $pdo->prepare("INSERT INTO categories (name, des, image)   VALUES (:cName, :cDesc, :cImage)");
            $query->bindParam(":cName", $CategoryName);
            $query->bindParam(":cDesc", $CategoryDesc);
            $query->bindParam(":cImage", $CategoryImageName);
            $query->execute();
            echo "<script> alert('Category added successfully'); location.assign('select.php'); </script>";
        }
    }
}
?>
