package net.wg.gui.lobby.badges
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.badges.data.BadgeSuffixItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   
   public class SuffixItem extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const GAP:int = 20;
      
      private static const INV_SELECTED:String = "inv_selected";
      
      private static const FOOTNOTE_MARK_Y_OFFSET:int = -2;
       
      
      public var radioButton:RadioButton;
      
      public var textField:TextField;
      
      public var isShortState:Boolean = false;
      
      private var _data:BadgeSuffixItemVO = null;
      
      private var _selected:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function SuffixItem()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.radioButton.visible = !this.isShortState;
               this.textField.y = !!this._data.hasFootnoteMark ? Number(FOOTNOTE_MARK_Y_OFFSET) : Number(0);
               invalidate(INV_SELECTED);
            }
            if(isInvalid(INV_SELECTED))
            {
               this.radioButton.selected = this._selected;
               this.textField.htmlText = !!this._selected ? this._data.activeLabel : this._data.label;
               App.utils.commons.updateTextFieldSize(this.textField,true,false);
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.textField.x = !!this.isShortState ? Number(0) : Number(GAP);
               if(this.radioButton.visible)
               {
                  this.radioButton.width = this.textField.x + this.textField.width;
               }
               width = this.textField.x + this.textField.width;
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.radioButton.dispose();
         this.radioButton = null;
         this.textField = null;
         this._data = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function getId() : int
      {
         return this._data != null ? int(this._data.id) : int(0);
      }
      
      public function update(param1:Object) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = BadgeSuffixItemVO(param1);
            invalidateData();
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected != param1)
         {
            this._selected = param1;
            invalidate(INV_SELECTED);
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showSpecial(this._data.tooltip,null,this._data.id);
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
