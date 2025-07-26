table 74016 SIGIAutoRentHeader
{
    DataClassification = CustomerContent;
    Caption = 'SIGI Auto Rent Header';


    fields
    {
        field(1; "Nr."; Code[20])
        {
            Caption = 'Nr.';

        }
        field(2; "Client No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Kliento Nr.';
            TableRelation = Customer."No.";
        }
        field(3; "Driver License Image"; Media)
        {
            Caption = 'Vairuotojo pažymėjimas';
        }
        field(4; "Date"; Date)
        {
            Caption = 'Data';
        }
        field(5; "Auto No."; Code[20])
        {
            Caption = 'Automobilio Nr.';
            TableRelation = SIGIAuto."Nr.";
        }
        field(6; "ReservedFrom"; Date)
        {
            Caption = 'Rezervuota nuo data';
        }
        field(7; "ReservedTo"; Date)
        {
            Caption = 'Rezervuota iki data';
        }
        field(8; "Amount"; Decimal)
        {
            //FieldClass = FlowField;
            Caption = 'Amount';
            //CalcFormula = Sum("Auto Rent Line".Amount where("Document No." = field("No.")));
        }
        field(9; "Status"; Enum SIGIAutoRentStatus)
        {
            Caption = 'Būsena';
            Editable = false;
        }
        field(20; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys
    {
        key(PK; "Nr.")
        {
            Clustered = true;
        }
    }

    var
        SIGIValidationsCodeunit: Codeunit "SIGIValidations";

    trigger OnInsert()
    var
        AutoSetup: Record SIGIAutoSetup;
        Auto: Record SIGIAuto;
        NoSeries: Codeunit "No. Series";
    begin
        Status := Enum::"SIGIAutoRentStatus"::Atidaryta; // document is in status OPEN upon creation
        AutoSetup.GetRecordOnce();
        if NoSeries.AreRelated(AutoSetup."Rent Card Series", xRec."No. Series") then
            "No. Series" := xRec."No. Series"
        else
            "No. Series" := AutoSetup."Rent Card Series";
        "Nr." := NoSeries.GetNextNo("No. Series");
        Auto.ReadIsolation(IsolationLevel::ReadUncommitted);
        Auto.SetLoadFields("Nr.");
        while Auto.Get("Nr.") do // runs until finds a unique number
            "Nr." := NoSeries.GetNextNo("No. Series");

        SIGIValidationsCodeunit.ValidateReservationExists(Rec);
    end;

    trigger OnModify()
    begin
        CheckIsOpen();
        //SIGIValidationsCodeunit.ValidateReservationExists(Rec);
    end;

    procedure SetStatusToReleased()
    var
        ReleaseMsg: Label 'Dokumentas jau yra išduotas.';
    begin
        if Status = Status::"Išduota" then begin
            Message(ReleaseMsg);
            exit;
        end;
        Status := Status::"Išduota";
        Modify(false);
    end;

    procedure SetStatusToOpen()
    var
        OpenMsg: Label 'Dokumentas jau yra atidarytas.';
    begin
        if Status = Status::"Atidaryta" then begin
            Message(OpenMsg);
            exit;
        end;
        Status := Status::"Atidaryta";
        Modify(false);
    end;

    local Procedure CheckIsOpen()
    var
        MustBeOpenErr: Label 'Šiam veiksmui atlikti statusas turi būti "Išduota"';
    begin
        if Status <> Status::"Išduota" then
            Error(MustBeOpenErr);
    end;

}
