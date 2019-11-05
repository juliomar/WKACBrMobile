unit Controller.Customer;

interface

uses
  MVCFramework, MVCFramework.Commons;

type

  [MVCPath('/api')]
  TCustomerController = class(TMVCController)
  protected
    procedure OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean); override;
    procedure OnAfterAction(Context: TWebContext; const AActionName: string); override;

  public
    [MVCPath('/')]
    [MVCHTTPMethod([httpGET])]
    procedure Index;

    //Sample CRUD Actions for a "Customer" entity
    [MVCPath('/customers')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomers;

    [MVCPath('/customers/($ACodigo)')]
    [MVCHTTPMethod([httpGET])]
    procedure GetCustomer(ACodigo: Integer);

    [MVCPath('/customers')]
    [MVCHTTPMethod([httpPOST])]
    procedure CreateCustomer;

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpPUT])]
    procedure UpdateCustomer(id: Integer);

    [MVCPath('/customers/($id)')]
    [MVCHTTPMethod([httpDELETE])]
    procedure DeleteCustomer(id: Integer);

  end;

implementation

uses
  System.SysUtils, MVCFramework.Logger, System.StrUtils, Model.Customer;

procedure TCustomerController.Index;
begin
  //use Context property to access to the HTTP request and response
  Render('<h1>API - Customers</h1> <br> Todos os end  points dos meus clientes');
  ContentType := 'text/html';
end;

procedure TCustomerController.OnAfterAction(Context: TWebContext; const AActionName: string);
begin
  { Executed after each action }
  inherited;
end;

procedure TCustomerController.OnBeforeAction(Context: TWebContext; const AActionName: string; var Handled: Boolean);
begin
  { Executed before each action
    if handled is true (or an exception is raised) the actual
    action will not be called }
  inherited;
end;

//Sample CRUD Actions for a "Customer" entity
procedure TCustomerController.GetCustomers;
begin
  Render<TCustomer>( TCustomer.GetAll);
end;

procedure TCustomerController.GetCustomer(ACodigo: Integer);
begin
  Render( TCustomer.GetByID(ACodigo));
end;

procedure TCustomerController.CreateCustomer;
var
  lCustomer : TCustomer;
begin
  lCustomer := Context.Request.BodyAs<TCustomer>;
  try
    if TCustomer.Adicionar(lCustomer) then
      Render(200, 'Cliente Inserido')
    else
      Render(500, 'Internal Server Error');


  finally
    lCustomer.Free;
  end;
end;

procedure TCustomerController.UpdateCustomer(id: Integer);
var
  lCustomer : TCustomer;
begin
  lCustomer := Context.Request.BodyAs<TCustomer>;
  try
    if TCustomer.Atualizar(lCustomer) then
      Render(200, TCustomer.GetByID(id))
    else
      Render(500, 'Internal Server Error');

  finally
    lCustomer.Free;
  end;

end;

procedure TCustomerController.DeleteCustomer(id: Integer);
begin
  if TCustomer.Delete(id) then
    Render(200, 'Registro removido')
  else
    Render(500, 'Internal Server Error');
end;



end.
