package net.wg.gui.rally.helpers
{
   import flash.display.InteractiveObject;
   import net.wg.gui.interfaces.IDropList;
   import net.wg.infrastructure.helpers.DropListDelegateCtrlr;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.entity.IDroppable;
   
   public class RallyDragDropListDelegateController extends DropListDelegateCtrlr
   {
       
      
      public function RallyDragDropListDelegateController(param1:Vector.<InteractiveObject>, param2:Class, param3:String, param4:Function, param5:Function, param6:Function)
      {
         var _loc7_:IDroppable = null;
         super(param1,param2,param3);
         for each(_loc7_ in getDelegates())
         {
            RallyDragDropDelegate(_loc7_).setHandlers(param4,param5,param6);
         }
      }
      
      override protected function onHighlightHitAreas(param1:Boolean, param2:InteractiveObject) : void
      {
         var _loc3_:IDroppable = null;
         if(param2 is IDropItem)
         {
            if(param1)
            {
               if(param2.alpha == 1)
               {
                  param2.alpha = 0.3;
               }
            }
            else
            {
               if(param2)
               {
                  param2.alpha = 1;
               }
               for each(_loc3_ in getDelegates())
               {
                  IDropList(_loc3_.getHitArea()).hideHighLight();
               }
            }
         }
      }
      
      override protected function getPairedElementsFromVector(param1:InteractiveObject, param2:Vector.<InteractiveObject>) : Vector.<InteractiveObject>
      {
         return param2;
      }
   }
}
