package net.wg.gui.components.containers
{
   public class TooltipContainer extends SimpleManagedContainer
   {
       
      
      public function TooltipContainer(param1:String)
      {
         super(param1);
         _manageFocus = false;
         mouseChildren = false;
         mouseEnabled = false;
      }
   }
}
