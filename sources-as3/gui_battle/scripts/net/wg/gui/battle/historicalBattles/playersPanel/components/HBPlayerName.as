package net.wg.gui.battle.historicalBattles.playersPanel.components
{
   import flash.display.BlendMode;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.battle.historicalBattles.playersPanel.VO.HBPlayerInfoVO;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class HBPlayerName extends BattleUIComponent
   {
      
      private static const INVALIDATE_NAME:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const PLAYER_NAME_OFFSET:int = 5;
       
      
      public var hitMc:MovieClip = null;
      
      public var badge:BadgeComponent = null;
      
      public var playerNameTF:TextField = null;
      
      private var _playerNameWidth:int = 120;
      
      private var _playerNameBadgeActiveWidth:int = 91;
      
      private var _isBadgeActive:Boolean = false;
      
      private var _toolTip:String = "";
      
      private var _userProps:IUserProps = null;
      
      private var _badgeVO:BadgeVisualVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function HBPlayerName()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hitArea = this.hitMc;
         this.playerNameTF.blendMode = BlendMode.SCREEN;
         mouseChildren = false;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.badge.addEventListener(Event.CHANGE,this.onBadgeChangeHandler);
         this.badge.visible = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._badgeVO && isInvalid(InvalidationType.DATA))
         {
            this.validateBadge();
         }
         if(this._userProps)
         {
            if(isInvalid(INVALIDATE_NAME))
            {
               this.validateName();
            }
            if(isInvalid(InvalidationType.POSITION))
            {
               this.validatePosition();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.badge.removeEventListener(Event.CHANGE,this.onBadgeChangeHandler);
         this.badge.dispose();
         this.badge = null;
         this.hitMc = null;
         this.playerNameTF = null;
         this._toolTipMgr = null;
         this._userProps = null;
         this._badgeVO = null;
         super.onDispose();
      }
      
      public function setData(param1:HBPlayerInfoVO) : void
      {
         this._userProps = App.utils.commons.getUserProps(param1.playerName,param1.clanAbbrev,param1.region,param1.igrType,param1.userTags,param1.playerFakeName);
         this._badgeVO = param1.badgeVO;
         invalidate();
      }
      
      private function validatePosition() : void
      {
         this.playerNameTF.x = !!this._isBadgeActive ? Number(this.badge.width + PLAYER_NAME_OFFSET >> 0) : Number(Values.ZERO);
         this.hitMc.width = this.playerNameTF.x + this.playerNameTF.width >> 0;
      }
      
      private function validateName() : void
      {
         var _loc1_:Boolean = false;
         this.playerNameTF.width = !!this._isBadgeActive ? Number(this._playerNameBadgeActiveWidth) : Number(this._playerNameWidth);
         _loc1_ = App.utils.commons.formatPlayerName(this.playerNameTF,this._userProps);
         mouseEnabled = _loc1_;
         this._toolTip = !!_loc1_ ? App.utils.commons.getFullPlayerName(this._userProps) : null;
      }
      
      private function validateBadge() : void
      {
         this._isBadgeActive = this._badgeVO != null;
         this.badge.visible = this._isBadgeActive;
         if(this._isBadgeActive)
         {
            this.badge.setData(this._badgeVO);
         }
      }
      
      public function set textColor(param1:int) : void
      {
         this.playerNameTF.textColor = param1;
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(!this._toolTip)
         {
            return;
         }
         this._toolTipMgr.show(this._toolTip);
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(!this._toolTip)
         {
            return;
         }
         this._toolTipMgr.hide();
      }
      
      private function onBadgeChangeHandler(param1:Event) : void
      {
         invalidatePosition();
      }
   }
}
