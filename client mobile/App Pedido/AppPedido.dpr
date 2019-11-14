program AppPedido;

uses
  System.StartUpCopy,
  FMX.Forms,
  {$IFDEF ANDROID}
    Androidapi.Helpers,
    Androidapi.JNI.JavaTypes,
    Androidapi.JNI.Os,
  {$ENDIF}
  UPrincipal in 'UPrincipal.pas' {Form1},
  UConfigClass in 'UConfigClass.pas',
  UFrameConfiguracao in 'UFrameConfiguracao.pas' {FrameConfiguracao: TFrame},
  UFrameAtualizar in 'UFrameAtualizar.pas' {FrameAtualizar: TFrame},
  DPrincipal in 'DPrincipal.pas' {DtmPrincipal: TDataModule},
  UFramePedido in 'UFramePedido.pas' {FramePedido: TFrame},
  UNFCeClass in '..\..\comum\UNFCeClass.pas',
  FMX.Consts in 'FMX.Consts.pas';

{$R *.res}
var
    FPermissionCamera : string;
    FRead_Storage     : string;
    FWrite_Storage    : string;
    FStateWifi        : string;
    FStateNetwork     : string;

begin

  {$IFDEF ANDROID}
    FPermissionCamera := JStringToString(TJManifest_permission.JavaClass.CAMERA);
    FRead_Storage     := JStringToString(TJManifest_permission.JavaClass.READ_EXTERNAL_STORAGE);
    FWrite_Storage    := JStringToString(TJManifest_permission.JavaClass.WRITE_EXTERNAL_STORAGE);
    FStateWifi        := JStringToString(TJManifest_permission.JavaClass.ACCESS_WIFI_STATE);
    FStateNetwork     := JStringToString(TJManifest_permission.JavaClass.ACCESS_NETWORK_STATE);

    PermissionsService.RequestPermissions([
      FPermissionCamera,
      FRead_Storage,
      FWrite_Storage,
      FStateWifi,
      FStateNetwork
      ], nil, nil);
  {$ENDIF}
  
  Application.Initialize;
  Application.FormFactor.Orientations := [TFormOrientation.Portrait];
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDtmPrincipal, DtmPrincipal);
  Application.Run;
end.
