package net.wg.gui.login.impl.components
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextLineMetrics;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class Copyright extends UIComponentEx
   {
      
      private static const LINK_MARGIN:int = 9;
      
      private static const MARGIN:int = 40;
      
      private static const TEXT_FIELD_Y_SHIFT:int = 2;
      
      private static const MAX_TEXTFIELD_NUMLINES:int = 3;
      
      private static const TEXTFIELD_WIDTH_ENLARGE_STEP:int = 100;
       
      
      public var logo:UILoaderAlt = null;
      
      public var textField:TextField = null;
      
      public var legalLink:SoundButtonEx = null;
      
      private var _copyright:String = null;
      
      private var _legalInfo:String = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _defaultTextFieldW:int;
      
      private var _defaultTextFieldH:int;
      
      private var _defaultTextFieldX:int;
      
      private var _defaultTextFieldY:int;
      
      private var _isLogoLoaded:Boolean = false;
      
      public function Copyright()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._defaultTextFieldW = this.textField.width;
         this._defaultTextFieldH = this.textField.height;
         this._defaultTextFieldX = this.textField.x;
         this._defaultTextFieldY = this.textField.y;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.legalLink.addEventListener(MouseEvent.ROLL_OVER,this.onLegalLinkRollOverHandler);
         this.legalLink.addEventListener(MouseEvent.ROLL_OUT,this.onLegalLinkRollOutHandler);
         this.legalLink.addEventListener(ButtonEvent.CLICK,this.onLegalLinkClickHandler);
         this.logo.addEventListener(UILoaderEvent.COMPLETE,this.onLogoCompleteHandler);
         this.logo.source = RES_ICONS.MAPS_ICONS_LIBRARY_LOGOS_PRODUCER_LOGO_HORISONTAL;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:TextLineMetrics = null;
         super.draw();
         if(StringUtils.isNotEmpty(this._copyright))
         {
            _loc1_ = StringUtils.isEmpty(this._legalInfo);
            if(isInvalid(InvalidationType.DATA))
            {
               if(this.textField.width != this._defaultTextFieldW)
               {
                  this.textField.width = this._defaultTextFieldW;
               }
               if(this.textField.height != this._defaultTextFieldH)
               {
                  this.textField.height = this._defaultTextFieldH;
               }
               this.legalLink.visible = !_loc1_;
               if(_loc1_)
               {
                  this.textField.text = this._copyright;
               }
               else
               {
                  this.textField.text = this._copyright + Values.NEW_LINE + this._legalInfo;
                  _loc2_ = this.textField.numLines;
                  if(_loc2_ > MAX_TEXTFIELD_NUMLINES)
                  {
                     this.textField.text = this._copyright + Values.SPACE_STR + this._legalInfo;
                     while(_loc2_ > MAX_TEXTFIELD_NUMLINES)
                     {
                        this.textField.width += TEXTFIELD_WIDTH_ENLARGE_STEP;
                        _loc2_ = this.textField.numLines;
                     }
                  }
                  App.utils.commons.updateTextFieldSize(this.textField,false,true);
               }
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.textField.x = (!!this._isLogoLoaded ? this.logo.x + this.logo.width : 0) + (!!_loc1_ ? this._defaultTextFieldX : MARGIN);
               this.textField.y = !!_loc1_ ? Number(this._defaultTextFieldY) : Number(this.logo.y + TEXT_FIELD_Y_SHIFT);
               _loc3_ = this.textField.numLines - 1;
               if(_loc3_ < 0)
               {
                  dispatchEvent(new Event(Event.CHANGE));
                  return;
               }
               _loc4_ = this.textField.getLineMetrics(_loc3_);
               this.legalLink.x = this.textField.x + _loc4_.width + LINK_MARGIN;
               this.legalLink.y = this.textField.y + _loc3_ * _loc4_.height + (this.legalLink.height - _loc4_.height >> 1) + _loc4_.leading ^ 0;
               dispatchEvent(new Event(Event.CHANGE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.legalLink.removeEventListener(MouseEvent.ROLL_OVER,this.onLegalLinkRollOverHandler);
         this.legalLink.removeEventListener(MouseEvent.ROLL_OUT,this.onLegalLinkRollOutHandler);
         this.legalLink.removeEventListener(ButtonEvent.CLICK,this.onLegalLinkClickHandler);
         this.logo.removeEventListener(UILoaderEvent.COMPLETE,this.onLogoCompleteHandler);
         this.logo.dispose();
         this.logo = null;
         this.legalLink.dispose();
         this.legalLink = null;
         this.textField = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function getWidth() : int
      {
         return this.textField.x + this.textField.textWidth;
      }
      
      public function getHeight() : int
      {
         return Math.max(this.logo.height,this.textField.height);
      }
      
      public function updateLabel(param1:String, param2:String = "") : void
      {
         var _loc3_:Boolean = false;
         if(this._copyright != param1)
         {
            this._copyright = param1;
            _loc3_ = true;
         }
         if(this._legalInfo != param2)
         {
            this._legalInfo = param2;
            _loc3_ = true;
         }
         if(_loc3_)
         {
            invalidateData();
         }
      }
      
      private function onLogoCompleteHandler(param1:Event) : void
      {
         this._isLogoLoaded = true;
         invalidateLayout();
      }
      
      private function onLegalLinkClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new CopyrightEvent(CopyrightEvent.TO_LEGAL));
      }
      
      private function onLegalLinkRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onLegalLinkRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(TOOLTIPS.LOGIN_LEGAL);
      }
   }
}
