table 74010 "SIGIAutoSetup"
{
    Caption = 'SIGI Auto Setup';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[20])
        {

        }
        field(2; "Automobile No. Series"; Code[20])
        {
            Caption = 'Automobilių nr. serija';
            TableRelation = "No. Series".Code;
        }
        field(3; "Rent Card Series"; Code[20])
        {
            Caption = 'Nuomos kortelės nr. serija';
            TableRelation = "No. Series".Code;
        }
        field(4; "Details"; Code[100])
        {
            Caption = 'Priedų vieta';
            TableRelation = Location;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        RecordHasBeenRead: Boolean;

    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    procedure InsertIfNotExists()
    begin
        Reset();
        if not Get() then begin
            Init();
            Insert(true);
        end;
    end;

}
