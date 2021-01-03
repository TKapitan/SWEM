/// <summary>
/// Page TKA Project Card (ID 81001).
/// Shows details of one specific project.
/// </summary>
page 81001 "TKA Project Card"
{
    Caption = 'Project Card';
    PageType = Card;
    UsageCategory = None;
    SourceTable = "TKA Project";


    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General';

                field("TKA No."; Rec."TKA No.")
                {
                    ToolTip = 'Specifies no. of project.';
                    ApplicationArea = All;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("TKA Status"; Rec."TKA Status")
                {
                    ToolTip = 'Specifies status of the project.';
                    ApplicationArea = All;
                }
                field("TKA Description"; Rec."TKA Description")
                {
                    ToolTip = 'Specifies description of the project.';
                    ApplicationArea = All;
                }
                field("TKA Project Manager Code"; Rec."TKA Project Manager Code")
                {
                    ToolTip = 'Specifies code of the salesperson who is in role of project manager.';
                    ApplicationArea = All;
                }
                field("TKA Starting Date"; Rec."TKA Starting Date")
                {
                    ToolTip = 'Specifies starting date of the project.';
                    ApplicationArea = All;
                }
                field("TKA Ending Date"; Rec."TKA Ending Date")
                {
                    ToolTip = 'Specifies ending date of the project.';
                    ApplicationArea = All;
                }
                field("TKA Invoicing Work Type Code"; Rec."TKA Invoicing Work Type Code")
                {
                    ToolTip = 'Specifies invoicing work type code. Invoicing work type specifies work type which will be used for creating sales documents.';
                    ApplicationArea = All;
                }
                field("TKA Calc. Work Type Code"; Rec."TKA Calc. Work Type Code")
                {
                    ToolTip = 'Specifies calculation work type code. Calculation work type specifies work type code for reporting. For example, if the project is calculated with fixed amount, invoicing work type is with zero price but the calculation one specifies real amount.';
                    ApplicationArea = All;
                }
                field("TKA Invoicing Unit Price"; Rec."TKA Invoicing Unit Price")
                {
                    ToolTip = 'Specifies invoicing unit price. Invoicing unit price specifies unit price which will be used for creating sales documents.';
                    ApplicationArea = All;
                }
                field("TKA Calc. Unit Price (LCY)"; Rec."TKA Calc. Unit Price (LCY)")
                {
                    ToolTip = 'Specifies calculation unit price in LCY. Calculation unit price specifies unit price in local currency for reporting. For example, if the project is calculated with fixed amount, invoicing unit price is zero but the calculation one specifies real amount.';
                    ApplicationArea = All;
                }
                field("TKA Invoicing Currency Code"; Rec."TKA Invoicing Currency Code")
                {
                    ToolTip = 'Specifies invoicing currency code. Invoicing currency code specifies currency which will be used for creating sales documents.';
                    ApplicationArea = All;
                }
                field("TKA Allow API Create Tasks"; Rec."TKA Allow API Create Tasks")
                {
                    ToolTip = 'Specifies whether it is possible to create tasks in this project using APIs.';
                    ApplicationArea = All;
                }
            }
            part("TKA Project Task Subform"; "TKA Project Task Subform")
            {
                SubPageLink = "TKA Project No." = field("TKA No.");
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("TKA Copy Project")
            {
                Caption = 'Kopírovat projekt';
                ToolTip = 'Allows to copy existing project(s) into newer copy.';
                Image = CopyBudget;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    TKAProject: Record "TKA Project";
                    TKACopyProjects: Report "TKA Copy Projects";
                begin
                    CurrPage.SetSelectionFilter(TKAProject);

                    TKACopyProjects.SetTableView(TKAProject);
                    TKACopyProjects.RunModal();
                end;
            }
        }
    }
}