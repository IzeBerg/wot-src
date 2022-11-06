from gui.miniclient.notifications.clan_applications import ClanMultiNotifPointCut, ClanSingleInviteNotifPointCut, ClanSingleAppNotifPointCut, ClanSingleNotificationHtmlTextFormatterPointCut

def configure_pointcuts():
    ClanSingleAppNotifPointCut()
    ClanSingleInviteNotifPointCut()
    ClanMultiNotifPointCut()
    ClanSingleNotificationHtmlTextFormatterPointCut()