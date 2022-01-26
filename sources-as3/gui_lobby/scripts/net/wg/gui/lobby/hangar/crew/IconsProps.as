package net.wg.gui.lobby.hangar.crew
{
   public class IconsProps
   {
       
      
      private var _alpha:Number;
      
      private var _visible:Boolean;
      
      private var _autoSize:String;
      
      private var _text:String;
      
      public function IconsProps()
      {
         super();
      }
      
      public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function set alpha(param1:Number) : void
      {
         this._alpha = param1;
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      public function set visible(param1:Boolean) : void
      {
         this._visible = param1;
      }
      
      public function get autoSize() : String
      {
         return this._autoSize;
      }
      
      public function set autoSize(param1:String) : void
      {
         this._autoSize = param1;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         this._text = param1;
      }
   }
}
