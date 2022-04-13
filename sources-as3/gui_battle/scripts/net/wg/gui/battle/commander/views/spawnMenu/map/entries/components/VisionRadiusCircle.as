package net.wg.gui.battle.commander.views.spawnMenu.map.entries.components
{
   import flash.display.Graphics;
   import flash.display.LineScaleMode;
   import flash.display.Shape;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VisionRadiusCircle implements IDisposable
   {
       
      
      private var _parent:VisionRadius = null;
      
      private var _shape:Shape;
      
      private var _thickness:uint;
      
      private var _color:Number;
      
      private var _alpha:Number;
      
      private var _isDisposed:Boolean = false;
      
      public function VisionRadiusCircle(param1:VisionRadius, param2:uint, param3:Number, param4:Number)
      {
         this._shape = new Shape();
         super();
         this._parent = param1;
         this._parent.addChild(this._shape);
         this._thickness = param2;
         this._color = param3;
         this._alpha = param4;
      }
      
      public final function dispose() : void
      {
         this._parent.removeChild(this._shape);
         this._parent = null;
         this._shape = null;
         this._isDisposed = true;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function drawCircle(param1:Number) : void
      {
         var _loc2_:Graphics = this._shape.graphics;
         _loc2_.clear();
         _loc2_.lineStyle(this._thickness,this._color,this._alpha,false,LineScaleMode.NONE);
         _loc2_.drawCircle(0,0,param1);
         _loc2_.endFill();
      }
      
      public function hide() : void
      {
         this._shape.graphics.clear();
      }
   }
}
