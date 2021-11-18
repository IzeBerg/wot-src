package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface ICustomizationPropertiesSheetMeta extends IEventDispatcher
   {
       
      
      function onActionBtnClickS(param1:int, param2:int) : void;
      
      function elementControlsHideS() : void;
      
      function onCloseS() : void;
      
      function registerInscriptionControllerS(param1:Object, param2:Object) : void;
      
      function as_setDataAndShow(param1:Object) : void;
      
      function as_setArrowsStates(param1:Boolean, param2:Boolean) : void;
      
      function as_hide() : void;
   }
}
