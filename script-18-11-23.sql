-- criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- criar tabela cliente
create table clients(
	idClient int auto_increment primary key,
    Fname varchar(10),
    Minit char(3),
    Lname varchar(20),
    CPF char(11) not null,
    Address varchar(30),
    constraint unique_cpf_client unique (CPF) 
);

alter table clients auto_increment=1;

desc clients;
-- criar tabela produto

-- size = dimensão do produto
create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    classification_kids bool default false,
    category enum('Eletrônico','Vestimenta','Brinquedos','Alimentos', 'Móveis') not null,
    avaliação float default 0,
    size varchar(10)
);

-- para ser continuado no desafio: termine de implementar a tabela e crie a conexão com as tabelas necessárias (NÃO EXECUTADO)
-- além disso, reflita essa modificação no diagrama de esquema relacional
-- criar constraints relacionadas ao pagamento (NÃO EXECUTADO)

create table payments(
	idClient int,
    idPayment int,
    typePayment enum('Boleto','Cartão','Dois cartões'),
    limitAvailable float,
    primary key(idClient, id_payment)
);

-- criar tabela pedido
drop table orders;
create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    orderStatus enum('Cancelado','Confirmado','Em processamento') default 'Em processamento',
    orderDescription varchar(255),
    sendValue float default 10,
    paymentCash boolean default false   
    
);
desc orders;

alter table orders add constraint fk_orders_client foreign key (idOrderClient) references clients(idClient);
	
-- criar tabela estoque
create table productStorage(
	idProdStorage int auto_increment primary key,
    storageLocation varchar(255),
    quantity int default 0
);

-- criar tabela fornecedor
create table supplier(
	idSupplier int auto_increment primary key,
    SocialName varchar(255) not null,
    CNPJ char(15) not null,
    contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);
desc supplier;

-- criar tabela vendedor
create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15),
    CPF char(9),
    location varchar(255),
    contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

drop table productSeller;
create table productSeller(
	idPseller int,
    idPproduct int,
    prodQuantity int default 1,
    primary key (idPSeller, idPproduct)    
);

alter table productSeller add constraint fk_product_seller foreign key (idPseller) references seller(idSeller);
alter table productSeller add constraint fk_product_product foreign key (idPproduct) references product(idProduct);

desc productSeller;

drop table productOrder;
create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poStatus enum('Disponível', 'Sem estoque') default 'Disponível',
    primary key (idPOproduct, idPOorder)        
);

alter table productOrder add constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct);
alter table productOrder add constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);

drop table productSupplier;
create table productSupplier(
	idPsSupplier int,
    idPsProduct int, 
    quantity int not null,
    primary key (idPsSupplier, idPsProduct)   
);

alter table productSupplier add constraint fk_product_supplier_supplier foreign key (idPsSupplier) references supplier(idSupplier);
alter table productSupplier add constraint fk_product_supplier_product foreign key (idPsProduct) references product(idProduct);

desc productSupplier;
show tables;
show databases;
use information_schema;
desc referential_constraints;
select * from referential_constraints;
select * from referential_constraints where constraint_schema = 'ecommerce';