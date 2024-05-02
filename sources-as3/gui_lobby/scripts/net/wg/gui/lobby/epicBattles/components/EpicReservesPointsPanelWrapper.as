package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EpicReservesPointsPanelWrapper extends Sprite implements IDisposable
   {
      
      private static const OFFSET_POINTS_X_SMALL:uint = 6;
      
      private static const OFFSET_POINTS_X_BIG:uint = 8;
      
      private static const OFFSET_POINTS_Y_SMALL:uint = 98;
      
      private static const OFFSET_POINTS_Y_BIG:uint = 60;
       
      
      public var reservesPoints:EpicReservesPointsPanel = null;
      
      private var _disposed:Boolean = false;
      
      public function EpicReservesPointsPanelWrapper()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.reservesPoints.dispose();
         this.reservesPoints = null;
      }
      
      public function setData(param1:String) : void
      {
         this.reservesPoints.setData(param1);
      }
      
      public function updateSize(param1:Boolean, param2:int) : void
      {
         this.reservesPoints.x = (param2 >> 1) - (!!param1 ? OFFSET_POINTS_X_SMALL : OFFSET_POINTS_X_BIG);
         this.reservesPoints.y = !!param1 ? Number(OFFSET_POINTS_Y_SMALL) : Number(OFFSET_POINTS_Y_BIG);
         this.reservesPoints.updateSize(param1);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
