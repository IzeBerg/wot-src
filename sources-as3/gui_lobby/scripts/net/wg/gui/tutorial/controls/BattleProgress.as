package net.wg.gui.tutorial.controls
{
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class BattleProgress extends UIComponentEx
   {
      
      private static const PHASE_DONE:String = "done";
      
      private static const PHASE_FAIL:String = "fail";
      
      private static const PHASE_NONE:String = "none";
      
      private static const MASK:uint = 3;
      
      private static const BODY_WIDTH_CORRECTION:Number = 8;
       
      
      public var progressItemRenderer:String = "BattleProgressItem";
      
      public var separatorRenderer:String = "BattleSeparator";
      
      private var _curPhase:Number = -1;
      
      private var _allPhases:Number = 0;
      
      private var _phaseStatusMask:Number;
      
      private var _allTasks:Number = 0;
      
      private var _tasksStatusMask:Number;
      
      public var background:MovieClip;
      
      public var phasesContainer:Sprite;
      
      public var tasksContainer:Sprite;
      
      public var separatorsContainer:Sprite;
      
      private var separatorItems:Array;
      
      private var taskItems:Array;
      
      private var phaseItems:Array;
      
      private var _phaseWidth:Number;
      
      private var _bodyWidth:Number;
      
      public function BattleProgress()
      {
         this.separatorItems = [];
         this.taskItems = [];
         this.phaseItems = [];
         super();
         this._bodyWidth = this.background.width - BODY_WIDTH_CORRECTION;
      }
      
      override protected function draw() : void
      {
         super.draw();
         this.setupPhases();
         this.setupTasks();
      }
      
      override protected function onDispose() : void
      {
         this.clearItems(this.separatorsContainer,this.separatorItems);
         this.clearItems(this.phasesContainer,this.phaseItems);
         this.clearItems(this.tasksContainer,this.taskItems);
         super.onDispose();
      }
      
      public function populateUI(param1:Number, param2:Number) : void
      {
         if(this._allPhases != param2)
         {
            this._allPhases = param2;
            this.rebuildPhases();
            this.rebuildTasks();
            invalidate();
         }
         if(this._curPhase != param1)
         {
            this._curPhase = param1;
            this.rebuildTasks();
            invalidate();
         }
      }
      
      public function setPhases(param1:Number) : void
      {
         this._phaseStatusMask = param1;
         invalidate();
      }
      
      public function setTasks(param1:Number, param2:Number) : void
      {
         if(this._allTasks != param1)
         {
            this._allTasks = param1;
            this.rebuildTasks();
         }
         if(this._tasksStatusMask != param2)
         {
            this._tasksStatusMask = param2;
            invalidate();
         }
      }
      
      private function rebuildPhases() : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:ProgressSeparator = null;
         var _loc4_:ProgressItem = null;
         this.clearItems(this.separatorsContainer,this.separatorItems);
         this.clearItems(this.phasesContainer,this.phaseItems);
         this._phaseWidth = this._bodyWidth / this._allPhases;
         var _loc1_:int = 0;
         while(_loc1_ < this._allPhases)
         {
            _loc2_ = this._phaseWidth * _loc1_ ^ 0;
            _loc3_ = this.createInstance(this.separatorsContainer,this.separatorRenderer) as ProgressSeparator;
            App.utils.asserter.assertNotNull(_loc3_,"separatorItem" + Errors.CANT_NULL);
            _loc3_.x = _loc2_;
            _loc3_.setup(_loc1_,this._phaseWidth);
            this.separatorItems.push(_loc3_);
            _loc4_ = this.createInstance(this.phasesContainer,this.progressItemRenderer) as ProgressItem;
            App.utils.asserter.assertNotNull(_loc4_,"phaseItem" + Errors.CANT_NULL);
            _loc4_.x = _loc2_;
            _loc4_.width = this._phaseWidth;
            this.phaseItems.push(_loc4_);
            _loc1_++;
         }
      }
      
      private function setupPhases() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:ProgressItem = null;
         var _loc4_:ProgressSeparator = null;
         var _loc5_:String = null;
         if(!isNaN(this._phaseStatusMask) && this.phaseItems != null)
         {
            _loc1_ = MASK;
            _loc2_ = 0;
            while(_loc2_ < this.phaseItems.length)
            {
               _loc3_ = this.phaseItems[_loc2_];
               _loc4_ = this.separatorItems[_loc2_];
               _loc5_ = this.getLineStatus((_loc1_ & this._phaseStatusMask) >> 2 * _loc2_);
               _loc3_.setPhase(_loc5_);
               _loc4_.gotoAndStop(this._curPhase == _loc2_ ? "current" : _loc3_.phaseFrame);
               _loc4_.setup(_loc2_,this._phaseWidth);
               _loc1_ <<= 2;
               _loc2_++;
            }
         }
      }
      
      private function setupTasks() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:int = 0;
         var _loc3_:ProgressItem = null;
         var _loc4_:String = null;
         if(this._curPhase > -1 && !isNaN(this._tasksStatusMask))
         {
            _loc1_ = MASK;
            _loc2_ = 0;
            while(_loc2_ < this.taskItems.length)
            {
               _loc3_ = this.taskItems[_loc2_];
               _loc4_ = this.getLineStatus((_loc1_ & this._tasksStatusMask) >> 2 * _loc2_);
               _loc3_.setPhase(_loc4_);
               _loc3_.highlight();
               _loc1_ <<= 2;
               _loc2_++;
            }
         }
      }
      
      private function rebuildTasks() : void
      {
         var _loc4_:ProgressItem = null;
         this.clearItems(this.tasksContainer,this.taskItems);
         var _loc1_:Number = this._phaseWidth * this._curPhase ^ 0;
         var _loc2_:Number = this._phaseWidth / this._allTasks ^ 0;
         var _loc3_:int = 0;
         while(_loc3_ < this._allTasks)
         {
            _loc4_ = this.createInstance(this.tasksContainer,this.progressItemRenderer) as ProgressItem;
            App.utils.asserter.assertNotNull(_loc4_,"taskItem" + Errors.CANT_NULL);
            _loc4_.x = _loc1_ + _loc3_ * _loc2_;
            _loc4_.width = _loc3_ == this._allTasks - 1 ? Number((this._phaseWidth % this._allTasks ^ 0) + _loc2_) : Number(_loc2_);
            this.taskItems.push(_loc4_);
            _loc3_++;
         }
      }
      
      private function getLineStatus(param1:Number) : String
      {
         var _loc2_:String = PHASE_NONE;
         switch(param1)
         {
            case 0:
               _loc2_ = PHASE_NONE;
               break;
            case 1:
               _loc2_ = PHASE_FAIL;
               break;
            case 2:
               _loc2_ = PHASE_NONE;
               break;
            case 3:
               _loc2_ = PHASE_DONE;
         }
         return _loc2_;
      }
      
      public function createInstance(param1:DisplayObjectContainer, param2:String) : MovieClip
      {
         var _loc3_:MovieClip = null;
         _loc3_ = App.utils.classFactory.getComponent(param2,MovieClip) as MovieClip;
         if(_loc3_)
         {
            param1.addChild(_loc3_);
         }
         return _loc3_;
      }
      
      private function clearItems(param1:Sprite, param2:Array) : void
      {
         while(param1.numChildren)
         {
            param1.removeChildAt(0);
         }
         param2.splice(0,param2.legth);
      }
   }
}
