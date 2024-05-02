package net.wg.gui.lobby.questsWindow
{
   import flash.display.DisplayObject;
   
   public class QuestWindowUtils
   {
      
      private static var _instance:QuestWindowUtils = null;
       
      
      public function QuestWindowUtils()
      {
         super();
      }
      
      public static function get instance() : QuestWindowUtils
      {
         if(_instance == null)
         {
            _instance = new QuestWindowUtils();
         }
         return _instance;
      }
      
      public function setItemsVisible(param1:Vector.<DisplayObject>, param2:Boolean) : void
      {
         var _loc3_:DisplayObject = null;
         for each(_loc3_ in param1)
         {
            _loc3_.visible = param2;
         }
      }
   }
}
