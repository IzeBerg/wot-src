package net.wg.gui.lobby.invites.controls
{
   import flash.display.InteractiveObject;
   import net.wg.gui.messenger.controls.ContactItem;
   import net.wg.gui.messenger.controls.ContactsDropListDelegate;
   import net.wg.gui.messenger.data.IContactItemRenderer;
   
   public class TreeDropDelegate extends ContactsDropListDelegate
   {
       
      
      public var endDropHandler:Function = null;
      
      public function TreeDropDelegate(param1:InteractiveObject, param2:String)
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
