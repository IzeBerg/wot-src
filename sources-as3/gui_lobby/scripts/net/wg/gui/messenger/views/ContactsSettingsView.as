package net.wg.gui.messenger.views
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.messenger.data.ContactsSettingsDataVO;
   import net.wg.gui.messenger.data.ContactsSettingsViewInitDataVO;
   import net.wg.gui.messenger.data.ContactsViewInitDataVO;
   import net.wg.gui.messenger.meta.IContactsSettingsViewMeta;
   import net.wg.gui.messenger.meta.impl.ContactsSettingsViewMeta;
   import net.wg.utils.ILocale;
   import scaleform.clik.controls.ButtonGroup;
   
   public class ContactsSettingsView extends ContactsSettingsViewMeta implements IContactsSettingsViewMeta
   {
       
      
      public var cbIsShowOfflineUsers:CheckBox;
      
      public var cbIsShowOthers:CheckBox;
      
      public var rbGroup:ButtonGroup;
      
      private var initDataReceived:Boolean = false;
      
      public function ContactsSettingsView()
      {
         super();
      }
      
      override public function getComponentForFocus() : InteractiveObject
      {
         return this.cbIsShowOfflineUsers;
      }
      
      override public function getFocusChain() : Vector.<InteractiveObject>
      {
         return new <InteractiveObject>[this.cbIsShowOfflineUsers].concat(super.getFocusChain());
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         var _loc1_:ILocale = App.utils.locale;
         this.cbIsShowOfflineUsers.label = _loc1_.makeString(MESSENGER.MESSENGER_CONTACTS_VIEW_SETTINGS_ISSHOWOFFLINEUSERS_LABEL);
         this.cbIsShowOthers.label = _loc1_.makeString(MESSENGER.MESSENGER_CONTACTS_VIEW_SETTINGS_ISSHOWOTHERS_LABEL);
         btns.btnOk.tooltip = MESSENGER.CONTACTS_SETTINGSVIEW_TOOLTIPS_BTNS_APPLY;
         btns.btnCancel.tooltip = MESSENGER.CONTACTS_SETTINGSVIEW_TOOLTIPS_BTNS_CLOSE;
      }
      
      override protected function applyInitData(param1:ContactsViewInitDataVO) : void
      {
         super.applyInitData(param1);
         var _loc2_:ContactsSettingsDataVO = ContactsSettingsViewInitDataVO(param1).mainDataVO;
         this.cbIsShowOfflineUsers.selected = _loc2_.showOfflineUsers;
         this.cbIsShowOthers.selected = _loc2_.showOthersCategory;
         if(!this.initDataReceived)
         {
            this.initDataReceived = true;
            this.rbGroup = new ButtonGroup("rbGroupName",this);
            this.cbIsShowOfflineUsers.addEventListener(Event.SELECT,this.showOfflineUsersSelectHandler,false,0,true);
            this.cbIsShowOthers.addEventListener(Event.SELECT,this.showOthersSelectHandler,false,0,true);
         }
      }
      
      override protected function getContactsViewInitDataVOForData(param1:Object) : ContactsViewInitDataVO
      {
         return new ContactsSettingsViewInitDataVO(param1);
      }
      
      override protected function onDispose() : void
      {
         if(this.rbGroup)
         {
            this.rbGroup.removeEventListener(Event.CHANGE,this.groupChangeHandler);
         }
         this.cbIsShowOfflineUsers.removeEventListener(Event.SELECT,this.showOfflineUsersSelectHandler);
         this.cbIsShowOthers.removeEventListener(Event.SELECT,this.showOthersSelectHandler);
         super.onDispose();
         this.rbGroup = null;
         this.cbIsShowOfflineUsers = null;
         this.cbIsShowOthers = null;
      }
      
      private function showOthersSelectHandler(param1:Event) : void
      {
         showOthersS(this.cbIsShowOthers.selected);
      }
      
      private function showOfflineUsersSelectHandler(param1:Event) : void
      {
         showOfflineUsersS(this.cbIsShowOfflineUsers.selected);
      }
      
      private function groupChangeHandler(param1:Event) : void
      {
         messagesNotFromContactsS(this.rbGroup.selectedIndex);
      }
   }
}
