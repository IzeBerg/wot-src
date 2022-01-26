package net.wg.gui.components.advanced
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.data.AwardItemVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class AwardItemEx extends UIComponentEx implements IListItemRenderer, IUpdatable
   {
      
      private static const X_LETTER:String = "x";
       
      
      public var img:Image;
      
      public var highlight:Image;
      
      public var overlay:Image;
      
      public var txtLabel:TextField;
      
      private var _data:AwardItemVO;
      
      private var _index:uint = 0;
      
      private var _owner:UIComponent;
      
      private var _hasSize:Boolean = false;
      
      private var _maxHeight:int = -2147483648;
      
      public function AwardItemEx()
      {
         super();
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         this._hasSize = true;
      }
      
      override protected function onDispose() : void
      {
         this.img.removeEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.img.dispose();
         this.img = null;
         this.highlight.removeEventListener(Event.CHANGE,this.onChangeHandler);
         this.highlight.dispose();
         this.highlight = null;
         this.overlay.removeEventListener(Event.CHANGE,this.onChangeHandler);
         this.overlay.dispose();
         this.overlay = null;
         this.txtLabel = null;
         this._owner = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.txtLabel.mouseEnabled = false;
         this.img.addEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.highlight.addEventListener(Event.CHANGE,this.onChangeHandler);
         this.overlay.addEventListener(Event.CHANGE,this.onChangeHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.img.scaleX = this.img.scaleY = 1;
            this.txtLabel.htmlText = this._data.label;
            this.img.source = this._data.imgSource;
            this.highlight.source = this._data.highlight;
            this.overlay.source = this._data.overlay;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            if(this._hasSize)
            {
               this.img.scaleX = this.img.scaleY = _width / this.img.width;
               this.img.y = height - this.img.height >> 1;
            }
            else if(this._maxHeight > int.MIN_VALUE)
            {
               this.img.y = this._maxHeight - this.img.height >> 1;
               this.highlight.y = this._maxHeight - this.highlight.height >> 1;
               this.overlay.y = this._maxHeight - this.overlay.height >> 1;
               this.highlight.x = this.img.width - this.highlight.width >> 1;
            }
            this.txtLabel.y = this.img.y + this.img.height - this.txtLabel.textHeight ^ 0;
            dispatchEvent(new Event(Event.CHANGE));
         }
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function setData(param1:Object) : void
      {
         this._data = AwardItemVO(param1);
         invalidateData();
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function update(param1:Object) : void
      {
         this.setData(param1);
      }
      
      override public function get width() : Number
      {
         return this.img.width;
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
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      private function onImgChangeHandler(param1:Event) : void
      {
         App.utils.commons.updateTextFieldSize(this.txtLabel);
         if(this.txtLabel.text.charAt(0) == X_LETTER)
         {
            this.txtLabel.x = this.img.width - this.txtLabel.textWidth;
         }
         else
         {
            this.txtLabel.x = this.img.width - this.txtLabel.textWidth >> 1;
         }
         this.onChangeHandler(param1);
      }
      
      private function onChangeHandler(param1:Event) : void
      {
         var _loc2_:int = Image(param1.target).height;
         this._maxHeight = _loc2_ > this._maxHeight ? int(_loc2_) : int(this._maxHeight);
         invalidateSize();
      }
   }
}
