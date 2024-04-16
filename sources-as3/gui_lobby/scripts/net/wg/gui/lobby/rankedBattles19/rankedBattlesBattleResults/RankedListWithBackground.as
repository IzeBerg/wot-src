package net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults
{
   import flash.display.MovieClip;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.generated.RANKEDBATTLES_ALIASES;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.rankedBattles19.data.RankedListVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedListWithBackground extends UIComponentEx
   {
      
      private static const RENDERER_WIDTH:int = 60;
      
      private static const RENDERER_LEFT:String = "playerLeftRendererUI";
      
      private static const RENDERER_RIGHT:String = "playerRightRendererUI";
      
      private static const TOP_ICON_Y_OFFSET:int = -8;
      
      private static const TOP1_ICON_Y_OFFSET:int = -10;
      
      private static const TOP1_ICON_Y_OFFSET_COMPACT:int = -12;
      
      private static const TOP_ICON_X_OFFSET_RIGHTSIDE:int = 19;
      
      private static const TOP_ICON_X_OFFSET_LEFTSIDE:int = -73;
      
      private static const LIST_X_OFFSET_LEFTSIDE:int = -300;
      
      private static const CAPACITY_TOP1:int = 1;
      
      private static const TOP1_COMPACT_POSTFIX:String = "compact";
      
      private static const ICON_POS_Y:int = 19;
      
      private static const ICON_POS_TOP1:int = 16;
      
      private static const ICON_POS_TOP1_Y_COMPACT:int = 14;
      
      private static const BLIND_POSTFIX:String = "_blind";
      
      private static const BLIND_FILL_POSTFIX:String = "Blind";
       
      
      public var list:RankedSimpleTileList = null;
      
      public var topElement:MovieClip = null;
      
      public var topToMiddleElement:BitmapFill = null;
      
      public var middleElement:MovieClip = null;
      
      public var middleToBottomElement:BitmapFill = null;
      
      public var bottomElement:MovieClip = null;
      
      public var topIcon:Image = null;
      
      private var _topData:RankedListVO = null;
      
      private var _standOffActiveItem:PlayerRankedRenderer = null;
      
      private var _standOffItemFindComplete:Boolean = false;
      
      private var _isLeftSidePlacement:Boolean = false;
      
      private var _topCapacity:int = -1;
      
      private var _isCompactSize:Boolean = false;
      
      private var _rendererHeight:int = -1;
      
      private var _topElementHeight:int = -1;
      
      private var _bottomElementHeight:int = -1;
      
      private var _middleElementHeight:int = -1;
      
      public function RankedListWithBackground()
      {
         super();
         this._rendererHeight = PlayerRankedRenderer.RENDERER_HEIGHT;
         this._topElementHeight = this.topElement.height;
         this._bottomElementHeight = this.bottomElement.height;
         this._middleElementHeight = this.middleElement.height;
      }
      
      override protected function onDispose() : void
      {
         this._standOffActiveItem = null;
         this.topElement = null;
         this.bottomElement = null;
         this.middleElement = null;
         this.topToMiddleElement.dispose();
         this.topToMiddleElement = null;
         this.middleToBottomElement.dispose();
         this.middleToBottomElement = null;
         this.list.dispose();
         this.list = null;
         this.topIcon.dispose();
         this.topIcon = null;
         this._topData = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.list.directionMode = DirectionMode.VERTICAL;
         this.list.tileWidth = RENDERER_WIDTH;
         this.list.tileHeight = this._rendererHeight;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:String = null;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:MovieClip = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:Boolean = false;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         super.draw();
         if(this._topData)
         {
            _loc1_ = this._topData.topCapacity;
            _loc2_ = this._topData.backgroundType;
            _loc3_ = this._topData.isColorBlind;
            if(_loc3_)
            {
               _loc2_ += BLIND_POSTFIX;
            }
            _loc4_ = _loc1_ == CAPACITY_TOP1;
            _loc5_ = this.middleElement.iconMc;
            _loc8_ = false;
            if(isInvalid(InvalidationType.DATA))
            {
               this.topElement.scaleX = this.topToMiddleElement.scaleX = this.middleElement.scaleX = _loc5_.scaleX = this.middleToBottomElement.scaleX = this.bottomElement.scaleX = !!this._isLeftSidePlacement ? Number(1) : Number(-1);
               this.list.itemRenderer = App.utils.classFactory.getClass(!!this._isLeftSidePlacement ? RENDERER_LEFT : RENDERER_RIGHT);
               this.list.dataProvider = this._topData.listData;
               this.list.x = !!this._isLeftSidePlacement ? Number(0) : Number(LIST_X_OFFSET_LEFTSIDE);
               _loc9_ = this._topData.backgroundType;
               if(_loc3_)
               {
                  _loc9_ += BLIND_FILL_POSTFIX;
               }
               _loc9_ += Linkages.RANKED_TOP_BG_BITMAPDATA_POSTFIX;
               if(!_loc4_)
               {
                  this.bottomElement.gotoAndStop(_loc2_);
                  this.topElement.gotoAndStop(_loc2_);
                  this.topToMiddleElement.source = _loc9_;
                  this.middleToBottomElement.source = _loc9_;
                  this.bottomElement.visible = this.topElement.visible = this.middleToBottomElement.visible = this.topToMiddleElement.visible = true;
               }
               else
               {
                  this.bottomElement.visible = this.topElement.visible = this.middleToBottomElement.visible = this.topToMiddleElement.visible = false;
               }
               _loc5_.gotoAndStop(this._topData.iconType);
               this.topIcon.source = this._topData.topIcon;
               _loc8_ = true;
            }
            if(_loc8_ || isInvalid(InvalidationType.SIZE))
            {
               this.list.tileHeight = this._rendererHeight;
               _loc6_ = _loc1_ * this._rendererHeight;
               this.list.height = _loc6_;
               this.list.setCompact(this._isCompactSize);
               if(_loc4_)
               {
                  _loc10_ = _loc2_ + CAPACITY_TOP1;
                  if(this._isCompactSize)
                  {
                     _loc10_ += TOP1_COMPACT_POSTFIX;
                     _loc11_ = TOP1_ICON_Y_OFFSET_COMPACT;
                  }
                  else
                  {
                     _loc11_ = TOP1_ICON_Y_OFFSET;
                  }
                  this.middleElement.y = 0;
                  _loc12_ = !!this._isCompactSize ? int(ICON_POS_TOP1_Y_COMPACT) : int(ICON_POS_TOP1);
               }
               else
               {
                  _loc14_ = 0;
                  _loc11_ = TOP_ICON_Y_OFFSET;
                  _loc10_ = _loc2_;
                  this.topElement.y = _loc14_;
                  _loc7_ = _loc6_ - this._middleElementHeight - this._topElementHeight - this._bottomElementHeight >> 1;
                  _loc14_ += this._topElementHeight;
                  this.topToMiddleElement.y = _loc14_;
                  this.topToMiddleElement.heightFill = _loc7_;
                  _loc14_ += _loc7_;
                  this.middleElement.y = _loc14_;
                  _loc14_ += this._middleElementHeight;
                  this.middleToBottomElement.y = _loc14_;
                  _loc14_ += _loc7_;
                  this.middleToBottomElement.heightFill = _loc7_;
                  this.bottomElement.y = _loc14_ + this._bottomElementHeight;
                  _loc12_ = ICON_POS_Y;
               }
               _loc5_.y = _loc12_;
               this.middleElement.gotoAndStop(_loc10_);
               _loc13_ = !!this._isLeftSidePlacement ? int(TOP_ICON_X_OFFSET_LEFTSIDE) : int(TOP_ICON_X_OFFSET_RIGHTSIDE);
               this.topIcon.x = this.middleElement.x + _loc13_;
               this.topIcon.y = this.middleElement.y + _loc11_;
            }
         }
      }
      
      public function blink() : void
      {
         if(this._topData && this._topData.backgroundBlink)
         {
            this.middleElement.wave.gotoAndPlay(RANKEDBATTLES_ALIASES.BLINK_BACKGROUND_SHOW);
         }
      }
      
      public function blinkStandOffItem() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PlayerRankedRenderer = null;
         var _loc3_:int = 0;
         if(!this._standOffItemFindComplete && !this._standOffActiveItem && this.list.dataProvider)
         {
            _loc1_ = this.list.dataProvider.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ = PlayerRankedRenderer(this.list.getRendererAt(_loc3_));
               if(_loc2_.standoffVisible && _loc2_.selectedActive)
               {
                  this._standOffActiveItem = _loc2_;
                  break;
               }
               _loc3_++;
            }
            this._standOffItemFindComplete = true;
         }
         if(this._standOffActiveItem)
         {
            this._standOffActiveItem.blink();
         }
      }
      
      public function setCompact(param1:Boolean) : void
      {
         this._isCompactSize = param1;
         this._rendererHeight = !!param1 ? int(PlayerRankedRenderer.RENDERER_HEIGHT) : int(PlayerRankedRenderer.HUGE_RENDERER_HEIGHT);
         invalidateSize();
      }
      
      public function update(param1:RankedListVO, param2:Boolean) : void
      {
         this._topData = param1;
         this._topCapacity = param1.topCapacity;
         this._isLeftSidePlacement = param2;
         invalidateData();
      }
      
      public function get topCapacity() : int
      {
         return this._topCapacity;
      }
      
      public function get rendererHeight() : int
      {
         return this._rendererHeight;
      }
   }
}
