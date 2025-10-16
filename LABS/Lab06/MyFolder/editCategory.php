 <?php
include("php/query.php");
?> 
<!doctype html>
<html lang="en">
  <head>
    <title>Title</title>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
  </head>
  <body>
        <?php 
            if(isset($_GET["cId"])){
                $categoryId = $_GET["cId"];
                $query = $pdo->prepare('select * from categories where id = :catId');
                $query->execute();
                $category = $query->fetch(PDO::FETCH_ASSOC);
                print_r($category);
            }
        ?>

      <div class = "container">
            <form action="" method="post" enctype="multipart/form-data">
                <div class = "form-group">
                    <label for=""> Name</label>
                    <input type="text" value="<?php echo $category['name']?>" name="cName" id="" class="form-control"
                    placeholder="" aria-describedby="helpid" >
                    <small id="helpid" class = "text-danger"><?php echo $CategoryNameErr?></small>
                </div>
                <div class = "form-group">
                    <label for=""> Image</label>
                    <input type="file" name="cImage" id="" class="form-control"
                    placeholder="" aria-describedby="helpid" >
                    <small id="helpid" class = "text-danger"><?php echo $CategoryImageNameErr?></small>  
                    <img src="images/<?php echo $category['image']?>" alt="">
                </div>
                <div class = "form-group">
                    <label for=""> Description</label>
                    <textarea type="text" name="cDesc" id="" class="form-control"
                    placeholder="" aria-describedby="helpid" ><?php echo $category['des']?></textarea>
                    <small id="helpid" class = "text-danger"><?php echo $CategoryDescErr?></small>
                    
                </div>
                <button class ="btn-info btn" name="updateCategory"> Update Category</button>
            </form>
      </div>

  </body>
</html>