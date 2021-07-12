package net.wg.gui.components.containers
{
   public class CursorManagedContainer extends SimpleManagedContainer
   {
       
      
      public function CursorManagedContainer(param1:String)
      {
         super(param1);
         _manageFocus = false;
         enabled = false;
         mouseEnabled = false;
         mouseChildren = false;
      }
   }
}
