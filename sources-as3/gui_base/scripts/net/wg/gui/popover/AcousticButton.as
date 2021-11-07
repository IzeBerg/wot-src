package net.wg.gui.popover
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.popover.data.AcousticItemData;
   
   public class AcousticButton extends SoundButtonEx
   {
       
      
      public var icon:UILoaderAlt = null;
      
      public var anim:MovieClip = null;
      
      private var _itemData:AcousticItemData = null;
      
      private var _isInteractive:Boolean = false;
      
      private var _isAnimate:Boolean = false;
      
      public function AcousticButton()
      {
         super();
         preventAutosizing = true;
         constraintsDisabled = true;
         this.anim.visible = false;
         this.anim.stop();
         mouseEnabledOnDisabled = true;
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.anim = null;
         this._itemData = null;
         super.onDispose();
      }
      
      public function get id() : String
      {
         return Boolean(this._itemData) ? this._itemData.id : Values.EMPTY_STR;
      }
      
      public function setData(param1:AcousticItemData) : void
      {
         this._itemData = param1;
         label = this._itemData.label;
         this.icon.source = this._itemData.img;
         this._isInteractive = this._itemData.isInteractive;
         tooltip = this._itemData.tooltip;
         super.enabled = enabled && this._isInteractive;
         invalidateData();
      }
      
      public function set animate(param1:Boolean) : void
      {
         if(this._isAnimate == param1)
         {
            return;
         }
         this._isAnimate = param1;
         if(param1)
         {
            this.anim.gotoAndPlay(1);
         }
         else
         {
            this.anim.stop();
         }
         this.anim.visible = param1;
      }
      
      override public function set selected(param1:Boolean) : void
      {
         var _loc2_:Boolean = false;
         if(!this._isInteractive || _selected == param1)
         {
            return;
         }
         _selected = param1;
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
         if(owner)
         {
            _loc2_ = _selected && owner != null && checkOwnerFocused();
            setState(_loc2_ && _focusIndicator == null ? "selecting" : "toggle");
            displayFocus = _loc2_;
         }
         validateNow();
         dispatchEvent(new Event(Event.SELECT));
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1 && this._isInteractive;
      }
   }
}
