table 74014 "SIGIAutoReservation"
{
    Caption = 'SIGI Auto Reservation';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Auto No."; Code[20])
        {
            Caption = 'Automobilio Nr.';
            TableRelation = SIGIAuto."Nr.";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Eilutės Nr.';
            AutoIncrement = true;
        }
        field(3; "Client No."; Code[20])
        {
            Caption = 'Kliento numeris';
            TableRelation = Customer."No.";
        }
        field(4; ReservedFrom; DateTime)
        {
            Caption = 'Rezervuota nuo data laikas';
        }
        field(5; ReservedTo; DateTime)
        {
            Caption = 'Rezervuota iki data laikas';
        }

    }

    keys
    {
        key(PK; "Auto No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        SIGIValidationsCodeunit: Codeunit "SIGIValidations";

    trigger OnInsert()
    begin
        this.SIGIValidationsCodeunit.ValidateReservationDates(Rec);
    end;

    trigger OnModify()
    begin
        this.SIGIValidationsCodeunit.ValidateReservationDates(Rec);
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;


}
