CREATE TABLE IF NOT EXISTS veiculos (
    id INT AUTO_INCREMENT PRIMERY KEY,
    cliente_id INT NOT NULL,
    placa VARCHAR(7) NOT NULL,
    tipo ENUM('CARRO', 'MOTO') NOT NULL,
    foto_credencial VARCHAR(255),
    criado_em DATETIME DEFAULT CURRNT_TIMESTAMP,
    FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);