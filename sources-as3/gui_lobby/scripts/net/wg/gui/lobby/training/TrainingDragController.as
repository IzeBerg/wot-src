package net.wg.gui.lobby.training
{
   import flash.display.InteractiveObject;
   import net.wg.data.VO.TrainingRoomRendererVO;
   import net.wg.gui.interfaces.IDropList;
   import net.wg.infrastructure.helpers.DropListDelegateCtrlr;
   import net.wg.infrastructure.helpers.interfaces.IDropListDelegate;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.entity.IDroppable;
   
   public class TrainingDragController extends DropListDelegateCtrlr
   {
       
      
      private var _isSlotDroppable:Function = null;
      
      public function TrainingDragController(param1:Vector.<InteractiveObject>, param2:Class, param3:String, param4:Function)
      {
         this._isSlotDroppable = param4;
         super(param1,param2,param3);
      }
      
      override protected function onHighlightHitAreas(param1:Boolean, param2:InteractiveObject) : void
      {
         var _loc3_:Vector.<IDropListDelegate> = null;
         var _loc4_:TrainingRoomRendererVO = null;
         var _loc5_:int = 0;
         var _loc6_:IDroppable = null;
         if(param2 is IDropItem)
         {
            if(param1)
            {
               param2.alpha = 0.3;
               _loc3_ = getDelegates();
               _loc4_ = TrainingRoomRendererVO(IDropItem(param2).data);
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if(this._isSlotDroppable(_loc4_.accID,_loc5_))
                  {
                     IDropList(_loc3_[_loc5_].getHitArea()).highlightList();
                  }
                  _loc5_++;
               }
            }
            else
            {
               if(param2)
               {
                  param2.alpha = 1;
               }
               for each(_loc6_ in getDelegates())
               {
                  IDropList(_loc6_.getHitArea()).hideHighLight();
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._isSlotDroppable = null;
         super.onDispose();
      }
   }
}
