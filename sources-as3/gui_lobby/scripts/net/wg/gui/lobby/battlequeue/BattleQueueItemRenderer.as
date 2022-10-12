package net.wg.gui.lobby.battlequeue
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.AlignType;
   import net.wg.gui.components.controls.ImageComponent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IUtils;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class BattleQueueItemRenderer extends UIComponentEx implements IListItemRenderer
   {
      
      private static const INVALIDATE_COUNT:String = "invalidateCount";
      
      private static const WARNING_HIGHLIHGHT:String = "Item renderer highlight is null. There is no error, but you can highlight renderers if you want";
      
      private static const HIGHLIGHT_COLOR:uint = 16768409;
       
      
      public var tankType:ImageComponent;
      
      public var textField:TextField;
      
      public var countField:TextField;
      
      public var highlight:Sprite;
      
      private var _index:uint = 0;
      
      private var _selectable:Boolean = false;
      
      private var _selected:Boolean = false;
      
      private var _data:BattleQueueItemVO;
      
      private var _utils:IUtils;
      
      private var _countDefaultColor:uint;
      
      private var _textDefaultColor:uint;
      
      public function BattleQueueItemRenderer()
      {
         super();
      }
      
      override public function toString() : String
      {
         return "[WG BattleQueueItemRenderer " + name + "]";
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._utils = App.utils;
         this._countDefaultColor = this.countField.textColor;
         this._textDefaultColor = this.textField.textColor;
         this.tankType.tooltipEnabled = false;
         this.tankType.horizontalAlign = AlignType.CENTER;
         this.tankType.verticalAlign = AlignType.CENTER;
         this.textField.autoSize = TextFieldAutoSize.LEFT;
         this.highlight.mouseChildren = this.highlight.mouseEnabled = this.highlight.tabEnabled = false;
         this._utils.commons.addEmptyHitArea(this.highlight);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            if(this.highlight)
            {
               _loc1_ = this._data.highlight;
               this.highlight.visible = _loc1_;
               this.countField.textColor = !!_loc1_ ? uint(HIGHLIGHT_COLOR) : uint(this._countDefaultColor);
               this.textField.textColor = !!_loc1_ ? uint(HIGHLIGHT_COLOR) : uint(this._textDefaultColor);
            }
            else
            {
               this._utils.asserter.assertNotNull(this.highlight,WARNING_HIGHLIHGHT);
            }
            if(this.textField && this._data.type != null)
            {
               this.textField.text = this._data.type;
            }
            if(this.countField)
            {
               this.countField.text = String(this._data.count);
            }
            if(this.tankType && StringUtils.isNotEmpty(this._data.icon))
            {
               this.tankType.source = this._data.icon;
            }
         }
         if(isInvalid(INVALIDATE_COUNT) && this._data)
         {
            if(this.countField)
            {
               this.countField.text = String(this._data.count);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.tankType.dispose();
         this.tankType = null;
         this._data = null;
         this.textField = null;
         this.countField = null;
         this.highlight = null;
         this._utils = null;
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function invalidateCount() : void
      {
         invalidate(INVALIDATE_COUNT);
      }
      
      public function setCount(param1:Number) : void
      {
         this._data.count = param1;
         this.invalidateCount();
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:BattleQueueItemVO = BattleQueueItemVO(param1);
         var _loc3_:Boolean = this._data == null || this._data.type != _loc2_.type;
         if(_loc3_)
         {
            this._data = _loc2_;
            invalidateData();
         }
         else if(this._data.count != _loc2_.count)
         {
            this._data.count = _loc2_.count;
            this.invalidateCount();
         }
      }
      
      public function setListData(param1:ListData) : void
      {
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
         return null;
      }
      
      public function set owner(param1:UIComponent) : void
      {
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
         if(this._selected == param1)
         {
            return;
         }
         this._selected = param1;
      }
   }
}
