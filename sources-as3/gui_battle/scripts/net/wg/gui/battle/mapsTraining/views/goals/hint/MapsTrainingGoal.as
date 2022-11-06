package net.wg.gui.battle.mapsTraining.views.goals.hint
{
   import flash.display.Sprite;
   import net.wg.gui.battle.mapsTraining.views.goals.data.MapsTrainingGoalVO;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.utils.IScheduler;
   
   public class MapsTrainingGoal extends Sprite implements IDisposable
   {
      
      private static const GOAL_LINKAGE:String = "GoalItemUI";
      
      private static const GOAL_GAP:int = 52;
      
      private static const SUFFIX_DESTROYED:String = "_destroyed";
      
      private static const DESTROY_LAYOUT_DELAY:int = 500;
       
      
      public var container:Sprite = null;
      
      private var _items:Vector.<MapsTrainingGoalItem>;
      
      private var _destroyedItems:Vector.<MapsTrainingGoalItem>;
      
      private var _scheduler:IScheduler;
      
      private var _isColorBlind:Boolean = false;
      
      private var _colorMgr:IColorSchemeManager;
      
      private var _disposed:Boolean = false;
      
      public function MapsTrainingGoal()
      {
         this._items = new Vector.<MapsTrainingGoalItem>();
         this._destroyedItems = new Vector.<MapsTrainingGoalItem>();
         this._scheduler = App.utils.scheduler;
         this._colorMgr = App.colorSchemeMgr;
         super();
         this._isColorBlind = this._colorMgr.getIsColorBlindS();
         this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
      }
      
      public function createGoals(param1:Vector.<MapsTrainingGoalVO>) : void
      {
         var _loc2_:MapsTrainingGoalVO = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:MapsTrainingGoalItem = null;
         this.clearGoals();
         for each(_loc2_ in param1)
         {
            _loc3_ = _loc2_.total;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc5_ = App.utils.classFactory.getObject(GOAL_LINKAGE) as MapsTrainingGoalItem;
               _loc5_.gotoAndStop(_loc2_.vehClass);
               _loc5_.mouseEnabled = _loc5_.mouseChildren = false;
               this.container.addChild(_loc5_);
               this._items.push(_loc5_);
               _loc4_++;
            }
         }
         this.setColorBlind();
         this.layoutItems();
      }
      
      public function destroyGoal(param1:String) : void
      {
         var _loc2_:MapsTrainingGoalItem = null;
         for each(_loc2_ in this._items)
         {
            if(_loc2_.currentLabel == param1)
            {
               _loc2_.gotoAndPlay(param1 + SUFFIX_DESTROYED);
               this._scheduler.scheduleTask(this.markDestroyed,DESTROY_LAYOUT_DELAY,_loc2_);
               break;
            }
         }
      }
      
      public function clearGoals() : void
      {
         var _loc1_:MapsTrainingGoalItem = null;
         this._scheduler.cancelTask(this.markDestroyed);
         for each(_loc1_ in this._items)
         {
            this.container.removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._items.splice(0,this._items.length);
         this._destroyedItems.splice(0,this._destroyedItems.length);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.clearGoals();
         this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorSchemasUpdatedHandler);
         this._colorMgr = null;
         this._items = null;
         this._destroyedItems = null;
         this.container = null;
         this._scheduler = null;
      }
      
      public function set offset(param1:int) : void
      {
         this.container.y = param1;
      }
      
      public function set scale(param1:Number) : void
      {
         this.container.scaleX = this.container.scaleY = param1;
      }
      
      private function markDestroyed(param1:MapsTrainingGoalItem) : void
      {
         this._destroyedItems.push(param1);
         this.layoutItems();
      }
      
      private function layoutItems() : void
      {
         var _loc5_:MapsTrainingGoalItem = null;
         var _loc1_:int = this._items.length;
         var _loc2_:int = -((_loc1_ + 1) * GOAL_GAP) >> 1;
         var _loc3_:int = _loc2_ + GOAL_GAP * (_loc1_ - this._destroyedItems.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc5_ = this._items[_loc4_];
            if(this._destroyedItems.indexOf(_loc5_) != -1)
            {
               _loc5_.x = _loc3_ = _loc3_ + GOAL_GAP;
            }
            else
            {
               _loc5_.x = _loc2_ = _loc2_ + GOAL_GAP;
            }
            _loc4_++;
         }
      }
      
      private function setColorBlind() : void
      {
         var _loc1_:MapsTrainingGoalItem = null;
         for each(_loc1_ in this._items)
         {
            _loc1_.setColorBlind(this._isColorBlind);
         }
      }
      
      private function onColorSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this._isColorBlind = this._colorMgr.getIsColorBlindS();
         this.setColorBlind();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
