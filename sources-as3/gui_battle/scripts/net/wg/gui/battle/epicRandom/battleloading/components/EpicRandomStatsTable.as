package net.wg.gui.battle.epicRandom.battleloading.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.controls.ScrollingList;
   
   public class EpicRandomStatsTable extends Sprite implements IDisposable
   {
       
      
      public var team1TF:TextField = null;
      
      public var team2TF:TextField = null;
      
      public var team1PlayerList:ScrollingList = null;
      
      public var team2PlayerList:ScrollingList = null;
      
      public var team1ScrollBar:ScrollBar = null;
      
      public var team2ScrollBar:ScrollBar = null;
      
      public function EpicRandomStatsTable()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      protected function onDispose() : void
      {
         this.team1TF = null;
         this.team2TF = null;
         this.team1PlayerList.dispose();
         this.team1PlayerList = null;
         this.team2PlayerList.dispose();
         this.team2PlayerList = null;
         this.team1ScrollBar.dispose();
         this.team1ScrollBar = null;
         this.team2ScrollBar.dispose();
         this.team2ScrollBar = null;
      }
   }
}
