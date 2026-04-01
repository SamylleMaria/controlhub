CREATE TABLE IF NOT EXISTS assinaturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    veiculo_id INT NOT NULL,
    plano_id INT NOT NULL,
    status ENUM('PENDENTE', 'ATIVA', 'INATIVA') NOT NULL DEFAULT 'PENDENTE',
    data_ativacao DATE,
    dia_vencimento INT,
    lav_simples_usadas INT NOT NULL DEFAULT 0,
    lav_completas_usadas INT NOT NULL DEFAULT 0,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (veiculo_id) REFERENCES veiculos(id),
    FOREIGN KEY (plano_id) REFERENCES planos(id)
);