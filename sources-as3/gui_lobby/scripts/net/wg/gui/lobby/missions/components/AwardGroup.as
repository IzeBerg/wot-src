package net.wg.gui.lobby.missions.components
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.gui.components.containers.GroupEx;
   
   public class AwardGroup extends GroupEx
   {
       
      
      public function AwardGroup()
      {
         super();
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         _loc2_ = super.addChild(param1);
         Sprite(_loc2_).buttonMode = true;
         Sprite(_loc2_).mouseChildren = false;
         return _loc2_;
      }
   }
}
