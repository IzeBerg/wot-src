package net.wg.gui.components.questProgress.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.questProgress.QuestProgressConstsBase;
   import net.wg.gui.components.questProgress.interfaces.components.IChartProgress;
   import net.wg.gui.components.questProgress.interfaces.data.IQPInitData;
   import net.wg.gui.components.questProgress.interfaces.data.IQPProgressData;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ChartProgress extends UIComponentEx implements IChartProgress
   {
      
      private static const MIN_PERCENT:int = 0;
      
      private static const MAX_PERCENT:int = 100;
      
      private static const START_FRAME:int = 1;
       
      
      public var bounds:Sprite = null;
      
      public var failed:Sprite = null;
      
      public var completed:Sprite = null;
      
      public var progress:MovieClip = null;
      
      private var _lastVisibleState:DisplayObject = null;
      
      private var _state:int = -1;
      
      private var _isLocked:Boolean = false;
      
      public function ChartProgress()
      {
         super();
         this.failed.visible = false;
         this.completed.visible = false;
         this.progress.gotoAndStop(1);
         this.progress.visible = false;
         this._lastVisibleState = this.progress;
      }
      
      override protected function onDispose() : void
      {
         this._lastVisibleState = null;
         this.failed = null;
         this.completed = null;
         this.progress = null;
         this.bounds = null;
         super.onDispose();
      }
      
      public function getMetrics() : Rectangle
      {
         return new Rectangle(this.bounds.x,this.bounds.y,this.bounds.width,this.bounds.height);
      }
      
      public function init(param1:IQPInitData) : void
      {
      }
      
      public function unlock() : void
      {
         this.progress.filters = [];
         this._isLocked = false;
         this.updateState();
      }
      
      public function update(param1:IQPProgressData) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         this._isLocked = this._isLocked || param1.isLocked;
         if(this._state != param1.state)
         {
            this._state = param1.state;
            this.updateState();
         }
         if(this._state == QUEST_PROGRESS_BASE.IN_PROGRESS_STATE || this._state == QUEST_PROGRESS_BASE.COMPLETED_STATE && this._isLocked)
         {
            _loc2_ = param1.goal;
            _loc3_ = param1.current;
            _loc4_ = _loc3_ >= 0 && _loc2_ > 0 ? int(_loc3_ * MAX_PERCENT / _loc2_) : int(MIN_PERCENT);
            this.progress.gotoAndStop(_loc4_ + START_FRAME);
            if(this._isLocked)
            {
               this.progress.filters = [QuestProgressConstsBase.lockedFilter];
            }
         }
      }
      
      private function updateState() : void
      {
         this._lastVisibleState.visible = false;
         if(this._state == QUEST_PROGRESS_BASE.FAILED_STATE)
         {
            this.failed.visible = true;
            this._lastVisibleState = this.failed;
         }
         else if(this._state == QUEST_PROGRESS_BASE.COMPLETED_STATE && !this._isLocked)
         {
            this.completed.visible = true;
            this._lastVisibleState = this.completed;
         }
         else if(this._state == QUEST_PROGRESS_BASE.IN_PROGRESS_STATE || this._isLocked)
         {
            this.progress.visible = true;
            this._lastVisibleState = this.progress;
         }
      }
   }
}
