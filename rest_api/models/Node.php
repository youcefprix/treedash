<?php
class Node
{
    // DB stuff
    private $conn;
    private $table = 'node';

    // Data Properties
    public $nodeId;
    public $parentId;
    public $nodeTitle;
    

    // Constructor with DB
    public function __construct($db)
    {
        $this->conn = $db;
    }

    // Get Trees
    public function read()
    {
        // Create query
        $query = 'SELECT * FROM  ' . $this->table . ' WHERE  parentId = -1';

        $stmt = $this->conn->query($query);

        $stmt->execute();

        return $stmt;
    }


    public function read_single()
    {
        // Create query
        $query = 'SELECT * FROM  ' . $this->table . ' WHERE  nodeId = ' . $this->nodeId . '';

        $stmt = $this->conn->query($query);

        $stmt->execute();

        return $stmt;
    }


    public function read_tree()
    {
        // Create query
        $query = 'SELECT * FROM  ' . $this->table . '';

        $stmt = $this->conn->query($query);

        $stmt->execute();

        return $stmt;
    }



    // Create new node
    public function create_node()
    {

        // Create query
        $query = "INSERT INTO  $this->table  (parentId,nodeTitle) VALUES ( ' $this->parentId ','  $this->nodeTitle ')";

        // Prepare statement
        $stmt = $this->conn->query($query);

        // Clean data
        $this->parentId = htmlspecialchars(strip_tags($this->parentId));
        $this->nodeTitle = htmlspecialchars(strip_tags($this->nodeTitle));


        // Bind data
        $stmt->bindParam(':parentId', $this->parentId);
        $stmt->bindParam(':nodeTitle', $this->nodeTitle);
  
        
        
    }

    //delete a node
    public function delete_node(){
        $query = 'DELETE FROM  ' . $this->table . ' WHERE  nodeId = ' . $this->nodeId . '';

        // Prepare statement
        $stmt = $this->conn->query($query);

    
      
        $stmt->execute();

        return $stmt;
    }
}
