const connection = require("../../config/db");
const { changeUser } = require("../../config/db");
const bcryptjs = require("bcryptjs");

module.exports = (app) => {
    app.get("/", (req, res) => {
        if (req.session.loggedin) {
            res.render("../views/index.ejs", {
                login: true,
                name: req.session.name,
            });
        } else {
            res.render("../views/index.ejs", {
                login: false,
                name: "por favor inicie sesion",
            });
        }
    });
    app.get("/login", (req, res) => {
        res.render("../views/login.ejs");
    });

    app.get("/servicios", (req, res) => {
        res.render("../views/servicios.ejs");
    });

    app.get("/initSession", (req, res) => {
        res.render("../views/initSession.ejs");
    });

    app.get("/register", (req, res) => {
        res.render("../views/register.ejs");
    });

    app.get("/detalles", (req, res) => {
        res.render("../views/detalles.ejs");
    });

    app.get("/desarrolladores", (req, res) => {
        res.render("../views/desarrolladores.ejs");
    });

    app.get("/logout", (req, res) => {
        req.session.destroy(() => {
            res.redirect("/");
        });
    });

    app.post("/initSession", (req, res) => {
        var cedula = req.body.cedula;
        var password = req.body.password;
        connection.query(
            `SELECT * FROM users WHERE identification_user LIKE N'%${cedula}%' AND password_user LIKE N'%${password}%' `,
            function(error, filas) {
                if (error) {
                    throw error;
                } else {
                    res.render(
                        "../views/initSession.ejs", { data: filas[0] },
                    );
                }
            }
        );
    });


    app.post("/agregarAhorro", (req, res) => {
        var mes = req.body.mes;
        var cedula = req.body.cedula;
        var valorAhorro = req.body.valorAhorro;
        let values = { id_ahorro: 0, mes_ahorro: mes, cedula_ahorro: cedula, valor_ahorro: valorAhorro }

        connection.query(
            "INSERT INTO ahorrousers SET ?", values,
            function(error, filas) {
                if (error) {
                    throw error;
                } else {
                    res.redirect('http://localhost:3000/consultarAhorro?');
                }
            }
        );
    });


    app.get("/consultarAhorro/", (req, res) => {
        connection.query(
            "SELECT * FROM  ahorrousers",
            function(error, response) {
                if (error) {
                    throw error;
                } else {
                    res.render(
                        "../views/initSession.ejs", { data: response },
                    );
                }
            }
        );
    });

    app.post("/eliminarAhorro/:id", (req, res) => {
        const courseId = req.params.id;

        connection.query(
            `DELETE FROM ahorrousers WHERE  id_ahorro = ${courseId}`,
            function(error, response) {
                if (error) {
                    throw error;
                } else {

                    res.redirect('http://localhost:3000/consultarAhorro?');
                }
            }
        );
    });


    app.post("/consultarCedula", (req, res) => {
        var cedula = req.body.cedula;

        console.log(cedula);

        connection.query(
            `SELECT * from ahorrousers WHERE cedula_ahorro =  ${cedula}`,
            function(error, response) {
                if (error) {
                    throw error;
                } else {
                    res.render(
                        "../views/initSession.ejs", { data: response },
                    );
                }
            }
        );
    });




    app.post("/register", async(req, res) => {
        const { user, name, rol, pass } = req.body;
        let passwordHash = await bcryptjs.hash(pass, 8);
        connection.query(
            "INSERT INTO users SET ?", {
                user: user,
                name: name,
                rol: rol,
                pass: passwordHash,
            },
            async(error, result) => {
                if (error) {
                    console.log(error);
                } else {
                    res.render("../views/register.ejs", {
                        alert: true,
                        alertTitle: "Registration",
                        alertMessage: "Successful Registration",
                        alertIcon: "success",
                        showConfirmButton: false,
                        timer: 15000,
                    });
                }
            }
        );
    });

    app.post("/auth", async(req, res) => {
        const { user, pass } = req.body;
        let passwordHash = await bcryptjs.hash(pass, 8);

        if (user && pass) {
            connection.query(
                "SELECT * FROM administrador WHERE nombre_admin = ?", [user],
                async(err, results) => {
                    console.log(results);

                    if (err) {
                        res.send("error " + err);
                    }
                    if (
                        results.length === 0 ||
                        !(await bcryptjs.compare(pass, results[0].contrasena_admin))
                    ) {
                        res.render("../views/register.ejs", {
                            alert: true,
                            alertTitle: "Error",
                            alertMessage: "Usuario y/o contraseña incorrectos",
                            alertIcon: "error",
                            showConfirmButton: true,
                            timer: 1500,
                            ruta: "",
                        });
                    } else {
                        req.session.loggedin = true;
                        req.session.name = results[0].nombre_admin;
                        res.render("../views/register.ejs", {
                            alert: true,
                            alertTitle: "Conexión exitosa",
                            alertMessage: "Login Correcto",
                            alertIcon: "success",
                            showConfirmButton: true,
                            timer: 1500,
                            ruta: "",
                        });
                    }
                }
            );
        }
    });
};