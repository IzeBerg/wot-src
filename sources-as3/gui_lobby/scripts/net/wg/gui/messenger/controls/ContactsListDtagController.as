package net.wg.gui.messenger.controls
{
   import flash.display.InteractiveObject;
   import net.wg.gui.messenger.data.ContactItemVO;
   import net.wg.gui.messenger.data.ITreeItemInfo;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   
   public class ContactsListDtagController extends ContactsListBaseController
   {
       
      
      protected var canBeDragged:Boolean;
      
      public function ContactsListDtagController(param1:Vector.<InteractiveObject>, param2:Class, param3:String)
      {
         super(param1,param2,param3);
      }
      
      override protected function onHighlightHitAreas(param1:Boolean, param2:InteractiveObject) : void
      {
         var _loc3_:ITreeItemInfo = ITreeItemInfo(IDropItem(param2).data);
         this.canBeDragged = !_loc3_.isBrunch && _loc3_.gui["id"] != null;
         if(this.canBeDragged)
         {
            if(param1)
            {
               fireDragStartEvent(ContactItemVO(ContactItem(ContactsTreeItemRenderer(param2).getCurrentContentItem()).data).dbID);
            }
            else
            {
               fireDragEndEvent();
            }
         }
      }
      
      override protected function getPairedElementsFromVector(param1:InteractiveObject, param2:Vector.<InteractiveObject>) : Vector.<InteractiveObject>
      {
         return param2;
      }
   }
}
