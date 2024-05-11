package net.wg.gui.lobby.profile.components.chart.layout
{
   public class LayoutBase implements IChartLayout
   {
       
      
      private var _gap:Number;
      
      private var _paddingRight:Number = 0;
      
      private var _paddingLeft:Number = 0;
      
      private var _paddingTop:Number = 0;
      
      private var _paddingBottom:Number = 0;
      
      private var _disposed:Boolean = false;
      
      public function LayoutBase()
      {
         super();
      }
      
      public function set gap(param1:Number) : void
      {
         this._gap = param1;
      }
      
      public function get gap() : Number
      {
         return this._gap;
      }
      
      public function set paddingRight(param1:Number) : void
      {
         this._paddingRight = param1;
      }
      
      public function get paddingRight() : Number
      {
         return this._paddingRight;
      }
      
      public function set paddingLeft(param1:Number) : void
      {
         this._paddingLeft = param1;
      }
      
      public function get paddingLeft() : Number
      {
         return this._paddingLeft;
      }
      
      public function set paddingTop(param1:Number) : void
      {
         this._paddingTop = param1;
      }
      
      public function get paddingTop() : Number
      {
         return this._paddingTop;
      }
      
      public function set paddingBottom(param1:Number) : void
      {
         this._paddingBottom = param1;
      }
      
      public function get paddingBottom() : Number
      {
         return this._paddingBottom;
      }
      
      public function layout(param1:uint, param2:Object) : void
      {
      }
      
      public function dispose() : void
      {
         this._disposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
