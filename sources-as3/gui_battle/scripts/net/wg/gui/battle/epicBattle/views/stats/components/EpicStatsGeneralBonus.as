package net.wg.gui.battle.epicBattle.views.stats.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class EpicStatsGeneralBonus extends BattleUIComponent
   {
      
      private static const ZERO_BONUS:int = 0;
      
      private static const ICON_ALPHA:Number = 0.5;
      
      private static const TEXT_ALPHA:Number = 0.8;
      
      private static const FULL_ALPHA:Number = 1;
      
      private static const X_SHIFT:Number = 41;
       
      
      public var valueTF:TextField = null;
      
      public var descriptionTF:TextField = null;
      
      public var iconMC:MovieClip = null;
      
      public var glowMC:MovieClip = null;
      
      private var _bonusValue:Number = 0;
      
      public function EpicStatsGeneralBonus()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.valueTF = null;
         this.descriptionTF = null;
         this.iconMC = null;
         this.glowMC = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         this.glowMC.mouseEnabled = false;
         this.descriptionTF.text = EPIC_BATTLE.TAB_SCREEN_GENERALBONUSDESCR;
         this.descriptionTF.autoSize = TextFormatAlign.LEFT;
         this.x = -Math.round(this.width / 2) + X_SHIFT;
         this.updateBonus();
      }
      
      public function set bonusValue(param1:Number) : void
      {
         this._bonusValue = param1;
         this.updateBonus();
      }
      
      private function updateBonus() : void
      {
         this.valueTF.text = App.utils.locale.makeString(EPIC_BATTLE.TAB_SCREEN_GENERALBONUSVALUE,{"value":String(this._bonusValue)});
         if(this._bonusValue > ZERO_BONUS)
         {
            this.valueTF.alpha = this.iconMC.alpha = FULL_ALPHA;
            this.glowMC.visible = true;
         }
         else
         {
            this.valueTF.alpha = TEXT_ALPHA;
            this.iconMC.alpha = ICON_ALPHA;
            this.glowMC.visible = false;
         }
      }
   }
}
