table 74012 SIGIAutoModel
{
    Caption = 'SIGI Auto Model';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "MarkCode"; Code[10])
        {
            Caption = 'Auto mark code.';
            TableRelation = SIGIAutoMark;
            NotBlank = true;
        }
        field(2; "ModelCode"; Code[20])
        {
            Caption = 'Auto model code.';
            NotBlank = true;
        }
        field(3; "Description"; Text[100])
        {
            Caption = 'Auto model description';
        }
    }

    keys
    {
        key(PK; "MarkCode", "ModelCode")
        {
            Clustered = true;
        }
    }
}
