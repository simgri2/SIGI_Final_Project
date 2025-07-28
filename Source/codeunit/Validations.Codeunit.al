codeunit 74010 SIGIValidations
{
    // Check if new reservation does not overlap with an existing one
    procedure ValidateReservationDates(NewRes: Record "SIGIAutoReservation")
    var
        SIGIExistingAutoReservations: Record "SIGIAutoReservation";
        ReservationDateErr: Label 'Rezervacijos pradžia negali būti vėlesnė už pabaigą.';
        ReservationOverlapErr: Label 'Automobilis yra užimtas pasirinktu laiku';
    begin
        // If date fields are still empty, ignore validation
        if (NewRes."ReservedFrom" = 0DT) or (NewRes."ReservedTo" = 0DT) then
            exit;

        // Avoid wrong date input
        if NewRes."ReservedFrom" > NewRes."ReservedTo" then
            Error(ReservationDateErr);

        // Filtering reservation records to find overlappings with new reservation
        SIGIExistingAutoReservations.SetRange("Auto No.", NewRes."Auto No."); //Filtering by current car
        SIGIExistingAutoReservations.SetFilter("Line No.", '<>%1', NewRes."Line No."); // Excluding self
        SIGIExistingAutoReservations.SetFilter("ReservedFrom", '<=%1', NewRes."ReservedTo"); // Reservations that start before current reservation
        SIGIExistingAutoReservations.SetFilter("ReservedTo", '>=%1', NewRes."ReservedFrom"); //Reservations that didn't end before current reservation

        // If after filtering there are still records, show error
        if not SIGIExistingAutoReservations.IsEmpty() then
            Error(ReservationOverlapErr);
    end;

    // Check if there is a valid reservation for this rent
    procedure ValidateReservationExists(SIGIAutoRentHeader: Record "SIGIAutoRentHeader")
    var
        SIGIAutoReservation: Record "SIGIAutoReservation";
        RentFromDate: Date;
        RentToDate: Date;
        ReservedFromDate: Date;
        ReservedToDate: Date;
        ReservationDateErr: Label 'Nerasta atitinkama rezervacija.';
    begin
        //Message('Validation initiated');
        // If date fields are still empty, ignore validation
        if (SIGIAutoRentHeader."ReservedFrom" = 0D) or (SIGIAutoRentHeader."ReservedTo" = 0D) then
            exit;

        RentFromDate := SIGIAutoRentHeader.ReservedFrom;
        RentToDate := SIGIAutoRentHeader.ReservedTo;


        // Filter reservations by Auto No. and Client No.
        SIGIAutoReservation.SetRange("Auto No.", SIGIAutoRentHeader."Auto No.");
        SIGIAutoReservation.SetRange("Client No.", SIGIAutoRentHeader."Client No.");

        // If filters found reservations for this auto and client, go through them
        if SIGIAutoReservation.FindSet() then
            repeat
                // Take only date value of datetime
                ReservedFromDate := DT2Date(SIGIAutoReservation.ReservedFrom);
                ReservedToDate := DT2Date(SIGIAutoReservation.ReservedTo);

                //Message('Validuoju reservacijas (rent and res): %1 and %2 / %3 and %4', RentFromDate, ReservedFromDate, RentToDate, ReservedToDate);

                // Check if RentHeader date range is within or equal to reservation's date range
                if (RentFromDate >= ReservedFromDate) and
                   (RentToDate <= ReservedToDate) then
                    exit; // Valid match found
            until SIGIAutoReservation.Next() = 0;

        Error(ReservationDateErr); // If no reservation at these dates were found
    end;

    procedure ValidateYear(var SIGIAuto: Record "SIGIAuto")
    var
        CurrentYear: Integer;
        ManufactureYearErr: Label 'Neteisingi pagaminimo metai';
    begin
        CurrentYear := DATE2DMY(TODAY, 3); // Extracts current year as integer
        if (SIGIAuto."ManufactureYear" < 1885) or (SIGIAuto."ManufactureYear" > CurrentYear) then
            Error(ManufactureYearErr);
    end;


}
