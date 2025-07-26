table 74013 SIGIAuto
{
    Caption = 'SIGI Auto';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Nr."; Code[20])
        {
            Caption = 'Nr.';
            //NotBlank = true; //taken care by OnInsert trigger
        }
        field(2; "Name"; Text[100])
        {
            Caption = 'Pavadinimas';
        }
        field(3; "Mark"; Code[20])
        {
            Caption = 'Markė';
            TableRelation = SIGIAutoMark;
        }
        field(4; "Model"; Code[20])
        {
            Caption = 'Modelis';
            TableRelation = SIGIAutoModel.ModelCode where(MarkCode = field(Mark));
        }
        field(5; "ManufactureYear"; Integer)
        {
            Caption = 'Pagaminimo metai';

            trigger OnValidate()
            var
                CurrentYear: Integer;
                ManufactureYearErr: Label 'Neteisingi pagaminimo metai';
            begin
                CurrentYear := DATE2DMY(TODAY, 3); // Extracts current year as integer
                if ("ManufactureYear" < 1885) or ("ManufactureYear" > CurrentYear) then
                    Error(ManufactureYearErr);
            end;
        }
        field(6; "InsuranceExpirationDate"; Date)
        {
            Caption = 'Civilinio draudimo galiojimas iki';
        }
        field(7; "TechExpirationDate"; Date)
        {
            Caption = 'Techninės apžiūros galiojimas iki';
        }
        field(8; "Location"; Code[10])
        {
            Caption = 'Vietos Kodas';
            TableRelation = Location.Code;
        }
        field(9; "RentalService"; Code[20])
        {
            Caption = 'Nuomos paslauga';
            TableRelation = Resource; //patikslinti!!!
        }
        field(10; "RentalCost"; Decimal)
        {
            Caption = 'Nuomos kaina';
            FieldClass = FlowField;
            CalcFormula = lookup(Resource."Unit Price" where("No." = field("RentalService")));
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

    fieldgroups
    {
        // Add changes to field groups here
    }

    trigger OnInsert()
    var
        AutoSetup: Record SIGIAutoSetup;
        Auto: Record SIGIAuto;
        NoSeries: Codeunit Microsoft.Foundation.NoSeries."No. Series";
    begin
        AutoSetup.GetRecordOnce();
        if NoSeries.AreRelated(AutoSetup."Automobile No. Series", xRec."No. Series") then
            "No. Series" := xRec."No. Series"
        else
            "No. Series" := AutoSetup."Automobile No. Series";
        "Nr." := NoSeries.GetNextNo("No. Series");
        Auto.ReadIsolation(IsolationLevel::ReadUncommitted);
        Auto.SetLoadFields("Nr.");
        while Auto.Get("Nr.") do // runs until finds a unique number
            "Nr." := NoSeries.GetNextNo("No. Series");
    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}
