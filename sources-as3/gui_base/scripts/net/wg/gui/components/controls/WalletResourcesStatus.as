package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class WalletResourcesStatus extends UIComponentEx implements IDisposable
   {
      
      private static const STATE_EMPTY:String = "empty";
      
      private static const RESOURCE_ICO_ALIGN_LEFT_ALERT_RIGHT:String = "resIcoLeftAlertRight";
      
      private static const ICO_TYPE_GOLD:String = "gold";
      
      private static const ICO_TYPE_FREEXP:String = "freeXp";
      
      private static const ICO_TYPE_CREDITS:String = "credits";
      
      private static const ICO_TYPE_CRYSTAL:String = "crystal";
      
      private static const AVAILABLE:uint = 2;
      
      private static const NOT_AVAILABLE:uint = 1;
      
      private static const ICO_RIGHT_MARGIN:int = 35;
      
      private static const ALERT_ICON_HIT_CORRECT_GAP:int = -11;
       
      
      public var anim:MovieClip = null;
      
      public var ico:IconText = null;
      
      public var hit:Sprite = null;
      
      public var alertIco:AlertIco = null;
      
      private var _state:String = "";
      
      private var _icoType:String = "";
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      public function WalletResourcesStatus()
      {
         super();
         this._tooltipMgr = App.toolTipMgr;
         this.alertIco.visible = false;
         hitArea = this.hit;
         this.hit.buttonMode = false;
         this.hit.addEventListener(MouseEvent.ROLL_OVER,this.onHitRollOverHandler);
         this.hit.addEventListener(MouseEvent.ROLL_OUT,this.onHitRollOutHandler);
         this.ico.textAlign = TextFormatAlign.LEFT;
      }
      
      override protected function onDispose() : void
      {
         this.hit.removeEventListener(MouseEvent.ROLL_OVER,this.onHitRollOverHandler);
         this.hit.removeEventListener(MouseEvent.ROLL_OUT,this.onHitRollOutHandler);
         this.ico.dispose();
         this.ico = null;
         this.anim = null;
         this.alertIco.dispose();
         this.alertIco = null;
         this.hit = null;
         this._tooltipMgr.hide();
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(StringUtils.isNotEmpty(this._icoType) && isInvalid(InvalidationType.STATE))
         {
            gotoAndStop(this._state);
            this.alertIco.x = this.alertIco.visible && this._state == RESOURCE_ICO_ALIGN_LEFT_ALERT_RIGHT ? Number(ICO_RIGHT_MARGIN) : Number(0);
            if(this.alertIco.visible)
            {
               this.hit.width = this.alertIco.x + this.alertIco.width + ALERT_ICON_HIT_CORRECT_GAP;
            }
            else
            {
               this.hit.width = this.anim.x + this.anim.width;
            }
         }
         if(this._icoType != Values.EMPTY_STR && isInvalid(InvalidationType.DATA))
         {
            this.ico.icon = this._icoType;
         }
      }
      
      public function updateStatus(param1:uint) : Boolean
      {
         this.visible = param1 != AVAILABLE;
         this.alertIco.visible = param1 == NOT_AVAILABLE;
         invalidateState();
         validateNow();
         return this.visible;
      }
      
      private function getToolTipId() : String
      {
         var _loc1_:String = Values.EMPTY_STR;
         switch(this.icoType)
         {
            case ICO_TYPE_GOLD:
               _loc1_ = TOOLTIPS.WALLET_NOT_AVAILABLE_GOLD;
               break;
            case ICO_TYPE_FREEXP:
               _loc1_ = TOOLTIPS.WALLET_NOT_AVAILABLE_FREEXP;
               break;
            case ICO_TYPE_CREDITS:
               _loc1_ = TOOLTIPS.WALLET_NOT_AVAILABLE_CREDITS;
               break;
            case ICO_TYPE_CRYSTAL:
               _loc1_ = TOOLTIPS.WALLET_NOT_AVAILABLE_CRYSTAL;
         }
         return _loc1_;
      }
      
      public function get state() : String
      {
         return this._state;
      }
      
      [Inspectable(defaultValue="empty",name="state",type="list",enumeration="empty,resIcoLeft,resIcoRight,resIcoForTechTree,resIcoLeftAlertRight")]
      public function set state(param1:String) : void
      {
         if(param1 == this._state)
         {
            return;
         }
         this._state = param1;
         this.visible = this._state != STATE_EMPTY;
         invalidateState();
      }
      
      public function get icoType() : String
      {
         return this._icoType;
      }
      
      [Inspectable(defaultValue="empty",name="icoType",type="list",enumeration="empty,gold,freeXp,credits,crystal")]
      public function set icoType(param1:String) : void
      {
         if(param1 == this._icoType)
         {
            return;
         }
         this._icoType = param1;
         invalidateData();
      }
      
      private function onHitRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onHitRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = this.getToolTipId();
         if(StringUtils.isNotEmpty(_loc2_))
         {
            this._tooltipMgr.showComplex(_loc2_);
         }
      }
   }
}
