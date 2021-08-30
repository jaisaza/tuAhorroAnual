const mysql = require("mysql");
const connection = mysql.createConnection({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    database: process.env.DB_DATABASE,
});

connection.connect((error) => {
    if (error) {
        console.log("este error se presenta: " + error);
        return;
    }
    console.log("Conectado exitosamente a la BD");
});

module.exports = connection;

/*console.log('Entró');
connection.query('SELECT * FROM users', function(error, filas) {
    if (error) {
        throw error;
    } else {
        filas.forEach(response => {
            //console.log(response);
        });
    }
});*/

//var cedula = 1152715284;

/*connection.query(`SELECT * FROM users WHERE identification_user LIKE N'%${cedula}%' `, function(error, filas) {
    if (error) {
        throw error;
    } else {
        filas.forEach(response => {
            //console.log(response);
        });
    }
})*/