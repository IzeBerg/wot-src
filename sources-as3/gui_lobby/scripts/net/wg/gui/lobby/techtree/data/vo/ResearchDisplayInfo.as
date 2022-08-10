package net.wg.gui.lobby.techtree.data.vo
{
   import net.wg.gui.lobby.techtree.interfaces.IValueObject;
   import net.wg.utils.ILocale;
   
   public class ResearchDisplayInfo implements IValueObject
   {
      
      public static const VEHICLE_RENDERER:String = "vehicle";
      
      private static const MIN_SOURCE_ARRAY_LEN:uint = 3;
      
      private static const SOURCE_ARRAY_PATH_INDEX:uint = 0;
      
      private static const SOURCE_ARRAY_RENDERER_INDEX:uint = 1;
      
      private static const SOURCE_ARRAY_LEVEL_INDEX:uint = 2;
       
      
      private var _path:Array;
      
      private var _renderer:String;
      
      private var _level:int;
      
      private var _disposed:Boolean = false;
      
      public function ResearchDisplayInfo(param1:Array = null, param2:String = "", param3:int = -1)
      {
         super();
         this._path = param1;
         this._renderer = param2;
         this._level = param3;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         if(this._path != null)
         {
            this._path.splice(0,this._path.length);
            this._path = null;
         }
      }
      
      public function fromArray(param1:Array, param2:ILocale) : void
      {
         if(param1.length >= MIN_SOURCE_ARRAY_LEN)
         {
            this._path = param1[SOURCE_ARRAY_PATH_INDEX];
            this._renderer = param1[SOURCE_ARRAY_RENDERER_INDEX];
            this._level = param1[SOURCE_ARRAY_LEVEL_INDEX];
         }
      }
      
      public function fromObject(param1:Object, param2:ILocale) : void
      {
         if(param1 == null)
         {
            return;
         }
         if(param1.path)
         {
            this._path = param1.path;
         }
         if(param1.renderer)
         {
            this._renderer = param1.renderer;
         }
         if(param1.level)
         {
            this._level = param1.level;
         }
      }
      
      public function getDepthOfPath() : Number
      {
         return this._path != null ? Number(this._path.length) : Number(0);
      }
      
      public function isDrawVehicle() : Boolean
      {
         return this._renderer == VEHICLE_RENDERER;
      }
      
      public function toString() : String
      {
         return "[ResearchDisplayInfo: path = " + this._path + ", renderer = " + this._renderer + ", level = " + this._level + "]";
      }
      
      public function get path() : Array
      {
         return this._path;
      }
      
      public function get renderer() : String
      {
         return this._renderer;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
