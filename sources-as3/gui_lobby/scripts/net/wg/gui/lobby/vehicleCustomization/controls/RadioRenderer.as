package net.wg.gui.lobby.vehicleCustomization.controls
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.lobby.vehicleCustomization.data.CustomizationRadioRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class RadioRenderer extends UIComponentEx implements IListItemRenderer
   {
      
      private static const ENABLE_BTN_ALPHA:Number = 1;
      
      private static const DISABLE_BTN_ALPHA:Number = 0.5;
       
      
      public var btn:RadioButton = null;
      
      private var _index:uint = 0;
      
      private var _tooltip:String = "";
      
      private var _tooltipDisabled:String = "";
      
      private var _data:CustomizationRadioRendererVO = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      public function RadioRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._tooltipMgr = App.toolTipMgr;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this._tooltipMgr = null;
         this.btn.dispose();
         this.btn = null;
         if(this._data != null)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return this.btn.label;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = CustomizationRadioRendererVO(param1);
         if(param1 != null)
         {
            this.btn.label = this._data.label;
            this._tooltip = this._data.tooltip;
            this._tooltipDisabled = this._data.tooltipDisabled;
            this.btn.enabled = this._data.enabled;
            this.btn.alpha = !!this._data.enabled ? Number(ENABLE_BTN_ALPHA) : Number(DISABLE_BTN_ALPHA);
         }
         else
         {
            this.btn.visible = false;
         }
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
         this.selected = param1.selected;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         this.btn.enabled = param1;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get owner() : UIComponent
      {
         return this.btn.owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this.btn.owner = param1;
      }
      
      public function get selected() : Boolean
      {
         return this.btn.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this.btn.selected = param1;
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = Values.EMPTY_STR;
         if(this.btn.enabled)
         {
            _loc2_ = this._tooltip;
         }
         else
         {
            _loc2_ = this._tooltipDisabled;
         }
         this._tooltipMgr.showComplex(_loc2_);
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
