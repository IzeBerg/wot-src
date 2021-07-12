package net.wg.gui.components.tooltips.inblocks.components
{
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.data.ImageRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class ImageRenderer extends UIComponentEx implements IListItemRenderer
   {
       
      
      public var img:Image = null;
      
      private var _index:uint;
      
      private var _owner:UIComponent = null;
      
      private var _data:ImageRendererVO = null;
      
      private var _selectable:Boolean = false;
      
      private var _selected:Boolean = false;
      
      public function ImageRenderer()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this._owner = null;
         this._data = null;
         this.img.dispose();
         this.img = null;
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = ImageRendererVO(param1);
         this.img.source = this._data.imgSrc;
         this.img.alpha = this._data.imgAlpha;
      }
      
      public function setListData(param1:ListData) : void
      {
         this.img.source = param1.label;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._selectable = param1;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         this._selected = param1;
      }
   }
}
