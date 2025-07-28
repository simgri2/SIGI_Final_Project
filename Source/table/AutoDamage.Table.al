table 74015 SIGIAutoDamage
{
    DataClassification = ToBeClassified;
    Caption = 'SIGI Auto Damage';

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
        field(3; "Date"; Date)
        {
            Caption = 'Data';
        }
        field(4; Description; Text[100])
        {
            Caption = 'Aprašas';
        }
        field(5; Status; Enum SIGIAutoDamageStatus)
        {
            Caption = 'Statusas';
        }
    }

    keys
    {
        key("Auto No."; "Line No.")
        {
            Clustered = true;
        }
    }
}
