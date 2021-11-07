package net.wg.gui.components.controls
{
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ToggleRenderer extends UIComponentEx implements IListItemRenderer
   {
       
      
      public var btn:BlackButton = null;
      
      private var _rendererData:SimpleRendererVO = null;
      
      private var _index:uint = 0;
      
      private var _selected:Boolean = false;
      
      private var _updateSelectedFromData:Boolean = true;
      
      public function ToggleRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btn.toggleEnable = true;
         this.btn.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._rendererData != null)
            {
               this.btn.visible = true;
               this.btn.iconSource = this._rendererData.value;
               if(this._updateSelectedFromData)
               {
                  this.btn.selected = this._rendererData.selected;
               }
               this.btn.tooltip = this._rendererData.tooltip;
               this.btn.enabled = this._rendererData.enabled;
            }
            else
            {
               this.btn.visible = false;
            }
         }
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
            this._rendererData = SimpleRendererVO(param1);
         }
         else
         {
            this._rendererData = null;
         }
         invalidateData();
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
         this.selected = param1.selected;
      }
      
      public function set updateSelectedFromData(param1:Boolean) : void
      {
         this._updateSelectedFromData = param1;
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
         this.selectable = !this.selectable;
         dispatchEvent(new RendererEvent(RendererEvent.ITEM_CLICK,this._index,true));
      }
   }
}
