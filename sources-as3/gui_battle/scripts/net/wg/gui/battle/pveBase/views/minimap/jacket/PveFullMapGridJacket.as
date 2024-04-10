package net.wg.gui.battle.pveBase.views.minimap.jacket
{
   import flash.display.Sprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.pveBase.views.minimap.jacket.grid.PveMinimapCoordinates;
   
   public class PveFullMapGridJacket extends BattleUIComponent
   {
      
      public static const BORDERS:int = 20;
      
      public static const THICK_BORDER:int = 16;
       
      
      public var horizontalCoordinates:PveMinimapCoordinates;
      
      public var verticalCoordinates:PveMinimapCoordinates;
      
      public var frame:Sprite;
      
      private var _rows:int;
      
      private var _columns:int;
      
      private var _size:int;
      
      public function PveFullMapGridJacket()
      {
         super();
      }
      
      public function setGrid(param1:int, param2:int) : void
      {
         if(this._rows == param1 || this._columns == param2)
         {
            return;
         }
         this._rows = param1;
         this._columns = param2;
         this.redraw();
      }
      
      public function setSize(param1:int) : void
      {
         if(this._size == param1)
         {
            return;
         }
         this._size = param1;
         this.redraw();
      }
      
      private function redraw() : void
      {
         this.frame.width = this._size;
         this.frame.height = this._size;
         var _loc1_:Number = this._size - BORDERS;
         this.horizontalCoordinates.redraw(_loc1_,this._columns);
         this.verticalCoordinates.redraw(_loc1_,this._rows);
      }
      
      override protected function onDispose() : void
      {
         this.horizontalCoordinates.dispose();
         this.horizontalCoordinates = null;
         this.verticalCoordinates.dispose();
         this.verticalCoordinates = null;
         this.frame = null;
         super.onDispose();
      }
   }
}
