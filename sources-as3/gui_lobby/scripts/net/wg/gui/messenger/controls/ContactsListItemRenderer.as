package net.wg.gui.messenger.controls
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.messenger.data.ContactItemVO;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.InputEvent;
   
   public class ContactsListItemRenderer extends ContactItemRenderer
   {
      
      private static const UPDATE_DATA:String = "updD";
       
      
      private var contactItem:ContactItem;
      
      private var myData:ContactItemVO;
      
      public function ContactsListItemRenderer()
      {
         constraintsDisabled = true;
         super();
      }
      
      override public function getData() : Object
      {
         return this.myData;
      }
      
      override public function setData(param1:Object) : void
      {
         this.myData = Boolean(param1) ? (param1 is ContactItemVO ? ContactItemVO(param1) : new ContactItemVO(param1)) : null;
         invalidate(UPDATE_DATA);
      }
      
      override public function getCurrentContentItem() : UIComponent
      {
         return this.contactItem;
      }
      
      override protected function preInitialize() : void
      {
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(UPDATE_DATA))
         {
            if(this.myData)
            {
               visible = true;
               if(!this.contactItem)
               {
                  this.contactItem = App.utils.classFactory.getComponent("ContactItemUI",ContactItem);
                  this.contactItem.width = _width / scaleX;
                  this.contactItem.height = _height / scaleY;
                  this.contactItem.validateNow();
                  addChild(this.contactItem);
               }
               this.contactItem.update(this.myData);
               this.contactItem.validateNow();
            }
            else
            {
               visible = false;
            }
         }
         if(isInvalid(UPDATE_DATA) || isInvalid(DRAGGING_ITEM_INV))
         {
            alpha = !isNaN(draggedItemId) && this.contactItem != null && ContactItemVO(this.contactItem.data).dbID == draggedItemId ? Number(0.3) : Number(1);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.contactItem)
         {
            this.contactItem.dispose();
            this.contactItem = null;
         }
         super.onDispose();
      }
      
      [Inspectable(defaultValue="",type="string")]
      override public function get data() : Object
      {
         return this.myData;
      }
      
      override public function handleInput(param1:InputEvent) : void
      {
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         var _loc2_:ContactItemVO = null;
         super.handleMouseRollOver(param1);
         if(this.contactItem && this.myData)
         {
            _loc2_ = ContactItemVO(this.contactItem.data);
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.CONTACT,null,_loc2_.dbID,App.utils.commons.getFullPlayerName(_loc2_.userPropsVO));
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         App.toolTipMgr.hide();
      }
   }
}
