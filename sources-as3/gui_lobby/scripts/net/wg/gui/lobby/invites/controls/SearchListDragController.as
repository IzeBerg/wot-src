package net.wg.gui.lobby.invites.controls
{
   import flash.display.InteractiveObject;
   import net.wg.gui.interfaces.IDropList;
   import net.wg.gui.messenger.controls.ContactsListBaseController;
   import net.wg.gui.messenger.data.ContactItemVO;
   import net.wg.infrastructure.helpers.interfaces.IDropListDelegate;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   
   public class SearchListDragController extends ContactsListBaseController
   {
       
      
      public function SearchListDragController(param1:Function, param2:Vector.<InteractiveObject>, param3:String)
      {
         var _loc4_:IDropListDelegate = null;
         super(param2,SearchListDropDelegate,param3);
         for each(_loc4_ in getDelegates())
         {
            SearchListDropDelegate(_loc4_).setEndDropHandler(param1);
         }
      }
      
      override protected function onHighlightHitAreas(param1:Boolean, param2:InteractiveObject) : void
      {
         var _loc4_:IDropListDelegate = null;
         var _loc5_:IDropList = null;
         var _loc3_:IDropItem = param2 as IDropItem;
         if(_loc3_ && _loc3_.data)
         {
            if(param1)
            {
               fireDragStartEvent(ContactItemVO(_loc3_.data).dbID);
            }
            else
            {
               fireDragEndEvent();
            }
            _loc4_ = null;
            if(param1)
            {
               for each(_loc4_ in getDelegates())
               {
                  _loc5_ = _loc4_.getHitArea() as IDropList;
                  if(_loc5_)
                  {
                     _loc5_.highlightList();
                  }
               }
            }
            else
            {
               for each(_loc4_ in getDelegates())
               {
                  _loc5_ = _loc4_.getHitArea() as IDropList;
                  if(_loc5_)
                  {
                     _loc5_.hideHighLight();
                  }
               }
            }
         }
         else
         {
            DebugUtils.LOG_WARNING("Passed item \'" + param2 + "\' is not of type IDropItem.");
         }
      }
   }
}
