package net.wg.gui.battle.commander.views.spawnMenu.map.entries.components
{
   import flash.display.Graphics;
   import flash.display.GraphicsPathCommand;
   import flash.display.LineScaleMode;
   import flash.display.Shape;
   import net.wg.gui.utils.GraphicsUtilities;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VisionRadiusCone implements IDisposable
   {
       
      
      private var _parent:VisionRadius = null;
      
      private var _shape:Shape;
      
      private var _thickness:uint;
      
      private var _color:Number;
      
      private var _alpha:Number;
      
      private var _isDisposed:Boolean = false;
      
      public function VisionRadiusCone(param1:VisionRadius, param2:uint, param3:Number, param4:Number)
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
      
      public function drawCone(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:Number = param1 * Math.cos(param2);
         var _loc5_:Number = param1 * Math.sin(param2);
         var _loc6_:Number = param1 * Math.cos(param3);
         var _loc7_:Number = param1 * Math.sin(param3);
         var _loc8_:Graphics = this._shape.graphics;
         _loc8_.clear();
         _loc8_.lineStyle(this._thickness,this._color,this._alpha,false,LineScaleMode.NONE);
         var _loc9_:Vector.<int> = new Vector.<int>(3,true);
         _loc9_[0] = GraphicsPathCommand.MOVE_TO;
         _loc9_[1] = GraphicsPathCommand.LINE_TO;
         _loc9_[2] = GraphicsPathCommand.LINE_TO;
         var _loc10_:Vector.<Number> = new Vector.<Number>(6,true);
         _loc10_[0] = _loc4_;
         _loc10_[1] = _loc5_;
         _loc10_[2] = 0;
         _loc10_[3] = 0;
         _loc10_[4] = _loc6_;
         _loc10_[5] = _loc7_;
         _loc8_.drawPath(_loc9_,_loc10_);
         _loc8_.lineStyle(this._thickness,this._color,this._alpha,false,LineScaleMode.NONE);
         GraphicsUtilities.drawArc(_loc8_,0,0,-param2,-param3 + param2,param1);
      }
      
      public function hide() : void
      {
         this._shape.graphics.clear();
      }
   }
}
