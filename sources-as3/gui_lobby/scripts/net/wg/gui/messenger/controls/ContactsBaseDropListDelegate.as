package net.wg.gui.messenger.controls
{
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.Errors;
   import net.wg.gui.messenger.data.IContactItemRenderer;
   import net.wg.infrastructure.events.DropEvent;
   import net.wg.infrastructure.helpers.DropListDelegate;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ContactsBaseDropListDelegate extends DropListDelegate
   {
       
      
      public function ContactsBaseDropListDelegate(param1:InteractiveObject, param2:String)
      {
         super(param1,param2);
      }
      
      protected static function applySuccessStartDrop(param1:Object) : void
      {
         var _loc3_:IListItemRenderer = null;
         var _loc2_:Sprite = App.cursor.getAttachedSprite();
         if(App.instance)
         {
            _loc3_ = _loc2_ as IListItemRenderer;
            if(_loc3_)
            {
               App.utils.asserter.assertNotNull(_loc3_,"cursor.attachedSprite" + Errors.CANT_NULL);
               _loc3_.setData(param1);
               IContactItemRenderer(_loc3_).setDragStart();
            }
         }
      }
      
      [Event(name="onBeforeDrop",type="net.wg.infrastructure.events.DropEvent")]
      override public function onBeforeDrop(param1:InteractiveObject, param2:InteractiveObject) : Boolean
      {
         var _loc3_:IDropItem = param2 as IDropItem;
         if(_loc3_ != null)
         {
            if(_loc3_.getCursorType == Cursors.DRAG_OPEN)
            {
               dispatchDropEvent(DropEvent.BEFORE_DROP,param1,null,param2);
               return true;
            }
         }
         return false;
      }
   }
}
