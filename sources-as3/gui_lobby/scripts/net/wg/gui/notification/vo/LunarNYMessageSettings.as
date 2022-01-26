package net.wg.gui.notification.vo
{
   public class LunarNYMessageSettings
   {
       
      
      private var _iconX:int = 0;
      
      private var _iconY:int = 0;
      
      private var _iconW:int = 0;
      
      private var _iconH:int = 0;
      
      private var _textX:int = 0;
      
      private var _textY:int = 0;
      
      private var _textW:int = 0;
      
      private var _bgIconOffset:int = 0;
      
      private var _counterX:int = 0;
      
      private var _counterY:int = 0;
      
      private var _btnPadding:int = 0;
      
      private var _bottomOffset:int = 0;
      
      private var _rightOffset:int = 0;
      
      private var _bgLinkage:String = "";
      
      private var _counterLinkage:String = "";
      
      private var _hitLinkage:String = "";
      
      public function LunarNYMessageSettings(param1:int, param2:int, param3:int, param4:int, param5:int, param6:int, param7:int, param8:int, param9:int, param10:int, param11:int, param12:int, param13:int, param14:String, param15:String, param16:String)
      {
         super();
         this._iconX = param1;
         this._iconY = param2;
         this._iconW = param3;
         this._iconH = param4;
         this._textX = param5;
         this._textY = param6;
         this._textW = param7;
         this._bgIconOffset = param8;
         this._counterX = param9;
         this._counterY = param10;
         this._btnPadding = param11;
         this._bottomOffset = param12;
         this._rightOffset = param13;
         this._bgLinkage = param14;
         this._counterLinkage = param15;
         this._hitLinkage = param16;
      }
      
      public function get iconX() : int
      {
         return this._iconX;
      }
      
      public function get iconY() : int
      {
         return this._iconY;
      }
      
      public function get textX() : int
      {
         return this._textX;
      }
      
      public function get textY() : int
      {
         return this._textY;
      }
      
      public function get bgIconOffset() : int
      {
         return this._bgIconOffset;
      }
      
      public function get counterX() : int
      {
         return this._counterX;
      }
      
      public function get counterY() : int
      {
         return this._counterY;
      }
      
      public function get btnPadding() : int
      {
         return this._btnPadding;
      }
      
      public function get bottomOffset() : int
      {
         return this._bottomOffset;
      }
      
      public function get textW() : int
      {
         return this._textW;
      }
      
      public function get bgLinkage() : String
      {
         return this._bgLinkage;
      }
      
      public function set bgLinkage(param1:String) : void
      {
         this._bgLinkage = param1;
      }
      
      public function get counterLinkage() : String
      {
         return this._counterLinkage;
      }
      
      public function get rightOffset() : int
      {
         return this._rightOffset;
      }
      
      public function get iconW() : int
      {
         return this._iconW;
      }
      
      public function set iconW(param1:int) : void
      {
         this._iconW = param1;
      }
      
      public function get iconH() : int
      {
         return this._iconH;
      }
      
      public function set iconH(param1:int) : void
      {
         this._iconH = param1;
      }
      
      public function set counterX(param1:int) : void
      {
         this._counterX = param1;
      }
      
      public function set iconX(param1:int) : void
      {
         this._iconX = param1;
      }
      
      public function set iconY(param1:int) : void
      {
         this._iconY = param1;
      }
      
      public function set btnPadding(param1:int) : void
      {
         this._btnPadding = param1;
      }
      
      public function set counterY(param1:int) : void
      {
         this._counterY = param1;
      }
      
      public function set textY(param1:int) : void
      {
         this._textY = param1;
      }
      
      public function get hitLinkage() : String
      {
         return this._hitLinkage;
      }
   }
}
