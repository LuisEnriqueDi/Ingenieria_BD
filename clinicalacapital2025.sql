-- Tabla Persona
CREATE TABLE Persona (
    ID_Persona INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremento en SQL Server
    Nombre VARCHAR(100) NOT NULL,
    Documento VARCHAR(20) UNIQUE NOT NULL,
    Telefono VARCHAR(15),
    Direccion VARCHAR(255),
    Email VARCHAR(100) UNIQUE,
    Tipo VARCHAR(50) NOT NULL CHECK (Tipo IN ('Médico', 'Paciente', 'Administrativo', 'Servicio General', 'Usuario'))
);

-- Tabla Especialidades
CREATE TABLE Especialidades (
    ID_Especialidad INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremento en SQL Server
    Nombre VARCHAR(100) UNIQUE NOT NULL,
    Descripcion TEXT
);

-- Tabla Medicos
CREATE TABLE Medicos (
    ID_Medico INT PRIMARY KEY,  -- No auto-incremento (se relaciona con Persona)
    ID_Especialidad INT NOT NULL,
    FOREIGN KEY (ID_Medico) REFERENCES Persona(ID_Persona) ON DELETE CASCADE,
    FOREIGN KEY (ID_Especialidad) REFERENCES Especialidades(ID_Especialidad)
);

-- Tabla Pacientes
CREATE TABLE Pacientes (
    ID_Paciente INT PRIMARY KEY,  -- No auto-incremento (se relaciona con Persona)
    Fecha_Nacimiento DATE NOT NULL,
    FOREIGN KEY (ID_Paciente) REFERENCES Persona(ID_Persona) ON DELETE CASCADE
);

-- Tabla Trabajadores_Administrativos
CREATE TABLE Trabajadores_Administrativos (
    ID_Trabajador INT PRIMARY KEY,  -- No auto-incremento (se relaciona con Persona)
    Cargo VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_Trabajador) REFERENCES Persona(ID_Persona) ON DELETE CASCADE
);

-- Tabla Servicios_Generales
CREATE TABLE Servicios_Generales (
    ID_Empleado INT PRIMARY KEY,  -- No auto-incremento (se relaciona con Persona)
    Area VARCHAR(50) NOT NULL,
    FOREIGN KEY (ID_Empleado) REFERENCES Persona(ID_Persona) ON DELETE CASCADE
);

-- Tabla Usuarios
CREATE TABLE Usuarios (
    ID_Usuario INT PRIMARY KEY,  -- No auto-incremento (se relaciona con Persona)
    Username VARCHAR(50) UNIQUE NOT NULL,
    Password VARCHAR(255) NOT NULL,
    Rol VARCHAR(50) NOT NULL CHECK (Rol IN ('Administrador', 'Recepcionista', 'Médico', 'Paciente')),
    FOREIGN KEY (ID_Usuario) REFERENCES Persona(ID_Persona) ON DELETE CASCADE
);

-- Tabla Consultorios
CREATE TABLE Consultorios (
    ID_Consultorio INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremento en SQL Server
    Numero VARCHAR(10) UNIQUE NOT NULL,
    Piso INT NOT NULL
);

-- Tabla Citas
CREATE TABLE Citas (
    ID_Cita INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremento en SQL Server
    Fecha DATE NOT NULL,
    Hora TIME NOT NULL,
    ID_Paciente INT NOT NULL,
    ID_Medico INT NOT NULL,
    ID_Consultorio INT NOT NULL,
    Estado VARCHAR(50) DEFAULT 'Programada' CHECK (Estado IN ('Programada', 'Cancelada', 'Realizada')),
    FOREIGN KEY (ID_Paciente) REFERENCES Pacientes(ID_Paciente),
    FOREIGN KEY (ID_Medico) REFERENCES Medicos(ID_Medico),
    FOREIGN KEY (ID_Consultorio) REFERENCES Consultorios(ID_Consultorio)
);

-- Tabla HistorialMedico
CREATE TABLE HistorialMedico (
    ID_Historial INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremento en SQL Server
    ID_Paciente INT NOT NULL,
    Fecha DATE NOT NULL,
    Diagnostico TEXT NOT NULL,
    FOREIGN KEY (ID_Paciente) REFERENCES Pacientes(ID_Paciente)
);

-- Tabla Tratamientos
CREATE TABLE Tratamientos (
    ID_Tratamiento INT IDENTITY(1,1) PRIMARY KEY,  -- Auto-incremento en SQL Server
    ID_Historial INT NOT NULL,
    Descripcion TEXT NOT NULL,
    Fecha_Inicio DATE NOT NULL,
    Fecha_Fin DATE,
    FOREIGN KEY (ID_Historial) REFERENCES HistorialMedico(ID_Historial)
);

--------------insertar datos 


-- Insertar todas las personas necesarias
INSERT INTO Persona (Nombre, Documento, Telefono, Direccion, Email, Tipo) VALUES
-- Médicos
('Juan Pérez', '100000001', '3001234567', 'Calle 1 #10-20', 'juan.perez@email.com', 'Médico'),
('Laura Sánchez', '100000006', '3045678901', 'Calle 6 #35-70', 'laura.sanchez@email.com', 'Médico'),
('Jorge López', '100000007', '3056789012', 'Calle 7 #40-80', 'jorge.lopez@email.com', 'Médico'),
('Sofía Ramírez', '100000008', '3067890123', 'Calle 8 #45-90', 'sofia.ramirez@email.com', 'Médico'),
('Luis Torres', '100000009', '3078901234', 'Calle 9 #50-100', 'luis.torres@email.com', 'Médico'),

-- Pacientes
('María Gómez', '100000002', '3009876543', 'Calle 2 #15-30', 'maria.gomez@email.com', 'Paciente'),
('Carmen Díaz', '100000010', '3089012345', 'Calle 10 #55-110', 'carmen.diaz@email.com', 'Paciente'),
('Luis Martínez', '100000011', '3090123456', 'Calle 11 #60-120', 'luis.martinez@email.com', 'Paciente'),
('Ana López', '100000012', '3101234567', 'Calle 12 #65-130', 'ana.lopez@email.com', 'Paciente'),
('Pedro Sánchez', '100000013', '3112345678', 'Calle 13 #70-140', 'pedro.sanchez@email.com', 'Paciente'),

-- Trabajadores Administrativos
('Carlos Ríos', '100000003', '3014567890', 'Calle 3 #20-40', 'carlos.rios@email.com', 'Administrativo'),
('Marta Rodríguez', '100000014', '3123456789', 'Calle 14 #75-150', 'marta.rodriguez@email.com', 'Administrativo'),
('Carlos Fernández', '100000015', '3134567890', 'Calle 15 #80-160', 'carlos.fernandez@email.com', 'Administrativo'),
('Laura Morales', '100000016', '3145678901', 'Calle 16 #85-170', 'laura.morales@email.com', 'Administrativo'),
('Javier Ruiz', '100000017', '3156789012', 'Calle 17 #90-180', 'javier.ruiz@email.com', 'Administrativo'),

-- Servicios Generales
('Ana Torres', '100000004', '3023456789', 'Calle 4 #25-50', 'ana.torres@email.com', 'Servicio General'),
('Sara Castro', '100000018', '3167890123', 'Calle 18 #95-190', 'sara.castro@email.com', 'Servicio General'),
('Diego Navarro', '100000019', '3178901234', 'Calle 19 #100-200', 'diego.navarro@email.com', 'Servicio General'),
('Elena Vargas', '100000020', '3189012345', 'Calle 20 #105-210', 'elena.vargas@email.com', 'Servicio General'),
('Miguel Torres', '100000021', '3190123456', 'Calle 21 #110-220', 'miguel.torres@email.com', 'Servicio General'),

-- Usuarios
('Pedro Ramírez', '100000005', '3032345678', 'Calle 5 #30-60', 'pedro.ramirez@email.com', 'Usuario'),
('Admin Clinica', '100000022', '3201234567', 'Calle 22 #115-230', 'admin.clinica@email.com', 'Usuario'),
('Recepcionista1', '100000023', '3212345678', 'Calle 23 #120-240', 'recepcionista1@email.com', 'Usuario'),
('Médico Carlos', '100000024', '3223456789', 'Calle 24 #125-250', 'medico.carlos@email.com', 'Usuario'),
('Paciente Luis', '100000025', '3234567890', 'Calle 25 #130-260', 'paciente.luis@email.com', 'Usuario');

INSERT INTO Especialidades (Nombre, Descripcion) VALUES
('Cardiología', 'Especialidad en enfermedades del corazón'),
('Neurología', 'Especialidad en trastornos del sistema nervioso'),
('Pediatría', 'Especialidad en niños y adolescentes'),
('Dermatología', 'Especialidad en enfermedades de la piel'),
('Ortopedia', 'Especialidad en huesos y articulaciones');

INSERT INTO Medicos (ID_Medico, ID_Especialidad) VALUES
(1, 1),  -- Juan Pérez, Cardiología
(6, 2),  -- Laura Sánchez, Neurología
(7, 3),  -- Jorge López, Pediatría
(8, 4),  -- Sofía Ramírez, Dermatología
(9, 5);  -- Luis Torres, Ortopedia

INSERT INTO Pacientes (ID_Paciente, Fecha_Nacimiento) VALUES
(2, '1990-05-15'),  -- María Gómez
(10, '1985-07-20'), -- Carmen Díaz
(11, '2000-03-12'), -- (Agregar a Persona primero)
(12, '1978-09-05'), -- (Agregar a Persona primero)
(13, '1995-11-25'); -- (Agregar a Persona primero)

INSERT INTO Trabajadores_Administrativos (ID_Trabajador, Cargo) VALUES
(3, 'Gerente'),      -- Carlos Ríos
(14, 'Secretaria'),  -- (Agregar a Persona primero)
(15, 'Contador'),    -- (Agregar a Persona primero)
(16, 'Recepcionista'), -- (Agregar a Persona primero)
(17, 'Asistente');   -- (Agregar a Persona primero)

INSERT INTO Servicios_Generales (ID_Empleado, Area) VALUES
(4, 'Limpieza'),      -- Ana Torres
(18, 'Mantenimiento'), -- (Agregar a Persona primero)
(19, 'Seguridad'),    -- (Agregar a Persona primero)
(20, 'Cafetería'),    -- (Agregar a Persona primero)
(21, 'Jardinería');   -- (Agregar a Persona primero)

INSERT INTO Usuarios (ID_Usuario, Username, Password, Rol) VALUES
(5, 'pedro_ramirez', 'hashed_password1', 'Paciente'),  -- Pedro Ramírez
(22, 'admin_clinica', 'hashed_password2', 'Administrador'), -- (Agregar a Persona primero)
(23, 'recepcionista1', 'hashed_password3', 'Recepcionista'), -- (Agregar a Persona primero)
(24, 'medico_carlos', 'hashed_password4', 'Médico'), -- (Agregar a Persona primero)
(25, 'paciente_luis', 'hashed_password5', 'Paciente'); -- (Agregar a Persona primero)

INSERT INTO Consultorios (Numero, Piso) VALUES
('101', 1),
('102', 1),
('201', 2),
('202', 2),
('301', 3);

INSERT INTO Citas (Fecha, Hora, ID_Paciente, ID_Medico, ID_Consultorio, Estado) VALUES
('2025-03-10', '10:00:00', 2, 1, 1, 'Programada'),  -- María Gómez, Juan Pérez
('2025-03-11', '11:30:00', 10, 6, 2, 'Programada'), -- Carmen Díaz, Laura Sánchez
('2025-03-12', '14:00:00', 11, 7, 3, 'Cancelada'),  -- (Agregar a Persona primero)
('2025-03-13', '16:00:00', 12, 8, 4, 'Realizada'),  -- (Agregar a Persona primero)
('2025-03-14', '09:00:00', 13, 9, 5, 'Programada'); -- (Agregar a Persona primero)

INSERT INTO HistorialMedico (ID_Paciente, Fecha, Diagnostico) VALUES
(2, '2025-02-15', 'Hipertensión leve'),  -- María Gómez
(10, '2025-01-20', 'Dolor de cabeza crónico'), -- Carmen Díaz
(11, '2025-02-10', 'Fractura en brazo derecho'), -- Luis Martínez
(12, '2025-01-25', 'Alergia severa'), -- Ana López
(13, '2025-03-01', 'Gastritis'); -- Pedro Sánchez

INSERT INTO Tratamientos (ID_Historial, Descripcion, Fecha_Inicio, Fecha_Fin) VALUES
(1, 'Dieta baja en sal y ejercicio', '2025-02-16', '2025-05-16'),  -- Historial 1
(2, 'Medicamento para migrañas', '2025-01-21', '2025-04-21'),     -- Historial 2
(3, 'Fisioterapia y reposo', '2025-02-11', '2025-06-11'),         -- Historial 3
(4, 'Antihistamínicos y seguimiento', '2025-01-26', '2025-03-26'),-- Historial 4
(5, 'Dieta especial y tratamiento para el reflujo', '2025-03-02', '2025-06-02'); -- Historial 5

select * from Citas;
select * from HistorialMedico;