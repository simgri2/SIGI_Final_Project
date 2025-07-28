table 74017 SIGIAutoRentLine
{
    DataClassification = CustomerContent;
    Caption = 'SIGI Auto Rent Line';

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
        field(3; "Type"; Enum SIGIAutoRentLineType)
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

            trigger OnValidate()
            var
                ItemRec: Record Item;
                ResourceRec: Record Resource;
            begin
                if Type = Type::Item then
                    if ItemRec.Get("Nr.") then begin
                        Description := ItemRec.Description;
                        "Unit Price" := ItemRec."Unit Price";
                    end;

                if Type = Type::Resource then
                    if ResourceRec.Get("Nr.") then begin
                        Description := ResourceRec.Name;
                        "Unit Price" := ResourceRec."Unit Price";
                    end;
            end;

        }
        field(5; "Description"; Text[100])
        {
            Caption = 'Aprašas';
        }
        field(6; "Quantity"; Integer)
        {
            Caption = 'Kiekis';
            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Price";
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            Caption = 'Kaina';
            trigger OnValidate()
            begin
                Amount := Quantity * "Unit Price";
            end;
        }
        field(8; "Amount"; Decimal)
        {
            Editable = false;
            Caption = 'Suma';
        }
        field(20; "Is System Created"; Boolean)
        {
            Editable = false; // prevent UI editing for system created first line
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        SystemLineErr: Label 'Negalima redaguoti sistemos sukurtos eilutės.';

    trigger OnModify()
    begin
        if "Is System Created" then
            Error(SystemLineErr);
    end;

    trigger OnDelete()
    begin
        if "Is System Created" then
            Error(SystemLineErr);
    end;

}
