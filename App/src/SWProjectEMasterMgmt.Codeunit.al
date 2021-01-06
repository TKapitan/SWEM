/// <summary>
/// Codeunit TKA SW Project E-Master Mgmt. (ID 81000).
/// </summary>
codeunit 81000 "TKA SW Project E-Master Mgmt."
{
    SingleInstance = true;

    var
        EmailMessage: Codeunit "Email Message";

    /// <summary>
    /// InitEmail.
    /// </summary>
    /// <param name="projectReportKey">Text[50].</param>
    /// <param name="sendToEmail">Text.</param>
    procedure InitEmail(projectReportKey: Text[50]; sendToEmail: Text)
    var
        TKAProjectDocument: Record "TKA Project Document";
    begin
        GetProjectReportSetting(projectReportKey, TKAProjectDocument);
        EmailMessage.Create(sendToEmail, TKAProjectDocument."TKA Email Subject", TKAProjectDocument."TKA Email Body");
    end;

    /// <summary>
    /// AddAttachment.
    /// </summary>
    /// <param name="ReportID">Integer.</param>
    /// <param name="FileName">Text.</param>
    /// <param name="AttachmentRecordRef">RecordRef.</param>
    procedure AddAttachment(ReportID: Integer; FileName: Text[250]; AttachmentRecordRef: RecordRef)
    var
        TempBlob: Codeunit "Temp Blob";

        AttachmentInStream: InStream;
        AttachmentOutStream: OutStream;
    begin
        TempBlob.CreateOutStream(AttachmentOutStream);
        Report.SaveAs(ReportID, '', ReportFormat::Pdf, AttachmentOutStream, AttachmentRecordRef);
        TempBlob.CreateInStream(AttachmentInStream);
        EmailMessage.AddAttachment(FileName, '', AttachmentInStream);
    end;

    /// <summary>
    /// SendEmail.
    /// </summary>
    procedure SendEmail()
    var
        Email: Codeunit Email;
    begin
        Email.Send(EmailMessage);
        Clear(EmailMessage);
    end;

    /// <summary>
    /// GetProjectReportSetting.
    /// </summary>
    /// <param name="ProjectReportKey">Text[50].</param>
    /// <param name="TKAProjectDocument">VAR Record "TKA Service Document".</param>
    procedure GetProjectReportSetting(ProjectReportKey: Text[50]; var TKAProjectDocument: Record "TKA Project Document")
    var
        TKASWProjectEMasterSetup: Record "TKA SW Project E-Master Setup";
    begin
        TKASWProjectEMasterSetup.FindFirst();
        TKASWProjectEMasterSetup.TestField("TKA Service Valid. - Report");
        case TKASWProjectEMasterSetup."TKA Service Valid. - Report" of
            TKASWProjectEMasterSetup."TKA Service Valid. - Report"::"TKA Standard ID/No/Key":
                TKAProjectDocument.Get(ProjectReportKey);
            TKASWProjectEMasterSetup."TKA Service Valid. - Report"::"TKA External ID/No/Key":
                begin
                    TKAProjectDocument.SetRange("TKA Project External ID", ProjectReportKey);
                    TKAProjectDocument.FindFirst();
                end;
        end;
        TKAProjectDocument.TestField("TKA Report Object No.");
        TKAProjectDocument.TestField("TKA Email Subject");
        TKAProjectDocument.TestField("TKA Email Body");
    end;

    // 
    // Subscribers
    // 

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInitInsert', '', false, false)]
    local procedure SalesHeaderOnBeforeInitInsert(var SalesHeader: Record "Sales Header"; xSalesHeader: Record "Sales Header"; var IsHandled: Boolean)
    var
        TKASWProjectEMasterSetup: Record "TKA SW Project E-Master Setup";

        NoSeriesManagement: Codeunit NoSeriesManagement;
    begin
        if not SalesHeader."TKA SWEM Service Order" then
            exit;

        TKASWProjectEMasterSetup.FindFirst();
        if TKASWProjectEMasterSetup."TKA Service Order Nos." <> '' then begin
            NoSeriesManagement.InitSeries(TKASWProjectEMasterSetup."TKA Service Order Nos.", xSalesHeader."No. Series", SalesHeader."Posting Date", SalesHeader."No.", SalesHeader."No. Series");
            IsHandled := true;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure SalesLineOnAfterInsertEvent()
    begin
        // TODO Post project ledger entries
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure SalesLineOnAfterDeleteEvent(var Rec: Record "Sales Line")
    var
        SalesLine: Record "Sales Line";
    begin
        SalesLine.SetRange("Document Type", Rec."Document Type");
        SalesLine.SetRange("Document No.", Rec."Document No.");
        SalesLine.SetRange("TKA Linked To Line No.", Rec."Line No.");
        SalesLine.DeleteAll(true);
        SalesLine.SetRange("TKA Linked To Line No.");

        if Rec."TKA Linked To Line No." <> 0 then begin
            SalesLine.SetRange("Line No.", Rec."TKA Linked To Line No.");
            SalesLine.DeleteAll(true);
        end;

        // TODO Post cancellation for Project Ledger Entries
    end;
}