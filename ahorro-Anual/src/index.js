const app = require('./config/server');
const connection = require('./config/db');
require('./app/routes/login_registro')(app);


app.listen(app.get('port'), () => {
    console.log("estamos en el puerto ", app.get('port'))
})