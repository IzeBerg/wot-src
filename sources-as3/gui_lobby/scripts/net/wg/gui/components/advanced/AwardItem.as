package net.wg.gui.components.advanced
{
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.data.AwardItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class AwardItem extends UIComponentEx implements IListItemRenderer
   {
      
      private static const ICONS_OFFSET_Y:int = 11;
       
      
      public var img:Image;
      
      public var txtLabel:TextField;
      
      public var txtCounter:TextField;
      
      private var _data:AwardItemVO;
      
      private var _index:uint = 0;
      
      private var _owner:UIComponent;
      
      public function AwardItem()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.img.removeEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.img.dispose();
         this.img = null;
         this.txtLabel = null;
         this.txtCounter = null;
         this._owner = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.txtCounter.autoSize = this.txtLabel.autoSize = TextFieldAutoSize.LEFT;
         this.txtLabel.mouseEnabled = false;
         this.img.addEventListener(Event.CHANGE,this.onImgChangeHandler);
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function setData(param1:Object) : void
      {
         this.data = param1;
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      protected function updatePosition() : void
      {
         if(this.img.scaleX != this._data.scaleImg || this.img.scaleY != this._data.scaleImg)
         {
            this.img.scaleX = this.img.scaleY = this._data.scaleImg;
         }
         this.img.x = width - this.img.width - this.txtCounter.width >> 1;
         this.img.y = height - this.img.height >> 1;
         this.txtCounter.x = this.img.x + this.img.width | 0;
         this.txtCounter.y = height >> 1;
         if(StringUtils.isNotEmpty(this.txtLabel.htmlText))
         {
            this.txtLabel.x = this.img.x + (this.img.width - this.txtLabel.textWidth >> 1) | 0;
            this.txtLabel.y = this.img.y + this.img.height - this.txtLabel.textHeight + ICONS_OFFSET_Y | 0;
         }
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
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function set data(param1:Object) : void
      {
         this._data = AwardItemVO(param1);
         var _loc2_:Boolean = this._data != null;
         if(_loc2_)
         {
            this.txtLabel.htmlText = this._data.label;
            this.txtCounter.htmlText = this._data.counter;
            this.img.source = this._data.imgSource;
            this.updatePosition();
         }
         this.txtLabel.visible = this.txtCounter.visible = this.img.visible = _loc2_;
         mouseEnabled = _loc2_;
      }
      
      private function onImgChangeHandler(param1:Event) : void
      {
         this.updatePosition();
      }
   }
}
