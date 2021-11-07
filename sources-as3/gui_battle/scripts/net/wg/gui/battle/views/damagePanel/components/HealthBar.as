package net.wg.gui.battle.views.damagePanel.components
{
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class HealthBar extends BattleUIComponent
   {
       
      
      private var _progress:int = 0;
      
      public function HealthBar()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            _loc1_ = 1 + totalFrames * (this.progress * 0.01) | 0;
            gotoAndStop(_loc1_);
         }
      }
      
      public function get progress() : int
      {
         return this._progress;
      }
      
      public function set progress(param1:int) : void
      {
         this._progress = param1;
         invalidateData();
      }
   }
}
