package net.wg.gui.lobby.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import net.wg.gui.components.advanced.CooldownSlot;
   import net.wg.gui.lobby.components.data.BoosterSlotVO;
   import net.wg.gui.lobby.components.interfaces.IBoosterSlot;
   
   public class BaseBoosterSlot extends CooldownSlot implements IBoosterSlot
   {
       
      
      public var slotBg:MovieClip;
      
      private var _offsettedItems:Vector.<DisplayObject>;
      
      private var _itemsOffset:int = 0;
      
      private var _boosterId:Number = -1;
      
      public function BaseBoosterSlot()
      {
         super();
         constraintsDisabled = true;
         preventAutosizing = true;
         mouseEnabledOnDisabled = true;
         this._offsettedItems = new <DisplayObject>[this.slotBg];
      }
      
      override protected function setState(param1:String) : void
      {
         super.setState(param1);
         if(this.slotBg != null)
         {
            this.slotBg.gotoAndPlay(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         this.slotBg = null;
         if(this._offsettedItems != null)
         {
            this._offsettedItems.splice(0,this._offsettedItems.length);
            this._offsettedItems = null;
         }
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:BoosterSlotVO = null;
         if(param1 != null)
         {
            _loc2_ = BoosterSlotVO(param1);
            this._boosterId = _loc2_.boosterId;
         }
      }
      
      protected function addOffsettedItems(... rest) : void
      {
         var _loc2_:DisplayObject = null;
         for each(_loc2_ in rest)
         {
            if(this._offsettedItems.indexOf(_loc2_) < 0)
            {
               this._offsettedItems.push(_loc2_);
            }
         }
      }
      
      private function updateOffset(param1:int) : void
      {
         var _loc2_:DisplayObject = null;
         for each(_loc2_ in this._offsettedItems)
         {
            if(_loc2_ != null)
            {
               if(this._itemsOffset > 0)
               {
                  _loc2_.x -= this._itemsOffset;
               }
               if(param1 > 0)
               {
                  _loc2_.x += param1;
               }
            }
         }
         if(this._itemsOffset > 0 || param1 > 0)
         {
            setSize(actualWidth,height);
         }
      }
      
      public function get boosterId() : Number
      {
         return this._boosterId;
      }
      
      public function get itemsOffset() : int
      {
         return this._itemsOffset;
      }
      
      public function set itemsOffset(param1:int) : void
      {
         if(this._itemsOffset != param1)
         {
            this.updateOffset(param1);
            this._itemsOffset = param1;
         }
      }
   }
}
