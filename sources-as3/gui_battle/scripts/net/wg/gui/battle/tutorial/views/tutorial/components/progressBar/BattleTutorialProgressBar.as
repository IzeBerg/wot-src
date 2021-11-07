package net.wg.gui.battle.tutorial.views.tutorial.components.progressBar
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.utils.IClassFactory;
   
   public class BattleTutorialProgressBar extends BattleUIComponent
   {
      
      public static const PHASE_DEFAULT_ID:int = 0;
      
      public static const PHASE_FAIL_ID:int = 1;
      
      public static const PHASE_NONE_ID:int = 2;
      
      public static const PHASE_DONE_ID:int = 3;
      
      public static const PHASE_CURRENT_ID:int = 4;
      
      private static const MASK:int = 3;
       
      
      public var textField:TextField = null;
      
      private const DEFAULT_X:int = 4;
      
      private const DEFAULT_LINE_Y:int = 22;
      
      private const DEFAULT_Y:int = 23;
      
      private const DEFAULT_WIDTH:int = 323;
      
      private const SEPARATOR_SHIFT:int = -2;
      
      private const ITEM_LABEL_WIDTH:int = 22;
      
      private const LAST_TASK_ADDITIONAL_WIDTH_SHIFT:int = 1;
      
      private const ITEM_LABEL_SHIFT:int = 4;
      
      private var _labels:Vector.<BattleProgressItemLabel>;
      
      private var _itemLabelsStorage:Vector.<BattleProgressItemLabel>;
      
      private var _taskSeparators:Vector.<Sprite>;
      
      private var _itemSeparatorsStorage:Vector.<Sprite>;
      
      private var _phases:Vector.<BattleProgressItemLine>;
      
      private var _itemLinesStorage:Vector.<BattleProgressItemLine>;
      
      private var _tasks:Vector.<BattleProgressItemLine>;
      
      private var _currentPhase:int = -1;
      
      private var _phasesCount:int = -1;
      
      private var _phaseStatusMask:int = -1;
      
      private var _phaseWidth:Number = -1;
      
      private var _allTasks:int = -1;
      
      private var _tasksStatusMask:int = -1;
      
      private var _classFactory:IClassFactory;
      
      public function BattleTutorialProgressBar()
      {
         this._labels = new Vector.<BattleProgressItemLabel>();
         this._itemLabelsStorage = new Vector.<BattleProgressItemLabel>();
         this._taskSeparators = new Vector.<Sprite>();
         this._itemSeparatorsStorage = new Vector.<Sprite>();
         this._phases = new Vector.<BattleProgressItemLine>();
         this._itemLinesStorage = new Vector.<BattleProgressItemLine>();
         this._tasks = new Vector.<BattleProgressItemLine>();
         this._classFactory = App.utils.classFactory;
         super();
         this.textField.text = BATTLE_TUTORIAL.GUI_PROGRESS_BAR_TITLE;
      }
      
      public function populateProgressBar(param1:int, param2:int) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         if(this._phasesCount != param2)
         {
            this._phasesCount = param2;
            this.rebuildPhases();
            _loc3_ = true;
         }
         if(this._currentPhase != param1)
         {
            this._currentPhase = param1;
            _loc4_ = true;
         }
         if(_loc3_ || _loc4_)
         {
            this.rebuildTasks();
            this.setupPhases();
            this.setupTasks();
         }
      }
      
      public function setPhasesStatusMask(param1:int) : void
      {
         this._phaseStatusMask = param1;
         this.setupPhases();
         this.setupTasks();
      }
      
      private function rebuildPhases() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:BattleProgressItemLabel = null;
         var _loc3_:BattleProgressItemLine = null;
         var _loc4_:Sprite = null;
         this.returnLabelsToStorage(this._labels);
         this.returnLinesToStorage(this._phases);
         this.returnSeparatorsToStorage(this._taskSeparators);
         this._phaseWidth = this.DEFAULT_WIDTH / this._phasesCount;
         var _loc5_:int = 0;
         while(_loc5_ < this._phasesCount)
         {
            _loc1_ = this.DEFAULT_X + this._phaseWidth * _loc5_;
            if(_loc5_ != 0)
            {
               _loc4_ = this.getSeparator();
               _loc4_.x = _loc1_ + this.SEPARATOR_SHIFT ^ 0;
               _loc4_.y = this.DEFAULT_Y;
               this._taskSeparators.push(_loc4_);
               addChild(_loc4_);
            }
            _loc2_ = this.getLabel();
            _loc2_.x = _loc1_ + (this._phaseWidth - this.ITEM_LABEL_WIDTH >> 1) ^ 0;
            _loc2_.y = this.DEFAULT_Y + this.ITEM_LABEL_SHIFT;
            _loc2_.updateLabelText(String(_loc5_ + 1));
            this._labels.push(_loc2_);
            addChild(_loc2_);
            _loc3_ = this.getLine();
            _loc3_.x = _loc1_ ^ 0;
            _loc3_.y = this.DEFAULT_LINE_Y;
            _loc3_.width = this._phaseWidth ^ 0;
            this._phases.push(_loc3_);
            addChild(_loc3_);
            _loc5_++;
         }
      }
      
      private function setupPhases() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(this._phaseStatusMask != Values.DEFAULT_INT)
         {
            _loc1_ = MASK;
            _loc3_ = this._phases.length;
            _loc4_ = 0;
            while(_loc4_ < _loc3_)
            {
               _loc2_ = (_loc1_ & this._phaseStatusMask) >> 2 * _loc4_;
               this._phases[_loc4_].setPhase(_loc2_);
               this._labels[_loc4_].setPhase(this._currentPhase == _loc4_ ? int(PHASE_CURRENT_ID) : int(_loc2_));
               _loc1_ <<= 2;
               _loc4_++;
            }
         }
      }
      
      public function setTasks(param1:int, param2:int) : void
      {
         if(this._allTasks != param1)
         {
            this._allTasks = param1;
            this.rebuildTasks();
         }
         if(this._tasksStatusMask != param2)
         {
            this._tasksStatusMask = param2;
            this.setupPhases();
            this.setupTasks();
         }
      }
      
      private function setupTasks() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(this._currentPhase != Values.DEFAULT_INT && this._tasksStatusMask != Values.DEFAULT_INT)
         {
            _loc1_ = MASK;
            _loc2_ = this._tasks.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               this._tasks[_loc3_].setPhase((_loc1_ & this._tasksStatusMask) >> 2 * _loc3_);
               _loc1_ <<= 2;
               _loc3_++;
            }
         }
      }
      
      private function rebuildTasks() : void
      {
         var _loc4_:BattleProgressItemLine = null;
         this.returnLinesToStorage(this._tasks);
         var _loc1_:Number = this.DEFAULT_X + this._phaseWidth * this._currentPhase;
         var _loc2_:Number = this._phaseWidth / this._allTasks;
         var _loc3_:int = this._phaseWidth % this._allTasks - this.LAST_TASK_ADDITIONAL_WIDTH_SHIFT;
         var _loc5_:int = 0;
         while(_loc5_ < this._allTasks)
         {
            _loc4_ = this.getLine();
            _loc4_.x = _loc1_ + _loc5_ * _loc2_ ^ 0;
            _loc4_.y = this.DEFAULT_LINE_Y;
            _loc4_.width = _loc5_ == this._allTasks - 1 ? Number(_loc3_ + _loc2_) : Number(_loc2_);
            this._tasks.push(_loc4_);
            addChild(_loc4_);
            _loc5_++;
         }
      }
      
      private function clearSpriteVector(param1:Vector.<Sprite>) : void
      {
         var _loc2_:Sprite = null;
         for each(_loc2_ in param1)
         {
            removeChild(_loc2_);
         }
         param1.splice(0,param1.length);
      }
      
      private function clearLabelVector(param1:Vector.<BattleProgressItemLabel>) : void
      {
         var _loc2_:BattleProgressItemLabel = null;
         for each(_loc2_ in param1)
         {
            _loc2_.dispose();
            removeChild(_loc2_);
         }
         param1.splice(0,param1.length);
      }
      
      private function clearLineVector(param1:Vector.<BattleProgressItemLine>) : void
      {
         var _loc2_:BattleProgressItemLine = null;
         for each(_loc2_ in param1)
         {
            _loc2_.dispose();
            removeChild(_loc2_);
         }
         param1.splice(0,param1.length);
      }
      
      private function returnLabelsToStorage(param1:Vector.<BattleProgressItemLabel>) : void
      {
         this._itemLabelsStorage = this._itemLabelsStorage.concat(param1);
         param1.splice(0,param1.length);
      }
      
      private function returnLinesToStorage(param1:Vector.<BattleProgressItemLine>) : void
      {
         this._itemLinesStorage = this._itemLinesStorage.concat(param1);
         param1.splice(0,param1.length);
      }
      
      private function returnSeparatorsToStorage(param1:Vector.<Sprite>) : void
      {
         this._itemSeparatorsStorage = this._itemSeparatorsStorage.concat(param1);
         param1.splice(0,param1.length);
      }
      
      private function getLabel() : BattleProgressItemLabel
      {
         var _loc1_:BattleProgressItemLabel = null;
         if(this._itemLabelsStorage.length > 0)
         {
            _loc1_ = this._itemLabelsStorage.pop();
            _loc1_.setPhase(PHASE_DEFAULT_ID);
         }
         else
         {
            _loc1_ = BattleProgressItemLabel(this._classFactory.getObject(Linkages.BATTLE_PROGRESS_ITEM_LABEL));
         }
         return _loc1_;
      }
      
      private function getSeparator() : Sprite
      {
         var _loc1_:Sprite = null;
         if(this._itemSeparatorsStorage.length > 0)
         {
            _loc1_ = this._itemSeparatorsStorage.pop();
         }
         else
         {
            _loc1_ = Sprite(this._classFactory.getObject(Linkages.BATTLE_PROGRESS_TASK_SEPARATOR));
         }
         return _loc1_;
      }
      
      private function getLine() : BattleProgressItemLine
      {
         var _loc1_:BattleProgressItemLine = null;
         if(this._itemLinesStorage.length > 0)
         {
            _loc1_ = this._itemLinesStorage.pop();
            _loc1_.reset();
         }
         else
         {
            _loc1_ = BattleProgressItemLine(this._classFactory.getObject(Linkages.BATTLE_PROGRESS_ITEM_LINE));
         }
         return _loc1_;
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this._classFactory = null;
         this.clearLabelVector(this._labels);
         this._labels = null;
         this.clearLineVector(this._phases);
         this._phases = null;
         this.clearSpriteVector(this._taskSeparators);
         this._taskSeparators = null;
         this.clearLineVector(this._tasks);
         this._tasks = null;
         this.clearLabelVector(this._itemLabelsStorage);
         this._itemLabelsStorage = null;
         this.clearLineVector(this._itemLinesStorage);
         this._itemLinesStorage = null;
         this.clearSpriteVector(this._itemSeparatorsStorage);
         this._itemSeparatorsStorage = null;
         super.onDispose();
      }
   }
}
