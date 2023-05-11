package net.wg.gui.lobby.profile.pages.awards
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.VO.AchievementProfileVO;
   import net.wg.data.constants.generated.TEXT_MANAGER_STYLES;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.ResizableScrollPane;
   import net.wg.gui.components.controls.achievements.AchievementCommon;
   import net.wg.gui.lobby.profile.ProfileConstants;
   import net.wg.gui.lobby.profile.components.AwardsTileListBlock;
   import net.wg.gui.lobby.profile.pages.awards.data.AchievementFilterVO;
   import net.wg.gui.lobby.profile.pages.awards.data.ProfileAwardsInitVO;
   import net.wg.infrastructure.base.meta.IProfileAwardsMeta;
   import net.wg.infrastructure.base.meta.impl.ProfileAwardsMeta;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ListEvent;
   
   public class ProfileAwards extends ProfileAwardsMeta implements IProfileAwardsMeta
   {
      
      private static const SB_MARGIN:Number = 10;
      
      private static const TXT_LABEL_OFFSET_X:int = 5;
      
      private static const MAIN_SCROLLPANE_OFFSET_X:int = 6;
      
      private static const WINDOW_OFFSET:int = 105;
      
      private static const COLUMN_COUNT_SMALL:int = 10;
      
      private static const COLUMN_COUNT:int = 12;
      
      private static const BLOCK_OFFSET:int = 100;
      
      private static const SCROLL_OFFSET:int = 90;
      
      private static const SCROLL_OFFSET_SMALL:int = -20;
       
      
      public var mainScrollPane:ResizableScrollPane;
      
      public var txtLabel:TextField;
      
      public var dropdownMenu:DropdownMenu;
      
      private var _startMenuX:int;
      
      private var _profileAwardsInitVO:ProfileAwardsInitVO;
      
      public function ProfileAwards()
      {
         super();
      }
      
      override public function as_setInitData(param1:Object) : void
      {
         var _loc8_:Object = null;
         this._profileAwardsInitVO = new ProfileAwardsInitVO(param1);
         this.txtLabel.htmlText = App.textMgr.getTextStyleById(TEXT_MANAGER_STYLES.MAIN_TEXT,App.utils.locale.makeString(PROFILE.PROFILE_DROPDOWN_EXISTENCE));
         var _loc2_:AchievementFilterVO = this._profileAwardsInitVO.achievementFilterVO;
         var _loc3_:String = _loc2_.selectedItem;
         var _loc4_:Array = _loc2_.dataProvider;
         this.dropdownMenu.dataProvider = new DataProvider(_loc4_);
         this.dropdownMenu.addEventListener(ListEvent.INDEX_CHANGE,this.onDropdownMenuIndexChangeHandler,false,0,true);
         var _loc5_:int = -1;
         var _loc6_:uint = _loc4_.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            _loc8_ = _loc4_[_loc7_];
            if(_loc8_.key == _loc3_)
            {
               _loc5_ = _loc7_;
               break;
            }
            _loc7_++;
         }
         this.dropdownMenu.selectedIndex = _loc5_;
         this.dropdownMenu.validateNow();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._startMenuX = this.dropdownMenu.x;
         var _loc1_:AwardsMainContainer = this.getMainContainer();
         AwardsBlock(_loc1_.blockSpecialAwards).showProgress = false;
         this.dropdownMenu.addEventListener(MouseEvent.MOUSE_OVER,this.onDropdownMenuMouseOverHandler,false,0,true);
         this.dropdownMenu.addEventListener(MouseEvent.MOUSE_OUT,this.onDropdownMenuMouseOutHandler,false,0,true);
         this.mainScrollPane.scrollBarMargin = SB_MARGIN;
         windowOffset = -WINDOW_OFFSET;
         title.text = PROFILE.SECTION_AWARDS_TITLE;
      }
      
      override protected function applyData(param1:Object) : void
      {
         var _loc7_:AwardsBlock = null;
         var _loc11_:AchievementProfileVO = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:uint = 0;
         var _loc15_:uint = 0;
         var _loc16_:int = 0;
         var _loc2_:AwardsMainContainer = this.getMainContainer();
         var _loc3_:Array = param1.achievementsList;
         var _loc4_:Array = param1.totalItemsList;
         var _loc5_:Vector.<AwardsBlock> = new Vector.<AwardsBlock>();
         _loc5_.push(_loc2_.blockBattleHeroes);
         _loc5_.push(_loc2_.blockHonors);
         _loc5_.push(_loc2_.blockEpicAwards);
         _loc5_.push(_loc2_.blockGroupAwards);
         _loc5_.push(_loc2_.blockCommemoratives);
         _loc5_.push(_loc2_.blockStageAwards);
         _loc5_.push(_loc2_.blockSpecialAwards);
         var _loc6_:uint = _loc4_.length;
         var _loc8_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = _loc5_[_loc8_];
            _loc7_.totalCount = _loc4_[_loc8_];
            _loc8_++;
         }
         var _loc9_:Array = [];
         var _loc10_:int = this.dropdownMenu.selectedIndex;
         _loc6_ = _loc3_.length;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc7_ = _loc5_[_loc8_];
            _loc12_ = [];
            _loc13_ = _loc3_[_loc8_];
            _loc14_ = 0;
            _loc15_ = _loc13_.length;
            _loc16_ = 0;
            while(_loc16_ < _loc15_)
            {
               _loc11_ = new AchievementProfileVO(_loc13_[_loc16_]);
               if(_loc10_ == 0 && _loc11_.isInDossier)
               {
                  _loc14_++;
               }
               _loc12_.push(_loc11_);
               _loc16_++;
            }
            if(_loc10_ != 0)
            {
               _loc14_ = _loc15_;
            }
            _loc7_.currentCount = _loc14_;
            _loc9_.push(_loc12_);
            _loc8_++;
         }
         _loc2_.data = _loc9_;
      }
      
      override protected function applyResizing() : void
      {
         var _loc1_:Number = Math.round(currentDimension.x / 2 - centerOffset);
         var _loc2_:Boolean = App.appWidth < StageSizeBoundaries.WIDTH_1280;
         this.dropdownMenu.x = this._startMenuX + _loc1_;
         this.txtLabel.autoSize = TextFieldAutoSize.LEFT;
         this.txtLabel.x = this.dropdownMenu.x - this.txtLabel.width - TXT_LABEL_OFFSET_X;
         var _loc3_:Number = Math.min(ProfileConstants.MIN_APP_WIDTH,currentDimension.x);
         this.mainScrollPane.target.x = _loc1_ + (_loc3_ - this.mainScrollPane.target.width >> 1) + MAIN_SCROLLPANE_OFFSET_X;
         var _loc4_:int = currentDimension.y;
         _loc4_ += !!isWindowed ? SCROLL_OFFSET : SCROLL_OFFSET_SMALL;
         this.mainScrollPane.setSize(currentDimension.x,_loc4_);
         windowOffset = -WINDOW_OFFSET;
         var _loc5_:AwardsMainContainer = this.getMainContainer();
         var _loc6_:Vector.<AwardsTileListBlock> = _loc5_.blocks;
         var _loc7_:AwardsTileListBlock = null;
         var _loc8_:int = 0;
         while(_loc8_ < _loc6_.length)
         {
            _loc7_ = _loc6_[_loc8_];
            _loc7_.tileList.columnCount = isWindowed || !_loc2_ ? uint(COLUMN_COUNT) : uint(COLUMN_COUNT_SMALL);
            _loc7_.tileList.x = isWindowed || !_loc2_ ? Number(0) : Number(BLOCK_OFFSET);
            _loc8_++;
         }
         title.visible = !isWindowed;
         title.x = App.appWidth - title.width >> 1;
      }
      
      override protected function applyRareAchievementsReceivedData(param1:Object) : void
      {
         var _loc5_:AchievementProfileVO = null;
         var _loc6_:* = null;
         var _loc7_:String = null;
         var _loc8_:int = 0;
         var _loc9_:AchievementCommon = null;
         var _loc10_:AchievementProfileVO = null;
         var _loc2_:AwardsTileListBlock = this.getMainContainer().blockSpecialAwards;
         var _loc3_:Array = _loc2_.dataProvider;
         var _loc4_:uint = _loc3_.length;
         for(_loc6_ in param1)
         {
            _loc7_ = param1[_loc6_];
            _loc8_ = 0;
            while(_loc8_ < _loc4_)
            {
               _loc5_ = AchievementProfileVO(_loc3_[_loc8_]);
               if(_loc5_.name == _loc6_)
               {
                  _loc5_.rareIconId = _loc7_;
                  break;
               }
               _loc8_++;
            }
            _loc9_ = _loc2_.getRendererById(_loc6_);
            if(_loc9_)
            {
               _loc10_ = AchievementProfileVO(_loc9_.data);
               _loc10_.rareIconId = _loc7_;
               _loc9_.setData(_loc10_);
               _loc9_.validateNow();
            }
         }
         super.applyRareAchievementsReceivedData(param1);
      }
      
      override protected function onDispose() : void
      {
         this.dropdownMenu.removeEventListener(MouseEvent.MOUSE_OVER,this.onDropdownMenuMouseOverHandler);
         this.dropdownMenu.removeEventListener(MouseEvent.MOUSE_OUT,this.onDropdownMenuMouseOutHandler);
         this.dropdownMenu.dispose();
         this.dropdownMenu = null;
         this.mainScrollPane.dispose();
         this.mainScrollPane = null;
         this.txtLabel = null;
         this._profileAwardsInitVO.dispose();
         this._profileAwardsInitVO = null;
         super.onDispose();
      }
      
      override public function set isWindowed(param1:Boolean) : void
      {
         super.isWindowed = param1;
         if(isWindowed)
         {
            this.mainScrollPane.height += WINDOW_OFFSET;
         }
      }
      
      public function setBattlesHeroesData(param1:Array) : void
      {
         this.getMainContainer().blockBattleHeroes.dataProvider = param1;
      }
      
      public function setHonorsData(param1:String, param2:Array) : void
      {
         this.getMainContainer().blockHonors.dataProvider = new DataProvider(param2);
      }
      
      protected function getMainContainer() : AwardsMainContainer
      {
         return AwardsMainContainer(this.mainScrollPane.target);
      }
      
      private function onDropdownMenuMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showComplex(PROFILE.SECTION_AWARDS_DROPDOWN_TOOLTIP);
      }
      
      private function onDropdownMenuMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onDropdownMenuIndexChangeHandler(param1:ListEvent) : void
      {
         setFilterS(param1.itemData.key);
      }
   }
}
