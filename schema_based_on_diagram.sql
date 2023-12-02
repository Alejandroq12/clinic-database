-- Creating table for patients
CREATE TABLE patients (
  id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  date_of_birth DATE
);

-- Creating table for medical histories
CREATE TABLE medical_histories (
  id SERIAL PRIMARY KEY,
  admitted_at TIMESTAMP,
  patient_id INT NOT NULL REFERENCES patients(id),
  status VARCHAR(50)
);

-- Creating table for invoices
CREATE TABLE invoices (
  id SERIAL PRIMARY KEY,
  total_amount DECIMAL(10, 2),
  generated_at TIMESTAMP,
  payed_at TIMESTAMP,
  medical_history_id INT NOT NULL REFERENCES medical_histories(id)
);

-- Creating table for treatments
CREATE TABLE treatments (
  id SERIAL PRIMARY KEY,
  type VARCHAR(50) NOT NULL,
  name VARCHAR(50) NOT NULL
);

-- Creating table for invoice items
CREATE TABLE invoice_items (
  id SERIAL PRIMARY KEY,
  unit_price DECIMAL(6, 2),
  quantity INT,
  total_price DECIMAL(10, 2),
  invoice_id INT NOT NULL REFERENCES invoices(id),
  treatment_id INT NOT NULL REFERENCES treatments(id)
);

-- Creating table for the many-to-many relationship between medical histories and treatments
CREATE TABLE medical_history_treatments (
  medical_history_id INT NOT NULL REFERENCES medical_histories(id),
  treatment_id INT NOT NULL REFERENCES treatments(id),
  PRIMARY KEY (medical_history_id, treatment_id)
);

-- Creating indexes for foreign keys
CREATE INDEX idx_medical_histories_patient_id ON medical_histories(patient_id);
CREATE INDEX idx_invoices_medical_history_id ON invoices(medical_history_id);
CREATE INDEX idx_invoice_items_invoice_id ON invoice_items(invoice_id);
CREATE INDEX idx_invoice_items_treatment_id ON invoice_items(treatment_id);
CREATE INDEX idx_medical_history_treatments_medical_history_id ON medical_history_treatments(medical_history_id);
CREATE INDEX idx_medical_history_treatments_treatment_id ON medical_history_treatments(treatment_id);
