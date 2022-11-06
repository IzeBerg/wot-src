package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IGammaWizardViewMeta extends IEventDispatcher
   {
       
      
      function onCloseS() : void;
      
      function onApplyS() : void;
      
      function onChangeGammaS(param1:Number) : void;
      
      function onResetS() : void;
      
      function updateTextureS(param1:int, param2:int, param3:int) : void;
      
      function as_initData(param1:Object) : void;
   }
}
