package net.wg.gui.components.controls
{
   import flash.events.Event;
   
   public class ListItemRendererWithFocusOnDis extends SoundListItemRenderer
   {
       
      
      public function ListItemRendererWithFocusOnDis()
      {
         super();
      }
      
      override protected function changeFocus() : void
      {
         var _loc1_:String = null;
         if(_focusIndicator == null)
         {
            setState(_focused || _displayFocus ? "over" : "out");
            if(_pressedByKeyboard && !_focused)
            {
               _pressedByKeyboard = false;
            }
         }
         else
         {
            if(_focusIndicator.totalframes == 1)
            {
               _focusIndicator.visible = _focused > 0;
            }
            else
            {
               _loc1_ = "state" + _focused;
               if(_focusIndicatorLabelHash[_loc1_])
               {
                  _newFocusIndicatorFrame = "state" + _focused;
               }
               else
               {
                  _newFocusIndicatorFrame = _focused || _displayFocus ? "show" : "hide";
               }
               invalidateState();
            }
            if(_pressedByKeyboard && !_focused)
            {
               setState("kb_release");
               _pressedByKeyboard = false;
            }
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         if(_selected == param1)
         {
            return;
         }
         _selected = param1;
         if(enabled)
         {
            if(!_focused)
            {
               setState("toggle");
            }
            else if(_pressedByKeyboard && _focusIndicator != null)
            {
               setState("kb_selecting");
            }
            else
            {
               setState("selecting");
            }
         }
         else
         {
            setState("disabled");
         }
         if(owner)
         {
            _loc2_ = _selected && owner != null && checkOwnerFocused();
            if(enabled)
            {
               setState(_loc2_ && _focusIndicator == null ? "selecting" : "toggle");
            }
            displayFocus = _loc2_;
         }
         validateNow();
         dispatchEvent(new Event(Event.SELECT));
      }
   }
}
