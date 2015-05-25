var express = require('express');
var mysql = require('mysql');
var formidable = require('formidable'); 

var app = express();

var static = __dirname + '/static';
app.use(express.static(static)); 

var uploads = __dirname + '/uploads';
app.use(express.static(uploads));

app.set('view engine', 'ejs');
app.set('views', __dirname + '/view');
app.engine('html', require('ejs').renderFile);

app.set('port', (process.env.PORT || 3000));

/* DB Connection Setting */
var pool = mysql.createPool({
    host :'10.73.43.77', 
    user : 'nextuser',
    password : 'dbgood',
    database : 'dskim',
});
app.get('/', function(req, res){
    pool.getConnection(function(err, connection){
        if(err){
            console.log('connection error');
            throw err;
        }
        connection.query('select customer_customerID, count(customer_customerID) from `order` group by customer_customerID;' ,function(err, result){
            if(err){
                console.log('select err');
                throw err;
            }
            console.log(result);
            var str = [];
            for(var i = 0; i< result.length; ++i){
                
                var ele = {
                    customerID : result[i].customer_customerID,
                    count : result[i]['count(customer_customerID)']
                };
                str[str.length] = ele;
            }
            res.send(JSON.stringify(str,null,4))
        });
    }); 
});

app.get('/:customerID', function(req, res){
    var cusId = req.param('customerID');
    pool.getConnection(function(err, connection){
        if(err){
            console.log('connection error');
            throw err;
        }
        connection.query('select customer_customerID, count(customer_customerID) from `order` where customer_customerID = ' + cusId + ';' ,function(err, result){
            if(err){
                console.log('select err');
                throw err;
            }
            var str = 'customerID : ' + result[0].customer_customerID + '\ncount : ' + result[0]['count(customer_customerID)'];
            res.send(str)
        });
    });     
});

app.listen(app.get("port"), function(){
    console.log('server running at port '+app.get("port")+'...');
});