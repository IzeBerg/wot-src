package net.wg.gui.lobby.profile.pages.statistics
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.StatisticsBodyContainer;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import net.wg.gui.lobby.profile.data.ProfileBattleTypeInitVO;
   import net.wg.gui.lobby.profile.pages.statistics.header.HeaderContainer;
   import net.wg.infrastructure.base.meta.IProfileStatisticsMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileStatisticsMeta;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class ProfileStatistics extends ProfileStatisticsMeta implements IProfileStatisticsMeta
   {
      
      private static const HEADER_SEPARATOR_BOTTOM_GAP:int = 100;
      
      private static const BODY_AND_HEADER_SEPARATOR_GAP:int = 20;
      
      private static const DROP_DOWN_GAP:int = 7;
      
      private static const DROP_DOWN_LADDER:int = 778;
      
      private static const DROP_DOWN_LADDER_WIDTH:int = 210;
      
      private static const DROP_DOWN_ATTACH_WIDTH:int = 170;
      
      private static const LAYOUT_WIDTH:int = 525;
      
      private static const LAYOUT_HEIGHT:int = 740;
      
      private static const TEST_LABEL_GAP:int = 5;
       
      
      public var headerLabel:TextField = null;
      
      public var lblSeasonDropdown:TextField = null;
      
      public var seasonDropdown:DropdownMenu = null;
      
      public var headerContainer:HeaderContainer = null;
      
      public var bodyContainer:StatisticsBodyContainer = null;
      
      public var playersStats:ISoundButtonEx = null;
      
      public var testLabel:TextField = null;
      
      private var _bodyParams:ProfileStatisticsBodyVO = null;
      
      public function ProfileStatistics()
      {
         super();
      }
      
      override public function as_setInitData(param1:Object) : void
      {
         var _loc2_:ProfileBattleTypeInitVO = new ProfileBattleTypeInitVO(param1);
         battlesDropdown.dataProvider = new DataProvider(_loc2_.dropDownProvider);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.headerLabel.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         layoutManager = new StatisticsLayoutManager(LAYOUT_WIDTH,LAYOUT_HEIGHT);
         layoutManager.registerComponents(this.headerContainer);
      }
      
      override protected function applyResizing() : void
      {
         super.applyResizing();
         var _loc1_:MovieClip = this.headerContainer.image.separator;
         this.bodyContainer.y = this.headerContainer.y + _loc1_.y + _loc1_.height - HEADER_SEPARATOR_BOTTOM_GAP + BODY_AND_HEADER_SEPARATOR_GAP;
         var _loc2_:int = Math.min(ProfileConstants.MIN_APP_WIDTH,currentDimension.x) >> 0;
         this.bodyContainer.setAvailableSize(_loc2_,currentDimension.y);
         this.headerLabel.x = _loc2_ - this.headerLabel.width >> 1;
      }
      
      override protected function applyData(param1:Object) : void
      {
         var _loc4_:Array = null;
         this.clearData();
         this._bodyParams = new ProfileStatisticsBodyVO(param1.bodyParams);
         if(param1.seasonItems != null)
         {
            _loc4_ = param1.seasonItems as Array;
            App.utils.asserter.assert(_loc4_ is Array,Errors.INVALID_TYPE + Array);
            if(_loc4_.length > 0)
            {
               this.seasonDropdown.dataProvider = new DataProvider(_loc4_);
               this.seasonDropdown.selectedIndex = param1.seasonIndex;
               this.seasonDropdown.enabled = param1.seasonEnabled;
            }
            this.seasonDropdown.validateNow();
         }
         var _loc2_:Boolean = param1.playersStats;
         this.headerLabel.text = param1.headerText;
         this.lblSeasonDropdown.htmlText = param1.dropdownSeasonLabel;
         this.lblSeasonDropdown.visible = this.seasonDropdown.visible = param1.showSeasonDropdown;
         this.playersStats.visible = _loc2_;
         if(_loc2_)
         {
            this.playersStats.label = param1.playersStatsLbl;
            this.playersStats.addEventListener(MouseEvent.CLICK,this.onPlayersStatsClickHandler);
         }
         else
         {
            this.playersStats.removeEventListener(MouseEvent.CLICK,this.onPlayersStatsClickHandler);
         }
         if(this.seasonDropdown.visible)
         {
            if(param1.seasonDropdownAttachToTitle)
            {
               this.seasonDropdown.x = this.headerLabel.x + this.headerLabel.textWidth + DROP_DOWN_GAP;
               this.seasonDropdown.width = DROP_DOWN_ATTACH_WIDTH;
            }
            else
            {
               this.seasonDropdown.x = DROP_DOWN_LADDER;
               this.seasonDropdown.width = DROP_DOWN_LADDER_WIDTH;
            }
            this.seasonDropdown.addEventListener(ListEvent.INDEX_CHANGE,this.onHeaderDropdownIndexChangeHandler);
         }
         else
         {
            this.seasonDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onHeaderDropdownIndexChangeHandler);
         }
         this.headerContainer.battlesType(battlesType,frameLabel);
         this.headerContainer.setDossierData(param1.headerParams);
         this.bodyContainer.setDossierData(this._bodyParams);
         var _loc3_:Boolean = StringUtils.isNotEmpty(param1.testText);
         this.testLabel.visible = _loc3_;
         if(_loc3_)
         {
            this.testLabel.text = param1.testText;
            this.testLabel.x = this.headerLabel.x + this.headerLabel.width + TEST_LABEL_GAP >> 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.headerLabel = null;
         this.lblSeasonDropdown = null;
         this.testLabel = null;
         this.playersStats.removeEventListener(MouseEvent.CLICK,this.onPlayersStatsClickHandler);
         this.playersStats.dispose();
         this.playersStats = null;
         this.seasonDropdown.removeEventListener(ListEvent.INDEX_CHANGE,this.onHeaderDropdownIndexChangeHandler);
         this.seasonDropdown.dispose();
         this.seasonDropdown = null;
         this.headerContainer.dispose();
         this.headerContainer = null;
         this.bodyContainer.dispose();
         this.bodyContainer = null;
         this.clearData();
         super.onDispose();
      }
      
      public function as_updatePlayerStatsBtn(param1:Boolean) : void
      {
         this.playersStats.visible = param1;
      }
      
      private function clearData() : void
      {
         if(this._bodyParams)
         {
            this._bodyParams.dispose();
            this._bodyParams = null;
         }
      }
      
      private function onHeaderDropdownIndexChangeHandler(param1:ListEvent) : void
      {
         setSeasonS(param1.itemData.key);
      }
      
      private function onPlayersStatsClickHandler(param1:MouseEvent) : void
      {
         showPlayersStatsS();
      }
   }
}
