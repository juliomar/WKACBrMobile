unit Model.Customer;

interface

uses
  System.Generics.Collections,
  System.SysUtils;

type
  TCustomer = class
  strict private
    Fstate_province: string;
    FCustomer      : string;
    Fcountry       : string;
    Fcust_no       : integer;
    Fcity          : string;
  public
    class function GetByID(AId: integer): TCustomer;
    class function GetAll: TObjectList<TCustomer>;
    class function Adicionar(ACostumer: TCustomer): Boolean;
    class function Atualizar(ACostumer :  TCustomer) : Boolean;
    class function Delete(AId : integer):Boolean;

    property cust_no: integer read Fcust_no write Fcust_no;
    property Customer: string read FCustomer write FCustomer;
    property city: string read Fcity write Fcity;
    property state_province: string read Fstate_province write Fstate_province;
    property country: string read Fcountry write Fcountry;
  end;

implementation

uses
  udmconexao,
  Data.DB;

{ TCustomer }

class function TCustomer.Adicionar(ACostumer: TCustomer): Boolean;
const
  cSQLInsert = 'INSERT INTO CUSTOMER (CUST_NO, CUSTOMER ) VALUES(%d, %s);';
var
  ldm: Tdmconexao;
begin
  ldm := Tdmconexao.Create(nil);
  try
     Result := ldm.FDConnection1.ExecSQL(
      Format( cSQLInsert,
      [ACostumer.cust_no,QuotedStr( ACostumer.Customer)]) ) > 0;

  finally
    ldm.Free;
  end;

end;

class function TCustomer.Atualizar(ACostumer: TCustomer): Boolean;
const
  cSQLUpdate =
    'UPDATE CUSTOMER SET CUSTOMER=%s WHERE CUST_NO=%d';
var
  ldm: Tdmconexao;
begin
  ldm := Tdmconexao.Create(nil);
  try
     Result := ldm.FDConnection1.ExecSQL(
      Format( cSQLUpdate,
      [QuotedStr( ACostumer.Customer),ACostumer.cust_no]) ) > 0;

  finally
    ldm.Free;
  end;
end;

class function TCustomer.Delete(AId: integer): Boolean;
const
  cSQLDelete =
    'DELETE FROM CUSTOMER WHERE CUST_NO=%d';
var
  ldm: Tdmconexao;
begin
  ldm := Tdmconexao.Create(nil);
  try
     Result := ldm.FDConnection1.ExecSQL(
      Format( cSQLDelete,
      [Aid]) ) > 0;

  finally
    ldm.Free;
  end;
end;

class function TCustomer.GetAll: TObjectList<TCustomer>;
var
  lCustomer     : TCustomer;
  lCustomerLista: TObjectList<TCustomer>;
  ldm           : Tdmconexao;
  lDataset      : TDataSet;
begin

  ldm := Tdmconexao.Create(nil);

  try
    lCustomerLista := TObjectList<TCustomer>.Create;

    ldm.FDConnection1.ExecSQL('SELECT	* FROM CUSTOMER', lDataset);

    lDataset.First;
    while not lDataset.Eof do
    begin
      lCustomer                := TCustomer.Create;
      lCustomer.cust_no        := lDataset.FieldByName('cust_no').AsInteger;
      lCustomer.Customer       := lDataset.FieldByName('Customer').AsString;
      lCustomer.city           := lDataset.FieldByName('city').AsString;
      lCustomer.country        := lDataset.FieldByName('country').AsString;
      lCustomer.state_province := lDataset.FieldByName('state_province').AsString;

      lCustomerLista.Add(lCustomer);

      lDataset.Next;
    end;

    Result := lCustomerLista;
  finally
    ldm.Free;
  end;
end;

class function TCustomer.GetByID(AId: integer): TCustomer;
var
  lCustomer: TCustomer;
  ldm      : Tdmconexao;
  lDataset : TDataSet;
begin
  ldm := Tdmconexao.Create(nil);
  try

    ldm.FDConnection1.ExecSQL(format('SELECT	* FROM CUSTOMER where cust_no = %d ', [AId]), lDataset);

    lCustomer := TCustomer.Create;

    lCustomer.cust_no        := lDataset.FieldByName('cust_no').AsInteger;
    lCustomer.Customer       := lDataset.FieldByName('Customer').AsString;
    lCustomer.city           := lDataset.FieldByName('city').AsString;
    lCustomer.country        := lDataset.FieldByName('country').AsString;
    lCustomer.state_province := lDataset.FieldByName('state_province').AsString;

    Result := lCustomer;
  finally
    ldm.Free;
  end;
end;

end.
