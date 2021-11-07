package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IColorSettingsViewMeta extends IEventDispatcher
   {
       
      
      function onCloseS() : void;
      
      function onApplyS(param1:Object) : void;
      
      function onResetS() : void;
      
      function onSettingsChangeS(param1:String, param2:Object) : void;
      
      function onTabSelectedS(param1:int) : void;
      
      function setViewWidthS(param1:int) : void;
      
      function moveSpaceS(param1:Number, param2:Number, param3:Number) : void;
      
      function as_initData(param1:Object) : void;
      
      function as_updateData(param1:int, param2:Object) : void;
   }
}
