table 74019 SIGIFinishedAutoRentLine
{
    DataClassification = CustomerContent;
    Caption = 'SIGI Finished Auto Rent Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Dokumento Nr.';
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Eilutės Nr.';
        }
        field(3; Type; Enum SIGIAutoRentLineType)
        {
            Caption = 'Tipas';
        }
        field(4; "Nr."; Code[20])
        {
            Caption = 'Nr.';
            TableRelation =
            if (Type = const(Item)) Item."No."
            else
            if (Type = const(Resource)) Resource."No.";
        }
        field(5; Description; Text[100])
        {
            Caption = 'Aprašas';
        }
        field(6; Quantity; Integer)
        {
            Caption = 'Kiekis';
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Kaina';
        }
        field(8; Amount; Decimal)
        {
            Caption = 'Suma';
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}
