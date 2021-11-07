package net.wg.infrastructure.events
{
   import flash.display.Loader;
   import flash.events.Event;
   
   public class IconLoaderEvent extends Event
   {
      
      public static const ICON_LOADED:String = "iconLoaded";
      
      public static const ICON_LOADING_FAILED:String = "iconLoadingFailed";
       
      
      public var loader:Loader;
      
      public var url:String;
      
      public function IconLoaderEvent(param1:String, param2:Loader, param3:String, param4:Boolean = false, param5:Boolean = false)
      {
         super(param1,param4,param5);
         this.loader = param2;
         this.url = param3;
      }
      
      override public function clone() : Event
      {
         return new IconLoaderEvent(type,this.loader,this.url,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("IconLoaderEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
