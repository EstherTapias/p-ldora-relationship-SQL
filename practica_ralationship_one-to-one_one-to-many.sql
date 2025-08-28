-- BIBLIOTECA DIGITAL
-- DATABASE
CREATE DATABASE relationship_sql;
USE relationship_sql;
-- Tabla Autores (Uno)
CREATE TABLE autores (
    id INTEGER PRIMARY KEY,
    nombre VARCHAR(100),
    nacionalidad VARCHAR(50)
);

-- Tabla Libros (Muchos) - One-to-Many
CREATE TABLE libros (
    id INTEGER PRIMARY KEY,
    titulo VARCHAR(200),
    autor_id INTEGER,
    año_publicacion INTEGER,
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

-- Tabla Perfiles_Autor (Uno) - One-to-One
CREATE TABLE perfiles_autor (
    id INTEGER PRIMARY KEY,
    autor_id INTEGER UNIQUE,
    biografia TEXT,
    foto_url VARCHAR(300),
    FOREIGN KEY (autor_id) REFERENCES autores(id)
);

SHOW TABLES;

-- Insertar autores
INSERT INTO autores VALUES 
(1, 'Gabriel García Márquez', 'Colombiana'),
(2, 'Isabel Allende', 'Chilena'),
(3, 'Mario Vargas Llosa', 'Peruana');

-- Insertar libros (One-to-Many: Un autor puede tener varios libros)
INSERT INTO libros VALUES 
(1, 'Cien años de soledad', 1, 1967),
(2, 'El amor en los tiempos del cólera', 1, 1985),
(3, 'La casa de los espíritus', 2, 1982),
(4, 'Eva Luna', 2, 1987),
(5, 'La ciudad y los perros', 3, 1963);

-- Insertar perfiles (One-to-One: Un autor tiene un solo perfil)
INSERT INTO perfiles_autor VALUES 
(1, 1, 'Escritor colombiano, Premio Nobel de Literatura 1982', 'foto1.jpg'),
(2, 2, 'Escritora chilena, una de las más leídas del mundo', 'foto2.jpg');

-- 1. Mostrar todos los libros con el nombre de su autor
SELECT l.titulo, a.nombre AS autor
FROM libros l
JOIN autores a ON l.autor_id = a.id;

-- 2. ¿Cuántos libros ha escrito cada autor?
SELECT a.nombre, COUNT(l.id) AS total_libros
FROM autores a
LEFT JOIN libros l ON a.id = l.autor_id
GROUP BY a.id, a.nombre;

-- 3. Mostrar solo autores que tienen más de 1 libro
SELECT a.nombre, COUNT(l.id) AS total_libros
FROM autores a
LEFT JOIN libros l ON a.id = l.autor_id
GROUP BY a.id, a.nombre
HAVING COUNT(l.id) > 1;

-- 1. Mostrar autores con su biografía
SELECT a.nombre, p.biografia
FROM autores a
JOIN perfiles_autor p ON a.id = p.autor_id;

-- 2. Mostrar TODOS los autores (tengan o no perfil)
SELECT a.nombre, p.biografia
FROM autores a
LEFT JOIN perfiles_autor p ON a.id = p.autor_id;