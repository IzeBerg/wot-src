package net.wg.gui.lobby.menu
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.login.impl.components.CopyrightEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class Copyright extends UIComponentEx
   {
      
      private static const LINK_BTN_Y_SHIFT:uint = 10;
      
      private static const TEXT_ALPHA:Number = 0.52;
       
      
      public var textField:TextField = null;
      
      public var legalLink:SoundButtonEx = null;
      
      private var _copyright:String = null;
      
      private var _legalInfo:String = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _defaultTextFieldW:int;
      
      private var _defaultCopyrightW:int;
      
      private var _defaultTextFieldH:int;
      
      public function Copyright()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._defaultTextFieldW = this.textField.width;
         this._defaultCopyrightW = this.legalLink.width;
         this._defaultTextFieldH = this.textField.height;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.textField.alpha = TEXT_ALPHA;
         this.legalLink.addEventListener(MouseEvent.ROLL_OVER,this.onLegalLinkRollOverHandler);
         this.legalLink.addEventListener(MouseEvent.ROLL_OUT,this.onLegalLinkRollOutHandler);
         this.legalLink.addEventListener(ButtonEvent.CLICK,this.onLegalLinkClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
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
               this.legalLink.label = this._legalInfo;
               this.textField.text = this._copyright;
               invalidateLayout();
            }
            if(isInvalid(InvalidationType.LAYOUT))
            {
               this.textField.y = !!_loc1_ ? Number(this.legalLink.y) : Number(this.legalLink.y + this.legalLink.height + LINK_BTN_Y_SHIFT);
               this.legalLink.x = this.textField.width - this.legalLink.width >> 1;
               dispatchEvent(new Event(Event.CHANGE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.legalLink.removeEventListener(MouseEvent.ROLL_OVER,this.onLegalLinkRollOverHandler);
         this.legalLink.removeEventListener(MouseEvent.ROLL_OUT,this.onLegalLinkRollOutHandler);
         this.legalLink.removeEventListener(ButtonEvent.CLICK,this.onLegalLinkClickHandler);
         this.legalLink.dispose();
         this.legalLink = null;
         this.textField = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      public function getWidth() : int
      {
         return Math.max(this.textField.width,this.legalLink.width);
      }
      
      public function getHeight() : int
      {
         return !!this.legalLink.visible ? int(this.textField.height + this.legalLink.height + LINK_BTN_Y_SHIFT) : int(this.textField.height);
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
