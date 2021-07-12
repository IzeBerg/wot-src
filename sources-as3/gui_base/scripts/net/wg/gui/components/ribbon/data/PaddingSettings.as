package net.wg.gui.components.ribbon.data
{
   public class PaddingSettings
   {
       
      
      private var _ribbonOffset:Number = 0;
      
      private var _valuePaddingX:Number = 0;
      
      private var _ribbonIconPaddingX:Number = 0;
      
      private var _tankIconPaddingX:Number = 0;
      
      private var _tankNamePaddingX:Number = 0;
      
      public function PaddingSettings(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number)
      {
         super();
         this._ribbonOffset = param1;
         this._valuePaddingX = param2;
         this._ribbonIconPaddingX = param3;
         this._tankIconPaddingX = param4;
         this._tankNamePaddingX = param5;
      }
      
      public function get valuePaddingX() : Number
      {
         return this._valuePaddingX;
      }
      
      public function get ribbonIconPaddingX() : Number
      {
         return this._ribbonIconPaddingX;
      }
      
      public function get tankIconPaddingX() : Number
      {
         return this._tankIconPaddingX;
      }
      
      public function get tankNamePaddingX() : Number
      {
         return this._tankNamePaddingX;
      }
      
      public function get ribbonOffset() : Number
      {
         return this._ribbonOffset;
      }
   }
}
