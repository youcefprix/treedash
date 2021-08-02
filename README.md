# treedash
##flutter app withe a simple PHP REST API


## Built With

* [Flutter](https://flutter.io) - Cross Platform App Development Framework



## How to use this App.
* Host the sample included inside [rest_api](https://github.com/youcefprix/treedash/tree/master/rest_api) on preffered web hosting
* Create a table inside your database using [FlutterClientPhpBackend.sql](https://github.com/harsh159357/flutter_client_php_backend/blob/master/phpbackend/FlutterClientPhpBackend.sql)
* If you are using your own website just edit the following constant inside [constants.dart](https://github.com/harsh159357/flutter_client_php_backend/blob/master/lib/utils/constants.dart)

      static const String API_BASE_URL = "https://bingedev.com/";

* Make sure to edit [DBOperations.php](https://github.com/harsh159357/flutter_client_php_backend/blob/master/phpbackend/DBOperations.php) and change following things -

    private $host = 'your_host';
    private $user = 'your_user_name';
    private $db = 'your_database';
    private $pass = 'your_password';

### Not Interested in doing above steps just clone this repo and use it as it is already hosted [bingedev](https://bingedev.com/)


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

