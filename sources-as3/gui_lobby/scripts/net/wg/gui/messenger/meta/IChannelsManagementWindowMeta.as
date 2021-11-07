package net.wg.gui.messenger.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IChannelsManagementWindowMeta extends IEventDispatcher
   {
       
      
      function getSearchLimitLabelS() : String;
      
      function searchTokenS(param1:String) : void;
      
      function joinToChannelS(param1:Number) : void;
      
      function createChannelS(param1:String, param2:Boolean, param3:String, param4:String) : void;
      
      function as_hideChannelNameInput(param1:Boolean) : void;
      
      function as_freezSearchButton(param1:Boolean) : void;
      
      function as_getDataProvider() : Object;
   }
}
