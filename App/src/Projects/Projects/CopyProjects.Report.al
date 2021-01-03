/// <summary>
/// Report TKA Copy Projects (ID 81000).
/// </summary>
report 81000 "TKA Copy Projects"
{
    Caption = 'Copy Projects';
    ProcessingOnly = true;
    UsageCategory = None;

    dataset
    {
        dataitem(CurrentTKAProject; "TKA Project")
        {
            trigger OnAfterGetRecord();
            var
                NewTKAProject: Record "TKA Project";
                NewTKAProjectTask, CurrentTKAProjectTask : Record "TKA Project Task";
                TKASWProjectEMasterSetup: Record "TKA SW Project E-Master Setup";

                NoSeriesManagement: Codeunit NoSeriesManagement;

                ReplaceTextBuilder: TextBuilder;
            begin
                NewTKAProject.Init();
                NewTKAProject.TransferFields(CurrentTKAProject, true);
                NewTKAProject."TKA No." := NoSeriesManagement.GetNextNo(TKASWProjectEMasterSetup."TKA Project Nos.", StartingDate, true);
                NewTKAProject.Validate("TKA Ending Date", EndingDate);
                NewTKAProject.Validate("TKA Starting Date", StartingDate);

                if OldTextToReplace <> '' then begin
                    Clear(ReplaceTextBuilder);
                    ReplaceTextBuilder.Append(NewTKAProject."TKA Description");
                    ReplaceTextBuilder.Replace(OldTextToReplace, NewTextToReplaceWith);
                    NewTKAProject.Validate("TKA Description", ReplaceTextBuilder.ToText());
                end;
                NewTKAProject.Insert(true);

                if WithProjectTasks then begin
                    CurrentTKAProjectTask.SetRange("TKA Project No.", CurrentTKAProject."TKA No.");
                    if WithoutClosedProjectTasks then
                        CurrentTKAProjectTask.SetRange("TKA Closed", false);

                    if CurrentTKAProjectTask.FindSet() then
                        repeat
                            NewTKAProjectTask.Init();
                            NewTKAProjectTask.TransferFields(CurrentTKAProjectTask, true);
                            NewTKAProjectTask.Validate("TKA Project No.", NewTKAProject."TKA No.");
                            if OldTextToReplace <> '' then begin
                                Clear(ReplaceTextBuilder);
                                ReplaceTextBuilder.Append(CurrentTKAProjectTask."TKA Task No.");
                                ReplaceTextBuilder.Replace(OldTextToReplace, NewTextToReplaceWith);
                                NewTKAProjectTask.Validate("TKA Task No.", ReplaceTextBuilder.ToText());

                                Clear(ReplaceTextBuilder);
                                ReplaceTextBuilder.Append(CurrentTKAProjectTask."TKA Description");
                                ReplaceTextBuilder.Replace(OldTextToReplace, NewTextToReplaceWith);
                                NewTKAProjectTask.Validate("TKA Description", ReplaceTextBuilder.ToText());
                            end;
                            NewTKAProjectTask.Validate("TKA Closed", false);
                            NewTKAProjectTask.Insert(true);
                        until CurrentTKAProjectTask.Next() < 1;
                end;
            end;
        }
    }

    requestpage
    {
        Caption = 'Setting';

        layout
        {
            area(content)
            {
                group("TKA General")
                {
                    Caption = 'General';

                    field("TKA Starting Date"; StartingDate)
                    {
                        Caption = 'Starting Date';
                        ToolTip = 'Specifies starting date for every newly created project.';
                        ApplicationArea = All;
                    }

                    field("TKA Ending Date"; EndingDate)
                    {
                        Caption = 'Ending Date';
                        ToolTip = 'Specifies ending date for every newly created project.';
                        ApplicationArea = All;
                    }

                    field("TKA With Project Tasks"; WithProjectTasks)
                    {
                        Caption = 'With Project Tasks';
                        ToolTip = 'Specifies whether projects should be copied with or without tasks.';
                        ApplicationArea = All;
                    }

                    field("TKA Without Closed Project Tasks"; WithoutClosedProjectTasks)
                    {
                        Caption = 'Without Closed Project Tasks';
                        ToolTip = 'Specifies whether projects should be copied without tasks that are marked as closed.';
                        ApplicationArea = All;
                    }

                    field("TKA Old Text To Replace"; OldTextToReplace)
                    {
                        Caption = 'Replace old String';
                        ToolTip = 'Specifies old string values to be replaced. Functionaly allows to replace string in project description and project task no. and description.';
                        ApplicationArea = All;
                    }

                    field("TKA New Text To Replace With"; NewTextToReplaceWith)
                    {
                        Caption = 'Replace with String';
                        ToolTip = 'Specifies new string values to replace with. Functionaly allows to replace string in project description and project task no. and description.';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnInitReport();
    begin
        WithProjectTasks := true;
    end;

    trigger OnPreReport();
    var
        DateMissingErr: Label 'Starting and Ending Date for newly created projects must be filled in.';
        ReplaceTextErr: Label 'Both or none of replace string fields must be filled in.';
    begin
        if ((StartingDate = 0D) or (EndingDate = 0D)) then
            Error(DateMissingErr);
        if (OldTextToReplace = '') xor (NewTextToReplaceWith = '') then
            Error(ReplaceTextErr);
    end;

    var
        StartingDate, EndingDate : Date;
        WithProjectTasks, WithoutClosedProjectTasks : Boolean;
        OldTextToReplace, NewTextToReplaceWith : Text;
}


