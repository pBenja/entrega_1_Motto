CREATE DATABASE IF NOT EXISTS agencias_growth_marketing;
USE agencias_growth_marketing;

CREATE TABLE IF NOT EXISTS Agencia(
    agencia_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(200) NOT NULL,
    sitio_web VARCHAR(200) DEFAULT NULL,
    email_contacto VARCHAR(200) UNIQUE DEFAULT NULL,
    pais VARCHAR(80) NOT NULL,
    ciudad VARCHAR(120) NOT NULL,
    tam_equipo INT DEFAULT NULL,
    anio_fundacion INT DEFAULT NULL,
    descripcion_corta TEXT DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS Servicio(
    servicio_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(120) NOT NULL,
    descripcion TEXT DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS Industria(
    industria_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(120) NOT NULL
);

CREATE TABLE IF NOT EXISTS Cliente(
    cliente_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    razon_social VARCHAR(200) NOT NULL,
    pais VARCHAR(80) NOT NULL,
    industria_ref VARCHAR(120) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS CasoExito(
    caso_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    agencia_id INT NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT DEFAULT NULL,
    fecha_inicio DATE DEFAULT NULL,
    fecha_fin DATE DEFAULT NULL,
    kpi_principal VARCHAR(80) DEFAULT NULL,
    kpi_valor DECIMAL(18,4) DEFAULT NULL,
    moneda VARCHAR(10) DEFAULT NULL,
    link_soporte VARCHAR(300) DEFAULT NULL,
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id)
);

CREATE TABLE IF NOT EXISTS ResultadoCaso(
    resultado_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    caso_id INT NOT NULL,
    kpi VARCHAR(80) NOT NULL,
    valor DECIMAL(18,4) DEFAULT NULL,
    unidad VARCHAR(40) DEFAULT NULL,
    moneda VARCHAR(10) DEFAULT NULL,
    fecha DATE DEFAULT NULL,
    FOREIGN KEY (caso_id) REFERENCES CasoExito(caso_id)
);

CREATE TABLE IF NOT EXISTS Certificacion(
    cert_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    emisor VARCHAR(150) NOT NULL,
    fecha_vigencia_desde DATE DEFAULT NULL,
    fecha_vigencia_hasta DATE DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS MiembroEquipo(
    miembro_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    agencia_id INT NOT NULL,
    nombre VARCHAR(120) NOT NULL,
    apellido VARCHAR(120) NOT NULL,
    rol VARCHAR(120) NOT NULL,
    seniority VARCHAR(50) DEFAULT NULL,
    linkedin_url VARCHAR(300) DEFAULT NULL,
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id)
);

CREATE TABLE IF NOT EXISTS Herramienta(
    herr_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    tipo VARCHAR(80) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS PlanPrecio(
    plan_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    monto_min DECIMAL(18,2) DEFAULT NULL,
    monto_max DECIMAL(18,2) DEFAULT NULL,
    moneda VARCHAR(10) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS Propuesta(
    propuesta_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    agencia_id INT NOT NULL,
    cliente_id INT NOT NULL,
    fecha_emision DATE NOT NULL,
    validez_dias INT DEFAULT NULL,
    alcance TEXT DEFAULT NULL,
    monto_estimado DECIMAL(18,2) DEFAULT NULL,
    moneda VARCHAR(10) DEFAULT NULL,
    estado VARCHAR(40) DEFAULT NULL,
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);

CREATE TABLE IF NOT EXISTS Contrato(
    contrato_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    agencia_id INT NOT NULL,
    cliente_id INT NOT NULL,
    propuesta_id INT DEFAULT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE DEFAULT NULL,
    monto_total DECIMAL(18,2) DEFAULT NULL,
    moneda VARCHAR(10) DEFAULT NULL,
    condiciones TEXT DEFAULT NULL,
    estado VARCHAR(40) DEFAULT NULL,
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id),
    FOREIGN KEY (propuesta_id) REFERENCES Propuesta(propuesta_id)
);

-- TABLAS ASOCIATIVAS

CREATE TABLE IF NOT EXISTS AgenciaServicio(
    agencia_id INT NOT NULL,
    servicio_id INT NOT NULL,
    PRIMARY KEY (agencia_id, servicio_id),
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (servicio_id) REFERENCES Servicio(servicio_id)
);

CREATE TABLE IF NOT EXISTS AgenciaIndustria(
    agencia_id INT NOT NULL,
    industria_id INT NOT NULL,
    PRIMARY KEY (agencia_id, industria_id),
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (industria_id) REFERENCES Industria(industria_id)
);

CREATE TABLE IF NOT EXISTS AgenciaCertificacion(
    agencia_id INT NOT NULL,
    cert_id INT NOT NULL,
    fecha_obtencion DATE DEFAULT NULL,
    fecha_expiracion DATE DEFAULT NULL,
    PRIMARY KEY (agencia_id, cert_id),
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (cert_id) REFERENCES Certificacion(cert_id)
);

CREATE TABLE IF NOT EXISTS AgenciaHerramienta(
    agencia_id INT NOT NULL,
    herr_id INT NOT NULL,
    nivel_uso VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY (agencia_id, herr_id),
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (herr_id) REFERENCES Herramienta(herr_id)
);

CREATE TABLE IF NOT EXISTS AgenciaPlan(
    agencia_id INT NOT NULL,
    plan_id INT NOT NULL,
    PRIMARY KEY (agencia_id, plan_id),
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (plan_id) REFERENCES PlanPrecio(plan_id)
);

CREATE TABLE IF NOT EXISTS CasoCliente(
    caso_id INT NOT NULL,
    cliente_id INT NOT NULL,
    PRIMARY KEY (caso_id, cliente_id),
    FOREIGN KEY (caso_id) REFERENCES CasoExito(caso_id),
    FOREIGN KEY (cliente_id) REFERENCES Cliente(cliente_id)
);
USE agencias_growth_marketing;

-- 1. Agencia
INSERT INTO Agencia (nombre, sitio_web, email_contacto, pais, ciudad, tam_equipo, anio_fundacion, descripcion_corta) VALUES
('GrowthLab', 'https://growthlab.com', 'contact@growthlab.com', 'Argentina', 'Buenos Aires', 25, 2015, 'Agencia enfocada en performance y data-driven growth.'),
('RocketMedia', 'https://rocketmedia.com', 'hello@rocketmedia.com', 'Chile', 'Santiago', 15, 2018, 'Especialistas en marketing digital y automation.'),
('Boost&Co', 'https://boostco.com', 'info@boostco.com', 'Argentina', 'Córdoba', 12, 2017, 'Agencia boutique de growth para startups.'),
('DataGrow', 'https://datagrow.com', 'team@datagrow.com', 'Uruguay', 'Montevideo', 18, 2016, 'Foco en analítica avanzada y performance marketing.'),
('ImpactAds', 'https://impactads.com', 'sales@impactads.com', 'México', 'CDMX', 30, 2014, 'Agencia full-service con especialidad en paid media.'),
('ScaleUp', 'https://scaleup.com', 'contact@scaleup.com', 'Argentina', 'Buenos Aires', 20, 2019, 'Especialistas en escalado de campañas de performance.'),
('AdBoosters', 'https://adboosters.com', 'info@adboosters.com', 'Chile', 'Valparaíso', 14, 2020, 'Agencia joven con foco en creatividades.'),
('ClickWise', 'https://clickwise.com', 'hello@clickwise.com', 'Argentina', 'Rosario', 10, 2018, 'Marketing digital con foco en pymes.'),
('Growthify', 'https://growthify.com', 'team@growthify.com', 'Uruguay', 'Montevideo', 22, 2016, 'Agencia de growth con foco en datos.'),
('MediaLab', 'https://medialab.com', 'contact@medialab.com', 'México', 'Guadalajara', 28, 2013, 'Estrategias de medios integradas.');

-- 2. Servicio
INSERT INTO Servicio (nombre, descripcion) VALUES
('Paid UA', 'User Acquisition pagada en múltiples canales'),
('CRM & Lifecycle', 'Gestión de la relación con el cliente y marketing automatizado'),
('ASO', 'App Store Optimization para mejorar visibilidad en tiendas'),
('Analytics', 'Implementación y análisis de datos'),
('SEO', 'Optimización en motores de búsqueda'),
('Content Marketing', 'Creación y distribución de contenido relevante'),
('Influencer Marketing', 'Campañas con creadores de contenido'),
('Email Marketing', 'Campañas de email masivas y segmentadas'),
('Media Buying', 'Compra estratégica de medios'),
('Marketing Automation', 'Automatización de flujos y procesos');

-- 3. Industria
INSERT INTO Industria (nombre) VALUES
('Fintech'),
('Retail'),
('Salud'),
('Educación'),
('E-commerce'),
('Turismo'),
('Alimentación'),
('Tecnología'),
('Entretenimiento'),
('Moda');

-- 4. Cliente
INSERT INTO Cliente (razon_social, pais, industria_ref) VALUES
('Banco Digital X', 'Argentina', 'Fintech'),
('Tienda Online Y', 'Chile', 'E-commerce'),
('Hospital Z', 'Argentina', 'Salud'),
('Universidad W', 'México', 'Educación'),
('Retail Store V', 'Uruguay', 'Retail'),
('Agencia Viajes Q', 'Argentina', 'Turismo'),
('Restaurante Gourmet P', 'Chile', 'Alimentación'),
('Startup Tech R', 'Uruguay', 'Tecnología'),
('Cine Center S', 'México', 'Entretenimiento'),
('Marca de Ropa T', 'Argentina', 'Moda');

-- 5. CasoExito
INSERT INTO CasoExito (agencia_id, titulo, descripcion, fecha_inicio, fecha_fin, kpi_principal, kpi_valor, moneda, link_soporte) VALUES
(1, 'Campaña UA Fintech', 'Adquisición de usuarios para app bancaria', '2023-01-01', '2023-06-30', 'ROAS', 3.5, 'USD', 'http://link1.com'),
(2, 'Lifecycle Retail', 'Automatización de emails y push para retail', '2022-03-01', '2022-09-30', 'Open Rate', 45.0, '%', 'http://link2.com'),
(3, 'ASO E-commerce', 'Optimización de fichas de app de e-commerce', '2023-05-01', '2023-07-15', 'Installs', 20000, 'units', 'http://link3.com'),
(4, 'Analytics Salud', 'Implementación GA4 en hospital', '2022-08-01', '2023-01-15', 'Conversion Rate', 2.3, '%', 'http://link4.com'),
(5, 'SEO Educación', 'Posicionamiento web para universidad', '2023-02-01', '2023-08-01', 'Traffic', 150000, 'visits', 'http://link5.com'),
(6, 'Content Moda', 'Estrategia de contenidos para marca de ropa', '2023-04-01', '2023-09-01', 'Engagement Rate', 8.5, '%', 'http://link6.com'),
(7, 'Influencers Turismo', 'Campaña con influencers para agencia de viajes', '2023-05-15', '2023-07-15', 'Reach', 500000, 'users', 'http://link7.com'),
(8, 'Email Alimentación', 'Campaña de email para restaurante gourmet', '2023-03-01', '2023-05-30', 'CTR', 4.2, '%', 'http://link8.com'),
(9, 'Media Buying Tecnología', 'Compra de medios para startup tecnológica', '2023-06-01', '2023-09-30', 'Leads', 1200, 'units', 'http://link9.com'),
(10, 'Automatización Entretenimiento', 'Automatización de marketing para cine', '2023-01-15', '2023-04-15', 'Tickets Sold', 25000, 'units', 'http://link10.com');

-- 6. ResultadoCaso
INSERT INTO ResultadoCaso (caso_id, kpi, valor, unidad, moneda, fecha) VALUES
(1, 'CPC', 0.35, 'USD', 'USD', '2023-03-15'),
(1, 'CTR', 2.5, '%', NULL, '2023-03-15'),
(2, 'Open Rate', 45.0, '%', NULL, '2022-06-15'),
(3, 'Installs', 20000, 'units', NULL, '2023-06-01'),
(4, 'Conversion Rate', 2.3, '%', NULL, '2022-12-15'),
(5, 'Traffic', 150000, 'visits', NULL, '2023-07-01'),
(6, 'Engagement Rate', 8.5, '%', NULL, '2023-06-15'),
(7, 'Reach', 500000, 'users', NULL, '2023-06-20'),
(8, 'CTR', 4.2, '%', NULL, '2023-04-15'),
(9, 'Leads', 1200, 'units', NULL, '2023-08-01');

-- 7. Certificacion
INSERT INTO Certificacion (nombre, emisor, fecha_vigencia_desde, fecha_vigencia_hasta) VALUES
('Google Partner', 'Google', '2022-01-01', '2024-01-01'),
('Meta Business Partner', 'Meta', '2023-01-01', '2025-01-01'),
('Braze Certified Marketer', 'Braze', '2023-05-01', '2025-05-01'),
('CleverTap Expert', 'CleverTap', '2022-06-01', '2024-06-01'),
('HubSpot Solutions Partner', 'HubSpot', '2023-02-01', '2025-02-01'),
('Salesforce Marketing Cloud Specialist', 'Salesforce', '2023-03-01', '2025-03-01'),
('LinkedIn Marketing Partner', 'LinkedIn', '2022-04-01', '2024-04-01'),
('TikTok Marketing Expert', 'TikTok', '2023-06-01', '2025-06-01'),
('Twitter Ads Specialist', 'Twitter', '2022-08-01', '2024-08-01'),
('Pinterest Partner', 'Pinterest', '2023-07-01', '2025-07-01');

-- 8. MiembroEquipo
INSERT INTO MiembroEquipo (agencia_id, nombre, apellido, rol, seniority, linkedin_url) VALUES
(1, 'Juan', 'Pérez', 'CEO', 'Senior', 'https://linkedin.com/in/juanperez'),
(1, 'María', 'López', 'Head of Growth', 'Senior', 'https://linkedin.com/in/marialopez'),
(2, 'Carlos', 'Martínez', 'Data Analyst', 'Semi-Senior', 'https://linkedin.com/in/carlosmartinez'),
(3, 'Laura', 'Fernández', 'ASO Specialist', 'Junior', 'https://linkedin.com/in/laurafernandez'),
(4, 'Pedro', 'Gómez', 'Marketing Manager', 'Senior', 'https://linkedin.com/in/pedrogomez'),
(5, 'Lucía', 'Suárez', 'SEO Specialist', 'Semi-Senior', 'https://linkedin.com/in/luciasuarez'),
(6, 'Diego', 'Torres', 'Content Manager', 'Junior', 'https://linkedin.com/in/diegotorres'),
(7, 'Ana', 'Martínez', 'Influencer Manager', 'Senior', 'https://linkedin.com/in/anamartinez'),
(8, 'Sofía', 'Rivas', 'Email Marketing Lead', 'Semi-Senior', 'https://linkedin.com/in/sofiarivas'),
(9, 'Martín', 'Silva', 'Media Buyer', 'Senior', 'https://linkedin.com/in/martinsilva');

-- 9. Herramienta
INSERT INTO Herramienta (nombre, tipo) VALUES
('Google Ads', 'Ads'),
('Meta Ads', 'Ads'),
('Google Analytics 4', 'Analytics'),
('Braze', 'CEP'),
('CleverTap', 'CEP'),
('HubSpot', 'CRM'),
('Salesforce Marketing Cloud', 'CRM'),
('BigQuery', 'Analytics'),
('TikTok Ads', 'Ads'),
('Mailchimp', 'Email');

-- 10. PlanPrecio
INSERT INTO PlanPrecio (tipo, monto_min, monto_max, moneda) VALUES
('Retainer Mensual', 1000, 5000, 'USD'),
('Por Proyecto', 500, 10000, 'USD'),
('Por Hora', 50, 100, 'USD'),
('Retainer Mensual', 1500, 6000, 'USD'),
('Por Proyecto', 1000, 15000, 'USD'),
('Por Hora', 60, 120, 'USD'),
('Retainer Mensual', 2000, 8000, 'USD'),
('Por Proyecto', 2000, 18000, 'USD'),
('Por Hora', 80, 150, 'USD'),
('Retainer Mensual', 2500, 9000, 'USD');

SELECT * FROM Herramienta;
SELECT * FROM AgenciaCertificacion;
USE agencias_growth_marketing;

-- 1) AgenciaServicio (agencia_id, servicio_id)
INSERT INTO AgenciaServicio VALUES
(1,1),
(1,2),
(2,2),
(2,4),
(3,3),
(4,4),
(5,5),
(6,1),
(7,7),
(8,9);

-- 2) AgenciaIndustria (agencia_id, industria_id)
INSERT INTO AgenciaIndustria VALUES
(1,1),  -- Fintech
(1,5),  -- E-commerce
(2,2),  -- Retail
(3,5),  -- E-commerce
(4,3),  -- Salud
(5,4),  -- Educación
(6,1),  -- Fintech
(7,6),  -- Turismo
(8,8),  -- Tecnología
(9,1);  -- Fintech

-- 3) AgenciaCertificacion (agencia_id, cert_id, fecha_obtencion, fecha_expiracion)
INSERT INTO AgenciaCertificacion VALUES
(1,1,'2022-01-01','2024-01-01'),
(1,2,'2023-01-01','2025-01-01'),
(2,3,'2023-05-01','2025-05-01'),
(3,4,'2022-06-01','2024-06-01'),
(4,5,'2023-02-01','2025-02-01'),
(5,6,'2023-03-01','2025-03-01'),
(6,7,'2022-04-01','2024-04-01'),
(7,8,'2023-06-01','2025-06-01'),
(8,9,'2022-08-01','2024-08-01'),
(9,10,'2023-07-01','2025-07-01');

-- 4) AgenciaHerramienta (agencia_id, herr_id, nivel_uso)
INSERT INTO AgenciaHerramienta VALUES
(1,1,'Avanzado'),   -- Google Ads
(1,3,'Avanzado'),   -- GA4
(2,2,'Medio'),      -- Meta Ads
(3,4,'Básico'),     -- Braze
(4,5,'Avanzado'),   -- CleverTap
(5,8,'Medio'),      -- BigQuery
(6,6,'Medio'),      -- HubSpot
(7,9,'Básico'),     -- TikTok Ads
(8,10,'Medio'),     -- Mailchimp
(9,7,'Avanzado');   -- Salesforce MC

-- 5) AgenciaPlan (agencia_id, plan_id)
INSERT INTO AgenciaPlan VALUES
(1,1),
(1,2),
(2,3),
(3,4),
(4,5),
(5,6),
(6,7),
(7,8),
(8,9),
(9,10);

-- 6) CasoCliente (caso_id, cliente_id)
INSERT INTO CasoCliente VALUES
(1,1),
(2,2),
(3,5),
(4,3),
(5,4),
(6,10),
(7,6),
(8,7),
(9,8),
(10,9);
SELECT * FROM AgenciaCertificacion;

