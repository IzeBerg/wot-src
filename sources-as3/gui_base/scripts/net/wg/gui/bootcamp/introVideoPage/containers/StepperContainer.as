package net.wg.gui.bootcamp.introVideoPage.containers
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class StepperContainer extends Sprite implements IDisposable
   {
      
      private static const RENDERER_CLASS_NAME:String = "stepperUI";
      
      private static const ACTIVE_STATE:String = "activate";
      
      private static const UNACTIVE_STATE:String = "deactivate";
      
      private static const STEPPER_PADDING:int = -1;
       
      
      private var _stepperList:Vector.<MovieClip>;
      
      private var _prevStepper:MovieClip = null;
      
      public function StepperContainer()
      {
         this._stepperList = new Vector.<MovieClip>();
         super();
      }
      
      public final function dispose() : void
      {
         this.disposeStepperList();
         this._stepperList = null;
         this._prevStepper = null;
      }
      
      public function disposeStepperList() : void
      {
         this._stepperList.splice(0,this._stepperList.length);
      }
      
      public function selectItem(param1:int) : void
      {
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
      
      public function setCount(param1:int) : void
      {
         var _loc3_:MovieClip = null;
         this.disposeStepperList();
         var _loc2_:uint = 0;
         while(_loc2_ < param1)
         {
            _loc3_ = App.utils.classFactory.getComponent(RENDERER_CLASS_NAME,MovieClip);
            this._stepperList.push(_loc3_);
            if(_loc2_ > 0)
            {
               this._stepperList[_loc2_].x = this._stepperList[_loc2_ - 1].x + this._stepperList[_loc2_ - 1].width + STEPPER_PADDING;
            }
            addChild(this._stepperList[_loc2_]);
            _loc2_++;
         }
      }
   }
}
