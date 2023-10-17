package net.wg.gui.components.containers
{
   import net.wg.infrastructure.interfaces.IManagedContainer;
   import net.wg.infrastructure.interfaces.IManagedContent;
   
   public class HiddenServiceManagedContainer extends SimpleManagedContainer implements IManagedContainer
   {
       
      
      public function HiddenServiceManagedContainer(param1:String)
      {
         super(param1);
         _manageFocus = false;
      }
      
      public function getTopmostView(param1:Boolean = false) : IManagedContent
      {
         return null;
      }
      
      public function setFocusedView(param1:IManagedContent) : void
      {
      }
      
      public function tryToSetFocus(param1:Boolean = false) : Boolean
      {
         return false;
      }
      
      public function tryToUpdateContent() : void
      {
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
      }
   }
}
