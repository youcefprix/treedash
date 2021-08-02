<?php

require_once '../../vendor/autoload.php';



include_once '../../config/Database.php';
include_once '../../models/Node.php';

// Instantiate DB & connect
$database = new Database();
$db = $database->connect();

$node = new Node($db);




// Get ID
$node->nodeId = isset($_GET['id']) ? $_GET['id'] : die();

$result = $node->read_tree();

$rootNode = $node->read_single();
$rootRow = $rootNode->fetch(PDO::FETCH_ASSOC);
extract($rootRow);
$node->nodeTitle = $nodeTitle;




if ($result->rowCount() > 0) {
    // data array
    $node_arr = array();
    
    while ($row = $result->fetch(PDO::FETCH_ASSOC)) {
        extract($row);
       
       
        array_push($node_arr, array(
            'nodeId' => $nodeId,
            'parentId' => $parentId,
            'nodeTitle' => $nodeTitle,
        ));
      
        
    }
     
    $theTree = array(
        'nodeId' => $node->nodeId,
        'parentId' => -1,
        'nodeTitle'=> $node->nodeTitle,
        'children' => parseTree($node_arr, $node->nodeId),
    );
   

    
   // printTree([$theTree]);
    $mpdf = new \Mpdf\Mpdf();
printTree([$theTree],$mpdf);
 
$mpdf->Output();

   
    
    
  
   
} else {
    // No Posts
    echo json_encode(
        array('message' => 'No node Found')
    );
}


function parseTree($tree,$root) {
    $return = array();
    # Traverse the tree and search for direct children of the root
    foreach($tree as $child => $parent) {
        # A direct child is found
        
        if($parent['parentId'] == $root) {
           /*print_r($parent['nodeId']);
           print_r($root);*/
           $reroot = $tree[$child];
            # Remove item from tree (we don't need to traverse this again)
            unset($tree[$child]);
            # Append the child into result array and parse its children
            $return[] = array(
                'nodeId' => $reroot['nodeId'],
                'parentId'=>$reroot['parentId'],
                'nodeTitle'=>$reroot['nodeTitle'],
                'children' => parseTree($tree, $reroot['nodeId'])
            );
           
        }
    }
    return empty($return) ? null : $return;    
}




function printTree($tree,$mp) {
    if(!is_null($tree) && count($tree) > 0) {
        $mp->WriteHTML( '<ul>');
        foreach($tree as $node) {
            $mp->WriteHTML( '<li>'.$node['nodeTitle']);
            printTree($node['children'],$mp);
            $mp->WriteHTML( '</li>');
        }
        $mp->WriteHTML( '</ul>');
    }
}







?>



