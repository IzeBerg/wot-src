package net.wg.mock.utils
{
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import net.wg.infrastructure.interfaces.IManagedContent;
   import net.wg.infrastructure.interfaces.IView;
   import net.wg.utils.IFocusHandler;
   import scaleform.clik.ui.InputDetails;
   
   public class MockFocusHandler implements IFocusHandler
   {
       
      
      public function MockFocusHandler()
      {
         super();
      }
      
      public function dispose() : void
      {
      }
      
      public function getFocus(param1:uint) : InteractiveObject
      {
         return null;
      }
      
      public function getModalFocus() : IView
      {
         return null;
      }
      
      public function hasModalFocus(param1:IView) : Boolean
      {
         return false;
      }
      
      public function input(param1:InputDetails) : void
      {
      }
      
      public function setFocus(param1:InteractiveObject, param2:uint = 0, param3:Boolean = false) : void
      {
      }
      
      public function setModalFocus(param1:IManagedContent) : void
      {
      }
      
      public function set stage(param1:Stage) : void
      {
      }
   }
}
