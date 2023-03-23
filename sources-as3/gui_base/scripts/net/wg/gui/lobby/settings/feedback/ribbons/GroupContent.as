package net.wg.gui.lobby.settings.feedback.ribbons
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.components.controls.CheckBox;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class GroupContent extends UIComponent
   {
       
      
      private var _allItems:Array;
      
      private var _itemsOffsetsList:Array;
      
      public function GroupContent()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         var _loc2_:DisplayObject = null;
         this._allItems = [];
         var _loc1_:int = 0;
         while(_loc1_ < this.numChildren)
         {
            this._allItems[this._allItems.length] = this.getChildAt(_loc1_);
            _loc1_++;
         }
         this._allItems.sortOn("y",Array.NUMERIC);
         this._itemsOffsetsList = [];
         var _loc3_:DisplayObject = this._allItems[0];
         _loc1_ = 1;
         while(_loc1_ < this._allItems.length)
         {
            _loc2_ = this._allItems[_loc1_];
            this._itemsOffsetsList[this._itemsOffsetsList.length] = _loc2_.y - _loc3_.y - _loc3_.height;
            _loc3_ = _loc2_;
            _loc1_++;
         }
         super.initialize();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:DisplayObject = null;
         super.configUI();
         var _loc2_:int = 0;
         while(_loc2_ < this.numChildren)
         {
            _loc1_ = this.getChildAt(_loc2_);
            if(_loc1_ is CheckBox)
            {
               CheckBox(_loc1_).multiline = true;
               CheckBox(_loc1_).wordWrap = true;
            }
            _loc1_.addEventListener(Event.RENDER,this.renderHandler);
            _loc2_++;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            _loc2_ = this._allItems[0];
            _loc3_ = 1;
            while(_loc3_ < this._allItems.length)
            {
               _loc1_ = this._allItems[_loc3_];
               _loc1_.y = Math.round(_loc2_.y + _loc2_.height + this._itemsOffsetsList[_loc3_ - 1]);
               _loc2_ = _loc1_;
               _loc3_++;
            }
            setSize(actualWidth,_loc1_.y + _loc1_.height);
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      private function renderHandler(param1:Event) : void
      {
         var _loc2_:CheckBox = null;
         (param1.currentTarget as DisplayObject).removeEventListener(Event.RENDER,this.renderHandler);
         if(param1.currentTarget is CheckBox)
         {
            _loc2_ = CheckBox(param1.currentTarget);
            _loc2_.height = _loc2_.textField.height;
         }
         invalidateLayout();
      }
   }
}
