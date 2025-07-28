table 74018 SIGIFinishedAutoRentHeader
{
    DataClassification = CustomerContent;
    Caption = 'SIGI Finished Auto Rent Header';

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
        field(6; ReservedFrom; Date)
        {
            Caption = 'Rezervuota nuo data';
        }
        field(7; ReservedTo; Date)
        {
            Caption = 'Rezervuota iki data';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(SIGIAutoRentLine.Amount where("Document No." = field("Nr.")));
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
}
