package net.wg.gui.components.carousels.controls
{
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.carousels.data.CheckBoxRendererVO;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class CheckBoxRenderer extends UIComponentEx implements IListItemRenderer
   {
       
      
      public var btn:CheckBox = null;
      
      private var _rendererData:CheckBoxRendererVO = null;
      
      private var _index:uint = 0;
      
      private var _selected:Boolean = false;
      
      public function CheckBoxRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btn.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         this.btn.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this.btn.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         this.btn.dispose();
         this.btn = null;
         this._rendererData = null;
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return this._rendererData;
      }
      
      public function setData(param1:Object) : void
      {
         if(param1 != null)
         {
            this._rendererData = CheckBoxRendererVO(param1);
            this.btn.label = this._rendererData.label;
            this.btn.selected = this._rendererData.selected;
            this.btn.enabled = this._rendererData.enabled;
            this.btn.toolTip = this._rendererData.tooltip;
         }
         else
         {
            this._rendererData = null;
            this.btn.visible = false;
         }
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
         this.selected = param1.selected;
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
         return this.btn.selected;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this.btn.selected = param1;
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
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
      }
      
      private function onBtnClickHandler(param1:ButtonEvent) : void
      {
         this.selected = this.btn.selected;
         dispatchEvent(new RendererEvent(RendererEvent.ITEM_CLICK,this._index,true));
      }
   }
}
