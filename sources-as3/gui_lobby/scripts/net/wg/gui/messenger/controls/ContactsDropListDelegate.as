package net.wg.gui.messenger.controls
{
   import flash.display.InteractiveObject;
   import net.wg.gui.messenger.data.ITreeItemInfo;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   
   public class ContactsDropListDelegate extends ContactsBaseDropListDelegate
   {
       
      
      public function ContactsDropListDelegate(param1:InteractiveObject, param2:String)
      {
         super(param1,param2);
      }
      
      [Event(name="onStartDrop",type="net.wg.infrastructure.events.DropEvent")]
      override public function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number) : Boolean
      {
         var _loc5_:ITreeItemInfo = ITreeItemInfo(IDropItem(param2).data);
         var _loc6_:Boolean = !_loc5_.isBrunch && _loc5_.gui["id"] != null;
         if(_loc6_)
         {
            super.onStartDrop(param1,param2,param3,param4);
            applySuccessStartDrop(_loc5_);
         }
         return _loc6_;
      }
   }
}
