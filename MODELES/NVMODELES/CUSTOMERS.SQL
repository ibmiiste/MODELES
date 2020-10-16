Set schema = Btodr;

CREATE OR REPLACE TABLE customers (
            customer_number FOR COLUMN custno CHAR(9) NOT NULL CONSTRAINT constraint PRIMARY KEY,
            customer_firstname FOR COLUMN cfname CHAR(15),
            customer_lastname FOR COLUMN clname CHAR(20),
            customer_adresse FOR COLUMN caddr CHAR(30),
            zip_code FOR COLUMN czip CHAR(5),
            customer_phone FOR COLUMN cphone CHAR(10),
            customer_email_address FOR COLUMN cemail CHAR(50),
            customer_date_naissance FOR COLUMN cdob DATE,
            customer_genre FOR COLUMN cgender CHAR(1)
        )
    RCDFMT custsrec;

LABEL ON TABLE customers IS 'MIRUS - UUID reference';

LABEL ON COLUMN customers (
    customer_number IS 'Numéro client',
    customer_firstname IS 'Prénom client',
    customer_lastname IS 'Nom client',
    customer_adresse IS 'Adresse client',
    zip_code IS 'Code postal',
    customer_phone IS 'Téléphone client',
    customer_email_address IS 'email client',
    customer_date_naissance IS 'Naissance client',
    customer_genre IS 'Genre client'
);

LABEL ON COLUMN customers (
    customer_number text IS 'Numéro de client',
    customer_firstname text IS 'Prénom du client',
    customer_lastname text IS 'Nom du client',
    customer_adresse text IS 'Adresse du client',
    zip_code text IS 'Code postal',
    customer_phone text IS 'Téléphone du client',
    customer_email_address text IS 'Adresse email du client',
    customer_date_naissance text IS 'Date de naissance du client',
    customer_genre text IS 'Genre client F=Femme M=Homme'
);


GRANT DELETE,
        INSERT,
        REFERENCES,
        SELECT,
        UPDATE
    ON customers
    TO public;

GRANT ALTER,
        DELETE,
        INDEX,
        INSERT,
        REFERENCES,
        SELECT,
        UPDATE
    ON customers
    TO qpgmr WITH GRANT OPTION;                           