package net.wg.infrastructure.events
{
   import flash.display.Loader;
   import flash.events.Event;
   
   public class LibraryLoaderEvent extends Event
   {
      
      public static const LOADED:String = "libLoaded";
      
      public static const LOADING_FAILED:String = "libLoadingFailed";
      
      public static const LOADED_COMPLETED:String = "libsLoadedCompleted";
       
      
      public var loader:Loader;
      
      public var url:String;
      
      public var requestedUrl:String;
      
      public function LibraryLoaderEvent(param1:String, param2:Loader = null, param3:String = null, param4:String = null, param5:Boolean = false, param6:Boolean = false)
      {
         super(param1,param5,param6);
         this.loader = param2;
         this.url = param3;
         this.requestedUrl = param4;
      }
      
      override public function clone() : Event
      {
         return new LibraryLoaderEvent(type,this.loader,this.url,this.requestedUrl,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("LibraryLoaderEvent","type","url","requestedUrl","bubbles","cancelable","eventPhase");
      }
   }
}
