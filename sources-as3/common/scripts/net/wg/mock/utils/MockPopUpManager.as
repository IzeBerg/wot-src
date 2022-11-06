package net.wg.mock.utils
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import net.wg.utils.IPopUpManager;
   import net.wg.utils.helpLayout.PopupLayoutVO;
   
   public class MockPopUpManager implements IPopUpManager
   {
       
      
      public function MockPopUpManager()
      {
         super();
      }
      
      public function contains(param1:DisplayObject) : Boolean
      {
         return false;
      }
      
      public function create(param1:String, param2:PopupLayoutVO = null) : DisplayObject
      {
         return null;
      }
      
      public function remove(param1:DisplayObject, param2:Boolean = true) : void
      {
      }
      
      public function removeAll() : void
      {
      }
      
      public function show(param1:DisplayObject, param2:Number = 0, param3:Number = 0, param4:DisplayObjectContainer = null) : void
      {
      }
      
      public function get popupCanvas() : DisplayObjectContainer
      {
         return null;
      }
   }
}
