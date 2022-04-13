package net.wg.gui.battle.commander.views.fullStats.list.vehicles
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.VO.daapi.DAAPIVehicleInfoVO;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.commander.VO.daapi.DAAPIVehicleCommanderDataVO;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsItemVehicle;
   import net.wg.gui.battle.commander.views.fullStats.interfaces.IRTSFullStatsListVehicles;
   import net.wg.gui.battle.commander.views.fullStats.list.base.AbstractRTSFullStatsList;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.components.controls.BadgeComponent;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.infrastructure.interfaces.IUserProps;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class AbstractRTSFullStatsListVehicles extends AbstractRTSFullStatsList implements IRTSFullStatsListVehicles
   {
      
      private static const BADGE_OFFSET:uint = 32;
      
      private static const RANKED_BADGE_OFFSET:int = 1;
      
      private static const FIELD_WIDTH_COMPENSATION:int = 2;
      
      private static const INVALID_COMMANDER_INFO:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      private static const INVALID_SUFFIXBAGE:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 2;
       
      
      public var commanderName:TextField = null;
      
      public var commanderBadge:BadgeComponent = null;
      
      public var icoTester:BattleAtlasSprite = null;
      
      public var testerBack:BattleAtlasSprite = null;
      
      private var _commanderInfo:DAAPIVehicleInfoVO = null;
      
      private var _suffixBadgeType:String;
      
      private var _toolTipString:String;
      
      private var _suffixBadgeStripType:String = null;
      
      private var _isCommander:Boolean = false;
      
      public function AbstractRTSFullStatsListVehicles()
      {
         super();
      }
      
      private static function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.icoTester.visible = false;
         this.testerBack.visible = false;
         setHeaderText(RTS_BATTLES.TEAM_TANKERS);
         this.hideCommanderInfo();
         this.commanderName.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler,false,0,true);
         this.commanderName.addEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler,false,0,true);
      }
      
      override protected function draw() : void
      {
         var _loc1_:IUserProps = null;
         var _loc2_:BadgeVisualVO = null;
         super.draw();
         if(isInvalid(INVALID_COMMANDER_INFO))
         {
            setHeaderText(!!this._isCommander ? RTS_BATTLES.TEAM_COMMANDER : RTS_BATTLES.TEAM_TANKERS);
         }
         if(isInvalid(INVALID_COMMANDER_INFO | InvalidationType.DATA))
         {
            if(this._commanderInfo)
            {
               this.commanderName.visible = true;
               _loc1_ = App.utils.commons.getUserProps(this._commanderInfo.playerName,this._commanderInfo.clanAbbrev,this._commanderInfo.region,Values.ZERO,this._commanderInfo.userTags,this._commanderInfo.playerFakeName);
               App.utils.commons.formatPlayerName(this.commanderName,_loc1_,!this._commanderInfo.isCurrentPlayer,this._commanderInfo.isCurrentPlayer);
               if(this._commanderInfo.isCurrentPlayer && StringUtils.isNotEmpty(_loc1_.fakeName) && _loc1_.isAnonymized)
               {
                  this._toolTipString = _loc1_.clanAbbrev != Values.EMPTY_STR ? App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_CLAN,{"fakeName":_loc1_.fakeName}) : App.utils.locale.makeString(TOOLTIPS.ANONYMIZER_BATTLE_TEAMLIST_NOCLAN,{"fakeName":_loc1_.fakeName});
               }
               _loc2_ = this._commanderInfo.badgeVO;
               this.commanderBadge.visible = Boolean(_loc2_);
               if(_loc2_)
               {
                  this.commanderBadge.setData(_loc2_);
                  this.commanderName.x += !!isAllyList ? BADGE_OFFSET : -BADGE_OFFSET;
               }
            }
            else
            {
               this.hideCommanderInfo();
            }
         }
         if(isInvalid(INVALID_SUFFIXBAGE))
         {
            this.icoTester.visible = this.testerBack.visible = Boolean(this._suffixBadgeType);
            if(this.icoTester.visible && this.commanderName.visible)
            {
               this.icoTester.imageName = this._suffixBadgeType;
               this.testerBack.imageName = this._suffixBadgeStripType;
               this.icoTester.y = this.testerBack.y = this.commanderName.y;
               if(isAllyList)
               {
                  this.icoTester.x = this.commanderName.x + this.commanderName.textWidth + RANKED_BADGE_OFFSET >> 0;
                  this.testerBack.x = -FIELD_WIDTH_COMPENSATION + ((this.icoTester.width >> 1) + this.icoTester.x - this.testerBack.width) >> 0;
               }
               else
               {
                  this.icoTester.x = -FIELD_WIDTH_COMPENSATION + (this.commanderName.width - this.commanderName.textWidth + this.commanderName.x - this.icoTester.width) >> 0;
                  this.testerBack.scaleX = -1;
                  this.testerBack.x = this.icoTester.x + this.testerBack.width + (this.icoTester.width >> 1) >> 0;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.commanderBadge.dispose();
         this.commanderName.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.commanderName.removeEventListener(MouseEvent.ROLL_OUT,onMouseRollOutHandler);
         this.commanderName = null;
         this.commanderBadge = null;
         this._toolTipString = null;
         this._commanderInfo = null;
         this.testerBack = null;
         this.icoTester = null;
         super.onDispose();
      }
      
      override protected function getItemID(param1:IDAAPIDataClass) : Number
      {
         return DAAPIVehicleInfoVO(param1).vehicleID;
      }
      
      public function setChatCommand(param1:Number, param2:String, param3:uint) : void
      {
         var _loc4_:IRTSFullStatsItemVehicle = this.getItemByVehicleID(param1);
         if(_loc4_)
         {
            _loc4_.setChatCommand(param2,param3);
         }
      }
      
      public function setInvitationStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:IRTSFullStatsItemVehicle = this.getItemByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setInvitationStatus(param2);
         }
      }
      
      public function setIsSpotted(param1:Number, param2:Boolean) : void
      {
         var _loc3_:IRTSFullStatsItemVehicle = this.getItemByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setIsSpotted(param2);
         }
      }
      
      public function setRTSIsMove(param1:Number, param2:Boolean) : void
      {
         var _loc3_:IRTSFullStatsItemVehicle = this.getItemByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setRTSIsMove(param2);
         }
      }
      
      public function setRTSCommanderInfo(param1:DAAPIVehicleInfoVO) : void
      {
         if(this._commanderInfo != param1)
         {
            this._commanderInfo = param1;
            if(this._commanderInfo)
            {
               this._isCommander = true;
            }
            invalidate(INVALID_COMMANDER_INFO);
         }
         if(param1)
         {
            this.setSuffixBadge(param1.suffixBadgeType);
            this.setSuffixBadgeStrip(param1.suffixBadgeStripType);
         }
      }
      
      public function setRTSCommanderData(param1:Vector.<DAAPIVehicleCommanderDataVO>) : void
      {
         var _loc2_:IRTSFullStatsItemVehicle = null;
         var _loc3_:DAAPIVehicleCommanderDataVO = null;
         for each(_loc3_ in param1)
         {
            _loc2_ = this.getItemByVehicleID(_loc3_.vehicleID);
            if(_loc2_)
            {
               _loc2_.setRTSCommanderData(_loc3_);
            }
         }
      }
      
      public function setUserTags(param1:Number, param2:Array) : void
      {
         var _loc3_:IRTSFullStatsItemVehicle = this.getItemByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setUserTags(param2);
         }
      }
      
      public function setVehicleStatus(param1:Number, param2:uint) : void
      {
         var _loc3_:IRTSFullStatsItemVehicle = this.getItemByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.setVehicleStatus(param2);
         }
      }
      
      public function triggerChatCommand(param1:Number, param2:String) : void
      {
         var _loc3_:IRTSFullStatsItemVehicle = this.getItemByVehicleID(param1);
         if(_loc3_)
         {
            _loc3_.triggerChatCommand(param2);
         }
      }
      
      public function getHeight() : Number
      {
         return container.y + container.height;
      }
      
      private function getItemByVehicleID(param1:Number) : IRTSFullStatsItemVehicle
      {
         return IRTSFullStatsItemVehicle(getItemByID(param1));
      }
      
      private function hideCommanderInfo() : void
      {
         this.commanderName.visible = this.commanderBadge.visible = false;
      }
      
      private function setSuffixBadge(param1:String) : void
      {
         if(this._suffixBadgeType == param1)
         {
            return;
         }
         this._suffixBadgeType = param1;
         invalidate(INVALID_SUFFIXBAGE);
      }
      
      private function setSuffixBadgeStrip(param1:String) : void
      {
         if(this._suffixBadgeStripType == param1)
         {
            return;
         }
         this._suffixBadgeStripType = param1;
         invalidate(INVALID_SUFFIXBAGE);
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this._toolTipString)
         {
            App.toolTipMgr.show(this._toolTipString);
         }
      }
   }
}
