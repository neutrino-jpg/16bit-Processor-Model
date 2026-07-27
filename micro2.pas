unit micro2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.ActnMan, Vcl.ActnColorMaps, Math, StrUtils;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    StringGrid5: TStringGrid;
    StringGrid6: TStringGrid;
    Label33: TLabel;
    Button8: TButton;
    Button9: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    SREG: TStringGrid;
    Edit6: TEdit;
    CMK_Work: TEdit;
    MUAD_Work: TEdit;
    STP_Work: TEdit;
    ERROR_Work: TEdit;
    RACT_Work: TEdit;
    ARAM_Work: TEdit;
    RGW_Work: TEdit;
    RGR_Work: TEdit;
    RGQ_Work: TEdit;
    Label34: TLabel;
    Label35: TLabel;
    RFI_work: TEdit;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    StringGrid1: TStringGrid;
    TabSheet4: TTabSheet;
    Label31: TLabel;
    Label32: TLabel;
    RAMGridByte: TStringGrid;
    HEXGrid: TStringGrid;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    RAMAddr: TEdit;
    Bytes: TRadioButton;
    Words: TRadioButton;
    RAMGridWord: TStringGrid;
    TabSheet5: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    LabelCS: TLabel;
    DSl: TLabel;
    SSl: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    AX: TEdit;
    BX: TEdit;
    CX: TEdit;
    DX: TEdit;
    SP: TEdit;
    BP: TEdit;
    SI: TEdit;
    DI: TEdit;
    CS: TEdit;
    SS: TEdit;
    DS: TEdit;
    ES: TEdit;
    IP: TEdit;
    PSW: TEdit;
    RGK: TEdit;
    RW: TEdit;
    RFI: TEdit;
    RFD: TEdit;
    RGQ: TEdit;
    ARAM: TEdit;
    RGW: TEdit;
    RGR: TEdit;
    CMK: TEdit;
    MUAD: TEdit;
    STP: TEdit;
    ERROR: TEdit;
    RACT: TEdit;
    Regim: TComboBox;
    RegLoadButton: TButton;
    RegSaveButton: TButton;
    RegOKButton: TButton;
    RegCancelButton: TButton;
    procedure FormCreate(Sender: TObject);
    procedure EditKeyPress(Sender: TObject; var Key: Char);
    procedure EditExit(Sender: TObject);
    procedure RegOKButtonClick(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure BytesClick(Sender: TObject);
    procedure WordsClick(Sender: TObject);
    procedure RAMGridByteSetEditText(Sender: TObject; ACol, ARow: LongInt;
      const Value: string);
    procedure RAMGridWordSetEditText(Sender: TObject; ACol, ARow: LongInt;
      const Value: string);
    procedure Button5Click(Sender: TObject);


  private
    { Private declarations }
    AX_var, BX_var, CX_var, DX_var, SP_var, BP_var, SI_var, DI_var,
    CS_var, DS_var, SS_var, ES_var, IP_var, PSW_var, RGK_var, RW_var,
    RFI_var, RFD_var, RGQ_var, ARAM_var, RGW_var, RGR_var,
    CMK_var, MUAD_var, STP_var, ERROR_var, RACT_var,
    RGA_var, RGB_var, R_var, S_var, ALU_var, SDA_var, C0_var, N: integer;
    MicroStack: array[0..7] of Integer;
    StackPointer: Integer;
    FlagN, FlagZ, FlagV, FlagC, FlagP, FlagM, b_mode, w_mode: Boolean;
    StopWork: Boolean;

    AX_ptr1, AX_ptr2, BX_ptr1, BX_ptr2, CX_ptr1, CX_ptr2, DX_ptr1, DX_ptr2,
    SP_ptr1, SP_ptr2, BP_ptr1, BP_ptr2, SI_ptr1, SI_ptr2, DI_ptr1, DI_ptr2,
    CS_ptr1, CS_ptr2, DS_ptr1, DS_ptr2, SS_ptr1, SS_ptr2, ES_ptr1, ES_ptr2,
    IP_ptr1, IP_ptr2, PSW_ptr1, PSW_ptr2, RGK_ptr1, RGK_ptr2, RW_ptr1, RW_ptr2,
    RFI_ptr1, RFI_ptr2, RFD_ptr1, RFD_ptr2, RGQ_ptr1, RGQ_ptr2, ARAM_ptr1, ARAM_ptr2,
    RGW_ptr1, RGW_ptr2, RGR_ptr1, RGR_ptr2, CMK_ptr1, CMK_ptr2, MUAD_ptr1, MUAD_ptr2,
    STP_ptr1, STP_ptr2, ERROR_ptr1, ERROR_ptr2, RACT_ptr1, RACT_ptr2,
    RGA_ptr1, RGA_ptr2, RGB_ptr1, RGB_ptr2, ALU_ptr1, ALU_ptr2, SDA_ptr1, SDA_ptr2: ^integer;

    function FormatHexValue(const Value: string): string;
    function HexToInt(const HexStr: string): Integer;
    procedure CalculateFlags(ALUResult: Integer; Operation: Integer; OperandR, OperandS: Integer);
    procedure UpdateFlagsDisplay;
    function ApplyShift(Value: Integer; ShiftOp: Integer; ShiftCount: Integer): Integer;
    procedure ProcessMultiplicationFlags(OperandR, OperandS: Integer);
    procedure UpdateWorkRegistersDisplay;
    function ReadByte(Address: Integer): Integer;
    function ReadWord(Address: Integer): Integer;
    procedure WriteByte(Address, Value: Integer);
    procedure WriteWord(Address, Value: Integer);
    function CheckCondition(CC_Code: Integer; UseRFD: Boolean): Boolean;
    procedure ProcessCHA(CHA_Code: Integer; Condition: Boolean; ConstValue: string; var NextAddress: Integer);
   // procedure DrawGridCell(Grid: TStringGrid; ACol, ARow: Integer; Color: TColor);
   procedure SyncRAMb;   //байты в слова
   procedure SyncRAMw;   //слова в байты
  public
    { Public declarations }

  end;

var
  Form1: TForm1;
  i,j,k: integer;


implementation

{$R *.dfm}

function TForm1.HexToInt(const HexStr: string): Integer;
var
  CleanStr: string;
  i: Integer;
begin
  Result := 0;
  if Trim(HexStr) = '' then
    Exit;

  CleanStr := '';

  for i := 1 to Length(HexStr) do
    if HexStr[i] in ['0'..'9', 'A'..'F', 'a'..'f'] then
      CleanStr := CleanStr + HexStr[i];

  if CleanStr = '' then
    Exit;

  try
    Result := StrToInt('$' + CleanStr);
  except
    on E: EConvertError do
      Result := 0; // Возвращаем 0 при ошибке преобразования
  end;
end;

function TForm1.FormatHexValue(const Value: string): string;
var
  CleanValue: string;
  i: Integer;
begin
  CleanValue := '';
  for i := 1 to Length(Value) do
    if Value[i] in ['0'..'9', 'A'..'F'] then
      CleanValue := CleanValue + Value[i];
  while Length(CleanValue) < 4 do
    CleanValue := '0' + CleanValue;
  if Length(CleanValue) > 4 then
    CleanValue := Copy(CleanValue, 1, 4);
  Result := CleanValue;
end;
procedure TForm1.ProcessCHA(CHA_Code: Integer; Condition: Boolean; ConstValue: string; var NextAddress: Integer);
var
  ConstAddr: Integer;
begin
  ConstAddr := HexToInt(ConstValue);

  case CHA_Code of
    0: begin // JS - переход на адрес 0, очистка стека
         NextAddress := 0;
         StackPointer := 0;
       end;
    1: begin // CJS - условный переход к подпрограмме
         if Condition then
         begin
           if StackPointer < 7 then
           begin
             MicroStack[StackPointer] := CMK_var + 1;
             Inc(StackPointer);
           end;
           NextAddress := ConstAddr;
         end
         else
           NextAddress := CMK_var + 1;
       end;
    2: begin // JMAP - переход по адресу из PA
         NextAddress := ConstAddr;
       end;
    3: begin // CJP - условный переход
         if Condition then
           NextAddress := ConstAddr
         else
           NextAddress := CMK_var + 1;
       end;
    4: begin // RPCT - повторение цикла
         if RACT_var <> 0 then
         begin
           Dec(RACT_var);
           NextAddress := ConstAddr;
         end
         else
           NextAddress := CMK_var + 1;
         StackPointer := 0;
       end;
    5: begin // CRTN - условный возврат из подпрограммы
         if Condition then
         begin
           if StackPointer > 0 then
           begin
             Dec(StackPointer);
             NextAddress := MicroStack[StackPointer];
           end
           else
             NextAddress := CMK_var + 1;
         end
         else
           NextAddress := CMK_var + 1;
       end;
    6: begin // LDCT - загрузка счетчика
         RACT_var := ConstAddr;
         NextAddress := CMK_var + 1;
         StackPointer := 0;
       end;
    7: begin // CONT - продолжение
         NextAddress := CMK_var + 1;
       end;
    else // 8-F - резерв
      NextAddress := CMK_var + 1;
  end;

  STP_var := StackPointer;
  STP.Text := IntToHex(STP_var, 4);
  RACT.Text := IntToHex(RACT_var, 4);
end;
procedure TForm1.CalculateFlags(ALUResult: Integer; Operation: Integer; OperandR, OperandS: Integer);
var
  Result16: Word;
  Parity, i: Integer;
  SignedR, SignedS, SignedResult: Integer;
begin
  Result16 := ALUResult and $FFFF;

  FlagN := (Result16 and $8000) <> 0;

  FlagZ := (Result16 = 0);

  Parity := 0;
  for i := 0 to 7 do
    if (Result16 and (1 shl i)) <> 0 then
      Inc(Parity);
  FlagP := (Parity mod 2) = 0;

  FlagV := False;
  SignedR := OperandR and $FFFF;
  if SignedR > 32767 then SignedR := SignedR - 65536;

  SignedS := OperandS and $FFFF;
  if SignedS > 32767 then SignedS := SignedS - 65536;

  SignedResult := Result16;
  if SignedResult > 32767 then SignedResult := SignedResult - 65536;

  case Operation of
    1: begin
         if ((SignedS < 0) and (SignedR > 0) and (SignedResult > 0)) or
            ((SignedS > 0) and (SignedR < 0) and (SignedResult < 0)) then
           FlagV := True;
       end;
    2: begin
         if ((SignedR < 0) and (SignedS > 0) and (SignedResult > 0)) or
            ((SignedR > 0) and (SignedS < 0) and (SignedResult < 0)) then
           FlagV := True;
       end;
    3: begin
         if ((SignedR > 0) and (SignedS > 0) and (SignedResult < 0)) or
            ((SignedR < 0) and (SignedS < 0) and (SignedResult > 0)) then
           FlagV := True;
       end;
    4,5: begin
          if ((SignedS > 0) and (SignedResult < 0)) or
             ((SignedS < 0) and (SignedResult > 0)) then
            FlagV := True;
        end;
    6,7: begin
          if ((SignedR > 0) and (SignedResult < 0)) or
             ((SignedR < 0) and (SignedResult > 0)) then
            FlagV := True;
        end;
  end;

FlagC := (ALUResult and $10000) <> 0;

  if Operation = 8 then
    ProcessMultiplicationFlags(OperandR, OperandS)
  else
    FlagM := False;

  UpdateFlagsDisplay;
end;

procedure TForm1.ProcessMultiplicationFlags(OperandR, OperandS: Integer);
begin
  FlagM := ((OperandS and $0003) = $0003) or
           (((OperandS and $0003) = $0002) and FlagM);
end;

procedure TForm1.UpdateFlagsDisplay;
begin
  SREG.Cells[0,1] := IntToStr(Ord(FlagN));
  SREG.Cells[1,1] := IntToStr(Ord(FlagZ));
  SREG.Cells[2,1] := IntToStr(Ord(FlagV));
  SREG.Cells[3,1] := IntToStr(Ord(FlagC));
  SREG.Cells[4,1] := IntToStr(Ord(FlagP));
  SREG.Cells[5,1] := IntToStr(Ord(FlagM));
end;

procedure TForm1.UpdateWorkRegistersDisplay;
begin
  CMK_Work.Text := 'CMK     '+IntToHex(CMK_ptr1^,4);
  MUAD_Work.Text := 'MUAD    '+IntToHex(MUAD_ptr1^,4);
  STP_Work.Text := 'STP     '+IntToHex(STP_ptr1^,4);
  ERROR_Work.Text := 'ERROR   '+IntToHex(ERROR_ptr1^,4);
  RACT_Work.Text := 'RACT    '+IntToHex(RACT_ptr1^,4);
  ARAM_Work.Text := IntToHex(ARAM_ptr1^,4);
  RGW_Work.Text := IntToHex(RGW_ptr1^,4);
  RGR_Work.Text := IntToHex(RGR_ptr1^,4);
  RGQ_Work.Text := IntToHex(RGQ_ptr1^,4);
  RFI_work.Text := IntToHex(RFI_var, 2);
end;

//ОПЕРАТИВНАЯ ЕБЛЯ

procedure TForm1.SyncRAMb;    //RAM: БАЙТЫ В СЛОВА
var
  i, j: Integer;
begin
  for j := 1 to 64 do
  begin
  k:=1;
    for i := 1 to 9 do
      while k < 16 do
        begin
          RAMGridWord.Cells[i,j]:=RAMGridByte.Cells[k+1,j]+RAMGridByte.Cells[k,j];
          k:=k+2;
          break
        end;
  end;
end;

procedure TForm1.SyncRAMw;    //RAM: СЛОВА В БАЙТЫ
var
  i, j: Integer;
begin
  for j := 1 to 64 do
  begin
  k:=1;
    for i := 1 to 9 do
      while k < 16 do
        begin
          RAMGridByte.Cells[k,j] := RightStr(RAMGridWord.Cells[i,j], 2);
          RAMGridByte.Cells[k+1,j] := LeftStr(RAMGridWord.Cells[i,j], 2);
          k:=k+2;
          break
        end;
  end;
end;

procedure TForm1.RAMGridByteSetEditText(Sender: TObject; ACol, ARow: LongInt;
  const Value: string); // При изменении байтов: bytes => words
begin
  SyncRAMb;
end;


procedure TForm1.RAMGridWordSetEditText(Sender: TObject; ACol, ARow: LongInt;
  const Value: string);   // При изменении слов: words => bytes
begin
  SyncRAMw
end;

//чтение из ОП

function TForm1.ReadByte(Address: Integer): Integer;
var
  row, col: Integer;
begin
  row := (Address div 16) + 1;
  col := (Address mod 16) + 1;
  if (row >= 1) and (row <= 64) and (col >= 1) and (col <= 16) then
    Result := HexToInt(RAMGridByte.Cells[col, row])
  else
    Result := 0;
end;

function TForm1.ReadWord(Address: Integer): Integer;
var
  lowByte, highByte: Integer;
begin
  lowByte := ReadByte(Address);
  highByte := ReadByte(Address + 1);
  Result := (highByte shl 8) or lowByte;
end;


procedure TForm1.WriteByte(Address, Value: Integer);
var
  row, col: Integer;
begin
  row := (Address div 16) + 1;
  col := (Address mod 16) + 1;
  if (row >= 1) and (row <= 64) and (col >= 1) and (col <= 16) then
    RAMGridByte.Cells[col, row] := IntToHex(Value and $FF, 2);
end;

procedure TForm1.WriteWord(Address, Value: Integer);
begin
  WriteByte(Address, Value and $FF);
  WriteByte(Address + 1, (Value shr 8) and $FF);
end;

function TForm1.CheckCondition(CC_Code: Integer; UseRFD: Boolean): Boolean;
var
  N_flag, Z_flag, V_flag, C_flag, P_flag: Boolean;
begin
  if UseRFD then
  begin
    N_flag := (RFD_var and $80) <> 0;
    Z_flag := (RFD_var and $40) <> 0;
    V_flag := (RFD_var and $20) <> 0;
    C_flag := (RFD_var and $10) <> 0;
    P_flag := (RFD_var and $08) <> 0;
  end
  else
  begin
    N_flag := FlagN;
    Z_flag := FlagZ;
    V_flag := FlagV;
    C_flag := FlagC;
    P_flag := FlagP;
  end;

  case CC_Code of
    0: Result := P_flag;
    1: Result := Z_flag;
    2: Result := N_flag;
    3: Result := V_flag;
    4: Result := C_flag;
    5: Result := N_flag xor V_flag;
    6: Result := Z_flag or (N_flag xor V_flag);
    7: Result := C_flag or Z_flag;
  else
    Result := False;
  end;
end;

function TForm1.ApplyShift(Value: Integer; ShiftOp: Integer; ShiftCount: Integer): Integer;
var
  i: Integer;
  DoubleWord: Integer;
begin
  Result := Value;
  ShiftCount := ShiftCount and $F;

  case ShiftOp of
    0: ; // без сдвига
    1: begin // Арифметический сдвиг АЛУ вправо
         for i := 1 to ShiftCount do
         begin
           if (Result and $8000) <> 0 then
             Result := (Result shr 1) or $8000
           else
             Result := Result shr 1;
         end;
       end;
    2: begin // Логический сдвиг АЛУ вправо
         Result := Result shr ShiftCount;
       end;
    3: begin // Арифметический сдвиг АЛУ, RGQ вправо
         DoubleWord := (RGQ_var shl 16) or (Result and $FFFF);
         for i := 1 to ShiftCount do
         begin
           if (DoubleWord and $80000000) <> 0 then
             DoubleWord := (DoubleWord shr 1) or $80000000
           else
             DoubleWord := DoubleWord shr 1;
         end;
         RGQ_var := (DoubleWord shr 16) and $FFFF;
         Result := DoubleWord and $FFFF;
       end;
    4: begin // Логический сдвиг АЛУ, RGQ вправо
         DoubleWord := (RGQ_var shl 16) or (Result and $FFFF);
         DoubleWord := DoubleWord shr ShiftCount;
         RGQ_var := (DoubleWord shr 16) and $FFFF;
         Result := DoubleWord and $FFFF;
       end;
    5: begin // Логический сдвиг RGQ вправо
         RGQ_var := RGQ_var shr ShiftCount;
       end;
    6: begin // RGQ <- ALU
         RGQ_var := Result;
       end;
    8: begin // Логический сдвиг АЛУ влево
         Result := (Result shl ShiftCount) and $FFFF;
       end;
    $A: begin // Логический сдвиг АЛУ, RGQ влево
         DoubleWord := (RGQ_var shl 16) or (Result and $FFFF);
         DoubleWord := DoubleWord shl ShiftCount;
         RGQ_var := (DoubleWord shr 16) and $FFFF;
         Result := DoubleWord and $FFFF;
       end;
    $E: begin // расширение знака
          if (Value and $80) <> 0 then
            Result := Value or $FF00
          else
            Result := Value and $00FF;
        end;
  end;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
  Edits: array[0..26] of TEdit;
begin
  StackPointer := 0;
for i := 0 to 7 do
  MicroStack[i] := 0;
  AX_var := 0; BX_var := 0; CX_var := 0; DX_var := 0;
  SP_var := 0; BP_var := 0; SI_var := 0; DI_var := 0;
  CS_var := 0; DS_var := 0; SS_var := 0; ES_var := 0;
  IP_var := 0; PSW_var := 0; RGK_var := 0; RW_var := 0;
  RFI_var := 0; RFD_var := 0; RGQ_var := 0;
  ARAM_var := 0; RGW_var := 0; RGR_var := 0;
  CMK_var := 0; MUAD_var := 0; STP_var := 0;
  ERROR_var := 0; RACT_var := 0;
  RGA_var := 0; RGB_var := 0; ALU_var := 0; SDA_var := 0; R_var := 0; S_var := 0;

  FlagN := False; FlagZ := False; FlagV := False;
  FlagC := False; FlagP := False; FlagM := False;
  StopWork := False;

  b_mode:=False; w_mode:=False;

  RAMGridByte.Visible := True;
  HEXGrid.Visible := True;
  RAMGridWord.Visible := False;

  AX_ptr1 := @AX_var; AX_ptr2 := @AX_var;
  BX_ptr1 := @BX_var; BX_ptr2 := @BX_var;
  CX_ptr1 := @CX_var; CX_ptr2 := @CX_var;
  DX_ptr1 := @DX_var; DX_ptr2 := @DX_var;
  SP_ptr1 := @SP_var; SP_ptr2 := @SP_var;
  BP_ptr1 := @BP_var; BP_ptr2 := @BP_var;
  SI_ptr1 := @SI_var; SI_ptr2 := @SI_var;
  DI_ptr1 := @DI_var; DI_ptr2 := @DI_var;
  CS_ptr1 := @CS_var; CS_ptr2 := @CS_var;
  DS_ptr1 := @DS_var; DS_ptr2 := @DS_var;
  SS_ptr1 := @SS_var; SS_ptr2 := @SS_var;
  ES_ptr1 := @ES_var; ES_ptr2 := @ES_var;
  IP_ptr1 := @IP_var; IP_ptr2 := @IP_var;
  PSW_ptr1 := @PSW_var; PSW_ptr2 := @PSW_var;
  RGK_ptr1 := @RGK_var; RGK_ptr2 := @RGK_var;
  RW_ptr1 := @RW_var; RW_ptr2 := @RW_var;
  RFI_ptr1 := @RFI_var; RFI_ptr2 := @RFI_var;
  RFD_ptr1 := @RFD_var; RFD_ptr2 := @RFD_var;
  RGQ_ptr1 := @RGQ_var; RGQ_ptr2 := @RGQ_var;
  ARAM_ptr1 := @ARAM_var; ARAM_ptr2 := @ARAM_var;
  RGW_ptr1 := @RGW_var; RGW_ptr2 := @RGW_var;
  RGR_ptr1 := @RGR_var; RGR_ptr2 := @RGR_var;
  CMK_ptr1 := @CMK_var; CMK_ptr2 := @CMK_var;
  MUAD_ptr1 := @MUAD_var; MUAD_ptr2 := @MUAD_var;
  STP_ptr1 := @STP_var; STP_ptr2 := @STP_var;
  ERROR_ptr1 := @ERROR_var; ERROR_ptr2 := @ERROR_var;
  RACT_ptr1 := @RACT_var; RACT_ptr2 := @RACT_var;
  RGA_ptr1 := @RGA_var; RGA_ptr2 := @RGA_var;
  RGB_ptr1 := @RGB_var; RGB_ptr2 := @RGB_var;
  ALU_ptr1 := @ALU_var; ALU_ptr2 := @ALU_var;
  SDA_ptr1 := @SDA_var; SDA_ptr2 := @SDA_var;

  Edits[0] := AX; Edits[1] := BX; Edits[2] := CX; Edits[3] := DX;
  Edits[4] := SP; Edits[5] := BP; Edits[6] := SI; Edits[7] := DI;
  Edits[8] := CS; Edits[9] := DS; Edits[10] := SS; Edits[11] := ES;
  Edits[12] := IP; Edits[13] := PSW; Edits[14] := RGK; Edits[15] := RW;
  Edits[16] := RFI; Edits[17] := RFD; Edits[18] := ARAM; Edits[19] := RGW;
  Edits[20] := RGR; Edits[21] := CMK; Edits[22] := MUAD; Edits[23] := STP;
  Edits[24] := ERROR; Edits[25] := RACT; Edits[26] := RGQ;

  for i := 0 to High(Edits) do
  begin
    case i of
      0: Edits[i].Text := IntToHex(AX_var,4);
      1: Edits[i].Text := IntToHex(BX_var,4);
      2: Edits[i].Text := IntToHex(CX_var,4);
      3: Edits[i].Text := IntToHex(DX_var,4);
      4: Edits[i].Text := IntToHex(SP_var,4);
      5: Edits[i].Text := IntToHex(BP_var,4);
      6: Edits[i].Text := IntToHex(SI_var,4);
      7: Edits[i].Text := IntToHex(DI_var,4);
      8: Edits[i].Text := IntToHex(CS_var,4);
      9: Edits[i].Text := IntToHex(DS_var,4);
      10: Edits[i].Text := IntToHex(SS_var,4);
      11: Edits[i].Text := IntToHex(ES_var,4);
      12: Edits[i].Text := IntToHex(IP_var,4);
      13: Edits[i].Text := IntToHex(PSW_var,4);
      14: Edits[i].Text := IntToHex(RGK_var,4);
      15: Edits[i].Text := IntToHex(RW_var,4);
      16: Edits[i].Text := IntToHex(RFI_var,2);
      17: Edits[i].Text := IntToHex(RFD_var,2);
      18: Edits[i].Text := IntToHex(ARAM_var,4);
      19: Edits[i].Text := IntToHex(RGW_var,4);
      20: Edits[i].Text := IntToHex(RGR_var,4);
      21: Edits[i].Text := IntToHex(CMK_var,4);
      22: Edits[i].Text := IntToHex(MUAD_var,4);
      23: Edits[i].Text := IntToHex(STP_var,4);
      24: Edits[i].Text := IntToHex(ERROR_var,4);
      25: Edits[i].Text := IntToHex(RACT_var,4);
      26: Edits[i].Text := IntToHex(RGQ_var,4);
    end;
    Edits[i].OnKeyPress := EditKeyPress;
    Edits[i].OnExit := EditExit;
  end;


  for j := 1 to 64 do
    StringGrid1.Cells[0,j] := IntToHex(j-1,2);

  StringGrid1.Cells[0,0] := 'Адрес';
  StringGrid1.Cells[1,0] := 'A';
  StringGrid1.Cells[2,0] := 'B';
  StringGrid1.Cells[3,0] := 'MA';
  StringGrid1.Cells[4,0] := 'MB';
  StringGrid1.Cells[5,0] := 'MEM';
  StringGrid1.Cells[6,0] := 'SRC';
  StringGrid1.Cells[7,0] := 'SH';
  StringGrid1.Cells[8,0] := 'N';
  StringGrid1.Cells[9,0] := 'ALU';
  StringGrid1.Cells[10,0] := 'CCX';
  StringGrid1.Cells[11,0] := 'F';
  StringGrid1.Cells[12,0] := 'DST';
  StringGrid1.Cells[13,0] := 'WM';
  StringGrid1.Cells[14,0] := 'JFI';
  StringGrid1.Cells[15,0] := 'CC';
  StringGrid1.Cells[16,0] := 'CHA';
  StringGrid1.Cells[17,0] := 'CONST';

  for i := 1 to 17 do                      //заполенине сетки МП
    for j := 1 to 64 do
    begin
      if (i <> 6) and (i <> 9) and (i <> 16) and (i <> 17) then
        StringGrid1.Cells[i,j] := '0'
      else if i = 6 then
        StringGrid1.Cells[i,j] := '1'
      else if i = 9 then
        StringGrid1.Cells[i,j] := '6'
      else if i = 16 then
        StringGrid1.Cells[i,j] := '7'
      else if i = 17 then
        StringGrid1.Cells[i,j] := '0000';
    end;

  RAMGridByte.Cells[0,0] := 'Ад';                   //Заполнение сеток ОП
  HEXGrid.Cells[0,0] := '0';
  RAMGridWord.Cells[0,0] := 'Адр';

  for i := 1 to 16 do
  begin
    RAMGridByte.Cells[i,0] := IntToHex(i-1,1);
    HEXGrid.Cells[i,0] := IntToHex(i,1);
  end;
  for j := 1 to 64 do
  begin
    RAMGridByte.Cells[0,j] := IntToHex(j-1,2);
    RAMGridWord.Cells[0,j] := IntToHex(j-1,2);
  end;
  for i := 1 to 9 do
    RAMGridWord.Cells[i,0] := IntToHex(2*(i-1),1);

 //тело RAMbyte
  for i := 1 to 16 do
    for j := 1 to 64 do
      RAMGridByte.Cells[i,j]:='00';

  //тело RAMword
  for j := 1 to 64 do
  begin
  k:=1;
    for i := 1 to 9 do
      while k < 16 do
        begin
          RAMGridWord.Cells[i,j]:=RAMGridByte.Cells[k+1,j]+RAMGridByte.Cells[k,j];
          k:=k+2;
          break
        end;
  end;

  StringGrid5.Cells[0,0] := 'AX     '+IntToHex(AX_ptr1^,4);
  StringGrid5.Cells[1,0] := 'BX     '+IntToHex(BX_ptr1^,4);
  StringGrid5.Cells[2,0] := 'CX     '+IntToHex(CX_ptr1^,4);
  StringGrid5.Cells[3,0] := 'DX     '+IntToHex(DX_ptr1^,4);
  StringGrid5.Cells[0,1] := 'SP      '+IntToHex(SP_ptr1^,4);
  StringGrid5.Cells[1,1] := 'BP      '+IntToHex(BP_ptr1^,4);
  StringGrid5.Cells[2,1] := 'SI      '+IntToHex(SI_ptr1^,4);
  StringGrid5.Cells[3,1] := 'DI      '+IntToHex(DI_ptr1^,4);
  StringGrid5.Cells[0,2] := 'CS      '+IntToHex(CS_ptr1^,4);
  StringGrid5.Cells[1,2] := 'SS      '+IntToHex(SS_ptr1^,4);
  StringGrid5.Cells[2,2] := 'DS      '+IntToHex(DS_ptr1^,4);
  StringGrid5.Cells[3,2] := 'ES      '+IntToHex(ES_ptr1^,4);
  StringGrid5.Cells[0,3] := 'IP      '+IntToHex(IP_ptr1^,4);
  StringGrid5.Cells[1,3] := 'PSW    '+IntToHex(PSW_ptr1^,4);
  StringGrid5.Cells[2,3] := 'RGK     '+IntToHex(RGK_ptr1^,4);
  StringGrid5.Cells[3,3] := 'RW      '+IntToHex(RW_ptr1^,4);


  Edit2.text := 'CMK     '+IntToHex(CMK_ptr1^,4);
  Edit3.text := 'RGA     '+IntToHex(RGA_ptr1^,4);
  Edit4.text := 'RGB     '+IntToHex(RGB_ptr1^,4);
  Edit5.text := 'ALU     '+IntToHex(ALU_ptr1^,4);
  Edit6.text := 'SDA     '+IntToHex(SDA_ptr1^,4);
  RGR_work.text := IntToHex(RGR_ptr1^,4);
  RGW_work.text := IntToHex(RGW_ptr1^,4);
  RGQ_work.text := IntToHex(RGQ_ptr1^,4);
  RACT_work.text := 'RACT     '+IntToHex(RACT_ptr1^,4);
  STP_work.text := 'STP     '+IntToHex(STP_ptr1^,4);
  CMK_work.text := 'CMK     '+IntToHex(CMK_ptr1^,4);
  ARAM_work.text := IntToHex(ARAM_ptr1^,4);
  MUAD_work.text := 'MUAD    '+IntToHex(MUAD_ptr1^,4);
  RFI_work.Text := IntToHex(RFI_var, 2);

  SREG.Cells[0,0] := 'N';
  SREG.Cells[1,0] := 'Z';
  SREG.Cells[2,0] := 'V';
  SREG.Cells[3,0] := 'C';
  SREG.Cells[4,0] := 'P';
  SREG.Cells[5,0] := 'M';
  for i := 0 to 5 do
    SREG.Cells[i,1] := '0';

  for i := 1 to 17 do
    StringGrid6.Cells[i-1,0] := StringGrid1.Cells[i,0];

  for i := 1 to 17 do
  begin
    if (i <> 6) and (i <> 9) and (i <> 16) and (i <> 17) then
      StringGrid6.Cells[i-1,1] := '0'
    else if i = 6 then
      StringGrid6.Cells[i-1,1] := '1'
    else if i = 9 then
      StringGrid6.Cells[i-1,1] := '6'
    else if i = 16 then
      StringGrid6.Cells[i-1,1] := '7'
    else if i = 17 then
      StringGrid6.Cells[i-1,1] := '0000';
  end;
end;

procedure TForm1.RegOKButtonClick(Sender: TObject);
begin
  StringGrid5.Cells[0,0] := 'AX     '+IntToHex(AX_ptr1^,4);
  StringGrid5.Cells[1,0] := 'BX     '+IntToHex(BX_ptr1^,4);
  StringGrid5.Cells[2,0] := 'CX     '+IntToHex(CX_ptr1^,4);
  StringGrid5.Cells[3,0] := 'DX     '+IntToHex(DX_ptr1^,4);
  StringGrid5.Cells[0,1] := 'SP     '+IntToHex(SP_ptr1^,4);
  StringGrid5.Cells[1,1] := 'BP     '+IntToHex(BP_ptr1^,4);
  StringGrid5.Cells[2,1] := 'SI      '+IntToHex(SI_ptr1^,4);
  StringGrid5.Cells[3,1] := 'DI     '+IntToHex(DI_ptr1^,4);
  StringGrid5.Cells[0,2] := 'CS      '+IntToHex(CS_ptr1^,4);
  StringGrid5.Cells[1,2] := 'SS      '+IntToHex(SS_ptr1^,4);
  StringGrid5.Cells[2,2] := 'DS     '+IntToHex(DS_ptr1^,4);
  StringGrid5.Cells[3,2] := 'ES      '+IntToHex(ES_ptr1^,4);
  StringGrid5.Cells[0,3] := 'IP        '+IntToHex(IP_ptr1^,4);
  StringGrid5.Cells[1,3] := 'PSW    '+IntToHex(PSW_ptr1^,4);
  StringGrid5.Cells[2,3] := 'RGK     '+IntToHex(RGK_ptr1^,4);
  StringGrid5.Cells[3,3] := 'RW      '+IntToHex(RW_ptr1^,4);

  UpdateWorkRegistersDisplay;
end;

procedure TForm1.EditKeyPress(Sender: TObject; var Key: Char);
const
  ValidHexChars: set of Char = ['0'..'9', 'A'..'F', 'a'..'f', #8];
begin
  if Key in ['a'..'f'] then
    Key := UpCase(Key);
  if not (Key in ValidHexChars) then
    Key := #0;
end;

procedure TForm1.Button5Click(Sender: TObject);  //Переход по адресу
begin

if (RAMGridByte.Visible = True) and (HEXGrid.Visible = True) then
begin
  RAMGridByte.Row := HexToInt('$'+LeftStr(RAMAddr.Text, 2))+1;    //байтовая сетка
  RAMGridByte.Col := HexToInt('$'+RightStr(RAMAddr.Text, 1))+1;
  RAMGridByte.SetFocus;

  HEXGrid.Row := HexToInt('$'+LeftStr(RAMAddr.Text, 2))+1;     //HEX сетка
  HEXGrid.Col := HexToInt('$'+RightStr(RAMAddr.Text, 1));
  HEXGrid.SetFocus;
end

else if RAMGridWord.Visible = True then
begin
  RAMGridWord.Row := HexToInt('$'+LeftStr(RAMAddr.Text, 2))+1;    //слово сетка
  RAMGridWord.Col := HexToInt('$'+RightStr(RAMAddr.Text, 1)) div 2 +1;// div 2 + HexToInt('$'+RightStr(RAMAddr.Text, 1)) mod 2 +1;
  RAMGridWord.SetFocus;
end;
end;

//раскраска

procedure DrawGridCell(Grid: TStringGrid; ACol, ARow: Integer; Color: TColor);
var
  Rect: TRect;
begin
  if (ACol < 0) or (ARow < 0) or (ACol >= Grid.ColCount) or (ARow >= Grid.RowCount) then
    Exit;

  Rect := Grid.CellRect(ACol, ARow);
  Grid.Canvas.Brush.Color := Color;
  Grid.Canvas.FillRect(Rect);
  Grid.Canvas.Font.Color := clWhite;
  Grid.Canvas.TextOut(Rect.Left, Rect.Top, Grid.Cells[ACol, ARow]);

  // Обновляем отображение
  Grid.Invalidate;
end;

procedure TForm1.Button8Click(Sender: TObject);
begin
  for i := 1 to 16 do
    StringGrid6.Cells[i-1,1] := StringGrid1.Cells[i,1];
  StackPointer := 0;
for i := 0 to 7 do
  MicroStack[i] := 0;
  STP_var := 0;
  CMK_var := 0;
  RGA_var := 0;
  RGB_var := 0;
  ALU_var := 0;
  SDA_var := 0;
  R_var := 0;
  S_var := 0;
  C0_var := 0;
  ARAM_var := 0;
  RGW_var := 0;
  RGR_var := 0;
  RGQ_var := 0;
  N := HexToInt(StringGrid6.Cells[7,1]);

  FlagN := False;
  FlagZ := False;
  FlagV := False;
  FlagC := False;
  FlagP := False;
  FlagM := False;
  StopWork := False;
  UpdateFlagsDisplay;

  Edit2.text := 'CMK     '+IntToHex(CMK_ptr1^,4);
  Edit3.text := 'RGA     '+IntToHex(RGA_ptr1^,4);
  Edit4.text := 'RGB     '+IntToHex(RGB_ptr1^,4);
  Edit5.text := 'ALU     '+IntToHex(ALU_ptr1^,4);
  Edit6.text := 'SDA     '+IntToHex(SDA_ptr1^,4);
  ARAM_work.text := 'ARAM    '+IntToHex(ARAM_ptr1^,4);
  RGR_work.text := 'RGR     '+IntToHex(RGR_ptr1^,4);
  RGW_work.text := 'RGW     '+IntToHex(RGW_ptr1^,4);
  RGQ_work.text := 'RGQ     '+IntToHex(RGQ_ptr1^,4);

  UpdateWorkRegistersDisplay;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  ShiftOp, ShiftCount: Integer;
  DST_Code, MEM_Code, JFI_Code, CC_Code, CHA_Code: Integer;
  Condition, InvertCondition: Boolean;
  NextAddress: Integer;
  ConstValue: string;
  B_Field: Integer;
begin
  if StopWork then Exit;

  // Загрузка следующей микрокоманды
  for i := 1 to 16 do
  begin
    if (CMK_ptr1^ + 1 <= 64) and (StringGrid1.Cells[i, CMK_ptr1^+1] <> '') then
      StringGrid6.Cells[i-1, 1] := StringGrid1.Cells[i, CMK_ptr1^+1]
    else
      StringGrid6.Cells[i-1, 1] := '0';
  end;

  // Обработка поля CONST
  ConstValue := StringGrid6.Cells[16, 1];
  if Trim(ConstValue) = '' then
    ConstValue := '0000';

  // Обработка поля MEM

  case HexToInt(StringGrid6.Cells[4,1]) of
    0..3: ;
    4: begin
        RGW_var :=  ReadByte(ARAM_var);
        RGW_work.text := IntToHex(RGW_var, 4);
       end;
    5: begin
        RGW_var := ReadWord(ARAM_var);
        RGW_work.Text := IntToHex(RGW_var, 4);
       end;
    6: begin
         WriteByte(ARAM_var, RGR_var and $00FF);
       end;
    7: begin
         WriteWord(ARAM_var, RGR_var);
       end;
  end;

  // Выбор операнда A
  case HexToInt(StringGrid6.Cells[0,1]) of
    0: RGA_var := AX_var;
    1: RGA_var := CX_var;
    2: RGA_var := DX_var;
    3: RGA_var := BX_var;
    4: RGA_var := SP_var;
    5: RGA_var := BP_var;
    6: RGA_var := SI_var;
    7: RGA_var := DI_var;
  end;

  // Выбор операнда B
  B_Field := HexToInt(StringGrid6.Cells[1,1]);
  case B_Field of
    0: RGB_var := AX_var;
    1: RGB_var := CX_var;
    2: RGB_var := DX_var;
    3: RGB_var := BX_var;
    4: RGB_var := SP_var;
    5: RGB_var := BP_var;
    6: RGB_var := SI_var;
    7: RGB_var := DI_var;
  end;

  // Выбор SRC
  case HexToInt(StringGrid6.Cells[5,1]) of
    1: begin R_var := RGA_ptr1^; S_var := RGB_ptr1^; end;
    2: begin R_var := RGA_ptr1^; S_var := RGQ_ptr1^; end;
    3: begin R_var := RGA_ptr1^; S_var := RGR_ptr1^; end;
    4: begin R_var := 2 * RGA_ptr1^; S_var := RGB_ptr1^; end;
    5: begin R_var := HexToInt(ConstValue); S_var := RGB_ptr1^; end;
    6: begin R_var := HexToInt(ConstValue); S_var := RGR_ptr1^; end;
    7: begin R_var := HexToInt(ConstValue); S_var := RGQ_ptr1^; end;
  end;

  //Поле SH

  case HexToInt(StringGrid6.Cells[6,1]) of
    0:;
    1: SDA_var := SDA_var shr N;
    2: SDA_var := Cardinal(SDA_var) shr N;
    3: begin SDA_var := SDA_var shr N; RGQ_var := RGQ_var shr N; end;
    4: begin SDA_var := Cardinal(SDA_var) shr N; RGQ_var := Cardinal(RGQ_var) shr N; end;
    5: RGQ_var := Cardinal(RGQ_var) shr N;
    6: RGQ_var := ALU_var;
    8: SDA_var := SDA_var shl N;
    $A: begin SDA_var := SDA_var shl N; RGQ_var := RGQ_var shl N; end;
    $E:;

  end;

  // Установка CCX
  case HexToInt(StringGrid6.Cells[9,1]) of
    0: C0_var := 0;
    1: C0_var := 1;
    2: C0_var := Ord(FlagC);
    3: C0_var := Ord(FlagC);
  end;

  // Выполнение операции ALU
  case HexToInt(StringGrid6.Cells[8,1]) of
    1: ALU_var := S_var - R_var - 1 + C0_var;
    2: ALU_var := R_var - S_var - 1 + C0_var;
    3: ALU_var := R_var + S_var + C0_var;
    4: ALU_var := S_var + C0_var;
    5: ALU_var := not(S_var) + C0_var;
    6: ALU_var := R_var + C0_var;
    7: ALU_var := not(R_var) + C0_var;
    9: ALU_var := R_var and S_var;
    10: ALU_var := R_var and not(S_var);
    11: ALU_var := not(R_var and S_var);
    12: ALU_var := R_var or S_var;
    13: ALU_var := not(R_var or S_var);
    14: ALU_var := R_var xor S_var;
    15: ALU_var := not(R_var xor S_var);
  end;

  // Вычисление флагов
  CalculateFlags(ALU_var, HexToInt(StringGrid6.Cells[8,1]), R_var, S_var);


  ShiftOp := HexToInt(StringGrid6.Cells[6,1]);
  ShiftCount := HexToInt(StringGrid6.Cells[7,1]);
  SDA_var := ApplyShift(ALU_var, ShiftOp, ShiftCount);

  // Обработка поля DST
  DST_Code := HexToInt(StringGrid6.Cells[11,1]);
  case DST_Code of
    0: ;
    1: begin
         RGR_var := SDA_var;
         case B_Field of
           0: AX_var := RGR_var;
           1: CX_var := RGR_var;
           2: DX_var := RGR_var;
           3: BX_var := RGR_var;
           4: SP_var := RGR_var;
           5: BP_var := RGR_var;
           6: SI_var := RGR_var;
           7: DI_var := RGR_var;
         end;
       end;
    2: begin
         RGR_var := (RGR_var and $FF00) or (SDA_var and $00FF);
         case B_Field of
           0: AX_var := (AX_var and $00FF) or ((SDA_var and $00FF) shl 8);
           1: CX_var := (CX_var and $00FF) or ((SDA_var and $00FF) shl 8);
           2: DX_var := (DX_var and $00FF) or ((SDA_var and $00FF) shl 8);
           3: BX_var := (BX_var and $00FF) or ((SDA_var and $00FF) shl 8);
           4: SP_var := (SP_var and $00FF) or ((SDA_var and $00FF) shl 8);
           5: BP_var := (BP_var and $00FF) or ((SDA_var and $00FF) shl 8);
           6: SI_var := (SI_var and $00FF) or ((SDA_var and $00FF) shl 8);
           7: DI_var := (DI_var and $00FF) or ((SDA_var and $00FF) shl 8);
         end;
       end;
    3: begin
         RGR_var := (RGR_var and $00FF) or ((SDA_var and $00FF) shl 8);
         case B_Field of
           0: AX_var := (AX_var and $FF00) or (SDA_var and $00FF);
           1: CX_var := (CX_var and $FF00) or (SDA_var and $00FF);
           2: DX_var := (DX_var and $FF00) or (SDA_var and $00FF);
           3: BX_var := (BX_var and $FF00) or (SDA_var and $00FF);
           4: SP_var := (SP_var and $FF00) or (SDA_var and $00FF);
           5: BP_var := (BP_var and $FF00) or (SDA_var and $00FF);
           6: SI_var := (SI_var and $FF00) or (SDA_var and $00FF);
           7: DI_var := (DI_var and $FF00) or (SDA_var and $00FF);
         end;
       end;
    4: begin
         case B_Field of
           0: begin AX_var := SDA_var; AX.Text := IntToHex(AX_var, 4); end;
           1: begin CX_var := SDA_var; CX.Text := IntToHex(CX_var, 4); end;
           2: begin DX_var := SDA_var; DX.Text := IntToHex(DX_var, 4); end;
           3: begin BX_var := SDA_var; BX.Text := IntToHex(BX_var, 4); end;
           4: begin SP_var := SDA_var; SP.Text := IntToHex(SP_var, 4); end;
           5: begin BP_var := SDA_var; BP.Text := IntToHex(BP_var, 4); end;
           6: begin SI_var := SDA_var; SI.Text := IntToHex(SI_var, 4); end;
           7: begin DI_var := SDA_var; DI.Text := IntToHex(DI_var, 4); end;
         end;
       end;
  end;

  if DST_Code in [1, 2, 3] then
    RGR.Text := IntToHex(RGR_var, 4);

  //обработка поля WM

  case HexToInt(StringGrid6.Cells[12,1]) of
  0: ;
  1: RGW_var := SDA_var;
  2: ARAM_var := SDA_var;
  3: ARAM_var := RGB_var;
  end;

  // Сохранение флагов в RFI
  if StringGrid6.Cells[10,1] = '1' then
  begin
    RFI_var := 0;
    if FlagN then RFI_var := RFI_var or $80;
    if FlagZ then RFI_var := RFI_var or $40;
    if FlagV then RFI_var := RFI_var or $20;
    if FlagC then RFI_var := RFI_var or $10;
    if FlagP then RFI_var := RFI_var or $08;
    if FlagM then RFI_var := RFI_var or $04;
    RFI.Text := IntToHex(RFI_var, 2);
    RFI_work.Text := IntToHex(RFI_var, 2);
  end;

  // Обработка переходов
  JFI_Code := HexToInt(StringGrid6.Cells[13,1]);
  CC_Code := HexToInt(StringGrid6.Cells[14,1]);
  CHA_Code := HexToInt(StringGrid6.Cells[15,1]);

  if JFI_Code = 5 then
  begin
    StopWork := True;
    ShowMessage('Остановка работы МПУ');
    Exit;
  end;

  Condition := False;
  InvertCondition := (JFI_Code and 1) <> 0;

  if (JFI_Code and 4) <> 0 then
  begin
    Condition := True;
  end
  else
  begin
    Condition := CheckCondition(CC_Code, (JFI_Code and 2) <> 0);
    if InvertCondition then
      Condition := not Condition;
  end;

  // Обработка поля CHA
  ProcessCHA(CHA_Code, Condition, ConstValue, NextAddress);

  if (NextAddress >= 0) and (NextAddress < 64) then
    CMK_var := NextAddress
  else
    CMK_var := (CMK_var + 1) mod 64;

  Edit2.text := 'CMK     '+IntToHex(CMK_ptr1^,4);
  Edit3.text := 'RGA     '+IntToHex(RGA_ptr1^,4);
  Edit4.text := 'RGB     '+IntToHex(RGB_ptr1^,4);
  Edit5.text := 'ALU     '+IntToHex(ALU_ptr1^,4);
  Edit6.text := 'SDA     '+IntToHex(SDA_ptr1^,4);

  UpdateWorkRegistersDisplay;

  StringGrid5.Cells[0,0] := 'AX     '+IntToHex(AX_var,4);
  StringGrid5.Cells[1,0] := 'BX     '+IntToHex(BX_var,4);
  StringGrid5.Cells[2,0] := 'CX     '+IntToHex(CX_var,4);
  StringGrid5.Cells[3,0] := 'DX     '+IntToHex(DX_var,4);
  StringGrid5.Cells[0,1] := 'SP     '+IntToHex(SP_var,4);
  StringGrid5.Cells[1,1] := 'BP     '+IntToHex(BP_var,4);
  StringGrid5.Cells[2,1] := 'SI     '+IntToHex(SI_var,4);
  StringGrid5.Cells[3,1] := 'DI     '+IntToHex(DI_var,4);
end;

procedure TForm1.BytesClick(Sender: TObject);
begin
  RAMGridByte.Visible := True;
  HEXGrid.Visible := True;
  RAMGridWord.Visible := False;
end;

procedure TForm1.WordsClick(Sender: TObject);
begin
  RAMGridByte.Visible := False;
  HEXGrid.Visible := False;
  RAMGridWord.Visible := True;
end;

procedure TForm1.EditExit(Sender: TObject);
var
  Edit: TEdit;
  NewValue: string;
begin
  if not (Sender is TEdit) then Exit;
  Edit := TEdit(Sender);
  NewValue := FormatHexValue(Edit.Text);
  Edit.Text := NewValue;

  if Edit = AX then AX_var := HexToInt(NewValue)
  else if Edit = BX then BX_var := HexToInt(NewValue)
  else if Edit = CX then CX_var := HexToInt(NewValue)
  else if Edit = DX then DX_var := HexToInt(NewValue)
  else if Edit = SP then SP_var := HexToInt(NewValue)
  else if Edit = BP then BP_var := HexToInt(NewValue)
  else if Edit = SI then SI_var := HexToInt(NewValue)
  else if Edit = DI then DI_var := HexToInt(NewValue)
  else if Edit = CS then CS_var := HexToInt(NewValue)
  else if Edit = DS then DS_var := HexToInt(NewValue)
  else if Edit = SS then SS_var := HexToInt(NewValue)
  else if Edit = ES then ES_var := HexToInt(NewValue)
  else if Edit = IP then IP_var := HexToInt(NewValue)
  else if Edit = PSW then PSW_var := HexToInt(NewValue)
  else if Edit = RGK then RGK_var := HexToInt(NewValue)
  else if Edit = RW then RW_var := HexToInt(NewValue)
  else if Edit = RFI then RFI_var := HexToInt(NewValue)
  else if Edit = RFD then RFD_var := HexToInt(NewValue)
  else if Edit = ARAM then ARAM_var := HexToInt(NewValue)
  else if Edit = RGW then RGW_var := HexToInt(NewValue)
  else if Edit = RGR then RGR_var := HexToInt(NewValue)
  else if Edit = CMK then CMK_var := HexToInt(NewValue)
  else if Edit = MUAD then MUAD_var := HexToInt(NewValue)
  else if Edit = STP then STP_var := HexToInt(NewValue)
  else if Edit = ERROR then ERROR_var := HexToInt(NewValue)
  else if Edit = RACT then RACT_var := HexToInt(NewValue);

  UpdateWorkRegistersDisplay;
end;

end.
