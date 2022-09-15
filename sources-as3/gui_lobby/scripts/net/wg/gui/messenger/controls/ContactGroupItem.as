package net.wg.gui.messenger.controls
{
   import net.wg.gui.lobby.questsWindow.components.TreeHeader;
   import net.wg.gui.messenger.data.ContactsListGroupVO;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class ContactGroupItem extends TreeHeader implements IUpdatable
   {
       
      
      public function ContactGroupItem()
      {
         super();
      }
      
      public function update(param1:Object) : void
      {
         this.setData(new ContactsListGroupVO(param1));
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         label = ContactsListGroupVO(param1).headerDisplayTitle;
      }
      
      override protected function applyHtmlTextChanges() : void
      {
         var _loc1_:Number = slideCheckBox.textField.textWidth;
         var _loc2_:int = Math.round(slideCheckBox.textField.x + _loc1_ + (_loc1_ > 0 ? TEXT_PADDING : 0));
         htmlTF.x = _loc2_;
         htmlTF.width = _width - _loc2_;
         htmlTF.htmlText = _htmlLabel;
      }
   }
}
