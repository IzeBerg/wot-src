package net.wg.gui.components.crosshairPanel.components.autoloader
{
   import net.wg.data.constants.generated.AUTOLOADERBOOSTVIEWSTATES;
   
   public class BoostIndicatorStateParamsVO
   {
       
      
      public var remainingDurationMSec:Number = 0;
      
      public var currentFrame:int = 1;
      
      public var currentState:int = -2;
      
      public var isRecharging:Boolean = false;
      
      public var isFadingOut:Boolean = false;
      
      public var isCharging:Boolean = false;
      
      public var isSideFadeOut:Boolean = false;
      
      public var percent:Number = 0;
      
      public function BoostIndicatorStateParamsVO()
      {
         super();
      }
      
      public function resetToDefault() : void
      {
         this.remainingDurationMSec = 0;
         this.currentFrame = 1;
         this.currentState = AUTOLOADERBOOSTVIEWSTATES.INVISIBLE;
         this.isRecharging = false;
         this.isFadingOut = false;
         this.isCharging = false;
         this.isSideFadeOut = false;
      }
   }
}
