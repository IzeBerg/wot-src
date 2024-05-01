package net.wg.gui.battle.battleloading
{
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.controls.StatusIndicator;
   
   public class SimpleBattleLoadingForm extends UIComponentEx
   {
      
      private static const PROGRESS:String = "progress";
       
      
      public var loadingBar:StatusIndicator;
      
      private var _progress:Number = 0;
      
      public function SimpleBattleLoadingForm()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(PROGRESS))
         {
            this.loadingBar.position = this._progress;
         }
      }
      
      public function updateProgress(param1:Number) : void
      {
         if(param1 != this._progress)
         {
            this._progress = param1;
            invalidate(PROGRESS);
         }
      }
      
      override protected function onDispose() : void
      {
         this.loadingBar.dispose();
         this.loadingBar = null;
         super.onDispose();
      }
   }
}
