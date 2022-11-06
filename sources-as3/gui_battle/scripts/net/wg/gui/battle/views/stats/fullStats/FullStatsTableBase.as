package net.wg.gui.battle.views.stats.fullStats
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class FullStatsTableBase extends MovieClip implements IDisposable
   {
      
      private static const NUM_ROWS:int = 15;
       
      
      public var team1TF:TextField = null;
      
      public var team2TF:TextField = null;
      
      public var selfBgLeft:BattleAtlasSprite = null;
      
      public var selfBgRight:BattleAtlasSprite = null;
      
      public var fragsCollection:Vector.<TextField> = null;
      
      public var playerNameCollection:Vector.<TextField> = null;
      
      public var vehicleNameCollection:Vector.<TextField> = null;
      
      private var _disposed:Boolean = false;
      
      public function FullStatsTableBase()
      {
         super();
         TextFieldEx.setNoTranslate(this.team1TF,true);
         TextFieldEx.setNoTranslate(this.team2TF,true);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      protected function onDispose() : void
      {
         this.team1TF = null;
         this.team2TF = null;
         this.selfBgLeft = null;
         this.selfBgRight = null;
         this.fragsCollection.length = 0;
         this.playerNameCollection.length = 0;
         this.vehicleNameCollection.length = 0;
         this.fragsCollection = null;
         this.playerNameCollection = null;
         this.vehicleNameCollection = null;
      }
      
      public function get numRows() : int
      {
         return NUM_ROWS;
      }
      
      public function setFDEvent(param1:Boolean) : void
      {
      }
   }
}
