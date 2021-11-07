package net.wg.gui.components.carousels.controls
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.VO.SimpleRendererVO;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.gui.interfaces.IButtonIconTextTransparent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IUniversalBtnToggleIndicator;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class GhostToggleRenderer extends UIComponentEx implements IListItemRenderer
   {
       
      
      public var toggleIndicator:IUniversalBtnToggleIndicator = null;
      
      public var toggleGlow:Sprite = null;
      
      public var image:Image = null;
      
      public var btn:IButtonIconTextTransparent = null;
      
      private var _rendererData:SimpleRendererVO = null;
      
      private var _index:uint = 0;
      
      private var _owner:UIComponent = null;
      
      private var _selected:Boolean = false;
      
      public function GhostToggleRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.btn.addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         this.toggleGlow.visible = false;
         this.toggleGlow.mouseChildren = this.toggleGlow.mouseEnabled = false;
         this.toggleIndicator.mouseChildren = this.toggleIndicator.mouseEnabled = false;
         this.image.visible = false;
         this.image.mouseEnabled = this.image.mouseChildren = false;
         this.image.addEventListener(Event.CHANGE,this.onIconChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!this._rendererData)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._rendererData != null)
            {
               this.image.visible = true;
               this.image.source = this._rendererData.value;
               this.btn.tooltip = this._rendererData.tooltip;
               this.btn.enabled = this._rendererData.enabled;
            }
            else
            {
               this.image.visible = false;
            }
         }
         if(isInvalid(InvalidationType.LAYOUT))
         {
            this.image.x = this.btn.width - this.image.width >> 1;
            this.image.y = this.btn.height - this.image.height >> 1;
         }
      }
      
      override protected function onDispose() : void
      {
         this.btn.removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         this.btn.dispose();
         this.btn = null;
         this.image.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.image.dispose();
         this.image = null;
         this.toggleIndicator.dispose();
         this.toggleIndicator = null;
         this.toggleGlow = null;
         this._rendererData = null;
         this._owner = null;
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
            this.selected = this._rendererData.selected;
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
         return this._selected;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this.selected = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(this._selected != param1)
         {
            this._selected = param1;
            this.toggleIndicator.selected = this._selected;
            this.toggleGlow.visible = this._selected;
         }
      }
      
      private function onBtnClickHandler(param1:ButtonEvent) : void
      {
         this.selected = !this.selected;
         dispatchEvent(new RendererEvent(RendererEvent.ITEM_CLICK,this._index,true));
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidateLayout();
      }
   }
}
