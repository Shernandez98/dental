-- Diseño relacional propuesto para una futura versión con backend (MySQL 8+).
-- El prototipo web actual NO se conecta a estas tablas.
CREATE DATABASE IF NOT EXISTS consultorio_dental CHARACTER SET utf8mb4;
USE consultorio_dental;
CREATE TABLE pacientes (id INT PRIMARY KEY AUTO_INCREMENT, nombre VARCHAR(80) NOT NULL, apellidos VARCHAR(120) NOT NULL, nacimiento DATE, telefono VARCHAR(25), direccion VARCHAR(255), correo VARCHAR(150));
CREATE TABLE tratamientos (id INT PRIMARY KEY AUTO_INCREMENT, nombre VARCHAR(120) NOT NULL, descripcion TEXT, precio DECIMAL(10,2) NOT NULL CHECK(precio >= 0));
CREATE TABLE citas (id INT PRIMARY KEY AUTO_INCREMENT, paciente_id INT NOT NULL, tratamiento_id INT NOT NULL, fecha DATE NOT NULL, hora TIME NOT NULL, dentista VARCHAR(120) NOT NULL, estado ENUM('Programada','Confirmada','Completada','Cancelada') NOT NULL DEFAULT 'Programada', notas TEXT, FOREIGN KEY(paciente_id) REFERENCES pacientes(id), FOREIGN KEY(tratamiento_id) REFERENCES tratamientos(id));
CREATE TABLE tratamientos_realizados (id INT PRIMARY KEY AUTO_INCREMENT, paciente_id INT NOT NULL, tratamiento_id INT NOT NULL, fecha DATE NOT NULL, detalle TEXT, precio DECIMAL(10,2) NOT NULL, FOREIGN KEY(paciente_id) REFERENCES pacientes(id), FOREIGN KEY(tratamiento_id) REFERENCES tratamientos(id));
CREATE TABLE facturas (id INT PRIMARY KEY AUTO_INCREMENT, paciente_id INT NOT NULL, fecha DATE NOT NULL, total DECIMAL(10,2) NOT NULL, FOREIGN KEY(paciente_id) REFERENCES pacientes(id));
CREATE TABLE detalle_factura (id INT PRIMARY KEY AUTO_INCREMENT, factura_id INT NOT NULL, tratamiento_id INT NOT NULL, descripcion VARCHAR(150) NOT NULL, cantidad INT NOT NULL, precio DECIMAL(10,2) NOT NULL, FOREIGN KEY(factura_id) REFERENCES facturas(id), FOREIGN KEY(tratamiento_id) REFERENCES tratamientos(id));
CREATE TABLE pagos (id INT PRIMARY KEY AUTO_INCREMENT, factura_id INT NOT NULL, fecha DATE NOT NULL, monto DECIMAL(10,2) NOT NULL CHECK(monto > 0), metodo ENUM('Efectivo','Tarjeta','Transferencia') NOT NULL, FOREIGN KEY(factura_id) REFERENCES facturas(id));
