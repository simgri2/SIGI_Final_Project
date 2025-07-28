codeunit 74011 SIGIAutoRentProcedures
{
    procedure CreateFirstRentLine(var SIGIAutoRentHeader: Record "SIGIAutoRentHeader")
    var
        Auto: Record SIGIAuto;
        Resource: Record Resource;
        SIGIAutoRentLine: Record "SIGIAutoRentLine";
    begin
        if SIGIAutoRentHeader."Nr." = '' then
            exit; // Header Nr. not inserted automatically yet

        // Load the Auto record based on selected Auto No.
        if not Auto.Get(SIGIAutoRentHeader."Auto No.") then
            exit;

        // Check if system-created first line already exists
        SIGIAutoRentLine.Reset();
        SIGIAutoRentLine.SetRange("Document No.", SIGIAutoRentHeader."Nr.");
        SIGIAutoRentLine.SetRange("Is System Created", true);
        if SIGIAutoRentLine.FindFirst() then
            exit;

        // Inserting a default first rent line
        if Resource.Get(Auto."RentalService") then begin
            SIGIAutoRentLine.Init();
            SIGIAutoRentLine."Document No." := SIGIAutoRentHeader."Nr.";
            SIGIAutoRentLine."Line No." := 1;
            SIGIAutoRentLine."Type" := SIGIAutoRentLine.Type::Resource;
            SIGIAutoRentLine."Nr." := Resource."No.";
            SIGIAutoRentLine."Description" := Resource.Name;
            SIGIAutoRentLine."Quantity" := SIGIAutoRentHeader.Duration;
            SIGIAutoRentLine."Unit Price" := Resource."Unit Price";
            SIGIAutoRentLine."Is System Created" := true;
            SIGIAutoRentLine.Insert();
        end;
    end;

    // Calculate the day duration of auto rent, assign to rent quantity, calculate rent amount
    procedure CalcDuration(var SIGIAutoRentHeader: Record "SIGIAutoRentHeader")
    var
        SIGIAutoRentLine: Record "SIGIAutoRentLine";
    begin
        if (SIGIAutoRentHeader."ReservedFrom" <> 0D) and (SIGIAutoRentHeader."ReservedTo" <> 0D) then
            SIGIAutoRentHeader."Duration" := SIGIAutoRentHeader."ReservedTo" - SIGIAutoRentHeader."ReservedFrom" + 1
        else
            SIGIAutoRentHeader."Duration" := 0;

        // Update the Quantity of the first rent line if it's system-created
        if SIGIAutoRentLine.Get(SIGIAutoRentHeader."Nr.", 1) then begin
            if SIGIAutoRentLine."Is System Created" then begin
                SIGIAutoRentLine."Quantity" := SIGIAutoRentHeader."Duration";
                SIGIAutoRentLine."Amount" := SIGIAutoRentLine."Quantity" * SIGIAutoRentLine."Unit Price";
            end;
            SIGIAutoRentLine.Modify();
        end;
    end;

    procedure SetStatusToReleased(var SIGIAutoRentHeader: Record "SIGIAutoRentHeader")
    var
        ReleaseMsg: Label 'Dokumentas jau yra išduotas.';
    begin
        if SIGIAutoRentHeader.Status = SIGIAutoRentHeader.Status::"Išduota" then begin
            Message(ReleaseMsg);
            exit;
        end;
        SIGIAutoRentHeader.Status := SIGIAutoRentHeader.Status::"Išduota";
    end;

    procedure SetStatusToOpen(var SIGIAutoRentHeader: Record "SIGIAutoRentHeader")
    var
        OpenMsg: Label 'Dokumentas jau yra atidarytas.';
    begin
        if SIGIAutoRentHeader.Status = SIGIAutoRentHeader.Status::"Atidaryta" then begin
            Message(OpenMsg);
            exit;
        end;
        SIGIAutoRentHeader.Status := SIGIAutoRentHeader.Status::"Atidaryta";
    end;

    procedure ReturnAuto(var SIGIAutoRentHeader: Record "SIGIAutoRentHeader")
    var
        SIGIFinishedAutoRentHeader: Record SIGIFinishedAutoRentHeader;
        SIGIFinishedAutoRentLine: Record SIGIFinishedAutoRentLine;
        SIGIAutoRentLine: Record SIGIAutoRentLine;
        ReturnSuccessMsg: Label 'Automobilis sėkmingai grąžintas';
        AutoAlreadyReturnedMsg: Label 'Šis automobilis jau yra grąžintas';
    begin
        // Check if finished header already exists. If not, copy data into new finished header
        if not SIGIFinishedAutoRentHeader.Get(SIGIAutoRentHeader."Nr.") then begin
            SIGIFinishedAutoRentHeader.Init();
            SIGIFinishedAutoRentHeader."Nr." := SIGIAutoRentHeader."Nr.";
            SIGIFinishedAutoRentHeader."Client No." := SIGIAutoRentHeader."Client No.";
            SIGIFinishedAutoRentHeader."Driver License Image" := SIGIAutoRentHeader."Driver License Image";
            SIGIFinishedAutoRentHeader."Date" := SIGIAutoRentHeader."Date";
            SIGIFinishedAutoRentHeader."Auto No." := SIGIAutoRentHeader."Auto No.";
            SIGIFinishedAutoRentHeader."ReservedFrom" := SIGIAutoRentHeader."ReservedFrom";
            SIGIFinishedAutoRentHeader."ReservedTo" := SIGIAutoRentHeader."ReservedTo";
            SIGIFinishedAutoRentHeader."Amount" := SIGIAutoRentHeader."Amount";
            SIGIFinishedAutoRentHeader.Insert();
        end else begin
            Message(AutoAlreadyReturnedMsg); // auto already returned
            exit;
        end;

        // If exist, copy rent lines
        SIGIAutoRentLine.SetRange("Document No.", SIGIAutoRentHeader."Nr.");
        if SIGIAutoRentLine.FindSet() then
            repeat
                SIGIFinishedAutoRentLine.Init();
                SIGIFinishedAutoRentLine."Document No." := SIGIAutoRentLine."Document No.";
                SIGIFinishedAutoRentLine."Line No." := SIGIAutoRentLine."Line No.";
                SIGIFinishedAutoRentLine."Type" := SIGIAutoRentLine."Type";
                SIGIFinishedAutoRentLine."Nr." := SIGIAutoRentLine."Nr.";
                SIGIFinishedAutoRentLine."Description" := SIGIAutoRentLine."Description";
                SIGIFinishedAutoRentLine."Quantity" := SIGIAutoRentLine."Quantity";
                SIGIFinishedAutoRentLine."Unit Price" := SIGIAutoRentLine."Unit Price";
                SIGIFinishedAutoRentLine."Amount" := SIGIAutoRentLine."Amount";
                SIGIFinishedAutoRentLine.Insert();
            until SIGIAutoRentLine.Next() = 0;
        Message(ReturnSuccessMsg);
    end;
}
