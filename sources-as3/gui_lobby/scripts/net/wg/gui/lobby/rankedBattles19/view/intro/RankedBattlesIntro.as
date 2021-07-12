package net.wg.gui.lobby.rankedBattles19.view.intro
{
   import flash.events.Event;
   import net.wg.data.constants.UniversalBtnStylesConst;
   import net.wg.gui.components.advanced.VideoButton;
   import net.wg.gui.components.controls.universalBtn.UniversalBtn;
   import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeader;
   import net.wg.gui.lobby.rankedBattles19.components.RankedBattlesPageHeaderHelper;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesIntroBlockVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
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
      
      private static const BTNS_GAP:int = 20;
      
      private static const CLOSE_BUTTON_OFFSET:int = 51;
      
      public static const VIEW_SIZE_ID_BIG:String = "viewSizeBig";
      
      public static const VIEW_SIZE_ID_MEDIUM:String = "viewSizeMedium";
      
      public static const VIEW_SIZE_ID_SMALL:String = "viewSizeSmall";
      
      public static const INV_PLAY_BTN_SIZE:String = "invalidatePlayButtonSize";
       
      
      public var header:RankedBattlesPageHeader = null;
      
      public var blocks:RankedIntroBlocks = null;
      
      public var acceptBtn:UniversalBtn = null;
      
      public var detailedBtn:UniversalBtn = null;
      
      public var playBtn:VideoButton = null;
      
      private var _headerData:RankedBattlesPageHeaderVO = null;
      
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
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this._utils.universalBtnStyles.setStyle(this.acceptBtn,UniversalBtnStylesConst.STYLE_HEAVY_GREEN);
         this._utils.universalBtnStyles.setStyle(this.detailedBtn,UniversalBtnStylesConst.STYLE_HEAVY_BLACK);
         this.acceptBtn.label = RANKED_BATTLES.INTROPAGE_BTNS_ACCEPT;
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
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(this._headerData)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.header.setData(this._headerData);
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.header.setSizeId(this._headerSizeId);
               this.header.y = this._headerHelper.getYOffset(this._headerSizeId);
               closeBtn.y = this.header.y + this._headerHelper.getCloseBtnYOffset(this._headerSizeId);
               _loc1_ = width >> 1;
               _loc2_ = BTNS_GAP >> 1;
               _loc3_ = height - this.acceptBtn.height - this._btnsBottomOffset;
               this.acceptBtn.y = _loc3_;
               this.detailedBtn.y = _loc3_;
               this.acceptBtn.x = _loc1_ - _loc2_ - this.acceptBtn.width;
               this.detailedBtn.x = _loc1_ + _loc2_;
               this.blocks.updateSizeID(this._viewSizeID);
               this.blocks.x = _loc1_;
               this.blocks.y = _loc3_ - this.blocks.height - this._blocksBottomOffset;
               closeBtn.x = _width - closeBtn.width - CLOSE_BUTTON_OFFSET;
               this.updateHeaderPosition();
               invalidate(INV_PLAY_BTN_SIZE);
            }
            if(isInvalid(INV_PLAY_BTN_SIZE))
            {
               this.playBtn.x = width - this.playBtn.width >> 1;
               this.playBtn.y = height - this.playBtn.height >> 1;
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
         this._utils = null;
         this._headerData = null;
         this._headerHelper = null;
         super.onDispose();
      }
      
      override protected function setData(param1:RankedBattlesPageHeaderVO, param2:Vector.<RankedBattlesIntroBlockVO>) : void
      {
         this.blocks.setData(param2);
         this._headerData = param1;
         invalidateData();
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
         if(param1 >= StageSizeBoundaries.WIDTH_1920 || param2 >= StageSizeBoundaries.HEIGHT_1080)
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
