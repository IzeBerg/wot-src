package net.wg.gui.battle.epicBattle.battleloading.components
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EpicBattleStatsTable extends Sprite implements IDisposable
   {
       
      
      public var team1PlayerList:EpicBattleScrollingList = null;
      
      public var team2PlayerList:EpicBattleScrollingList = null;
      
      public var team1ScrollBar:ScrollBar = null;
      
      public var team2ScrollBar:ScrollBar = null;
      
      private var _disposed:Boolean = false;
      
      public function EpicBattleStatsTable()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this.team1PlayerList.dispose();
         this.team1PlayerList = null;
         this.team2PlayerList.dispose();
         this.team2PlayerList = null;
         this.team1ScrollBar.dispose();
         this.team1ScrollBar = null;
         this.team2ScrollBar.dispose();
         this.team2ScrollBar = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
