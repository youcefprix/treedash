<?php

header('Access-Control-Allow-Origin: *');
header('Content-Type: application/json');


include_once '../../config/Database.php';
include_once '../../models/Node.php';

// Instantiate DB & connect
$database = new Database();
$db = $database->connect();

$node = new Node($db);

$result = $node->read();

if ($result->rowCount() > 0) {
    // data array
    $node_arr['node'] = array();

    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);
        $node_item = array(
            'nodeId' => $nodeId,
            'parentId' => $parentId,
            'nodeTitle' => $nodeTitle,
        );
        
       
            array_push($node_arr['node'], $node_item);
    }

    //Turn to JSON output
    echo json_encode($node_arr);
} else {
    // No Posts
    echo json_encode(
        array('message' => 'No node Found')
    );
}
