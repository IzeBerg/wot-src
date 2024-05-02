package net.wg.gui.lobby.missions.components
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import net.wg.gui.components.containers.GroupEx;
   
   public class AwardGroup extends GroupEx
   {
      
      private static const INVALIDATE_CHILD_BUTTON_MODE:String = "invalidateChildButtonMode";
       
      
      private var _childButtonMode:Boolean = true;
      
      public function AwardGroup()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         super.draw();
         if(isInvalid(INVALIDATE_CHILD_BUTTON_MODE))
         {
            _loc2_ = 0;
            while(_loc2_ < numChildren)
            {
               _loc1_ = getChildAt(_loc2_) as Sprite;
               if(_loc1_)
               {
                  _loc1_.buttonMode = this._childButtonMode;
               }
               _loc2_++;
            }
         }
      }
      
      override public function addChild(param1:DisplayObject) : DisplayObject
      {
         var _loc2_:DisplayObject = null;
         _loc2_ = super.addChild(param1);
         Sprite(_loc2_).buttonMode = this._childButtonMode;
         Sprite(_loc2_).mouseChildren = false;
         return _loc2_;
      }
      
      public function setChildButtonMode(param1:Boolean) : void
      {
         this._childButtonMode = param1;
         invalidate(INVALIDATE_CHILD_BUTTON_MODE);
      }
   }
}
