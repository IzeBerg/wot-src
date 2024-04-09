package net.wg.gui.battle.pveBase.views.minimap.jacket.grid
{
   import flash.display.Graphics;
   import flash.display.LineScaleMode;
   import flash.display.Sprite;
   import net.wg.gui.battle.components.BattleUIComponent;
   
   public class PveMinimapGrid extends BattleUIComponent
   {
      
      private static const GRID_COLOR:uint = 16777215;
      
      private static const DIMMER_COLOR:uint = 0;
      
      private static const GRID_ALPHA:Number = 0.12;
      
      private static const DIMMER_ALPHA:Number = 0.305;
      
      private static const GRID_THICKNESS:int = 1;
       
      
      private var _grid:Sprite;
      
      private var _rows:int;
      
      private var _columns:int;
      
      private var _width:Number = 0;
      
      private var _height:Number = 0;
      
      public function PveMinimapGrid()
      {
         super();
         this._grid = new Sprite();
         this._grid.alpha = GRID_ALPHA;
         addChild(this._grid);
      }
      
      override protected function onDispose() : void
      {
         removeChild(this._grid);
         this._grid = null;
         super.onDispose();
      }
      
      public function setGrid(param1:int, param2:int) : void
      {
         this._rows = param1;
         this._columns = param2;
         this.redrawGrid(this._rows,this._columns);
      }
      
      public function setSize(param1:Number, param2:Number) : void
      {
         if(param1 == this._width && param2 == this._height)
         {
            return;
         }
         this._width = param1;
         this._height = param2;
         this.drawDimmer();
         this.redrawGrid(this._rows,this._columns);
      }
      
      private function drawDimmer() : void
      {
         graphics.clear();
         graphics.beginFill(DIMMER_COLOR,DIMMER_ALPHA);
         graphics.drawRect(0,0,this._width,this._height);
         graphics.endFill();
      }
      
      private function redrawGrid(param1:int, param2:int) : void
      {
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         if(this._width == 0 || this._height == 0)
         {
            return;
         }
         var _loc3_:Graphics = this._grid.graphics;
         _loc3_.clear();
         _loc3_.lineStyle(GRID_THICKNESS,GRID_COLOR,1,false,LineScaleMode.NONE);
         var _loc4_:Number = this._width / param2;
         var _loc5_:Number = this._height / param1;
         var _loc6_:int = 1;
         while(_loc6_ < param2)
         {
            _loc8_ = _loc6_ * _loc4_;
            _loc3_.moveTo(_loc8_,0);
            _loc3_.lineTo(_loc8_,this._height);
            _loc6_++;
         }
         var _loc7_:int = 1;
         while(_loc7_ < param1)
         {
            _loc9_ = _loc7_ * _loc5_;
            _loc3_.moveTo(0,_loc9_);
            _loc3_.lineTo(this._width,_loc9_);
            _loc7_++;
         }
      }
   }
}
