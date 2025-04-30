show tables
create table Estatistica(
TotalCorpos int(4) not null,
TotalFuncionario int(4) not null);
describe estatistica
 
insert int
insert into estatistica(TotalCorpos,TotalFuncionario) values(8,2)

describe estatistica;

select* from estatistica; orpos_conhecidos
alter table funcionario drop column total_Funcionarios;

delimiter //
create trigger tr_insert_corposConhecidos
after insert on corpos_desconhecidos
for each row
 begin 
  update estatistica
    set TotalCorpos = TotalCorpos + 1;
end//
delimiter //
create trigger tr_inserir_corposDesconhecidos
after insert on corpos_desconhecidos
for each row
 begin 
  update estatistica
    set TotalCorpos = TotalCorpos + 1;
end//
