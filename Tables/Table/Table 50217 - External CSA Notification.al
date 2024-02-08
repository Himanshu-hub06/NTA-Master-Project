table 50217 "External CSA Notification"
{
    ExternalName = 'CSA_NotificationAlerts';
    ExternalSchema = 'dbo';
    TableType = ExternalSQL;

    fields
    {
        field(1; "Notification ID"; Integer)
        {
            AutoIncrement = true;
            DataClassification = ToBeClassified;
            ExternalName = 'PK_NotificationId';
        }
        field(2; "Module ID"; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'FK_ModuleId';
        }
        field(3; "View ID"; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'FK_ViewId';
        }
        field(4; "Action ID"; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'FK_ActionId';
        }
        field(5; "Sender ID"; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'FK_SenderUserId';
        }
        field(6; "Receiver ID"; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'FK_RecieverUserId';
        }
        field(7; "Notification Type"; Text[10])
        {
            DataClassification = ToBeClassified;
            ExternalName = 'NotificationType';
        }
        field(8; Status; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'Status';
        }
        field(9; Message; Text[250])
        {
            DataClassification = ToBeClassified;
            ExternalName = 'Message';
        }
        field(10; "Read Status"; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'ReadStatus';
        }
        field(11; "Last Modified on"; DateTime)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'LastModifiedOn';
        }
        field(12; "Last Modified by"; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'LastModifiedBy';
        }
        field(13; IsActive; Integer)
        {
            DataClassification = ToBeClassified;
            ExternalName = 'IsActive';
        }
    }

    keys
    {
        key(Key1; "Notification ID")
        {
        }
    }

    fieldgroups
    {
    }
}

