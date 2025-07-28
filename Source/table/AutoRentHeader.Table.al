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
            trigger OnValidate()
            var
                SIGIAutoRentProcedures: Codeunit SIGIAutoRentProcedures;
            begin
                SIGIAutoRentProcedures.CreateFirstRentLine(Rec);
            end;
        }
        field(6; "ReservedFrom"; Date)
        {
            Caption = 'Rezervuota nuo data';
            trigger OnValidate()
            begin
                this.SIGIValidationsCodeunit.ValidateReservationExists(Rec);
                this.SIGIAutoRentProcedures.CalcDuration(Rec);
            end;
        }
        field(7; "ReservedTo"; Date)
        {
            Caption = 'Rezervuota iki data';
            trigger OnValidate()
            begin
                this.SIGIValidationsCodeunit.ValidateReservationExists(Rec);
                this.SIGIAutoRentProcedures.CalcDuration(Rec);
            end;
        }
        field(8; "Amount"; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(SIGIAutoRentLine.Amount where("Document No." = field("Nr.")));
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
        field(30; "Duration"; Integer)
        {
            Editable = false;
        }
        // hidden fields that are accessed when creating a report
        field(40; "Auto Mark"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(SIGIAuto.Mark where("Nr." = field("Auto No.")));
            Editable = false;
        }
        field(50; "Auto Model"; Code[20])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(SIGIAuto.Model where("Nr." = field("Auto No.")));
            Editable = false;
        }
        field(60; "Client Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup(Customer.Name where("No." = field("Client No.")));
            Editable = false;
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
        SIGIAutoRentProcedures: Codeunit SIGIAutoRentProcedures;

    trigger OnInsert()
    var
        AutoSetup: Record SIGIAutoSetup;
        Auto: Record SIGIAuto;
        NoSeries: Codeunit "No. Series";
    begin
        // Set document status to OPEN upon creation
        Status := Enum::"SIGIAutoRentStatus"::Atidaryta;

        // Automatically assign Nr. from AutoSetup number series
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
    end;
}
