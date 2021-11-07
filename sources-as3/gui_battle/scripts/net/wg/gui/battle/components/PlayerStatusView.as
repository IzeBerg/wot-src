package net.wg.gui.battle.components
{
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class PlayerStatusView extends BattleIconHolder
   {
       
      
      public var inBattle:BattleAtlasSprite = null;
      
      public var offline:BattleAtlasSprite = null;
      
      public var killed:BattleAtlasSprite = null;
      
      public var dogTag:BattleAtlasSprite = null;
      
      public function PlayerStatusView()
      {
         super();
         this.inBattle.visible = false;
         this.offline.visible = false;
         this.killed.visible = false;
         this.dogTag.visible = false;
         this.inBattle.imageName = BATTLEATLAS.FULL_STATS_PLAYER_STATUS_IN_BATTLE;
         this.offline.imageName = BATTLEATLAS.FULL_STATS_PLAYER_STATUS_OFFLINE;
         this.killed.imageName = BATTLEATLAS.FULL_STATS_PLAYER_STATUS_KILLED;
         this.dogTag.imageName = BATTLEATLAS.FULL_STATS_PLAYER_STATUS_DOG_TAG;
      }
      
      override protected function onDispose() : void
      {
         this.inBattle = null;
         this.offline = null;
         this.killed = null;
         this.dogTag = null;
         super.onDispose();
      }
      
      public function showInBattle() : void
      {
         showItem(this.inBattle);
      }
      
      public function showKilled() : void
      {
         showItem(this.killed);
      }
      
      public function showOffline() : void
      {
         showItem(this.offline);
      }
      
      public function showDogTag() : void
      {
         showItem(this.dogTag);
      }
   }
}
