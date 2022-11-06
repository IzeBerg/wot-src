package net.wg.data.managers.impl
{
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.managers.ITooltipProps;
   
   public class TooltipProps implements ITooltipProps
   {
      
      public static const WARNING:TooltipProps = new TooltipProps(BaseTooltips.TYPE_WARNING,0,0,0,-1,0,0);
      
      public static const DEFAULT:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,0);
      
      public static const ADVANCED:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,0,0,0);
       
      
      private var _type:String = null;
      
      private var _x:Number = 0;
      
      private var _y:Number = 0;
      
      private var _minWidth:Number = 0;
      
      private var _drawDelay:Number = -1;
      
      private var _showDelay:Number = 0;
      
      private var _maxWidth:Number = 0;
      
      public function TooltipProps(param1:String, param2:Number, param3:Number, param4:Number = 0, param5:Number = -1, param6:Number = 0, param7:Number = 0)
      {
         super();
         this._type = param1;
         this._x = param2;
         this._y = param3;
         this._minWidth = param4;
         this._drawDelay = param5;
         this._showDelay = param6;
         this._maxWidth = param7;
      }
      
      public function clone() : Object
      {
         return new TooltipProps(this._type,this._x,this._y,this._minWidth,this._drawDelay,this._showDelay,this._maxWidth);
      }
      
      public function get type() : String
      {
         return this._type;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function get minWidth() : Number
      {
         return this._minWidth;
      }
      
      public function get drawDelay() : Number
      {
         return this._drawDelay;
      }
      
      public function get showDelay() : Number
      {
         return this._showDelay;
      }
      
      public function get maxWidth() : Number
      {
         return this._maxWidth;
      }
      
      public function set maxWidth(param1:Number) : void
      {
         this._maxWidth = param1;
      }
   }
}
