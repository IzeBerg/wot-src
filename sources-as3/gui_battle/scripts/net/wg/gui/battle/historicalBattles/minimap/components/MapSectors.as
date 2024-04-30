package net.wg.gui.battle.historicalBattles.minimap.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MapSectors extends MovieClip implements IDisposable
   {
      
      public static const START_SHIFT:int = 16;
      
      private static const END_SHIFT:int = 4;
      
      private static const SECTORS_AMOUNT:int = 10;
       
      
      public var frame:MovieClip = null;
      
      public var horizontal:MovieClip = null;
      
      public var vertical:MovieClip = null;
      
      private var _isDisposed:Boolean = false;
      
      public function MapSectors()
      {
         super();
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._isDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function updateSectorsSize(param1:Number) : void
      {
         this.frame.width = this.frame.height = param1 + START_SHIFT + END_SHIFT;
         this.horizontal.x = this.vertical.y = START_SHIFT;
         var _loc2_:Number = param1 / SECTORS_AMOUNT;
         var _loc3_:int = 1;
         while(_loc3_ <= SECTORS_AMOUNT)
         {
            this.horizontal["symbol_" + _loc3_].x = this.vertical["symbol_" + _loc3_].y = _loc2_ * (_loc3_ - 1) + _loc2_ / 2;
            _loc3_++;
         }
      }
      
      protected function onDispose() : void
      {
         this.frame = null;
         this.horizontal = null;
         this.vertical = null;
      }
   }
}
