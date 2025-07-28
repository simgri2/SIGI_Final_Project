page 74019 SIGIAutoRentHeaderCard
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = SIGIAutoRentHeader;
    Caption = 'SIGI Auto Rent Header';

    layout
    {
        area(Content)
        {
            group(GroupName)
            {
                Editable = IsEditable;
                Caption = 'Nuomos sutartis';

                field("Nr."; Rec."Nr.")
                {
                    ToolTip = 'Nuomos kortelės Nr.', Comment = '%';
                }
                field("Client No."; Rec."Client No.")
                {
                    ToolTip = 'Kliento Nr.', Comment = '%';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Sutarties sudarymo data.', Comment = '%';
                }
                field("Auto No."; Rec."Auto No.")
                {
                    ToolTip = 'Automobilio Nr.', Comment = '%';
                }
                field(ReservedFrom; Rec.ReservedFrom)
                {
                    ToolTip = 'Automobilio rezervacijos pradžios data.', Comment = '%';
                }
                field(ReservedTo; Rec.ReservedTo)
                {
                    ToolTip = 'Automobilio rezervacijos pabaigos data.', Comment = '%';
                }
                field(Amount; Rec.Amount)
                {
                    ToolTip = 'Nuomos paslaugų suma.', Comment = '%';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Sutarties būsena.', Comment = '%';
                }
            }
            group(Lines)
            {
                Editable = IsEditable;
                Caption = 'Paslaugos';
                part(OrderLines; "SIGIAutoRentLine")
                {
                    // Shows rent lines related only to this specific rent header
                    SubPageLink = "Document No." = field("Nr.");
                }
            }
        }

        area(FactBoxes)
        {
            part(DriverLicenseImage; "SIGIDriverLicenseImageFactBox")
            {
                SubPageLink = "Nr." = field("Nr.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Release)
            {
                Caption = 'Išduoti';
                Image = ReleaseDoc;
                ToolTip = 'Keisti statusą į "Išduota"';

                trigger OnAction()
                begin
                    SIGIAutoRentProcedures.SetStatusToReleased(Rec);
                end;
            }
            action(Reopen)
            {
                Caption = 'Atidaryti';
                Image = ReOpen;
                ToolTip = 'Keisti statusą į "Atidaryta"';

                trigger OnAction()
                begin
                    SIGIAutoRentProcedures.SetStatusToOpen(Rec);
                end;
            }
            action(PrintRentCard)
            {
                Caption = 'Spausdinti nuomos kortelę';
                Image = Print;
                ToolTip = 'Spausdinti šios nuomos dokumento ataskaitą';

                trigger OnAction()
                var
                    RentHeaderRec: Record SIGIAutoRentHeader;
                begin
                    RentHeaderRec.Reset();
                    RentHeaderRec.SetRange("Nr.", Rec."Nr."); // Filter by current record No.
                    Report.RunModal(74010, true, false, RentHeaderRec); // 74010 is report id
                end;
            }
            action("ViewReservations")
            {
                Caption = 'Rezervacijų sąrašas';
                ToolTip = 'Peržiūrėti rezervacijų sąrašą';
                Image = TaskList;
                ApplicationArea = All;
                trigger OnAction()
                var
                    AutoReservationPage: Page "SIGIAutoReservation";
                begin
                    AutoReservationPage.Run();
                end;
            }
            action(ReturnAuto)
            {
                Caption = 'Grąžinti automobilį';
                Image = ReturnOrder;
                ToolTip = 'Užbaigti automobilio nuomos sutartį.';

                trigger OnAction()
                begin
                    SIGIAutoRentProcedures.ReturnAuto(Rec);
                end;
            }
        }

        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(Release_Promoted; Release)
                {
                }
                actionref(Reopen_Promoted; Reopen)
                {
                }
                actionref(PrintRentCard_Promoted; PrintRentCard)
                {
                }
                actionref(ViewReservations_Promoted; ViewReservations)
                {
                }
                actionref(ReturnAuto_Promoted; ReturnAuto)
                {
                }
            }
        }
    }

    var
        SIGIAutoRentProcedures: Codeunit SIGIAutoRentProcedures;
        IsEditable: Boolean;

    trigger OnAfterGetRecord()
    begin
        // If status = Išduota, field editing is disabled
        IsEditable := Rec.Status <> Rec.Status::"Išduota";
    end;

    // Avoid all fields being disabled for editing upon creation
    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        IsEditable := true;
    end;

}
