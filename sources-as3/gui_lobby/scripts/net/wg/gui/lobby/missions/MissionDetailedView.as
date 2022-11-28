package net.wg.gui.lobby.missions
{
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.ImageCacheTypes;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.MISSIONS_ALIASES;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.containers.HorizontalGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.components.BaseMissionDetailedView;
   import net.wg.gui.lobby.components.MissionDetailsBg;
   import net.wg.gui.lobby.components.data.BaseMissionDetailedViewVO;
   import net.wg.gui.lobby.components.interfaces.IMissionDetailsPopUpPanel;
   import net.wg.gui.lobby.missions.components.AwardGroup;
   import net.wg.gui.lobby.missions.components.detailedView.MissionDetailsConditionsPanel;
   import net.wg.gui.lobby.missions.data.MissionDetailedViewVO;
   import net.wg.gui.lobby.missions.event.MissionConditionRendererEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionDetailedView extends BaseMissionDetailedView
   {
      
      private static const BATTLE_REQ_GAP:int = 40;
      
      private static const INFO_ICON_GAP:int = 6;
      
      private static const BOTTOM_STATUS_GAP:int = 8;
      
      private static const AWARDS_GROUP_PADDING_Y:int = 3;
       
      
      public var dateTf:TextField;
      
      public var resetDateTf:TextField;
      
      public var awardsPanel:IMissionDetailsPopUpPanel;
      
      public var accountRequirementsPanel:IMissionDetailsPopUpPanel;
      
      public var conditionsPanel:IMissionDetailsPopUpPanel;
      
      public var prebattleConditions:IGroupEx;
      
      public var battleConditions:MissionDetailsConditionsPanel;
      
      public var separator:ISeparatorAsset;
      
      public var separatorTop:ISeparatorAsset = null;
      
      public var uiDecoration:Image = null;
      
      public var bg:MissionDetailsBg = null;
      
      private var _isDateTruncated:Boolean = false;
      
      private var _vo:MissionDetailedViewVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function MissionDetailedView()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this.uiDecoration.cacheType = ImageCacheTypes.USE_WEB_CACHE;
         addItemToContentList(this.bg.statusBg);
         addItemToContentList(this.dateTf);
         addItemToContentList(this.resetDateTf);
         addItemToContentList(DisplayObject(this.accountRequirementsPanel));
         addItemToContentList(DisplayObject(this.conditionsPanel));
         addItemToContentList(DisplayObject(this.prebattleConditions));
         addItemToContentList(this.battleConditions);
         addItemToContentList(DisplayObject(this.awardsPanel));
      }
      
      override public function setData(param1:BaseMissionDetailedViewVO) : void
      {
         super.setData(param1);
         this._vo = MissionDetailedViewVO(param1);
      }
      
      override protected function canItemBeDisabled(param1:DisplayObject) : Boolean
      {
         return param1 == this.battleConditions || param1 == this.prebattleConditions;
      }
      
      override protected function getAwardsWidth() : int
      {
         return this.bg.width;
      }
      
      override protected function onDispose() : void
      {
         this.dateTf.removeEventListener(MouseEvent.ROLL_OVER,this.onDateTfRollOverHandler);
         this.dateTf.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.dateTf = null;
         this.resetDateTf.removeEventListener(MouseEvent.ROLL_OVER,this.onResetDateTfRollOverHandler);
         this.resetDateTf.removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.resetDateTf = null;
         this._vo = null;
         this._toolTipMgr = null;
         this.accountRequirementsPanel.dispose();
         this.accountRequirementsPanel = null;
         this.battleConditions.removeEventListener(MissionConditionRendererEvent.CLICK,this.onBattleConditionsClickHandler);
         this.battleConditions.dispose();
         this.battleConditions = null;
         this.separatorTop.dispose();
         this.separatorTop = null;
         this.prebattleConditions.dispose();
         this.prebattleConditions = null;
         this.conditionsPanel.dispose();
         this.conditionsPanel = null;
         this.awardsPanel.dispose();
         this.awardsPanel = null;
         this.separator.dispose();
         this.separator = null;
         this.uiDecoration.dispose();
         this.uiDecoration = null;
         this.bg.dispose();
         this.bg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         super.draw();
         if(this._vo != null && isInvalid(InvalidationType.DATA))
         {
            this.conditionsPanel.visible = false;
            this.awardsPanel.visible = false;
            this.resetDateTf.htmlText = this._vo.resetDateLabel;
            _loc1_ = App.utils.commons.truncateTextFieldText(this.dateTf,this._vo.dateLabel,true,true);
            this._isDateTruncated = _loc1_.length < this._vo.dateLabel.length;
            this.accountRequirementsPanel.setData(this._vo.accountRequirements);
            this.prebattleConditions.dataProvider = this._vo.prebattleConditions;
            this.prebattleConditions.validateNow();
            this.prebattleConditions.x = -this.prebattleConditions.width >> 1;
            this.separator.visible = this._vo.prebattleConditions && this._vo.prebattleConditions.length > 0;
            this.accountRequirementsPanel.setData(this._vo.accountRequirements);
            this.battleConditions.width = this.width;
            this.battleConditions.setData(this._vo.battleConditions);
            this.uiDecoration.visible = StringUtils.isNotEmpty(this._vo.uiDecoration);
            if(this.uiDecoration.visible)
            {
               this.uiDecoration.source = this._vo.uiDecoration;
            }
            this.bg.setStatus(this._vo.background);
            this.bg.typeBg.visible = !this.uiDecoration.visible;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.conditionsPanel.visible = false;
         this.awardsPanel.visible = false;
         this.separator.setType(SeparatorConstants.DOTTED_TYPE);
         this.separatorTop.setType(SeparatorConstants.MEDIUM_TYPE);
         this.prebattleConditions.layout = new HorizontalGroupLayout(BATTLE_REQ_GAP);
         this.prebattleConditions.itemRendererLinkage = Linkages.MISSION_BATTLE_REQUIREMENT_RENDERER;
         AwardGroup(awardsGroup).setChildButtonMode(false);
         this.resetDateTf.addEventListener(MouseEvent.ROLL_OVER,this.onResetDateTfRollOverHandler);
         this.resetDateTf.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.dateTf.addEventListener(MouseEvent.ROLL_OVER,this.onDateTfRollOverHandler);
         this.dateTf.addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler);
         this.battleConditions.addEventListener(MissionConditionRendererEvent.CLICK,this.onBattleConditionsClickHandler);
      }
      
      override protected function updateAwardsLayout() : void
      {
         super.updateAwardsLayout();
         awardsGroup.y = awardsBg.y + (awardsBg.height - awardsGroup.height >> 1) - AWARDS_GROUP_PADDING_Y;
      }
      
      override protected function updateInfoIconParams() : void
      {
         var _loc1_:Boolean = StringUtils.isNotEmpty(this._vo.titleTooltip);
         infoIcon.visible = _loc1_;
         if(_loc1_)
         {
            infoIcon.x = titleTf.x + titleTf.textWidth + INFO_ICON_GAP >> 0;
            infoIcon.source = RES_ICONS.MAPS_ICONS_LIBRARY_INFO;
         }
      }
      
      override protected function updateBottomStates() : void
      {
         var _loc5_:int = 0;
         var _loc1_:Boolean = StringUtils.isNotEmpty(this._vo.bottomStatusText);
         var _loc2_:Boolean = StringUtils.isNotEmpty(this._vo.addBottomStatusText);
         bottomStatusTf.visible = _loc1_;
         bottomStatus2Tf.visible = _loc2_;
         if(_loc1_)
         {
            bottomStatusTf.htmlText = this._vo.bottomStatusText;
         }
         var _loc3_:int = awardsBg.y + awardsBg.height;
         var _loc4_:int = this.bg.height - _loc3_;
         if(_loc2_)
         {
            bottomStatus2Tf.htmlText = this._vo.addBottomStatusText;
            _loc5_ = bottomStatusTf.textHeight + bottomStatus2Tf.textHeight + BOTTOM_STATUS_GAP;
            bottomStatusTf.y = _loc3_ + (_loc4_ - _loc5_ >> 1);
            bottomStatus2Tf.y = bottomStatusTf.y + bottomStatusTf.textHeight + BOTTOM_STATUS_GAP >> 0;
         }
         else
         {
            bottomStatusTf.y = _loc3_ + (_loc4_ - bottomStatusTf.textHeight >> 1);
         }
      }
      
      override public function get width() : Number
      {
         return this.bg.width;
      }
      
      private function onDateTfRollOverHandler(param1:MouseEvent) : void
      {
         if(this._isDateTruncated)
         {
            this._toolTipMgr.show(this._vo.dateLabel);
         }
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onResetDateTfRollOverHandler(param1:MouseEvent) : void
      {
         if(this._vo)
         {
            showTooltip(this._vo.scheduleTooltip);
         }
      }
      
      private function onBattleConditionsClickHandler(param1:MissionConditionRendererEvent) : void
      {
         var _loc2_:IMissionDetailsPopUpPanel = null;
         if(param1.data.rendererLinkage == MISSIONS_ALIASES.ACHIEVEMENT_RENDERER)
         {
            _loc2_ = this.awardsPanel;
         }
         else
         {
            _loc2_ = this.conditionsPanel;
         }
         _loc2_.setData(param1.data);
         _loc2_.visible = true;
      }
   }
}
