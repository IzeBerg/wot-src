package net.wg.gui.lobby.rankedBattles19.view.intro
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.gui.components.advanced.VideoButton;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.hangar.alertMessage.AlertMessageBlock;
   import net.wg.gui.lobby.hangar.data.AlertMessageBlockVO;
   import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeader;
   import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeaderHelper;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesIntroVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedIntroBeforeSeasonBlockVO;
   import net.wg.infrastructure.base.meta.IRankedBattlesIntroMeta;
   import net.wg.infrastructure.base.meta.impl.RankedBattlesIntroMeta;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.IUtils;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class RankedBattlesIntro extends RankedBattlesIntroMeta implements IRankedBattlesIntroMeta, IStageSizeDependComponent
   {
      
      private static const BTNS_BOTTOM_OFFSET_BIG:int = 59;
      
      private static const BTNS_BOTTOM_OFFSET_SMALL:int = 30;
      
      private static const BLOCKS_BOTTOM_OFFSET_BIG:int = 55;
      
      private static const BLOCKS_BOTTOM_OFFSET_MEDIUM:int = 50;
      
      private static const BLOCKS_BOTTOM_OFFSET_SMALL:int = 41;
      
      private static const BLOCKS_Y_OFFSET:int = 30;
      
      private static const ALERT_MESSAGE_BLOCK_Y_OFFSET:int = 15;
      
      private static const BEFORE_SEASON_BLOCK_Y_OFFSET:int = 15;
      
      private static const BTNS_GAP:int = 20;
      
      private static const CLOSE_BUTTON_OFFSET:int = 51;
      
      private static const BOTTOM_SHADOW_HEIGHT_FACTOR:Number = 0.7;
      
      public static const VIEW_SIZE_ID_BIG:String = "viewSizeBig";
      
      public static const VIEW_SIZE_ID_MEDIUM:String = "viewSizeMedium";
      
      public static const VIEW_SIZE_ID_SMALL:String = "viewSizeSmall";
      
      public static const INV_PLAY_BTN_SIZE:String = "invalidatePlayButtonSize";
       
      
      public var header:RankedBattlesPageHeader = null;
      
      public var blocks:RankedIntroBlocks = null;
      
      public var acceptBtn:UniversalBtn = null;
      
      public var detailedBtn:UniversalBtn = null;
      
      public var playBtn:VideoButton = null;
      
      public var alertMessageBlock:AlertMessageBlock = null;
      
      public var beforeSeasonBlock:RankedIntroBeforeSeasonBlock = null;
      
      public var bottomShadow:Sprite = null;
      
      private var _data:RankedBattlesIntroVO = null;
      
      private var _utils:IUtils;
      
      private var _btnsBottomOffset:int = 59;
      
      private var _blocksBottomOffset:int = 55;
      
      private var _viewSizeID:String = "";
      
      private var _headerHelper:RankedBattlesPageHeaderHelper = null;
      
      private var _headerSizeId:String = "small";
      
      public function RankedBattlesIntro()
      {
         this._utils = App.utils;
         super();
         this._headerHelper = RankedBattlesPageHeaderHelper.getInstance();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         setBackground(RES_ICONS.MAPS_ICONS_RANKEDBATTLES_BG_INTRO);
         closeBtn.label = RANKED_BATTLES.RANKEDBATTLEPAGE_CLOSEBTN;
         closeBtn.validateNow();
         this.alertMessageBlock.visible = false;
         this.beforeSeasonBlock.visible = false;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._utils.universalBtnStyles.setStyle(this.acceptBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
         this._utils.universalBtnStyles.setStyle(this.detailedBtn,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
         this.detailedBtn.label = RANKED_BATTLES.INTROPAGE_BTNS_DETAILED;
         this.acceptBtn.addEventListener(ButtonEvent.CLICK,this.onAcceptBtnClickHandler);
         this.detailedBtn.addEventListener(ButtonEvent.CLICK,this.onDetailedBtnClickHandler);
         this.playBtn.addEventListener(ButtonEvent.CLICK,this.onPlayBtnClickHandler);
         this.playBtn.addEventListener(Event.RESIZE,this.onPlayBtnResizeHandler);
         this.blocks.addEventListener(Event.RESIZE,this.onBlocksResizeHandler);
         this.header.addEventListener(Event.RESIZE,this.onHeaderResizeHandler);
         App.stageSizeMgr.register(this);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         super.draw();
         if(this._data == null)
         {
            return;
         }
         _loc1_ = this._data.state == RANKEDBATTLES_CONSTS.INTRO_STATE_DISABLED;
         _loc2_ = this._data.state == RANKEDBATTLES_CONSTS.INTRO_STATE_BEFORE_SEASON;
         _loc3_ = !_loc1_ && !_loc2_ && this._data.hasURL;
         if(isInvalid(InvalidationType.DATA))
         {
            this.header.setData(this._data.headerData);
            this.alertMessageBlock.visible = _loc1_;
            this.beforeSeasonBlock.visible = _loc2_;
            if(_loc1_)
            {
               bgHolder.filters = [RankedIntroHelper.grayscaleFilter];
               this.acceptBtn.label = RANKED_BATTLES.INTROPAGE_BTNS_TOHANGAR;
            }
            else
            {
               bgHolder.filters = [];
               this.acceptBtn.label = RANKED_BATTLES.INTROPAGE_BTNS_ACCEPT;
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.header.setSizeId(this._headerSizeId);
            this.header.y = this._headerHelper.getYOffset(this._headerSizeId);
            closeBtn.y = this.header.y + this._headerHelper.getCloseBtnYOffset(this._headerSizeId);
            if(_loc1_)
            {
               this.alertMessageBlock.x = width - this.alertMessageBlock.width >> 1;
               this.alertMessageBlock.y = this.header.y + this.header.height + ALERT_MESSAGE_BLOCK_Y_OFFSET | 0;
            }
            else if(_loc2_)
            {
               this.beforeSeasonBlock.x = width - this.beforeSeasonBlock.width >> 1;
               this.beforeSeasonBlock.y = this.header.y + this.header.height + BEFORE_SEASON_BLOCK_Y_OFFSET | 0;
            }
            _loc4_ = width >> 1;
            _loc5_ = BTNS_GAP >> 1;
            _loc6_ = height - this.acceptBtn.height - this._btnsBottomOffset;
            this.acceptBtn.y = _loc6_;
            this.detailedBtn.y = _loc6_;
            this.acceptBtn.x = _loc4_ - _loc5_ - this.acceptBtn.width;
            this.detailedBtn.x = _loc4_ + _loc5_;
            this.blocks.updateSizeID(this._viewSizeID);
            this.blocks.x = _loc4_;
            if(_loc3_)
            {
               this.blocks.y = _loc6_ - this.blocks.height - this._blocksBottomOffset;
            }
            else
            {
               this.blocks.y = (height - this.blocks.height >> 1) + BLOCKS_Y_OFFSET;
            }
            closeBtn.x = _width - closeBtn.width - CLOSE_BUTTON_OFFSET;
            this.updateHeaderPosition();
            this.bottomShadow.width = width;
            this.bottomShadow.height = height * BOTTOM_SHADOW_HEIGHT_FACTOR | 0;
            this.bottomShadow.y = height - this.bottomShadow.height;
            invalidate(INV_PLAY_BTN_SIZE);
         }
         if(isInvalid(INV_PLAY_BTN_SIZE))
         {
            this.playBtn.visible = _loc3_;
            if(_loc3_)
            {
               this.playBtn.x = width - this.playBtn.width >> 1;
               this.playBtn.y = this.header.y + this.header.height + this.blocks.y - this.playBtn.height >> 1;
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.header.removeEventListener(Event.RESIZE,this.onHeaderResizeHandler);
         this.acceptBtn.removeEventListener(ButtonEvent.CLICK,this.onAcceptBtnClickHandler);
         this.detailedBtn.removeEventListener(ButtonEvent.CLICK,this.onDetailedBtnClickHandler);
         this.playBtn.removeEventListener(ButtonEvent.CLICK,this.onPlayBtnClickHandler);
         this.playBtn.removeEventListener(Event.RESIZE,this.onPlayBtnResizeHandler);
         this.blocks.removeEventListener(Event.RESIZE,this.onBlocksResizeHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.header.dispose();
         this.header = null;
         this.acceptBtn.dispose();
         this.acceptBtn = null;
         this.detailedBtn.dispose();
         this.detailedBtn = null;
         this.playBtn.dispose();
         this.playBtn = null;
         this.blocks.dispose();
         this.blocks = null;
         this.alertMessageBlock.dispose();
         this.alertMessageBlock = null;
         this.beforeSeasonBlock.dispose();
         this.beforeSeasonBlock = null;
         this.bottomShadow = null;
         this._utils = null;
         this._data = null;
         this._headerHelper = null;
         super.onDispose();
      }
      
      override protected function setData(param1:RankedBattlesIntroVO) : void
      {
         this.blocks.setData(param1.blocksData,param1.state);
         this._data = param1;
         invalidateData();
      }
      
      override protected function setAlertMessageBlockData(param1:AlertMessageBlockVO) : void
      {
         this.alertMessageBlock.setLocalData(param1);
      }
      
      override protected function setBeforeSeasonBlockData(param1:RankedIntroBeforeSeasonBlockVO) : void
      {
         this.beforeSeasonBlock.setData(param1);
      }
      
      override protected function onEscapeKeyDown() : void
      {
         onCloseS();
      }
      
      override protected function onCloseBtn() : void
      {
         onCloseS();
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         this._headerSizeId = this._headerHelper.getSizeId(param1,param2);
         var _loc3_:String = VIEW_SIZE_ID_SMALL;
         if(param1 >= StageSizeBoundaries.WIDTH_1920 && param2 >= StageSizeBoundaries.HEIGHT_1080)
         {
            _loc3_ = VIEW_SIZE_ID_BIG;
         }
         else if(param1 >= StageSizeBoundaries.WIDTH_1366)
         {
            _loc3_ = VIEW_SIZE_ID_MEDIUM;
         }
         if(this._viewSizeID == _loc3_)
         {
            return;
         }
         this._viewSizeID = _loc3_;
         this._btnsBottomOffset = BTNS_BOTTOM_OFFSET_SMALL;
         var _loc4_:String = VideoButton.SIZE_ID_BIG;
         if(this._viewSizeID == VIEW_SIZE_ID_BIG)
         {
            this._btnsBottomOffset = BTNS_BOTTOM_OFFSET_BIG;
            this._blocksBottomOffset = BLOCKS_BOTTOM_OFFSET_BIG;
         }
         else if(this._viewSizeID == VIEW_SIZE_ID_MEDIUM)
         {
            this._blocksBottomOffset = BLOCKS_BOTTOM_OFFSET_MEDIUM;
         }
         else
         {
            this._blocksBottomOffset = BLOCKS_BOTTOM_OFFSET_SMALL;
            _loc4_ = VideoButton.SIZE_ID_SMALL;
         }
         this.playBtn.sizeID = _loc4_;
         invalidateSize();
      }
      
      private function updateHeaderPosition() : void
      {
         this.header.x = _width - this.header.width >> 1;
      }
      
      override protected function get autoShowViewProperty() : int
      {
         return SHOW_VIEW_PROP_AFTER_BG_READY;
      }
      
      private function onPlayBtnResizeHandler(param1:Event) : void
      {
         invalidate(INV_PLAY_BTN_SIZE);
      }
      
      private function onPlayBtnClickHandler(param1:ButtonEvent) : void
      {
         onPlayVideoClickS();
      }
      
      private function onBlocksResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onHeaderResizeHandler(param1:Event) : void
      {
         this.updateHeaderPosition();
      }
      
      private function onDetailedBtnClickHandler(param1:ButtonEvent) : void
      {
         onDetailedClickS();
      }
      
      private function onAcceptBtnClickHandler(param1:ButtonEvent) : void
      {
         onAcceptClickS();
      }
   }
}
