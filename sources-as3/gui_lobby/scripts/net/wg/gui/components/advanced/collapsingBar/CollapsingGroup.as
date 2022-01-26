package net.wg.gui.components.advanced.collapsingBar
{
   import flash.events.Event;
   import flash.geom.Point;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.containers.ButtonGroupEx;
   import scaleform.clik.controls.Button;
   
   public class CollapsingGroup extends ButtonGroupEx
   {
       
      
      private var _bar:CollapsingBar;
      
      private var _maxExpandedSize:Point;
      
      private var _collapsedButtonSize:Point;
      
      private var _sizeOffset:Point;
      
      public function CollapsingGroup(param1:CollapsingBar)
      {
         this._maxExpandedSize = new Point();
         this._collapsedButtonSize = new Point();
         this._sizeOffset = new Point();
         super(null,null);
         this._bar = param1;
      }
      
      override public function dispose() : void
      {
         this._maxExpandedSize = null;
         this._collapsedButtonSize = null;
         this._sizeOffset = null;
         this._bar = null;
         super.dispose();
      }
      
      public function get maxExpandedSize() : Point
      {
         return this._maxExpandedSize;
      }
      
      public function get collapsedButtonSize() : Point
      {
         return this._collapsedButtonSize;
      }
      
      public function get sizeOffset() : Point
      {
         return this._sizeOffset;
      }
      
      public function removeAllButtons() : void
      {
         while(length > 0)
         {
            removeButton(getButtonAt(0));
         }
         this._maxExpandedSize.x = 0;
         this._maxExpandedSize.y = 0;
      }
      
      public function collapseAll(param1:Boolean) : void
      {
         var _loc2_:ResizableButton = null;
         var _loc3_:int = length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = ResizableButton(getButtonAt(_loc4_));
            if(!_loc2_.selected && param1)
            {
               this.collapse(_loc2_);
            }
            else
            {
               this.expand(_loc2_);
            }
            _loc4_++;
         }
      }
      
      override protected function updateSelectedButton(param1:Button, param2:Boolean = true) : void
      {
         if(param2 && param1 == selectedButton)
         {
            return;
         }
         var _loc3_:Boolean = !param2 && param1 == selectedButton && param1.allowDeselect;
         var _loc4_:ResizableButton = ResizableButton(selectedButton);
         if(param2)
         {
            selectedButton = param1;
            if(this._bar.isBarCollapsed)
            {
               this.expand(ResizableButton(param1));
            }
         }
         if(param2 && _loc4_ != null)
         {
            _loc4_.selected = false;
            if(this._bar.isBarCollapsed)
            {
               this.collapse(_loc4_);
            }
         }
         if(_loc3_)
         {
            selectedButton = null;
         }
         else if(!param2)
         {
            return;
         }
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      private function expand(param1:ResizableButton) : void
      {
         param1.label = param1.data.label;
         var _loc2_:Point = !!this._bar.isBarCollapsed ? this._maxExpandedSize : param1.getOriginSize();
         param1.setSize(_loc2_.x + this._sizeOffset.x,_loc2_.y + this._sizeOffset.y);
      }
      
      private function collapse(param1:ResizableButton) : void
      {
         param1.label = Values.EMPTY_STR;
         param1.setSize(this._collapsedButtonSize.x + this._sizeOffset.x,this._collapsedButtonSize.y + this._sizeOffset.y);
      }
   }
}
