package net.wg.data
{
   import net.wg.infrastructure.interfaces.IImageUrlProperties;
   
   public class ImageUrlProperties implements IImageUrlProperties
   {
       
      
      private var _imageAlias:String = null;
      
      private var _width:int = 0;
      
      private var _height:int = 0;
      
      private var _vSpace:int = 0;
      
      private var _hSpace:int = 0;
      
      public function ImageUrlProperties(param1:String, param2:int, param3:int, param4:int, param5:int)
      {
         super();
         this.imageAlias = param1;
         this.width = param2;
         this.height = param3;
         this.vSpace = param4;
         this.hSpace = param5;
      }
      
      public function get imageAlias() : String
      {
         return this._imageAlias;
      }
      
      public function set imageAlias(param1:String) : void
      {
         this._imageAlias = param1;
      }
      
      public function get width() : int
      {
         return this._width;
      }
      
      public function set width(param1:int) : void
      {
         this._width = param1;
      }
      
      public function get height() : int
      {
         return this._height;
      }
      
      public function set height(param1:int) : void
      {
         this._height = param1;
      }
      
      public function get vSpace() : int
      {
         return this._vSpace;
      }
      
      public function set vSpace(param1:int) : void
      {
         this._vSpace = param1;
      }
      
      public function get hSpace() : int
      {
         return this._hSpace;
      }
      
      public function set hSpace(param1:int) : void
      {
         this._hSpace = param1;
      }
   }
}
