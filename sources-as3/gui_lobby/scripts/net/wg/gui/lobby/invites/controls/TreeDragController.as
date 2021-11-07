package net.wg.gui.lobby.invites.controls
{
   import flash.display.InteractiveObject;
   import net.wg.gui.interfaces.IDropList;
   import net.wg.gui.messenger.controls.ContactsListDtagController;
   import net.wg.infrastructure.helpers.interfaces.IDropListDelegate;
   
   public class TreeDragController extends ContactsListDtagController
   {
       
      
      public function TreeDragController(param1:Function, param2:Vector.<InteractiveObject>, param3:String)
      {
         var _loc4_:IDropListDelegate = null;
         super(param2,TreeDropDelegate,param3);
         for each(_loc4_ in _delegates)
         {
            TreeDropDelegate(_loc4_).setEndDropHandler(param1);
         }
      }
      
      override protected function onHighlightHitAreas(param1:Boolean, param2:InteractiveObject) : void
      {
         super.onHighlightHitAreas(param1,param2);
         var _loc3_:IDropListDelegate = null;
         if(canBeDragged)
         {
            if(param1)
            {
               for each(_loc3_ in _delegates)
               {
                  IDropList(_loc3_.getHitArea()).highlightList();
               }
            }
            else
            {
               for each(_loc3_ in _delegates)
               {
                  IDropList(_loc3_.getHitArea()).hideHighLight();
               }
            }
         }
      }
   }
}
