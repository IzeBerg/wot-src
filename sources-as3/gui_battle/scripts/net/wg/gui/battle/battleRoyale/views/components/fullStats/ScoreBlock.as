package net.wg.gui.battle.battleRoyale.views.components.fullStats
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.battleRoyale.data.BattleRoyaleFullStatsVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ScoreBlock extends Sprite implements IDisposable
   {
      
      private static const SEPARATOR_Y_SMALL:int = 45;
      
      private static const ALIVE_Y_SMALL:int = 50;
       
      
      public var alive:VehicleCounter = null;
      
      public var destroyed:VehicleCounter = null;
      
      public var separator:Sprite = null;
      
      private var _baseDisposed:Boolean = false;
      
      private var _aliveDefaultY:int;
      
      private var _separatorDefaultY:int;
      
      public function ScoreBlock()
      {
         super();
         this._aliveDefaultY = this.alive.y;
         this._separatorDefaultY = this.separator.y;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function setData(param1:BattleRoyaleFullStatsVO) : void
      {
         this.alive.setData(param1.aliveBlock);
         if(param1.aliveBlock.squads != Values.EMPTY_STR)
         {
            param1.destroyedBlock.squads = Values.SPACE_STR;
         }
         this.destroyed.setData(param1.destroyedBlock);
      }
      
      public function update(param1:int, param2:int, param3:String) : void
      {
         this.alive.update(param1,param3);
         this.destroyed.update(param2);
      }
      
      protected function onDispose() : void
      {
         this.alive.dispose();
         this.alive = null;
         this.destroyed.dispose();
         this.destroyed = null;
         this.separator = null;
      }
      
      public function set useSmallLayout(param1:Boolean) : void
      {
         this.alive.useSmallLayout = param1;
         this.destroyed.useSmallLayout = param1;
         if(param1)
         {
            this.alive.y = ALIVE_Y_SMALL;
            this.separator.y = SEPARATOR_Y_SMALL;
         }
         else
         {
            this.alive.y = this._aliveDefaultY;
            this.separator.y = this._separatorDefaultY;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
