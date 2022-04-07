package net.wg.gui.lobby.badges
{
   import flash.events.Event;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.badges.data.BadgeSuffixVO;
   import net.wg.gui.lobby.badges.events.BadgesEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class BadgesSuffixSettings extends UIComponentEx implements IUpdatableComponent
   {
       
      
      public var showCheckBox:CheckBox = null;
      
      public var suffixContainer:SuffixContainer = null;
      
      private var _data:BadgeSuffixVO = null;
      
      public function BadgesSuffixSettings()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.showCheckBox.autoSize = TextFieldAutoSize.LEFT;
         this.suffixContainer.addEventListener(Event.RESIZE,this.onSuffixContainerResizeHandler);
         this.suffixContainer.addEventListener(BadgesEvent.SUFFIX_BADGE_SELECT,this.onSuffixBadgeSelectHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.showCheckBox.selected = this._data.checkboxSelected;
               this.showCheckBox.addEventListener(Event.SELECT,this.onShowCheckBoxSelectHandler);
               this.showCheckBox.label = this._data.checkboxLabel;
               this.showCheckBox.toolTip = this._data.checkboxTooltip;
               this.showCheckBox.validateNow();
               this.suffixContainer.enabled = this._data.checkboxSelected;
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.suffixContainer.x = this.showCheckBox.x + this.showCheckBox.width | 0;
               width = this.suffixContainer.x + this.suffixContainer.width;
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.showCheckBox.removeEventListener(Event.SELECT,this.onShowCheckBoxSelectHandler);
         this.showCheckBox.dispose();
         this.showCheckBox = null;
         this.suffixContainer.removeEventListener(Event.RESIZE,this.onSuffixContainerResizeHandler);
         this.suffixContainer.removeEventListener(BadgesEvent.SUFFIX_BADGE_SELECT,this.onSuffixBadgeSelectHandler);
         this.suffixContainer.dispose();
         this.suffixContainer = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = BadgeSuffixVO(param1);
            this.suffixContainer.update(this._data.items);
            this.suffixContainer.setSelectedIdx(this._data.selectedItemIdx);
            invalidateData();
         }
      }
      
      private function onShowCheckBoxSelectHandler(param1:Event) : void
      {
         var _loc2_:Boolean = this.showCheckBox.selected;
         this.suffixContainer.enabled = _loc2_;
         if(_loc2_)
         {
            dispatchEvent(new BadgesEvent(BadgesEvent.SUFFIX_BADGE_SELECT,false,false,this.suffixContainer.getSelectedId()));
         }
         else
         {
            dispatchEvent(new BadgesEvent(BadgesEvent.SUFFIX_BADGE_DESELECT));
         }
      }
      
      private function onSuffixBadgeSelectHandler(param1:BadgesEvent) : void
      {
         this.showCheckBox.selected = true;
         this.showCheckBox.dispatchEvent(new Event(Event.SELECT));
      }
      
      private function onSuffixContainerResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
