package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.ComponentState;
   import net.wg.data.constants.SoundTypes;
   import scaleform.clik.constants.InvalidationType;
   
   public class SlotButtonBase extends SoundButtonEx
   {
      
      protected static const INV_SELECTION:String = "invalidSelection";
       
      
      public var border:MovieClip;
      
      public var allowSelectionDispatch:Boolean = true;
      
      public function SlotButtonBase()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.border = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = _newFrame;
         super.draw();
         if(isInvalid(INV_SELECTION))
         {
            if(this.allowSelectionDispatch)
            {
               dispatchEvent(new Event(Event.SELECT));
            }
         }
         if(_loc1_ && isInvalid(InvalidationType.STATE))
         {
            this.alpha = _loc1_ != ComponentState.DISABLED ? Number(ENABLED_ALPHA) : Number(DISABLED_ALPHA);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         useFocusedAsSelect = true;
         soundType = SoundTypes.RNDR_NORMAL;
         preventAutosizing = true;
         constraintsDisabled = true;
      }
      
      override public function set alpha(param1:Number) : void
      {
         if(alpha == param1)
         {
            return;
         }
         super.alpha = param1;
         this.border.alpha = Math.max(1,1 / param1);
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
               setState(ComponentState.TOGGLE);
            }
            else if(_pressedByKeyboard && _focusIndicator != null)
            {
               setState(ComponentState.KB_SELECTING);
            }
            else
            {
               setState(ComponentState.OVER);
            }
            if(owner)
            {
               _loc2_ = _selected && owner != null && checkOwnerFocused();
               setState(_loc2_ && _focusIndicator == null ? ComponentState.SELECTING : ComponentState.TOGGLE);
               displayFocus = _loc2_;
            }
         }
         else
         {
            setState(ComponentState.DISABLED);
         }
         invalidate(INV_SELECTION);
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         if(!param1.buttonDown && enabled)
         {
            setState(ComponentState.OVER);
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         if(!param1.buttonDown && enabled)
         {
            setState(ComponentState.OUT);
         }
      }
   }
}
