package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IAcousticPopoverMeta extends IEventDispatcher
   {
       
      
      function onActionStartS(param1:String) : void;
      
      function onSpeakerClickS(param1:String) : void;
      
      function as_setData(param1:Object) : void;
      
      function as_onItemPlay(param1:Array) : void;
      
      function as_onItemSelect(param1:Array) : void;
      
      function as_setEnable(param1:Boolean) : void;
      
      function as_updateBtnEnabled(param1:String, param2:Boolean) : void;
   }
}
