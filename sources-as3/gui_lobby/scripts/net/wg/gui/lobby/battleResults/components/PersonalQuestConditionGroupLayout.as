package net.wg.gui.lobby.battleResults.components
{
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import net.wg.gui.components.containers.Group;
   import net.wg.infrastructure.interfaces.IBaseLayout;
   
   public class PersonalQuestConditionGroupLayout implements IBaseLayout
   {
      
      private static const SECOND_ITEM_OFFSET_Y:int = -4;
      
      private static const LAYOUT_GAP:int = 8;
       
      
      private var _baseDisposed:Boolean = false;
      
      private var _target:Group = null;
      
      public function PersonalQuestConditionGroupLayout()
      {
         super();
      }
      
      protected function onDispose() : void
      {
         this._target = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function get target() : Object
      {
         return this._target;
      }
      
      public function set target(param1:Object) : void
      {
         this._target = Group(param1);
      }
      
      public function invokeLayout() : Object
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:uint = this._target.numChildren;
         var _loc2_:DisplayObject = null;
         _loc3_ = 0;
         if(_loc1_ > 0)
         {
            _loc2_ = this._target.getChildAt(0);
            _loc3_ = _loc2_.height + SECOND_ITEM_OFFSET_Y;
            _loc4_ = 1;
            while(_loc4_ < _loc1_)
            {
               _loc2_ = this._target.getChildAt(_loc4_);
               _loc2_.y = _loc3_;
               _loc3_ += _loc2_.height + LAYOUT_GAP;
               _loc4_++;
            }
         }
         return new Point(this._target.actualWidth,this._target.actualHeight);
      }
   }
}
