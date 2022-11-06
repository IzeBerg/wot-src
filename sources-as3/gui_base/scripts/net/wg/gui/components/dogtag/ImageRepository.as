package net.wg.gui.components.dogtag
{
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.ILocale;
   
   public class ImageRepository implements IDisposable
   {
      
      private static var _instance:ImageRepository;
      
      private static const BACKGROUND:String = "background";
      
      private static const ENGRAVING:String = "engraving";
      
      private static const POSTFIX_K:String = "_k";
      
      private static const POSTFIX_M:String = "_m";
       
      
      private var _disposed:Boolean = false;
      
      private var _digitsList:Vector.<String>;
      
      private var _locale:ILocale;
      
      private var _images:Dictionary = null;
      
      private var _characters:Dictionary = null;
      
      private var _hasImages:Boolean = false;
      
      public function ImageRepository()
      {
         this._digitsList = new <String>["0","1","2","3","4","5","6","7","8","9","dot","percentage"];
         this._locale = App.utils.locale;
         super();
         this._images = new Dictionary();
         this._characters = new Dictionary();
         this._digitsList.push(this._locale.makeString(SETTINGS.LANGUAGE_CODE) + POSTFIX_K);
         this._digitsList.push(this._locale.makeString(SETTINGS.LANGUAGE_CODE) + POSTFIX_M);
         this.preloadCharacters();
      }
      
      public static function getInstance() : ImageRepository
      {
         if(!_instance)
         {
            _instance = new ImageRepository();
         }
         return _instance;
      }
      
      public final function dispose() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         this._disposed = true;
         for(_loc1_ in this._images)
         {
            this._images[_loc1_].dispose();
            this._images[_loc1_] = null;
         }
         for(_loc2_ in this._characters)
         {
            this._characters[_loc2_].dispose();
            this._characters[_loc2_] = null;
         }
         this._digitsList.length = 0;
         this._digitsList = null;
         this._locale = null;
         this._hasImages = false;
      }
      
      public function getCharacterBitmapData(param1:String) : BitmapData
      {
         if(this._characters[param1])
         {
            return this._characters[param1].bitmapData;
         }
         App.utils.asserter.assertNotNull(this._characters[param1],"preloaded image digit" + Errors.CANT_NULL);
         return null;
      }
      
      public function getImageBitmapData(param1:String) : BitmapData
      {
         if(this._images[param1])
         {
            return this._images[param1].bitmapData;
         }
         App.utils.asserter.assertNotNull(this._images[param1],"preloaded image" + Errors.CANT_NULL);
         return null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function preloadCharacters() : void
      {
         var _loc3_:Image = null;
         var _loc4_:String = null;
         var _loc1_:int = this._digitsList.length;
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = new Image();
            _loc4_ = this._digitsList[_loc2_];
            _loc3_.source = RES_ICONS.getDogTagCharacterSmall(_loc4_);
            this._characters[_loc4_] = _loc3_;
            _loc2_++;
         }
      }
      
      public function setImages(param1:Array) : void
      {
         var _loc4_:Image = null;
         this._hasImages = true;
         var _loc2_:int = param1.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = new Image();
            if(param1[_loc3_].indexOf(BACKGROUND) != -1)
            {
               _loc4_.source = RES_ICONS.maps_icons_dogtags_small_backgrounds_all_png(param1[_loc3_]);
            }
            if(param1[_loc3_].indexOf(ENGRAVING) != -1)
            {
               _loc4_.source = RES_ICONS.maps_icons_dogtags_small_engravings_all_png(param1[_loc3_]);
            }
            if(_loc4_.source == Values.EMPTY_STR)
            {
               App.utils.asserter.assert(false,"Unsupported image name convention");
            }
            this._images[param1[_loc3_]] = _loc4_;
            _loc3_++;
         }
      }
      
      public function get hasImages() : Boolean
      {
         return this._hasImages;
      }
   }
}
