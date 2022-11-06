package net.wg.data.VO
{
   import fl.motion.AdjustColor;
   import flash.filters.BitmapFilter;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.exceptions.NullPointerException;
   import net.wg.infrastructure.interfaces.IColorScheme;
   
   public class ColorScheme extends DAAPIDataClass implements IColorScheme
   {
       
      
      private var _aliasColor:String = "";
      
      private var _rgb:Number = 0;
      
      private var _schemeName:String = "";
      
      private var _transform:Object = null;
      
      private var _colorTransform:ColorTransform = null;
      
      private var _adjust:Object = null;
      
      private var _adjustOffset:BitmapFilter = null;
      
      public function ColorScheme(param1:Object)
      {
         super(param1);
      }
      
      public function get aliasColor() : String
      {
         return this._aliasColor;
      }
      
      public function set aliasColor(param1:String) : void
      {
         this._aliasColor = param1;
      }
      
      public function get rgb() : Number
      {
         return this._rgb;
      }
      
      public function set rgb(param1:Number) : void
      {
         this._rgb = param1;
      }
      
      public function get schemeName() : String
      {
         return this._schemeName;
      }
      
      public function set schemeName(param1:String) : void
      {
         this._schemeName = param1;
      }
      
      public function get transform() : Object
      {
         return this._transform;
      }
      
      public function set transform(param1:Object) : void
      {
         this._transform = param1;
         var _loc2_:Object = param1["mult"];
         var _loc3_:Object = param1["offset"];
         this.assertNotNull(_loc2_,"mult");
         this.assertNotNull(_loc3_,"offset");
         this._colorTransform = new ColorTransform(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc3_[0],_loc3_[1],_loc3_[2],_loc3_[3]);
      }
      
      public function get colorTransform() : ColorTransform
      {
         return this._colorTransform;
      }
      
      public function get adjust() : Object
      {
         return this._adjust;
      }
      
      public function set adjust(param1:Object) : void
      {
         this._adjust = param1;
         var _loc2_:Array = param1["offset"];
         this.assertNotNull(_loc2_,"offset");
         var _loc3_:AdjustColor = new AdjustColor();
         _loc3_.brightness = _loc2_[0];
         _loc3_.contrast = _loc2_[1];
         _loc3_.saturation = _loc2_[2];
         _loc3_.hue = _loc2_[3];
         this._adjustOffset = new ColorMatrixFilter(_loc3_.CalculateFinalFlatArray());
      }
      
      public function get adjustOffset() : BitmapFilter
      {
         return this._adjustOffset;
      }
      
      private function assertNotNull(param1:Object, param2:String) : void
      {
         App.utils.asserter.assertNotNull(param1,param2 + Errors.CANT_NULL,NullPointerException);
      }
   }
}
