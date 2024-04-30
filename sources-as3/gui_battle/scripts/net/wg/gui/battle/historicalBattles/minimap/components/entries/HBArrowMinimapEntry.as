package net.wg.gui.battle.historicalBattles.minimap.components.entries
{
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class HBArrowMinimapEntry extends BattleUIComponent
   {
       
      
      public var arrow:HBArrowContainer = null;
      
      public function HBArrowMinimapEntry()
      {
         super();
      }
      
      public function setBlinking() : void
      {
         this.arrow.setBlinking();
      }
      
      public function setIcon(param1:String) : void
      {
         this.arrow.setIcon(param1);
      }
      
      override protected function onDispose() : void
      {
         this.arrow.dispose();
         this.arrow = null;
         super.onDispose();
      }
   }
}
