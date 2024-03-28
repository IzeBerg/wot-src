package net.wg.infrastructure.interfaces
{
   public interface IManagedContainer extends ISimpleManagedContainer
   {
       
      
      function updateStage(param1:Number, param2:Number) : void;
      
      function tryToSetFocus(param1:Boolean = false) : Boolean;
      
      function tryToUpdateContent() : void;
      
      function setFocusedView(param1:IManagedContent) : void;
      
      function getTopmostView(param1:Boolean = false) : IManagedContent;
   }
}
