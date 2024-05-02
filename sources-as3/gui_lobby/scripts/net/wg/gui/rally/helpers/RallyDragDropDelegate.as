package net.wg.gui.rally.helpers
{
   import flash.display.InteractiveObject;
   import net.wg.data.constants.Errors;
   import net.wg.gui.rally.controls.CandidatesScrollingList;
   import net.wg.gui.rally.controls.SlotDropIndicator;
   import net.wg.gui.rally.vo.RallyCandidateVO;
   import net.wg.infrastructure.helpers.DropListDelegate;
   import net.wg.infrastructure.interfaces.entity.IDropItem;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class RallyDragDropDelegate extends DropListDelegate
   {
      
      private static var s_lastFreeSlots:Array = null;
       
      
      private var _highlightingHandler:Function = null;
      
      private var _onEndDropHandler:Function = null;
      
      private var _leaveSlotHandler:Function = null;
      
      private var _playerID:Number = -1;
      
      private var id:Number = 0;
      
      public function RallyDragDropDelegate(param1:InteractiveObject, param2:String)
      {
         super(param1,param2);
         this.id = Math.round(Math.random() * 100);
      }
      
      [Event(name="onStartDrop",type="net.wg.infrastructure.events.DropEvent")]
      override public function onStartDrop(param1:InteractiveObject, param2:InteractiveObject, param3:Number, param4:Number) : Boolean
      {
         var _loc6_:IUpdatable = null;
         var _loc5_:Boolean = IDropItem(param2).data != null;
         if(_loc5_)
         {
            super.onStartDrop(param1,param2,param3,param4);
            if(App.instance)
            {
               _loc6_ = App.cursor.getAttachedSprite() as IUpdatable;
               if(_loc6_)
               {
                  App.utils.asserter.assertNotNull(_loc6_,"cursor.attachedSprite" + Errors.CANT_NULL);
                  IUpdatable(_loc6_).update(IDropItem(param2).data);
                  this._playerID = IDropItem(param2).data.dbID;
               }
               else
               {
                  DebugUtils.LOG_ERROR("attached sprite must implements IUpdatable interface.");
               }
            }
         }
         return _loc5_;
      }
      
      [Event(name="onBeforeDrop",type="net.wg.infrastructure.events.DropEvent")]
      override public function onBeforeDrop(param1:InteractiveObject, param2:InteractiveObject) : Boolean
      {
         var _loc3_:IDropItem = param2 as IDropItem;
         if(_loc3_)
         {
            if(_loc3_.data != null && !_loc3_.data.isCommander)
            {
               s_lastFreeSlots = [].concat(this._highlightingHandler(RallyCandidateVO(_loc3_.data).dbID));
               App.utils.asserter.assertNotNull(s_lastFreeSlots,"_lastFreeSlots" + Errors.CANT_NULL);
               return super.onBeforeDrop(param1,param2);
            }
            return false;
         }
         return false;
      }
      
      [Event(name="onEndDrop",type="net.wg.infrastructure.events.DropEvent")]
      override public function onEndDrop(param1:InteractiveObject, param2:InteractiveObject, param3:InteractiveObject, param4:InteractiveObject) : void
      {
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         super.onEndDrop(param1,param2,param3,param4);
         App.utils.asserter.assertNotNull(s_lastFreeSlots,"_lastFreeSlots" + Errors.CANT_NULL);
         var _loc5_:IDropItem = IDropItem(param3);
         var _loc6_:Number = Boolean(_loc5_.data) ? Number(_loc5_.data.dbID) : Number(this._playerID);
         if(param4 is SlotDropIndicator)
         {
            _loc7_ = SlotDropIndicator(param4).index;
            if(s_lastFreeSlots.indexOf(SlotDropIndicator(param4).index) != -1)
            {
               this._onEndDropHandler(_loc7_,_loc6_);
            }
         }
         else if(param2 is CandidatesScrollingList)
         {
            _loc8_ = param1 is CandidatesScrollingList;
            if(!_loc8_)
            {
               this._leaveSlotHandler(_loc6_);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._highlightingHandler = null;
         this._onEndDropHandler = null;
         this._leaveSlotHandler = null;
         super.onDispose();
      }
      
      public function setHandlers(param1:Function, param2:Function, param3:Function) : void
      {
         this._highlightingHandler = param1;
         this._onEndDropHandler = param2;
         this._leaveSlotHandler = param3;
      }
   }
}
