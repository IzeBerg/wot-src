package net.wg.gui.bootcamp.introVideoPage.containers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StepperContainer extends Sprite implements IDisposable
   {
      
      private static const RENDERER_CLASS_NAME:String = "stepperUI";
      
      private static const ACTIVE_STATE:String = "activate";
      
      private static const HOVER_STATE:String = "hover";
      
      private static const UNHOVER_STATE:String = "unhover";
      
      private static const UNACTIVE_STATE:String = "deactivate";
      
      private static const STEPPER_PADDING:int = -1;
       
      
      private var _stepperList:Vector.<MovieClip>;
      
      private var _prevStepper:MovieClip = null;
      
      private var _disposed:Boolean = false;
      
      private var _selectedStepper:int = 0;
      
      public function StepperContainer()
      {
         this._stepperList = new Vector.<MovieClip>();
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.disposeStepperList();
         this._stepperList = null;
         this._prevStepper = null;
      }
      
      public function disposeStepperList() : void
      {
         var _loc1_:uint = this._stepperList.length;
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._stepperList[_loc3_];
            _loc2_.removeEventListener(MouseEvent.ROLL_OVER,this.onStepperRollOverHandler);
            _loc2_.removeEventListener(MouseEvent.ROLL_OUT,this.onStepperRollOutHandler);
            _loc3_++;
         }
         this._stepperList.splice(0,this._stepperList.length);
      }
      
      public function getStepperIndex(param1:MovieClip) : int
      {
         return this._stepperList.indexOf(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function selectItem(param1:int) : void
      {
         this._selectedStepper = param1;
         if(this._prevStepper)
         {
            this._prevStepper.gotoAndPlay(UNACTIVE_STATE);
         }
         if(param1 >= 0 && param1 < this._stepperList.length)
         {
            this._stepperList[param1].gotoAndPlay(ACTIVE_STATE);
            this._prevStepper = this._stepperList[param1];
         }
      }
      
      public function setButtonMode() : void
      {
         buttonMode = true;
         var _loc1_:uint = this._stepperList.length;
         var _loc2_:MovieClip = null;
         var _loc3_:uint = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._stepperList[_loc3_];
            _loc2_.mouseChildren = false;
            _loc2_.useHandCursor = _loc2_.buttonMode = true;
            _loc2_.addEventListener(MouseEvent.ROLL_OVER,this.onStepperRollOverHandler);
            _loc2_.addEventListener(MouseEvent.ROLL_OUT,this.onStepperRollOutHandler);
            _loc3_++;
         }
      }
      
      public function setCount(param1:int) : void
      {
         var _loc3_:MovieClip = null;
         this.disposeStepperList();
         var _loc2_:uint = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = App.utils.classFactory.getComponent(RENDERER_CLASS_NAME,MovieClip);
            if(buttonMode)
            {
               _loc3_.mouseChildren = false;
               _loc3_.useHandCursor = _loc3_.buttonMode = true;
            }
            this._stepperList.push(_loc3_);
            if(_loc2_ > 0)
            {
               this._stepperList[_loc2_].x = this._stepperList[_loc2_ - 1].x + this._stepperList[_loc2_ - 1].width + STEPPER_PADDING;
            }
            addChild(this._stepperList[_loc2_]);
            _loc2_++;
         }
      }
      
      private function onStepperRollOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:int = this.getStepperIndex(_loc2_);
         if(buttonMode && _loc2_.currentLabel == HOVER_STATE)
         {
            _loc2_.gotoAndPlay(_loc3_ == this._selectedStepper ? ACTIVE_STATE : UNHOVER_STATE);
         }
      }
      
      private function onStepperRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:MovieClip = param1.target as MovieClip;
         var _loc3_:int = this.getStepperIndex(_loc2_);
         if(buttonMode && _loc3_ != this._selectedStepper)
         {
            _loc2_.gotoAndPlay(HOVER_STATE);
         }
      }
   }
}
