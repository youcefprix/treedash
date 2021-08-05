# treedash
##flutter app withe a simple PHP REST API


## Built With

* [Flutter](https://flutter.io) - Cross Platform App Development Framework

## Screenshots
![alt text](https://raw.githubusercontent.com/youcefprix/treedash/master/Capture.PNG)
![alt text](https://raw.githubusercontent.com/youcefprix/treedash/master/Capture2.PNG)

## How to use this App.
* Host the sample included inside [rest_api](https://github.com/youcefprix/treedash/tree/master/rest_api) on preffered web hosting
* Create a table inside your database using [api_data.sql](https://github.com/youcefprix/treedash/blob/master/rest_api/api_data.sql)
* If you are using your own website just edit the following constant inside [NodeProvider.dart](https://github.com/youcefprix/treedash/blob/master/lib/providers/node_provider.dart)

      final String apiUrl = "https://localhost.com/";

* Make sure to edit [DataBase.php](https://github.com/youcefprix/treedash/blob/master/rest_api/config/Database.php) and change following things -

    private $host = 'localhost';
    private $db_name = 'api_data';
    private $username = 'root';
    private $password = '';
    private $conn;


## Features Implemented
* Add a new tree
* Show all the trees from DB
* Add a new element 
* Delete a tree

## Things you can learn through this project -
* Navigation Between Pages.
* Performing Operations in Background Thread.
* Network Requests.
* Serializing and DesSerializing JSON.
* Dialogs and SnackBar.
* Custom Progress Dialog.
* Rest API Integration.
* Store and Retrieve values from Shared Preference.


## Helping Hands for this project

* https://flutter.io/

* https://flutter.io/json/#creating-model-classes-the-json_serializable-way
* https://flutter.io/json/
* https://flutter.io/cookbook/networking/fetch-data/
* https://flutter.io/cookbook/

