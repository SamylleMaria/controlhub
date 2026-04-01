CREATE TABLE IF NOT EXISTS lavagens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    assinatura_id INT NOT NULL,
    usuario_id INT NOT NULL,
    tipo ENUM('SIMPLES', 'COMPLETA') NOT NULL,
    realizada_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (assinatura_id) REFERENCES usuarios(id)
);