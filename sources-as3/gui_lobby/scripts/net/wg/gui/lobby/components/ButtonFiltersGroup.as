package net.wg.gui.lobby.components
{
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import scaleform.clik.controls.Button;
   import scaleform.clik.controls.ButtonGroup;
   
   public class ButtonFiltersGroup extends ButtonGroup
   {
       
      
      private var _minSelectedCount:uint;
      
      private var _selectedCount:uint = 0;
      
      public function ButtonFiltersGroup(param1:uint = 1, param2:String = null, param3:DisplayObjectContainer = null)
      {
         super(param2,param3);
         this._minSelectedCount = param1;
      }
      
      override protected function updateSelectedButton(param1:Button, param2:Boolean = true) : void
      {
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc3_:int = length;
         if(_loc3_ > this._minSelectedCount)
         {
            _loc4_ = 0;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               if(getButtonAt(_loc5_).selected)
               {
                  _loc4_++;
               }
               _loc5_++;
            }
            App.utils.asserter.assert(_loc4_ >= this._minSelectedCount,"selectedCount must be greater or equal then minSelectedCount");
            if(_loc4_ == this._minSelectedCount)
            {
               this.setSelectedButtonsEnabled(false);
            }
            else if(_loc4_ > this._minSelectedCount)
            {
               if(this._selectedCount == this._minSelectedCount)
               {
                  this.setSelectedButtonsEnabled(true);
               }
            }
            this._selectedCount = _loc4_;
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function getSelectedButtons() : Vector.<Button>
      {
         var _loc3_:Button = null;
         var _loc1_:int = length;
         var _loc2_:Vector.<Button> = new Vector.<Button>();
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_ = getButtonAt(_loc4_);
            if(_loc3_.selected)
            {
               _loc2_.push(_loc3_);
            }
            _loc4_++;
         }
         return _loc2_;
      }
      
      public function removeAllButtons() : void
      {
         while(length > 0)
         {
            removeButton(getButtonAt(0));
         }
      }
      
      private function setSelectedButtonsEnabled(param1:Boolean) : void
      {
         var _loc2_:Button = null;
         var _loc3_:int = 0;
         while(_loc3_ < length)
         {
            _loc2_ = getButtonAt(_loc3_);
            if(_loc2_.selected)
            {
               _loc2_.enabled = param1;
            }
            _loc3_++;
         }
      }
      
      public function get minSelectedCount() : uint
      {
         return this._minSelectedCount;
      }
      
      public function set minSelectedCount(param1:uint) : void
      {
         this._minSelectedCount = param1;
      }
   }
}
