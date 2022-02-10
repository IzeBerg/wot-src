package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.base.BaseDAAPIModule;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ImageManagerMeta extends BaseDAAPIModule
   {
       
      
      private var _array:Array;
      
      private var _array1:Array;
      
      public function ImageManagerMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._array)
         {
            this._array.splice(0,this._array.length);
            this._array = null;
         }
         if(this._array1)
         {
            this._array1.splice(0,this._array1.length);
            this._array1 = null;
         }
         super.onDispose();
      }
      
      public final function as_loadImages(param1:Array) : void
      {
         var _loc2_:Array = this._array;
         this._array = param1;
         this.loadImages(this._array);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_unloadImages(param1:Array) : void
      {
         var _loc2_:Array = this._array1;
         this._array1 = param1;
         this.unloadImages(this._array1);
         if(_loc2_)
         {
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function loadImages(param1:Array) : void
      {
         var _loc2_:String = "as_loadImages" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function unloadImages(param1:Array) : void
      {
         var _loc2_:String = "as_unloadImages" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
