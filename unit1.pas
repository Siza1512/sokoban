unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  Menus,mmsystem,unit3, LCLIntf;

type

  { TForm1 }

  TForm1 = class(TForm)
    ImageList1: TImageList;
    ImageList2: TImageList;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ImageList: TImageList;
    Pole: TImage;  // Рабочее поле
    Timer1: TTimer;


    procedure FormCreate(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem12Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure PoleClick(Sender: TObject);
    procedure StartClick(Sender: TObject);
    procedure DrawingLevel(Sender: TObject);
    procedure Displacement(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);


  private
    { private declarations }
  public
    { public declarations }
  end;
type
  mn = set of 4..7;
var
  Form1: TForm1;
  i, j, n, x0, y0, x, y, dx, dy, vid, vid0, b, c, k, kx, ky, tx, ty, kx0, ky0: integer;
  FName,s:string;
  bitmap : TBitmap;
  Field:  array[1..20, 1..30] of Integer;
  Stone:  array[1..20, 1..30] of Integer;
  Place:  array[1..20, 1..30] of Integer;
implementation

const

  Levels: array[1..10,1..20,1..30] of integer=
//
//
//
//
 ((
// № 1
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,2,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,0,2,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,0,0,2,0,0,2,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,0,8,0,8,8,8,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,0,0,0,8,0,8,8,8,0,8,8,8,8,8,8,8,0,0,1,1,8,8,8,8,8),
  (8,8,8,8,8,0,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,8,8,8,8,0,8,4,8,8,8,8,0,0,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ),(
 // № 2
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,0,0,8,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,0,0,8,0,2,0,0,2,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,0,0,8,2,8,8,8,8,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,0,0,0,0,4,0,8,8,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,0,0,8,0,8,0,0,2,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,8,8,2,0,2,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,0,2,0,0,2,0,2,0,2,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,8,0,0,0,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ),(
// № 3
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,4,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,2,8,2,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,2,0,0,2,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,2,0,2,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,2,0,8,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,1,1,1,1,0,0,8,8,0,2,0,0,2,0,0,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,1,1,1,0,0,0,0,2,0,0,2,0,0,0,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,1,1,1,1,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ),(
// № 4
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,0,0,0,8,0,0,2,0,2,0,0,0,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,2,2,2,8,2,0,0,2,0,8,0,0,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,0,2,0,0,0,0,0,2,0,8,0,0,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,2,2,0,8,2,0,2,0,2,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,0,2,0,8,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,0,0,0,8,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,0,0,0,0,2,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,0,2,2,8,2,2,0,4,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,0,0,0,8,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ),(
// № 5
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,8,2,8,8,0,0,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,2,0,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,8,8,8,0,0,0,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,1,1,0,0,8,8,0,2,0,0,2,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,1,1,0,0,0,0,2,0,2,2,0,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,1,1,0,0,8,8,2,0,0,2,0,4,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,2,0,0,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,2,0,2,0,0,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,8,8,0,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ),(
// № 6
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,1,1,0,0,8,8,8,8,4,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,1,1,0,0,8,8,8,0,0,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,1,1,0,0,0,0,0,2,2,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,1,1,0,0,8,0,8,0,2,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,1,1,8,8,8,0,8,0,2,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,0,2,0,8,2,0,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,2,8,0,2,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,0,2,0,0,2,0,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,8,8,0,0,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ),(
// № 7
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,0,8,0,4,8,8,0,2,2,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,0,0,0,2,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,0,2,0,0,8,8,8,0,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,0,8,8,8,8,8,2,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,2,0,0,8,8,8,0,1,1,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,2,0,2,0,2,0,1,1,1,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,0,0,0,8,8,8,1,1,1,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,2,2,0,8,8,8,1,1,1,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ),(
// № 8
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,0,0,0,2,0,0,0,2,0,2,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,2,8,0,2,0,8,0,0,2,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,0,2,0,2,0,0,8,0,0,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,2,8,0,8,0,0,8,8,8,8,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,4,8,2,0,2,0,2,0,0,8,8,0,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,0,0,0,0,2,0,8,2,8,0,0,0,8,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,0,2,0,0,0,0,2,0,2,0,2,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,1,1,1,1,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,1,1,1,1,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,1,1,1,1,1,1,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ),(
// № 9
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,1,1,1,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,1,1,1,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,1,1,1,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,8,8,0,0,1,1,1,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,8,8,0,0,1,1,1,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,0,2,2,2,0,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,0,0,2,0,2,0,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,0,0,8,2,0,2,0,0,0,8,0,0,0,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,4,0,2,0,0,2,0,0,0,0,2,0,0,2,0,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,0,2,2,0,2,0,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,0,2,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ),(
// № 10
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,8,8,8,8,0,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,8,8,8,0,0,0,0,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,4,8,8,8,8,0,0,0,2,2,2,0,8,0,0,0,0,8,8,8,8,8,8),
  (8,8,8,8,8,8,0,2,2,0,0,0,2,2,0,2,0,0,0,8,1,1,1,1,8,8,8,8,8,8),
  (8,8,8,8,8,8,0,0,2,2,2,8,0,0,0,0,2,0,0,8,1,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,0,2,0,0,0,8,0,2,2,0,2,2,0,8,1,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,0,0,8,0,0,2,0,0,0,0,8,1,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,0,0,8,0,2,0,2,0,2,0,8,1,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,8,8,8,8,8,8,8,0,8,8,8,1,1,1,1,1,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,0,0,0,8,0,0,2,0,2,0,0,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,8,0,2,2,0,2,0,2,8,8,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,8,0,0,2,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,8,0,2,2,2,0,2,2,2,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,8,0,0,0,0,0,0,0,8,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,8,8,8,8,8,8,8,8,8,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8),
  (8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8)
 ));

{ TForm1 }

// Заставка с музыкой
procedure TForm1.FormCreate(Sender: TObject);
begin
  PlaySound('menu2.wav', 0, SND_ASYNC );
end;

// Стартовый лабиринт
procedure TForm1.StartClick(Sender: TObject);
begin
  if b=0 then begin n:=1; PoleClick(self); end;
  b:=1;
end;

// Чтение и рисование лабиринта
procedure TForm1.PoleClick(Sender: TObject);
begin
  PlaySound(nil, 0, SND_PURGE);
  Pole.Picture.Clear;
  bitmap := TBitmap.Create;
    for i:=1 to 20 do
      begin
        for j:=1 to 30 do
          begin
            Field [i,j]:= 0;
            Place [i,j]:= 0;
            Stone [i,j]:= 0;
            if (levels [n,i,j]=8) then Field [i,j]:= 8;
            if (levels [n,i,j]=1) then Place [i,j]:= 1;
            if (levels [n,i,j]=2) then Stone [i,j]:= 2;
            case (levels [n,i,j]) of
              4: begin x:=i; y:=j; vid:=4 end;
              5: begin x:=i; y:=j; vid:=5 end;
              6: begin x:=i; y:=j; vid:=6 end;
              7: begin x:=i; y:=j; vid:=7 end;
            end;
              Form1.ImageList.GetBitmap(Field [i,j], bitmap);
              Form1.Pole.Canvas.Draw((j-1) *32, (i-1)*32, bitmap);
          end;
      end ;
  c:=0;
  DrawingLevel(self);
end;

// Заполнение лабиринта
procedure TForm1.DrawingLevel(Sender: TObject);
begin
  for i:=1 to 20 do
    begin
      for j:=1 to 30 do
        begin
           if (Field [i,j] = 0) then
              begin
                Form1.ImageList.GetBitmap(0, bitmap);
                Form1.Pole.Canvas.Draw((j-1) *32, (i-1)*32, bitmap);
              end;
           if (Place [i,j] = 1) then
              begin
                Form1.ImageList.GetBitmap(1, bitmap);
                Form1.Pole.Canvas.Draw((j-1) *32, (i-1)*32, bitmap);
              end;
           if (Stone [i,j] = 2) then
              begin
                Form1.ImageList.GetBitmap(2, bitmap);
                Form1.Pole.Canvas.Draw((j-1) *32, (i-1)*32, bitmap);
              end;
           if (x= i) and (y =j) then
              begin
                Form1.ImageList.GetBitmap(vid, bitmap);
                Form1.Pole.Canvas.Draw((j-1) *32, (i-1)*32, bitmap);
              end;
        end;
    end ;
  Pole.Canvas.Font.Size:=16;
  Pole.Canvas.Font.Style:= Pole.Canvas.Font.Style + [fsBold];
  SetBkMode(Pole.Canvas.Handle, 0);
  SetBkColor(Pole.Canvas.Handle, clBlack);
  SetTextColor(Pole.Canvas.Handle, clBlack);
  Pole.Canvas.TextOut(830, 5, 'Уровень '+IntToStr(n));
end;

// Обработка управляющих клавиш
procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    37: begin dy:=-1; dx:=0; vid:=6; Displacement(self); end;  { влево  }
    39: begin dy:=+1; dx:=0; vid:=7; Displacement(self); end;  { вправо }
    38: begin dy:=0; dx:=-1; vid:=4; Displacement(self); end;  { вверх  }
    40: begin dy:=0; dx:=+1; vid:=5; Displacement(self); end;  { вниз   }
  end;
end;

// Сдвиг трактора и камней и проверка прохождения лабиринта
procedure TForm1.Displacement(Sender: TObject);
begin
  if (stone [x+dx,y+dy]=2) and (stone [x+2*dx,y+2*dy]<>2) and (levels [n,x+2*dx,y+2*dy]<>8) then
    begin
      c:=1;
      kx0:=x+dx; ky0:=y+dy;
      kx:=x+2*dx; ky:=y+2*dy;
      tx:=x; ty:=y; vid0:=vid;
      stone [kx0,ky0]:=0;
      stone [kx,ky]:=2;
      x:=x+dx;
      y:=y+dy;
    end;
  if (levels [n,x+dx,y+dy]<>8)   and (stone [x+dx,y+dy]<>2)  then
    begin
      x:=x+dx;
      y:=y+dy;
    end;
  PlaySound('1.wav', 0, SND_ASYNC );
  DrawingLevel(self);
  k:=1;
  for i:=1 to 20 do
    begin
      for j:=1 to 30 do
        begin
          if (levels [n,i,j]=1) and (Stone [i,j]<>2) then k:=0;
        end;
    end;
  if k=1 then
    begin
      PlaySound('2.wav', 0, SND_ASYNC );
      form1.Timer1.Enabled:=true;
    end;
 end;

// Салют
procedure TForm1.Timer1Timer(Sender: TObject);
begin
  x0:=320; y0:=320; x:=640; y:=320;
  Canvas.Brush.Color := clBlack;
    While x0>0 do
      begin
        x0:=x0-1; y0:=y0-1;
        x:=x+1;   y:=y+1;
        Canvas.Rectangle(x0,y0,x,y);
        sleep(1) ;
      end;
  pole.Canvas.Brush.Color := clBlack;
  pole.Canvas.Rectangle(0,0,960,640);
  j:=0;
        PlaySound('Salut.wav', 0, SND_ASYNC );
        For i:=0 to 38 do
          begin
            Form1.ImageList2.GetBitmap(i, bitmap);
            Form1.Canvas.Draw(0,0, bitmap);
            Form1.Canvas.Draw(600,0, bitmap);
            Form1.Canvas.Draw(300,220, bitmap);
            Form1.ImageList1.GetBitmap(j, bitmap);
            Form1.Canvas.Draw(253,540, bitmap);
            if j<2 then j:=j+1 else j:=0;
            sleep(50);
          end;
        if n<10 then  n:=n+1 else n:=1;
  form1.Timer1.Enabled:=false;
  PoleClick(self);
end;



// Отмена хода
procedure TForm1.MenuItem2Click(Sender: TObject);
begin
  if c=1 then
    begin
      stone [kx0,ky0]:=2;
      stone [kx,ky]:=0;
      x:=tx;
      y:=ty;
      vid:=vid0;
    end;
  DrawingLevel(self);
end;

// Начало уровня
procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  PoleClick(self);
end;

// Следующий уровень
procedure TForm1.MenuItem4Click(Sender: TObject);
begin
  n:=n+1;
  if n>10 then n:=1;
  PoleClick(self);
end;

// Предыдущий уровень
procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  n:=n-1;
  if n<1 then n:=10;
  PoleClick(self);
end;

// Переход на заданный уровень
procedure TForm1.MenuItem6Click(Sender: TObject);
var nomer: string;
    nom: integer;
begin
  repeat
    nomer := InputBox('Sokoban', 'На какой уровень перейти?', '1');
  until nomer <> '';
  nom:=StrToInt(nomer);
  If (nom>0) and (nom<11) then
    begin
      n:=nom;
      PoleClick(self)
    end
                         else
    begin
      Application.Title := 'Sokoban';
      ShowMessage('Такого уровня нет!'+#13#10+'Остаемся здесь');
    end;
end;

// Запись лабиринта в файл
procedure TForm1.MenuItem7Click(Sender: TObject);
var
  f: TextFile;
begin
  if SaveDialog1.Execute then
  begin
    FName:= SaveDialog1.FileName;
    AssignFile(f, UTF8ToSys(FName));
    Rewrite(f);
    Writeln(f,n);
      for i:=1 to 20 do
        begin
          for j:=1 to 30 do
            begin
              Writeln(f, Field [i,j]);
              Writeln(f, Place [i,j]);
              Writeln(f, Stone [i,j]);
            end;
        end ;
    Writeln(f, x);
    Writeln(f, y);
    Writeln(f, vid);
    CloseFile(f);
  end;
end;

// Чтение лабиринта из файла
procedure TForm1.MenuItem8Click(Sender: TObject);
var
  f: TextFile;
begin
  if OpenDialog1.Execute then
    begin
      FName:= OpenDialog1.FileName;
      AssignFile(f, UTF8ToSys(FName));
      Reset(f);
      Readln(f, n);
      for i:=1 to 20 do
        begin
          for j:=1 to 30 do
            begin
              Readln(f, Field [i,j]);
              Form1.ImageList.GetBitmap(Field [i,j], bitmap);
              Form1.Pole.Canvas.Draw((j-1) *32, (i-1)*32, bitmap);
              Readln(f, Place [i,j]);
              Readln(f, Stone [i,j]);
            end;
        end;
      Readln(f, x);
      Readln(f, y);
      Readln(f, vid);
      CloseFile(f);
      DrawingLevel(self);
    end;
end;

// Выход из игры
procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  form1.close;
end;

// Справка
procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  Application.Title := 'Справка';
  showmessage ('     Сокобан (в переводе с японского — «кладовщик») — это классическая головоломка, созданная в Японии, по сложности сопоставимая с кубиком Рубика, шашками и даже шахматами. Автором оригинальной игры является Хироюки Имабаяши, создавший Сокобана в 1980-м году. В 1982 году игра была издана японской компанией Thinking Rabbit («Думающий Кролик»).'+#13#10+'     Правила Сокобана очень просты. На складе, представленном в игре в виде плана, находится кладовщик и ящики. Задача состоит в перемещении ящиков по лабиринту (складу) с целью поставить их на заданные конечные места. При этом ящики можно толкать, но нельзя тянуть. Кроме того, нельзя перемещать более одного ящика зараз. Кладовщик может свободно перемещаться по складу, но не может проходить через ящики и стены. Отсюда можно сделать несколько простых выводов по стратегии игры.'+#13#10+'     •нельзя допускать, чтобы два ящика оказались друг рядом с другом у стены (вы никогда их не вытащите оттуда: тянуть ящики нельзя, толкать два ящика - тоже);'+#13#10+'     •нельзя задвигать ящики в угол;'+#13#10+'     •нельзя сдвигать ящики в квадрат 2x2.'+#13#10+'     Кроме того, может возникнуть ситуация, когда ящиками будет заблокирована определенная область лабиринта. И любая попытка разблокировать эту область, подвинув ящик, приведет к одной из описанных выше ситуаций.');
end;

// Вызов формы "О проекте"
procedure TForm1.MenuItem12Click(Sender: TObject);
begin
  form3.Show;
end;


{$R *.lfm}

end.

