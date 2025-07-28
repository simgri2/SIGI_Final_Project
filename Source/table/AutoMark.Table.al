table 74011 "SIGIAutoMark"
{
    Caption = 'SIGI Auto Mark';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code';
            NotBlank = true;
        }
        field(2; "Description"; Text[20])
        {
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        AutoMarkRec: Record "SIGIAutoMark";
    begin
        if AutoMarkRec.Get("Code") then
            Error('Automobilio markės kodas %1 jau egzistuoja sąraše.', "Code");
    end;

}
