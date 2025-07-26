codeunit 74010 SIGIValidations
{
    procedure ValidateReservationDates(NewRes: Record "SIGIAutoReservation")
    var
        ExistingRes: Record "SIGIAutoReservation";
        ReservationDateErr: Label 'Rezervacijos pradžia negali būti vėlesnė už pabaigą.';
        ReservationOverlapErr: Label 'Automobilis yra užimtas pasirinktu laiku';
    begin
        if (NewRes."ReservedFrom" = 0DT) or (NewRes."ReservedTo" = 0DT) then
            exit; // if fields are still empty, ignore validation

        if NewRes."ReservedFrom" > NewRes."ReservedTo" then
            Error(ReservationDateErr);

        ExistingRes.SetRange("Auto No.", NewRes."Auto No."); //Filtering by current car
        ExistingRes.SetFilter("Line No.", '<>%1', NewRes."Line No."); // Excluding self
        ExistingRes.SetFilter("ReservedFrom", '<=%1', NewRes."ReservedTo"); // Reservations that start before current reservation
        ExistingRes.SetFilter("ReservedTo", '>=%1', NewRes."ReservedFrom"); //Reservations that didn't end before current reservation

        if not ExistingRes.IsEmpty() then
            Error(ReservationOverlapErr);
    end;

    procedure ValidateReservationExists(RentHeader: Record "SIGIAutoRentHeader")
    var
        Reservation: Record "SIGIAutoReservation";
        RentFromDate: Date;
        RentToDate: Date;
        ResFromDate: Date;
        ResToDate: Date;
        ReservationDateErr: Label 'Nerasta atitinkama rezervacija.';
    begin
        if (RentHeader."ReservedFrom" = 0D) or (RentHeader."ReservedTo" = 0D) then
            exit; // if fields are still empty, ignore validation

        RentFromDate := RentHeader.ReservedFrom;
        RentToDate := RentHeader.ReservedTo;

        Reservation.SetRange("Auto No.", RentHeader."Auto No.");
        Reservation.SetRange("Client No.", RentHeader."Client No.");

        if Reservation.FindSet() then
            repeat
                ResFromDate := DT2Date(Reservation.ReservedFrom);
                ResToDate := DT2Date(Reservation.ReservedTo);

                // Check if RentHeader date range is within or equal to Reservation's date range
                if (RentFromDate >= ResFromDate) and
                   (RentToDate <= ResToDate) then
                    exit; // Valid match found
            until Reservation.Next() = 0;

        Error(ReservationDateErr);
    end;


}
