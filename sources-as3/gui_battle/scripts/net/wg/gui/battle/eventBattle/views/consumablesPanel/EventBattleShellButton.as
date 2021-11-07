package net.wg.gui.battle.eventBattle.views.consumablesPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.views.consumablesPanel.BattleShellButton;
   
   public class EventBattleShellButton extends BattleShellButton
   {
      
      private static const INFINITY_SHELLS:int = 99;
       
      
      public var infinityMC:MovieClip = null;
      
      public function EventBattleShellButton()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.infinityMC = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(this.infinityMC && isInvalid(QUANTITY_VALIDATION))
         {
            _loc1_ = getQuantity() >= INFINITY_SHELLS;
            if(quantityField)
            {
               quantityField.visible = !_loc1_;
            }
            this.infinityMC.visible = _loc1_;
         }
      }
   }
}
