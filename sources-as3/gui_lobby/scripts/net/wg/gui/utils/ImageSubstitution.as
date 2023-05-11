package net.wg.gui.utils
{
   import flash.display.BitmapData;
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class ImageSubstitution implements IDisposable
   {
      
      private static const DEF_ICON_WIDTH:int = 16;
      
      private static const DEF_ICON_HEIGHT:int = 16;
      
      private static const IMAGE:String = "image";
       
      
      public var subString:String = null;
      
      public var source:String = null;
      
      public var image:BitmapData = null;
      
      public var baseLineY:Number = 0;
      
      public var width:Number = 16;
      
      public var height:Number = 16;
      
      private var _disposed:Boolean = false;
      
      public function ImageSubstitution(param1:String, param2:String, param3:Number = 0, param4:Number = 16, param5:Number = 16, param6:Boolean = false)
      {
         super();
         this.subString = param1;
         this.source = param2;
         this.baseLineY = param3;
         this.width = param4;
         this.height = param5;
         if(param6)
         {
            this.loadImage();
         }
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function loadImage() : Boolean
      {
         var _loc2_:Class = null;
         var _loc1_:Boolean = false;
         if(StringUtils.isNotEmpty(this.source))
         {
            _loc2_ = App.utils.classFactory.getClass(this.source);
            this.image = new _loc2_() as BitmapData;
            App.utils.asserter.assertNotNull(this.image,IMAGE + Errors.CANT_NULL);
            _loc1_ = true;
         }
         return _loc1_;
      }
      
      public function toString() : String
      {
         return "[ImageSubstitution subString=" + this.subString + " source=" + this.source + " image=" + this.image + " baseLineY=" + this.baseLineY + " width=" + this.width + " height=" + this.height + "]";
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
         if(this.image != null)
         {
            this.image.dispose();
            this.image = null;
         }
      }
      
      public function get valid() : Boolean
      {
         return this.image != null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
