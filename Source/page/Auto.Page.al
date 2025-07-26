page 74013 SIGIAuto
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = SIGIAuto;
    Editable = false;
    CardPageId = SIGIAutoCard;
    Caption = 'SIGI Auto';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Nr."; Rec."Nr.")
                {
                    ToolTip = 'Automobilio numeris', Comment = '%';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Automobilio pavadinimas.', Comment = '%';
                }
                field(Mark; Rec.Mark)
                {
                    ToolTip = 'Automobilio markė.', Comment = '%';
                }
                field(Model; Rec.Model)
                {
                    ToolTip = 'Automobilio modelis.', Comment = '%';
                }
                field(Year; Rec.ManufactureYear)
                {
                    ToolTip = 'Automobilio pagaminimo metai.', Comment = '%';
                }
                field(InsuranceExpirationDate; Rec.InsuranceExpirationDate)
                {
                    ToolTip = 'Automobilio civilinio draudimo galiojimo pabaiga.', Comment = '%';
                }
                field(TechExpirationDate; Rec.TechExpirationDate)
                {
                    ToolTip = 'Automobilio techninės apžiūros galiojimo pabaigos data.', Comment = '%';
                }
                field(Location; Rec.Location)
                {
                    ToolTip = 'Automobilio vieta.', Comment = '%';
                }
                field(RentalService; Rec.RentalService)
                {
                    ToolTip = 'Automobilo nuomos paslauga.', Comment = '%';
                }
                field(RentalCost; Rec.RentalCost)
                {
                    ToolTip = 'Automobilio nuomos kaina.', Comment = '%';
                }
            }
        }
    }



    actions
    {
        area(Processing)
        {
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
                    //AutoReservationPage.SetAutoFilter(Rec."No.");
                    AutoReservationPage.Run();
                end;
            }
            action("ViewCurrentReservations")
            {
                Caption = 'Galiojančių rezervacijų sąrašas';
                ToolTip = 'Peržiūrėti galiojančių rezervacijų sąrašą';
                Image = JobListSetup;
                ApplicationArea = All;
                trigger OnAction()
                var
                    CurrentReservationsPage: Page "SIGICurrentReservations";
                begin
                    CurrentReservationsPage.Run();
                end;
            }
        }
        area(Promoted)
        {
            group(Category_Process)
            {
                Caption = 'Process';
                actionref(ViewReservations_Promoted; ViewReservations)
                {
                }
                actionref(ViewCurrentReservations_Promoted; ViewCurrentReservations)
                {
                }
            }
        }
    }
}
