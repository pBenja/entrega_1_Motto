DROP DATABASE IF EXISTS agencias_growth_marketing;
CREATE DATABASE IF NOT EXISTS agencias_growth_marketing;
USE agencias_growth_marketing;
-- 1)
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
-- 2)
CREATE TABLE IF NOT EXISTS Servicio(
    servicio_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(120) NOT NULL,
    descripcion TEXT DEFAULT NULL
);
-- 3)
CREATE TABLE IF NOT EXISTS Industria(
    industria_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(120) NOT NULL
);
-- 4)
CREATE TABLE IF NOT EXISTS Cliente(
    cliente_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    razon_social VARCHAR(200) NOT NULL,
    pais VARCHAR(80) NOT NULL,
    industria_id INT DEFAULT NULL,
    FOREIGN KEY (industria_id) REFERENCES Industria(industria_id)
    );
-- 5)
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
-- 6)
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
-- 7) 
CREATE TABLE IF NOT EXISTS Certificacion(
    cert_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    emisor VARCHAR(150) NOT NULL,
    fecha_vigencia_desde DATE DEFAULT NULL,
    fecha_vigencia_hasta DATE DEFAULT NULL
);
-- 8 )
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
-- 9 )
CREATE TABLE IF NOT EXISTS Herramienta(
    herr_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(150) NOT NULL,
    tipo VARCHAR(80) DEFAULT NULL
);
-- 10) 
CREATE TABLE IF NOT EXISTS PlanPrecio(
    plan_id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    monto_min DECIMAL(18,2) DEFAULT NULL,
    monto_max DECIMAL(18,2) DEFAULT NULL,
    moneda VARCHAR(10) DEFAULT NULL
);
-- 11) 
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
-- 12)
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
-- 13)
CREATE TABLE IF NOT EXISTS AgenciaServicio(
    agencia_id INT NOT NULL,
    servicio_id INT NOT NULL,
    PRIMARY KEY (agencia_id, servicio_id),
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (servicio_id) REFERENCES Servicio(servicio_id)
);
-- 14)
CREATE TABLE IF NOT EXISTS AgenciaIndustria(
    agencia_id INT NOT NULL,
    industria_id INT NOT NULL,
    PRIMARY KEY (agencia_id, industria_id),
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (industria_id) REFERENCES Industria(industria_id)
);
-- 15) 
CREATE TABLE IF NOT EXISTS AgenciaCertificacion(
    agencia_id INT NOT NULL,
    cert_id INT NOT NULL,
    fecha_obtencion DATE DEFAULT NULL,
    fecha_expiracion DATE DEFAULT NULL,
    PRIMARY KEY (agencia_id, cert_id),
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (cert_id) REFERENCES Certificacion(cert_id)
);
-- 16)
CREATE TABLE IF NOT EXISTS AgenciaHerramienta(
    agencia_id INT NOT NULL,
    herr_id INT NOT NULL,
    nivel_uso VARCHAR(30) DEFAULT NULL,
    PRIMARY KEY (agencia_id, herr_id),
    FOREIGN KEY (agencia_id) REFERENCES Agencia(agencia_id),
    FOREIGN KEY (herr_id) REFERENCES Herramienta(herr_id)
);
-- 17 )
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
INSERT INTO Cliente (razon_social, pais, industria_id) VALUES
('Banco Digital X', 'Argentina', (SELECT industria_id FROM Industria WHERE nombre='Fintech')),
('Tienda Online Y', 'Chile', (SELECT industria_id FROM Industria WHERE nombre='E-commerce')),
('Hospital Z', 'Argentina', (SELECT industria_id FROM Industria WHERE nombre='Salud')),
('Universidad W', 'México', (SELECT industria_id FROM Industria WHERE nombre='Educación')),
('Retail Store V', 'Uruguay', (SELECT industria_id FROM Industria WHERE nombre='Retail')),
('Agencia Viajes Q', 'Argentina', (SELECT industria_id FROM Industria WHERE nombre='Turismo')),
('Restaurante Gourmet P', 'Chile', (SELECT industria_id FROM Industria WHERE nombre='Alimentación')),
('Startup Tech R', 'Uruguay', (SELECT industria_id FROM Industria WHERE nombre='Tecnología')),
('Cine Center S', 'México', (SELECT industria_id FROM Industria WHERE nombre='Entretenimiento')),
('Marca de Ropa T', 'Argentina', (SELECT industria_id FROM Industria WHERE nombre='Moda'));

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

/* ===========================================================
   TP SQL - Entrega 2 - Objetos de BD
   Requiere haber corrido la Entrega 1 (tablas + datos) que se encuentra en este mismo archivo
   Base: agencias_growth_marketing
   =========================================================== */

-- Voy a completar el agregado de datos a las tablas que no tenían este agregado en la entrega 1
-- 11. Propuesta
INSERT INTO Propuesta
(agencia_id, cliente_id, fecha_emision, validez_dias, alcance, monto_estimado, moneda, estado)
VALUES
((SELECT agencia_id FROM Agencia WHERE nombre='GrowthLab'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Banco Digital X'),
 '2025-01-05', 30, 'Implementación CRM + Retención', 6000, 'USD', 'Enviada'),

((SELECT agencia_id FROM Agencia WHERE nombre='RocketMedia'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Tienda Online Y'),
 '2025-01-08', 45, 'Paid Media + Analytics', 12000, 'USD', 'En negociación'),

((SELECT agencia_id FROM Agencia WHERE nombre='Boost&Co'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Hospital Z'),
 '2025-01-12', 30, 'Onboarding CEP + Journeys iniciales', 8000, 'USD', 'Enviada'),

((SELECT agencia_id FROM Agencia WHERE nombre='DataGrow'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Universidad W'),
 '2025-01-15', 60, 'Auditoría + Roadmap Growth', 10000, 'USD', 'Revisada'),

((SELECT agencia_id FROM Agencia WHERE nombre='ImpactAds'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Retail Store V'),
 '2025-01-18', 30, 'SEO técnico + Contenido', 7000, 'USD', 'Enviada'),

((SELECT agencia_id FROM Agencia WHERE nombre='ScaleUp'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Agencia Viajes Q'),
 '2025-01-22', 30, 'Dashboards BI + Atribución', 9000, 'USD', 'En negociación'),

((SELECT agencia_id FROM Agencia WHERE nombre='AdBoosters'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Restaurante Gourmet P'),
 '2025-01-25', 45, 'ASO + Push/Email lifecycle', 7500, 'USD', 'Enviada'),

((SELECT agencia_id FROM Agencia WHERE nombre='ClickWise'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Startup Tech R'),
 '2025-01-28', 30, 'Retargeting + Creatividades', 6500, 'USD', 'Revisada'),

((SELECT agencia_id FROM Agencia WHERE nombre='Growthify'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Cine Center S'),
 '2025-02-02', 30, 'Migración CEP + Entrenamiento', 15000, 'USD', 'Enviada'),

((SELECT agencia_id FROM Agencia WHERE nombre='MediaLab'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Marca de Ropa T'),
 '2025-02-05', 45, 'CRO + Experimentos A/B', 11000, 'USD', 'En negociación');

-- =========================================
-- CONTRATO (10 filas)
--  - 5 contratos referenciando propuestas (coinciden por agencia/cliente/fecha_emision)
--  - 5 contratos sin propuesta (retainers abiertos)
-- =========================================
-- 12. Propuesta
-- a) 5 contratos que referencian las primeras 5 propuestas insertadas arriba. (coinciden por agencia/cliente/fecha_emision)
INSERT INTO Contrato
(agencia_id, cliente_id, propuesta_id, fecha_inicio, fecha_fin, monto_total, moneda, condiciones, estado)
VALUES
(
 (SELECT agencia_id FROM Agencia WHERE nombre='GrowthLab'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Banco Digital X'),
 (SELECT propuesta_id FROM Propuesta
   WHERE agencia_id=(SELECT agencia_id FROM Agencia WHERE nombre='GrowthLab')
     AND cliente_id=(SELECT cliente_id FROM Cliente WHERE razon_social='Banco Digital X')
     AND fecha_emision='2025-01-05'),
 '2025-03-01', NULL, 8000, 'USD', 'Contrato dummy (retainer)', 'Activo'
),
(
 (SELECT agencia_id FROM Agencia WHERE nombre='RocketMedia'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Tienda Online Y'),
 (SELECT propuesta_id FROM Propuesta
   WHERE agencia_id=(SELECT agencia_id FROM Agencia WHERE nombre='RocketMedia')
     AND cliente_id=(SELECT cliente_id FROM Cliente WHERE razon_social='Tienda Online Y')
     AND fecha_emision='2025-01-08'),
 '2025-03-05', '2025-09-05', 36000, 'USD', 'Proyecto 6 meses; hitos trimestrales', 'Activo'
),
(
 (SELECT agencia_id FROM Agencia WHERE nombre='Boost&Co'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Hospital Z'),
 (SELECT propuesta_id FROM Propuesta
   WHERE agencia_id=(SELECT agencia_id FROM Agencia WHERE nombre='Boost&Co')
     AND cliente_id=(SELECT cliente_id FROM Cliente WHERE razon_social='Hospital Z')
     AND fecha_emision='2025-01-12'),
 '2025-03-10', NULL, 9000, 'USD', 'Soporte + optimización continua', 'Activo'
),
(
 (SELECT agencia_id FROM Agencia WHERE nombre='DataGrow'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Universidad W'),
 (SELECT propuesta_id FROM Propuesta
   WHERE agencia_id=(SELECT agencia_id FROM Agencia WHERE nombre='DataGrow')
     AND cliente_id=(SELECT cliente_id FROM Cliente WHERE razon_social='Universidad W')
     AND fecha_emision='2025-01-15'),
 '2025-03-15', '2025-06-15', 15000, 'USD', 'Proyecto 3 meses; KPIs acordados', 'Activo'
),
(
 (SELECT agencia_id FROM Agencia WHERE nombre='ImpactAds'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Retail Store V'),
 (SELECT propuesta_id FROM Propuesta
   WHERE agencia_id=(SELECT agencia_id FROM Agencia WHERE nombre='ImpactAds')
     AND cliente_id=(SELECT cliente_id FROM Cliente WHERE razon_social='Retail Store V')
     AND fecha_emision='2025-01-18'),
 '2025-03-20', NULL, 10000, 'USD', 'Retainer con scope mensual', 'Pausado'
);

-- b) 5 contratos sin propuesta (propuesta_id = NULL, (retainers abiertos))
INSERT INTO Contrato
(agencia_id, cliente_id, propuesta_id, fecha_inicio, fecha_fin, monto_total, moneda, condiciones, estado)
VALUES
(
 (SELECT agencia_id FROM Agencia WHERE nombre='ScaleUp'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Agencia Viajes Q'),
 NULL, '2025-01-10', NULL, 7000, 'USD', 'Retainer mensual; SLA 24h', 'Activo'
),
(
 (SELECT agencia_id FROM Agencia WHERE nombre='AdBoosters'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Restaurante Gourmet P'),
 NULL, '2025-01-12', NULL, 7500, 'USD', 'Retainer mensual; backlog acordado', 'Activo'
),
(
 (SELECT agencia_id FROM Agencia WHERE nombre='ClickWise'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Startup Tech R'),
 NULL, '2025-01-14', NULL, 8200, 'USD', 'Retainer mensual; soporte BI', 'Activo'
),
(
 (SELECT agencia_id FROM Agencia WHERE nombre='Growthify'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Cine Center S'),
 NULL, '2025-01-16', NULL, 9000, 'USD', 'Retainer mensual; auditorías', 'Pausado'
),
(
 (SELECT agencia_id FROM Agencia WHERE nombre='MediaLab'),
 (SELECT cliente_id FROM Cliente  WHERE razon_social='Marca de Ropa T'),
 NULL, '2025-01-18', NULL, 9500, 'USD', 'Retainer mensual; experim. CRO', 'Activo'
);

-- Checks rápidos 
SELECT COUNT(*) AS propuestas_cargadas FROM Propuesta;
SELECT COUNT(*) AS contratos_cargados  FROM Contrato;

-- Muestra
SELECT * FROM Propuesta ORDER BY propuesta_id DESC LIMIT 10;
SELECT * FROM Contrato  ORDER BY contrato_id  DESC LIMIT 10;

-- 0) Contexto de ejecución
USE agencias_growth_marketing;

-- Para la correcta re-ejecución del archivo: limpiar objetos en orden seguro
-- (DROP de TRIGGERS antes las tablas a las que apuntan)
DROP TRIGGER IF EXISTS trg_contrato_propuesta_aceptada;
DROP TRIGGER IF EXISTS trg_validar_fechas_caso;

DROP PROCEDURE IF EXISTS sp_buscar_agencias;
DROP PROCEDURE IF EXISTS sp_registrar_contrato;

DROP FUNCTION IF EXISTS fn_cert_vigente;
DROP FUNCTION IF EXISTS fn_dias_contrato_restantes;

DROP VIEW IF EXISTS v_agencia_resumen;
DROP VIEW IF EXISTS v_casos_detalle;
DROP VIEW IF EXISTS v_clientes_industria;
DROP VIEW IF EXISTS v_agencia_capacidades;
DROP VIEW IF EXISTS v_agencia_rango_precios;

/* ===========================================================
   1) VISTAS (5)
   Explicadas con más detalle en la documentación (PDF)
   =========================================================== */

-- 1.1) Resumen por agencia: ficha rápida de KPIs
CREATE VIEW v_agencia_resumen AS
SELECT
    a.agencia_id,
    a.nombre,
    a.pais,
    a.ciudad,
    a.tam_equipo,
    a.anio_fundacion,
    /* contadores */
    (SELECT COUNT(*) FROM AgenciaServicio xs WHERE xs.agencia_id = a.agencia_id)  AS cant_servicios,
    (SELECT COUNT(*) FROM AgenciaIndustria xi WHERE xi.agencia_id = a.agencia_id) AS cant_industrias,
    (SELECT COUNT(*) FROM AgenciaCertificacion xc WHERE xc.agencia_id = a.agencia_id) AS cant_certificaciones,
    (SELECT COUNT(*) FROM MiembroEquipo me WHERE me.agencia_id = a.agencia_id) AS cant_miembros
FROM Agencia a;

-- 1.2) Casos de éxito con detalle y profundidad de métricas
CREATE VIEW v_casos_detalle AS
SELECT
    c.caso_id,
    a.nombre          AS agencia,
    c.titulo,
    c.descripcion,
    c.fecha_inicio,
    c.fecha_fin,
    c.kpi_principal,
    c.kpi_valor,
    c.moneda,
    c.link_soporte,
    (SELECT COUNT(*) FROM ResultadoCaso r WHERE r.caso_id = c.caso_id) AS metricas_cargadas
FROM CasoExito c
JOIN Agencia a ON a.agencia_id = c.agencia_id;

-- 1.3) Clientes con industria legible y cuántos casos asociados
CREATE VIEW v_clientes_industria AS
SELECT
    cl.cliente_id,
    cl.razon_social,
    cl.pais,
    i.nombre   AS industria,
    (SELECT COUNT(*) FROM CasoCliente cc WHERE cc.cliente_id = cl.cliente_id) AS casos_asociados
FROM Cliente cl
LEFT JOIN Industria i ON i.industria_id = cl.industria_id;

-- 1.4) Capacidades: herramienta + nivel por agencia
CREATE VIEW v_agencia_capacidades AS
SELECT
    a.agencia_id,
    a.nombre           AS agencia,
    h.herr_id,
    h.nombre           AS herramienta,
    h.tipo,
    ah.nivel_uso
FROM AgenciaHerramienta ah
JOIN Agencia a    ON a.agencia_id = ah.agencia_id
JOIN Herramienta h ON h.herr_id   = ah.herr_id;

-- 1.5) Rango de precios consolidado por agencia
CREATE VIEW v_agencia_rango_precios AS
SELECT
    a.agencia_id,
    a.nombre AS agencia,
    MIN(pp.monto_min) AS monto_min_agencia,
    MAX(pp.monto_max) AS monto_max_agencia,
    /* si hay múltiples monedas, mostramos alguna (heurística: la más frecuente) */
    (SELECT pp2.moneda
       FROM AgenciaPlan ap2
       JOIN PlanPrecio pp2 ON pp2.plan_id = ap2.plan_id
      WHERE ap2.agencia_id = a.agencia_id
      GROUP BY pp2.moneda
      ORDER BY COUNT(*) DESC
      LIMIT 1) AS moneda_referencia
FROM Agencia a
JOIN AgenciaPlan ap ON ap.agencia_id = a.agencia_id
JOIN PlanPrecio pp ON pp.plan_id     = ap.plan_id
GROUP BY a.agencia_id, a.nombre;





/* ===========================================================
   2) FUNCIONES (2)
   Explicadas con más detalle en la documentación (PDF)
   =========================================================== */

-- 2.1) ¿La agencia tiene X certificación vigente hoy?
DELIMITER $$

CREATE FUNCTION fn_cert_vigente(
    p_agencia_id INT,
    p_cert_nombre VARCHAR(150)
)
RETURNS BOOLEAN
DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN EXISTS (
        SELECT 1
        FROM AgenciaCertificacion ac
        JOIN Certificacion c ON c.cert_id = ac.cert_id
        WHERE ac.agencia_id = p_agencia_id
          AND c.nombre = p_cert_nombre
          AND (ac.fecha_obtencion IS NULL OR ac.fecha_obtencion <= CURRENT_DATE())
          AND (ac.fecha_expiracion IS NULL OR ac.fecha_expiracion >= CURRENT_DATE())
    );
END$$

DELIMITER ;


-- 2.2) Días restantes de un contrato (0 si venció; NULL si no tiene fin)
DELIMITER $$
CREATE FUNCTION fn_dias_contrato_restantes(p_contrato_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_fin DATE;
    SELECT fecha_fin INTO v_fin
      FROM Contrato
     WHERE contrato_id = p_contrato_id;

    IF v_fin IS NULL THEN
        RETURN NULL;
    ELSEIF v_fin < CURDATE() THEN
        RETURN 0;
    ELSE
        RETURN DATEDIFF(v_fin, CURDATE());
    END IF;
END$$
DELIMITER ;





/* ===========================================================
   3) STORED PROCEDURES (2)
   Explicados con más detalle en la documentación (PDF)
   =========================================================== */

-- 3.1) Buscador multifiltro de agencias (parámetros opcionales)
DELIMITER $$
CREATE PROCEDURE sp_buscar_agencias(
    IN p_pais         VARCHAR(80),     -- NULL = sin filtro
    IN p_servicio_id  INT,             -- NULL = sin filtro
    IN p_industria_id INT,             -- NULL = sin filtro
    IN p_min_equipo   INT              -- NULL = sin filtro
)
BEGIN
    /* Armado dinámico para aplicar solo los filtros provistos */
    SET @sql = CONCAT(
        'SELECT a.agencia_id, a.nombre, a.pais, a.ciudad, a.tam_equipo, ',
        ' (SELECT COUNT(*) FROM AgenciaServicio xs WHERE xs.agencia_id = a.agencia_id) AS cant_servicios,',
        ' (SELECT COUNT(*) FROM AgenciaIndustria xi WHERE xi.agencia_id = a.agencia_id) AS cant_industrias',
        ' FROM Agencia a'
    );

    SET @where := ' WHERE 1=1';

    IF p_pais IS NOT NULL THEN
        SET @where := CONCAT(@where, ' AND a.pais = ?');
    END IF;

    IF p_min_equipo IS NOT NULL THEN
        SET @where := CONCAT(@where, ' AND a.tam_equipo >= ?');
    END IF;

    IF p_servicio_id IS NOT NULL THEN
        SET @sql := CONCAT(@sql, ' JOIN AgenciaServicio s ON s.agencia_id = a.agencia_id');
        SET @where := CONCAT(@where, ' AND s.servicio_id = ?');
    END IF;

    IF p_industria_id IS NOT NULL THEN
        SET @sql := CONCAT(@sql, ' JOIN AgenciaIndustria i ON i.agencia_id = a.agencia_id');
        SET @where := CONCAT(@where, ' AND i.industria_id = ?');
    END IF;

    SET @sql := CONCAT(@sql, @where, ' GROUP BY a.agencia_id, a.nombre, a.pais, a.ciudad, a.tam_equipo');

    PREPARE stmt FROM @sql;

    /* Bind dinámico según qué filtros llegaron */
    SET @i := 0;
    SET @p1 := p_pais;
    SET @p2 := p_min_equipo;
    SET @p3 := p_servicio_id;
    SET @p4 := p_industria_id;

    CASE
        WHEN p_pais IS NULL AND p_min_equipo IS NULL AND p_servicio_id IS NULL AND p_industria_id IS NULL THEN
            EXECUTE stmt;
        WHEN p_pais IS NOT NULL AND p_min_equipo IS NULL AND p_servicio_id IS NULL AND p_industria_id IS NULL THEN
            EXECUTE stmt USING @p1;
        WHEN p_pais IS NULL AND p_min_equipo IS NOT NULL AND p_servicio_id IS NULL AND p_industria_id IS NULL THEN
            EXECUTE stmt USING @p2;
        WHEN p_pais IS NULL AND p_min_equipo IS NULL AND p_servicio_id IS NOT NULL AND p_industria_id IS NULL THEN
            EXECUTE stmt USING @p3;
        WHEN p_pais IS NULL AND p_min_equipo IS NULL AND p_servicio_id IS NULL AND p_industria_id IS NOT NULL THEN
            EXECUTE stmt USING @p4;
        WHEN p_pais IS NOT NULL AND p_min_equipo IS NOT NULL AND p_servicio_id IS NULL AND p_industria_id IS NULL THEN
            EXECUTE stmt USING @p1, @p2;
        WHEN p_pais IS NOT NULL AND p_min_equipo IS NULL AND p_servicio_id IS NOT NULL AND p_industria_id IS NULL THEN
            EXECUTE stmt USING @p1, @p3;
        WHEN p_pais IS NOT NULL AND p_min_equipo IS NULL AND p_servicio_id IS NULL AND p_industria_id IS NOT NULL THEN
            EXECUTE stmt USING @p1, @p4;
        WHEN p_pais IS NULL AND p_min_equipo IS NOT NULL AND p_servicio_id IS NOT NULL AND p_industria_id IS NULL THEN
            EXECUTE stmt USING @p2, @p3;
        WHEN p_pais IS NULL AND p_min_equipo IS NOT NULL AND p_servicio_id IS NULL AND p_industria_id IS NOT NULL THEN
            EXECUTE stmt USING @p2, @p4;
        WHEN p_pais IS NULL AND p_min_equipo IS NULL AND p_servicio_id IS NOT NULL AND p_industria_id IS NOT NULL THEN
            EXECUTE stmt USING @p3, @p4;
        WHEN p_pais IS NOT NULL AND p_min_equipo IS NOT NULL AND p_servicio_id IS NOT NULL AND p_industria_id IS NULL THEN
            EXECUTE stmt USING @p1, @p2, @p3;
        WHEN p_pais IS NOT NULL AND p_min_equipo IS NOT NULL AND p_servicio_id IS NULL AND p_industria_id IS NOT NULL THEN
            EXECUTE stmt USING @p1, @p2, @p4;
        WHEN p_pais IS NOT NULL AND p_min_equipo IS NULL AND p_servicio_id IS NOT NULL AND p_industria_id IS NOT NULL THEN
            EXECUTE stmt USING @p1, @p3, @p4;
        WHEN p_pais IS NULL AND p_min_equipo IS NOT NULL AND p_servicio_id IS NOT NULL AND p_industria_id IS NOT NULL THEN
            EXECUTE stmt USING @p2, @p3, @p4;
        ELSE
            EXECUTE stmt USING @p1, @p2, @p3, @p4;
    END CASE;

    DEALLOCATE PREPARE stmt;
END$$
DELIMITER ;

-- 3.2) Registrar contrato (y aceptar propuesta si aplica)
DELIMITER $$
CREATE PROCEDURE sp_registrar_contrato(
    IN p_agencia_id   INT,
    IN p_cliente_id   INT,
    IN p_propuesta_id INT,     -- puede venir NULL
    IN p_fecha_inicio DATE,
    IN p_fecha_fin    DATE,    -- puede ser NULL
    IN p_monto_total  DECIMAL(12,2),
    IN p_moneda       VARCHAR(10),
    IN p_estado       VARCHAR(30)
)
BEGIN
    DECLARE v_nuevo_id INT;

    INSERT INTO Contrato (agencia_id, cliente_id, propuesta_id, fecha_inicio, fecha_fin, monto_total, moneda, condiciones, estado)
    VALUES (p_agencia_id, p_cliente_id, p_propuesta_id, p_fecha_inicio, p_fecha_fin, p_monto_total, p_moneda, NULL, COALESCE(p_estado,'Activo'));

    SET v_nuevo_id = LAST_INSERT_ID();

    IF p_propuesta_id IS NOT NULL THEN
        UPDATE Propuesta
           SET estado = 'Aceptada'
         WHERE propuesta_id = p_propuesta_id;
    END IF;

    SELECT v_nuevo_id AS contrato_id_creado;
END$$
DELIMITER ;



/* ===========================================================
   4) TRIGGERS (2)
   Explicados con más detalle en la documentación (PDF)
   =========================================================== */

-- 4.1) Al crear un contrato, si referencia propuesta, forzar estado 'Aceptada'
DELIMITER $$
CREATE TRIGGER trg_contrato_propuesta_aceptada
AFTER INSERT ON Contrato
FOR EACH ROW
BEGIN
    IF NEW.propuesta_id IS NOT NULL THEN
        UPDATE Propuesta
           SET estado = 'Aceptada'
         WHERE propuesta_id = NEW.propuesta_id;
    END IF;
END$$
DELIMITER ;

-- 4.2) Validar integridad temporal en CasoExito
DELIMITER $$
CREATE TRIGGER trg_validar_fechas_caso
BEFORE INSERT ON CasoExito
FOR EACH ROW
BEGIN
    IF NEW.fecha_fin IS NOT NULL AND NEW.fecha_fin < NEW.fecha_inicio THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'fecha_fin no puede ser menor que fecha_inicio en CasoExito';
    END IF;
END$$
DELIMITER ;



/* ===========================================================
   5) PRUEBAS RÁPIDAS (SELECT/CALL) - para verificar en la correción del trabajo
   =========================================================== */

-- Vistas
SELECT * FROM v_agencia_resumen LIMIT 5;
SELECT * FROM v_casos_detalle  LIMIT 5;
SELECT * FROM v_clientes_industria LIMIT 5;
SELECT * FROM v_agencia_capacidades LIMIT 5;
SELECT * FROM v_agencia_rango_precios LIMIT 5;

-- Funciones
SELECT fn_cert_vigente(1, 'Google Partner')     AS tiene_google_partner;
SELECT fn_dias_contrato_restantes(1)            AS dias_restantes_contrato_1;

-- Stored Procedures
CALL sp_buscar_agencias('Argentina', NULL, NULL, 10);
CALL sp_buscar_agencias(NULL,        1,    NULL, NULL);   -- por servicio
CALL sp_buscar_agencias(NULL,        NULL, 2,    NULL);   -- por industria (id de ejemplo)

-- Registrar contrato (usa propuesta)
CALL sp_registrar_contrato(
    1,                 -- agencia_id
    1,                 -- cliente_id
    1,                 -- propuesta_id (puede ser NULL)
    '2025-01-01',
    NULL,
    5000.00,
    'USD',
    'Activo'
);

-- Trigger de validación: este INSERT debería FALLAR (comentado)
-- INSERT INTO CasoExito(agencia_id, titulo, descripcion, fecha_inicio, fecha_fin, kpi_principal, kpi_valor, moneda, link_soporte)
-- VALUES (1, 'Test Fechas', 'Debe fallar', '2025-02-01', '2025-01-01', 'ROAS', 2.0, 'USD', 'http://test');


