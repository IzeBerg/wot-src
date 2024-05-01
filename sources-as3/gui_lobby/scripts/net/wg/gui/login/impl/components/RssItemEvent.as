package net.wg.gui.login.impl.components
{
   import flash.events.Event;
   import net.wg.gui.login.impl.vo.RssItemVo;
   
   public class RssItemEvent extends Event
   {
      
      public static const ITEM_SIZE_INVALID:String = "itemSizeInvalid";
      
      public static const TO_REED_MORE:String = "toReedMore";
      
      public static const ON_HIDED:String = "itemHided";
       
      
      public var rssVo:RssItemVo = null;
      
      public function RssItemEvent(param1:String, param2:Boolean = false, param3:Boolean = false, param4:RssItemVo = null)
      {
         super(param1,param2,param3);
         this.rssVo = param4;
      }
      
      override public function clone() : Event
      {
         return new RssItemEvent(type,bubbles,cancelable,this.rssVo);
      }
   }
}
