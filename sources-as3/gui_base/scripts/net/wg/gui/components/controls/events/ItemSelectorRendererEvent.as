package net.wg.gui.components.controls.events
{
   import flash.events.Event;
   
   public class ItemSelectorRendererEvent extends Event
   {
      
      public static const RENDERER_CLICK:String = "btnClick";
      
      public static const RENDERER_OVER:String = "btnOver";
       
      
      public var itemData:String = "";
      
      public var itemIsDisabled:Boolean = false;
      
      public function ItemSelectorRendererEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:String = null, param5:Boolean = false)
      {
         this.itemData = param4;
         this.itemIsDisabled = param5;
         super(param1,param2,param3);
      }
      
      override public function clone() : Event
      {
         return new ItemSelectorRendererEvent(type,bubbles,cancelable);
      }
      
      override public function toString() : String
      {
         return formatToString("ItemSelectorRendererEvent","type","bubbles","cancelable","eventPhase");
      }
   }
}
