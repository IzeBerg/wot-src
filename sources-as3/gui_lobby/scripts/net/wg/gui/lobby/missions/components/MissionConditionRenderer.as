package net.wg.gui.lobby.missions.components
{
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.advanced.interfaces.IProgressBarAnim;
   import net.wg.gui.lobby.missions.data.ConditionRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class MissionConditionRenderer extends UIComponentEx implements IListItemRenderer
   {
      
      private static const ICON_LEFT:int = -32;
      
      private static const ICON_TOP:int = -24;
      
      private static const DESC_WIDTH_MAX:int = 220;
      
      private static const PROGRESS_DESC_TOP_CONDITION:int = 1;
      
      private static const PROGRESS_DESC_TOP_DEFAULT:int = 5;
       
      
      public var icon:IImage = null;
      
      public var descTF:TextField = null;
      
      public var progressDescTF:TextField = null;
      
      public var progressBar:IProgressBarAnim = null;
      
      public var separatorIcon:Sprite = null;
      
      public var hit:Sprite = null;
      
      protected var rendererData:ConditionRendererVO = null;
      
      private var _owner:UIComponent = null;
      
      private var _index:uint = 0;
      
      private var _descIsTruncated:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _commons:ICommons;
      
      public function MissionConditionRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.rendererData != null && isInvalid(InvalidationType.DATA))
         {
            gotoAndStop(this.rendererData.state);
            if(StringUtils.isNotEmpty(this.rendererData.icon))
            {
               this.icon.source = this.rendererData.icon;
               this.icon.visible = true;
            }
            else
            {
               this.icon.visible = false;
            }
            if(this.rendererData.useWideTextField && !this.rendererData.isCondition)
            {
               this.descTF.width = this.getDescTextFieldSize();
            }
            this._descIsTruncated = this.truncateHtmlTextMultiline(this.descTF,this.rendererData.description,this.rendererData.maxDescLines);
            this._commons.updateTextFieldSize(this.descTF,false,true);
            if(StringUtils.isNotEmpty(this.rendererData.title))
            {
               this.progressDescTF.y = !!this.rendererData.isCondition ? Number(PROGRESS_DESC_TOP_CONDITION) : Number(PROGRESS_DESC_TOP_DEFAULT);
               this.progressDescTF.htmlText = this.rendererData.title;
               this._commons.updateTextFieldSize(this.progressDescTF,true,false);
            }
            if(this.separatorIcon != null)
            {
               this.separatorIcon.visible = StringUtils.isNotBlank(this.progressDescTF.text);
            }
            if(this.progressBar != null)
            {
               this.progressBar.setData(this.rendererData.progress);
               if(!this.progressBar.hasEventListener(MouseEvent.MOUSE_OVER))
               {
                  this.progressBar.addEventListener(MouseEvent.MOUSE_OVER,this.onProgressBarMouseOverHandler);
                  this.progressBar.addEventListener(MouseEvent.MOUSE_OUT,this.onProgressBarMouseOutHandler);
               }
               this.progressBar.visible = true;
            }
            if(StringUtils.isNotEmpty(this.descTF.text))
            {
               _width = this.descTF.x + this.descTF.width;
            }
            else
            {
               _width = this.progressDescTF.x + this.progressDescTF.width;
            }
            _height = this.descTF.y + this.descTF.textHeight;
            invalidateSize();
            if(this.hit)
            {
               this.hit.width = _width;
               this.hit.height = _height;
            }
         }
         if(this.icon.visible && isInvalid(InvalidationType.SIZE))
         {
            this.updateIconLayout();
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         this.progressDescTF.autoSize = TextFieldAutoSize.LEFT;
         this.progressDescTF.mouseEnabled = false;
         var _loc1_:DisplayObjectContainer = DisplayObjectContainer(this.icon);
         _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
         this.descTF.addEventListener(MouseEvent.MOUSE_OVER,this.onDescTFMouseOverHandler);
         this.descTF.addEventListener(MouseEvent.MOUSE_OUT,this.onDescTFMouseOutHandler);
         if(this.hit)
         {
            this.hit.addEventListener(MouseEvent.MOUSE_OVER,this.onDescTFMouseOverHandler);
            this.hit.addEventListener(MouseEvent.MOUSE_OUT,this.onDescTFMouseOutHandler);
         }
         if(this.progressBar != null)
         {
            this.progressBar.visible = false;
            this.progressBar.validateNow();
         }
      }
      
      override protected function onDispose() : void
      {
         this.descTF.removeEventListener(MouseEvent.MOUSE_OVER,this.onDescTFMouseOverHandler);
         this.descTF.removeEventListener(MouseEvent.MOUSE_OUT,this.onDescTFMouseOutHandler);
         if(this.hit)
         {
            this.hit.removeEventListener(MouseEvent.MOUSE_OVER,this.onDescTFMouseOverHandler);
            this.hit.removeEventListener(MouseEvent.MOUSE_OUT,this.onDescTFMouseOutHandler);
            this.hit = null;
         }
         this.icon.dispose();
         this.icon = null;
         if(this.progressBar != null)
         {
            this.progressBar.removeEventListener(MouseEvent.MOUSE_OVER,this.onProgressBarMouseOverHandler);
            this.progressBar.removeEventListener(MouseEvent.MOUSE_OUT,this.onProgressBarMouseOutHandler);
            this.progressBar.dispose();
            this.progressBar = null;
         }
         this.descTF = null;
         this.progressDescTF = null;
         this.separatorIcon = null;
         this._owner = null;
         this._toolTipMgr = null;
         this._commons = null;
         this.rendererData = null;
         super.onDispose();
      }
      
      public function getData() : Object
      {
         return this.rendererData;
      }
      
      public function setData(param1:Object) : void
      {
         if(param1 != null && param1 != this.rendererData)
         {
            this.rendererData = ConditionRendererVO(param1);
            invalidateData();
         }
      }
      
      public function setListData(param1:ListData) : void
      {
         this.index = param1.index;
      }
      
      public function truncateHtmlTextMultiline(param1:TextField, param2:String, param3:uint = 1) : Boolean
      {
         var _loc4_:String = "..";
         var _loc5_:String = param2;
         param1.htmlText = _loc5_;
         var _loc6_:Boolean = false;
         while(param1.numLines > param3)
         {
            _loc5_ = _loc5_.substr(0,_loc5_.length - 1);
            param1.htmlText = _loc5_ + _loc4_;
            _loc6_ = true;
         }
         return _loc6_;
      }
      
      protected function getDescTextFieldSize() : int
      {
         return DESC_WIDTH_MAX;
      }
      
      protected function updateIconLayout() : void
      {
         this.icon.x = ICON_LEFT;
         this.icon.y = ICON_TOP;
      }
      
      protected function showTooltip() : void
      {
         if(this.rendererData.tooltipData != null && this.rendererData.tooltipData.tooltip)
         {
            if(this.rendererData.tooltipData.isSpecial)
            {
               this._toolTipMgr.showSpecial.apply(this,[this.rendererData.tooltipData.specialAlias,null].concat(this.rendererData.tooltipData.specialArgs));
            }
            else
            {
               this._toolTipMgr.showComplex(this.rendererData.tooltipData.tooltip);
            }
         }
         else if(this._descIsTruncated)
         {
            this._toolTipMgr.show(this.rendererData.description);
         }
      }
      
      protected function hideToolTip() : void
      {
         this._toolTipMgr.hide();
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
      
      private function onDescTFMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideToolTip();
      }
      
      private function onDescTFMouseOverHandler(param1:MouseEvent) : void
      {
         this.showTooltip();
      }
      
      private function onProgressBarMouseOutHandler(param1:MouseEvent) : void
      {
         this.hideToolTip();
      }
      
      private function onProgressBarMouseOverHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.show(TOOLTIPS.MISSIONS_CONDITION_PROGRESS);
      }
   }
}
