package net.wg.gui.messenger.views
{
   import net.wg.gui.messenger.data.ContactListMainInfo;
   import net.wg.gui.messenger.data.ContactUserPropVO;
   import net.wg.gui.messenger.meta.IBaseManageContactViewMeta;
   import net.wg.gui.messenger.meta.IContactNoteManageViewMeta;
   import net.wg.gui.messenger.meta.impl.ContactNoteManageViewMeta;
   
   public class ContactNoteManageView extends ContactNoteManageViewMeta implements IContactNoteManageViewMeta, IBaseManageContactViewMeta
   {
       
      
      public function ContactNoteManageView()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         input.textField.multiline = true;
         input.textField.wordWrap = true;
      }
      
      override public function update(param1:Object) : void
      {
         var _loc2_:ContactListMainInfo = null;
         if(param1)
         {
            _loc2_ = ContactListMainInfo(param1);
            sendDataS({
               "name":_loc2_.name,
               "dbID":_loc2_.dbID
            });
         }
         super.update(param1);
      }
      
      override public function as_setInputText(param1:String) : void
      {
         input.text = param1;
      }
      
      override public function as_setLabel(param1:String) : void
      {
      }
      
      override protected function setUserProps(param1:ContactUserPropVO) : void
      {
         App.utils.commons.formatPlayerName(txtLabel,param1);
         txtLabel.htmlText = App.utils.locale.makeString(MESSENGER.MESSENGER_CONTACTS_VIEW_EDITNOTE_USERNAME) + txtLabel.htmlText;
      }
   }
}
