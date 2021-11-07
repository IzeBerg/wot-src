package net.wg.gui.lobby.battleRoyale.widget.data
{
   import flash.text.TextField;
   import net.wg.infrastructure.base.meta.IBattleRoyaleTournamentWidgetMeta;
   import net.wg.infrastructure.base.meta.impl.BattleRoyaleTournamentWidgetMeta;
   
   public class BattleRoyaleTournamentWidget extends BattleRoyaleTournamentWidgetMeta implements IBattleRoyaleTournamentWidgetMeta
   {
       
      
      public var titleTF:TextField = null;
      
      public function BattleRoyaleTournamentWidget()
      {
         super();
      }
      
      public function as_setTitle(param1:String) : void
      {
         this.titleTF.text = param1;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTF.text = BATTLE_ROYALE.TOURNAMENT_TITLE;
      }
      
      override protected function onDispose() : void
      {
         this.titleTF = null;
         super.onDispose();
      }
   }
}
