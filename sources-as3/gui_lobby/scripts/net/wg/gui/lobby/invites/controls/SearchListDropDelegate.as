package net.wg.gui.lobby.invites.controls
{
   import flash.display.InteractiveObject;
   import net.wg.gui.messenger.controls.ContactItem;
   import net.wg.gui.messenger.controls.ContactsBaseDropListDelegate;
   import net.wg.gui.messenger.data.IContactItemRenderer;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   
   public class SearchListDropDelegate extends ContactsBaseDropListDelegate
   {
       
      
      private var endDropHandler:Function = null;
      
      public function SearchListDropDelegate(param1:InteractiveObject, param2:String)
      {
         super(param1,param2);
      }
      
      [Event(name="onEndDrop",type="net.wg.infrastructure.events.DropEvent")]
      override public function onEndDrop(param1:InteractiveObject, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject) : void
      {
         super.onEndDrop(param1,param2,param3,param4);
         if(this.endDropHandler != null)
         {
            this.endDropHandler(param2,ContactItem(IContactItemRenderer(param3).getCurrentContentItem()).data);
         }
      }
      
      [Event(name="onStartDrop",type="net.wg.infrastructure.events.DropEvent")]
      override public function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:Boolean = param2 is IDropItem;
         if(_loc5_)
         {
            super.onStartDrop(param1,param2,param3,param4);
            applySuccessStartDrop(IDropItem(param2).data);
         }
         return _loc5_;
      }
      
      override protected function onDispose() : void
      {
         this.endDropHandler = null;
         super.onDispose();
      }
      
      public function setEndDropHandler(param1:Function) : void
      {
         this.endDropHandler = param1;
      }
   }
}
