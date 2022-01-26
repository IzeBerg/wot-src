package net.wg.gui.lobby.battleResults.epic
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.battleResults.epic.vo.EpicQuestProgressInfoItemVO;
   import net.wg.infrastructure.base.meta.IEpicQuestProgressInfoMeta;
   import net.wg.infrastructure.base.meta.impl.EpicQuestProgressInfoMeta;
   import net.wg.utils.IClassFactory;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicQuestProgressInfo extends EpicQuestProgressInfoMeta implements IEpicQuestProgressInfoMeta
   {
      
      private static const SUBTASKS_SIZE:String = "invSubtasksSize";
      
      private static const COMPONENT_WIDTH:int = 981;
      
      private static const REWARD_COMPONENT_WIDTH:int = 490;
      
      private static const REWARDS_X_GAP:int = 1;
      
      private static const REWARD_FULL_WIDTH:int = REWARD_COMPONENT_WIDTH + REWARDS_X_GAP;
       
      
      private var _data:Vector.<EpicQuestProgressInfoItemVO> = null;
      
      private var _tasks:Vector.<EpicBattleResultsEventRenderer>;
      
      public function EpicQuestProgressInfo()
      {
         super();
         this._tasks = new Vector.<EpicBattleResultsEventRenderer>();
      }
      
      override protected function onDispose() : void
      {
         this.clearTasks();
         this._tasks = null;
         if(this._data)
         {
            this._data = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.createTasks();
            invalidate(SUBTASKS_SIZE);
         }
         if(isInvalid(SUBTASKS_SIZE))
         {
            this.layoutTasks();
         }
      }
      
      override protected function updateData(param1:Vector.<EpicQuestProgressInfoItemVO>) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      protected function layoutTasks() : void
      {
         var _loc4_:EpicBattleResultsEventRenderer = null;
         var _loc1_:int = this._tasks.length;
         var _loc2_:int = this._tasks && _loc1_ > 1 ? int(1) : int(0);
         var _loc3_:int = COMPONENT_WIDTH - _loc1_ * REWARD_FULL_WIDTH + _loc2_ * REWARDS_X_GAP >> 1;
         for each(_loc4_ in this._tasks)
         {
            _loc4_.x = _loc3_;
            _loc3_ += REWARD_FULL_WIDTH;
         }
         setSize(COMPONENT_WIDTH,this.height);
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function clearTasks() : void
      {
         var _loc1_:EpicBattleResultsEventRenderer = null;
         for each(_loc1_ in this._tasks)
         {
            _loc1_.removeEventListener(Event.RESIZE,this.onTaskResizeHandler);
            _loc1_.dispose();
            removeChild(DisplayObject(_loc1_));
         }
         App.instance.utils.data.cleanupDynamicObject(this._tasks);
      }
      
      private function createTasks() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:EpicBattleResultsEventRenderer = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:IClassFactory = null;
         var _loc7_:int = 0;
         var _loc8_:EpicBattleResultsEventRenderer = null;
         if(this._data != null)
         {
            _loc1_ = this._data.length;
            _loc2_ = this._tasks.length;
            _loc3_ = null;
            if(this._tasks.length < _loc1_)
            {
               _loc5_ = _loc1_ - _loc2_;
               _loc6_ = App.utils.classFactory;
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  _loc3_ = _loc6_.getComponent(Linkages.EPIC_REWARD_COMPONENT_RENDERER_UI,EpicBattleResultsEventRenderer);
                  _loc3_.addEventListener(Event.RESIZE,this.onTaskResizeHandler);
                  this._tasks.push(_loc3_);
                  addChild(DisplayObject(_loc3_));
                  _loc2_++;
                  _loc7_++;
               }
            }
            else if(_loc2_ > _loc1_)
            {
               while(this._tasks.length > _loc1_)
               {
                  _loc8_ = this._tasks.pop();
                  _loc8_.removeEventListener(Event.RESIZE,this.onTaskResizeHandler);
                  _loc8_.dispose();
                  removeChild(DisplayObject(_loc8_));
               }
            }
            _loc4_ = 0;
            while(_loc4_ < _loc1_)
            {
               _loc3_ = this._tasks[_loc4_];
               _loc3_.setData(this._data[_loc4_]);
               _loc3_.validateNow();
               _loc4_++;
            }
         }
         else
         {
            this.clearTasks();
         }
      }
      
      private function onTaskResizeHandler(param1:Event) : void
      {
         invalidate(SUBTASKS_SIZE);
      }
   }
}
