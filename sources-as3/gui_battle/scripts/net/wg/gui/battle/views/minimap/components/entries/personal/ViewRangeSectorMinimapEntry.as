package net.wg.gui.battle.views.minimap.components.entries.personal
{
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ViewRangeSectorMinimapEntry extends Sprite implements IDisposable
   {
      
      private static const AREA_MAX_SIZE_REAL:int = 210;
      
      private static const SECTOR_BORDER_COLOR:uint = 5301276;
      
      private static const SECTOR_FILL_COLOR:uint = 1744896;
      
      private static const SECTOR_FILL_ALPHA:Number = 0.2;
       
      
      private var _dynamicMC:Shape = null;
      
      private var _circleDiameterCoeff:Number = 0;
      
      private var _currentSectorRadius:Number = 0;
      
      public function ViewRangeSectorMinimapEntry()
      {
         super();
      }
      
      private static function drawSector(param1:Graphics, param2:Number, param3:Number) : void
      {
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:int = 0;
         param1.moveTo(0,0);
         if(Math.abs(param3) > 360)
         {
            param3 = 360;
         }
         var _loc4_:int = (180 - param3) / 2;
         var _loc5_:int = Math.ceil(Math.abs(param3) / 45);
         var _loc6_:Number = param3 / _loc5_;
         var _loc7_:Number = -(_loc6_ / 180) * Math.PI;
         var _loc8_:Number = -(_loc4_ / 180) * Math.PI;
         if(_loc5_ > 0)
         {
            _loc9_ = Math.cos(_loc4_ / 180 * Math.PI) * param2;
            _loc10_ = Math.sin(-_loc4_ / 180 * Math.PI) * param2;
            param1.lineTo(_loc9_,_loc10_);
            _loc16_ = 0;
            while(_loc16_ < _loc5_)
            {
               _loc8_ += _loc7_;
               _loc11_ = _loc8_ - _loc7_ / 2;
               _loc12_ = Math.cos(_loc8_) * param2;
               _loc13_ = Math.sin(_loc8_) * param2;
               _loc14_ = Math.cos(_loc11_) * (param2 / Math.cos(_loc7_ / 2));
               _loc15_ = Math.sin(_loc11_) * (param2 / Math.cos(_loc7_ / 2));
               param1.curveTo(_loc14_,_loc15_,_loc12_,_loc13_);
               _loc16_++;
            }
            param1.lineTo(0,0);
         }
      }
      
      public function as_addSector(param1:Number, param2:Number) : void
      {
         if(this._dynamicMC == null)
         {
            this._dynamicMC = this.initializeSector(param1,param2);
         }
      }
      
      public function as_delSector() : void
      {
         if(this._dynamicMC)
         {
            removeChild(this._dynamicMC);
            this._dynamicMC = null;
         }
      }
      
      public function as_initArenaSize(param1:int) : void
      {
         var _loc2_:Number = AREA_MAX_SIZE_REAL / param1;
         this._circleDiameterCoeff = _loc2_ * 2;
      }
      
      public function as_updateSectorRadius(param1:Number) : void
      {
         var _loc2_:Number = NaN;
         if(this._dynamicMC && this._currentSectorRadius != param1)
         {
            this._currentSectorRadius = param1;
            _loc2_ = this._currentSectorRadius * this._circleDiameterCoeff * 2;
            this._dynamicMC.width = _loc2_;
            this._dynamicMC.height = _loc2_;
         }
      }
      
      public final function dispose() : void
      {
         this.as_delSector();
      }
      
      private function initializeSector(param1:Number, param2:Number) : Shape
      {
         var _loc3_:Shape = new Shape();
         addChild(_loc3_);
         var _loc4_:Graphics = _loc3_.graphics;
         _loc4_.clear();
         _loc4_.lineStyle(1,SECTOR_BORDER_COLOR);
         _loc4_.beginFill(SECTOR_FILL_COLOR,SECTOR_FILL_ALPHA);
         drawSector(_loc4_,AREA_MAX_SIZE_REAL,param2);
         _loc4_.endFill();
         _loc4_.lineStyle(0,16777215,0.01);
         _loc4_.drawCircle(0,0,AREA_MAX_SIZE_REAL);
         var _loc5_:Number = param1 * this._circleDiameterCoeff;
         _loc3_.width = _loc5_;
         _loc3_.height = _loc5_;
         return _loc3_;
      }
   }
}
