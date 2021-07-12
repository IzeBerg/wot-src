package net.wg.gui.lobby.header.itemSelectorPopover
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.assets.interfaces.INewIndicator;
   import net.wg.gui.components.controls.SoundListItemRenderer;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.events.ItemSelectorRendererEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Constraints;
   
   public class ExtraItemSelectorRenderer extends SoundListItemRenderer
   {
      
      private static const ICON_DISABLED_ALPHA:Number = 0.5;
       
      
      public var newIndicator:INewIndicator = null;
      
      public var hitAreaA:MovieClip = null;
      
      public var icon:UILoaderAlt = null;
      
      public var ribbon:UILoaderAlt = null;
      
      public var specialBg:UILoaderAlt = null;
      
      public var mainTextField:TextField = null;
      
      public var infoTextField:TextField = null;
      
      private var _mainLabel:String = "";
      
      private var _infoLabel:String = "";
      
      private var _dataVo:ExtraItemSelectorRendererVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _commons:ICommons;
      
      public function ExtraItemSelectorRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         super();
         soundType = SoundTypes.RNDR_NORMAL;
         this.newIndicator.visible = false;
         this.newIndicator.mouseChildren = false;
         hitArea = this.hitAreaA;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         textField.multiline = true;
         textField.wordWrap = true;
         mouseEnabledOnDisabled = true;
         if(!constraintsDisabled)
         {
            constraints.addElement(this.icon.name,this.icon,Constraints.LEFT | Constraints.TOP);
         }
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler,false,0,true);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler,false,0,true);
         addEventListener(ButtonEvent.CLICK,this.onClickHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         if(data && isInvalid(InvalidationType.DATA))
         {
            this.enabled = !this._dataVo.disabled;
         }
         super.draw();
         if(data && isInvalid(InvalidationType.DATA))
         {
            this.applyData(this._dataVo);
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         if(!constraintsDisabled && this.icon)
         {
            constraints.updateElement(this.icon.name,this.icon);
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         removeEventListener(ButtonEvent.CLICK,this.onClickHandler);
         this.newIndicator.dispose();
         this.newIndicator = null;
         this.mainTextField = null;
         this.infoTextField = null;
         this.hitAreaA = null;
         this.specialBg.dispose();
         this.specialBg = null;
         this.ribbon.dispose();
         this.ribbon = null;
         this.icon.dispose();
         this.icon = null;
         this._dataVo = null;
         this._toolTipMgr = null;
         this._commons = null;
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         this.updateTextField(this.mainTextField,this._mainLabel);
         this.updateTextField(this.infoTextField,this._infoLabel);
         this.updateTextField(textField,_label);
      }
      
      private function updateTextField(param1:TextField, param2:String) : void
      {
         if(param2 != null && param1 != null)
         {
            param1.htmlText = param2;
            this._commons.updateTextFieldSize(param1,false);
            param1.alpha = !!enabled ? Number(1) : Number(ICON_DISABLED_ALPHA);
         }
      }
      
      private function applyData(param1:ExtraItemSelectorRendererVO) : void
      {
         var _loc2_:Boolean = false;
         selected = param1.active;
         this._mainLabel = param1.mainLabel;
         this._infoLabel = param1.infoLabel;
         _label = param1.label;
         this.updateText();
         if(this.newIndicator)
         {
            _loc2_ = param1.isNew && !param1.disabled;
            if(this.newIndicator.visible != _loc2_)
            {
               this.newIndicator.visible = _loc2_;
               this.updateNewAnimation(_loc2_);
            }
         }
         this.icon.source = param1.icon;
         this.icon.visible = StringUtils.isNotEmpty(param1.icon);
         this.ribbon.source = param1.ribbonSrc;
         this.ribbon.visible = StringUtils.isNotEmpty(param1.ribbonSrc);
         this.specialBg.source = param1.specialBgIcon;
         this.specialBg.visible = StringUtils.isNotEmpty(this.specialBg.source);
      }
      
      private function updateNewAnimation(param1:Boolean) : void
      {
         preventAutosizing = true;
         if(param1)
         {
            this.newIndicator.shine();
         }
         else
         {
            this.newIndicator.pause();
         }
      }
      
      override public function set data(param1:Object) : void
      {
         super.data = param1;
         this._dataVo = ExtraItemSelectorRendererVO(data);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.icon.alpha = !!param1 ? Number(1) : Number(ICON_DISABLED_ALPHA);
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new ItemSelectorRendererEvent(ItemSelectorRendererEvent.RENDERER_OVER,true,false,this._dataVo.data,this._dataVo.disabled));
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onClickHandler(param1:ButtonEvent) : void
      {
         if(!enabled)
         {
            return;
         }
         dispatchEvent(new ItemSelectorRendererEvent(ItemSelectorRendererEvent.RENDERER_CLICK,true));
      }
   }
}
