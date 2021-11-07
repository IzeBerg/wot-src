package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPythonTweenMeta extends IEventDispatcher
   {
       
      
      function getFinishScaleXS() : Number;
      
      function setFinishScaleXS(param1:Number) : void;
      
      function getFinishScaleYS() : Number;
      
      function setFinishScaleYS(param1:Number) : void;
      
      function getFinishXS() : int;
      
      function setFinishXS(param1:int) : void;
      
      function getFinishYS() : int;
      
      function setFinishYS(param1:int) : void;
      
      function getFinishAlphaS() : Number;
      
      function setFinishAlphaS(param1:Number) : void;
      
      function getFinishRotationS() : Number;
      
      function setFinishRotationS(param1:Number) : void;
   }
}
