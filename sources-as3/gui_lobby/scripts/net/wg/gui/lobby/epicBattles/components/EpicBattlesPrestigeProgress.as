package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.lobby.epicBattles.components.prestigeProgress.PrestigeProgressBlock;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesPrestigeProgressBlockVO;
   import net.wg.gui.lobby.epicBattles.data.EpicBattlesPrestigeProgressVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EpicBattlesPrestigeProgress extends UIComponentEx
   {
      
      private static const TANK_REWARD_X_OFFSET:int = 138;
      
      private static const BLOCK_ELEMENTS_X_OFFSET:int = 100;
      
      private static const LINE_SEPARATOR_BLOCK_X_OFFSET:int = 50;
      
      private static const LINE_SEPARATOR_WIDTH:int = 45;
      
      private static const SMALL_BLOCK_ELEMENTS_X_OFFSET:int = 76;
      
      private static const SMALL_LINE_SEPARATOR_BLOCK_X_OFFSET:int = 38;
      
      private static const SMALL_LINE_SEPARATOR_WIDTH:int = 22;
      
      private static const Y_PRESTIGE_PROGRESS_BLOCK_OFFSET:int = 88;
      
      private static const DEFAULT_PRESTIGE_PROGRESS_HEIGHT:int = 176;
      
      private static const EMPTY_LINKAGE_VALUE:String = "";
      
      private static const BREAKING_POINT:int = 1240;
      
      private static const SHORT_SEPERATOR_LINE_PERCENTAGE:Number = 0.84;
       
      
      public var titleTF:TextField = null;
      
      private var _prestigeProgressVO:EpicBattlesPrestigeProgressVO = null;
      
      private var _prestigeProgressList:Vector.<PrestigeProgressBlock> = null;
      
      private var _lineSeparators:Vector.<MovieClip> = null;
      
      private var _isSmallMode:Boolean = false;
      
      public function EpicBattlesPrestigeProgress()
      {
         super();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Function = null;
         var _loc2_:EpicBattlesPrestigeProgressBlockVO = null;
         var _loc3_:PrestigeProgressBlock = null;
         var _loc4_:MovieClip = null;
         super.draw();
         if(this._prestigeProgressVO != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.titleTF.htmlText = this._prestigeProgressVO.titleHtmlText;
               this._prestigeProgressList = new Vector.<PrestigeProgressBlock>(0);
               this._lineSeparators = new Vector.<MovieClip>(0);
               _loc1_ = App.utils.classFactory.getComponent;
               for each(_loc2_ in this._prestigeProgressVO.progressBlocks)
               {
                  _loc3_ = _loc1_(_loc2_.blockStyle,PrestigeProgressBlock);
                  _loc3_.setData(_loc2_);
                  addChild(_loc3_);
                  this._prestigeProgressList.push(_loc3_);
                  if(_loc2_.lineSeparatorStyle != EMPTY_LINKAGE_VALUE)
                  {
                     _loc4_ = _loc1_(_loc2_.lineSeparatorStyle,MovieClip);
                     addChild(_loc4_);
                     this._lineSeparators.push(_loc4_);
                  }
               }
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.positionPrestigeProgressElements();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         this.titleTF = null;
         if(this._prestigeProgressList)
         {
            _loc1_ = this._prestigeProgressList.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._prestigeProgressList[_loc2_].dispose();
               _loc2_++;
            }
            this._prestigeProgressList.splice(0,this._prestigeProgressList.length);
            this._prestigeProgressList = null;
         }
         this._lineSeparators.splice(0,this._lineSeparators.length);
         this._lineSeparators = null;
         this._prestigeProgressVO = null;
         super.onDispose();
      }
      
      public function calculateHeight() : Number
      {
         var _loc2_:PrestigeProgressBlock = null;
         var _loc1_:int = Math.max(this.height,DEFAULT_PRESTIGE_PROGRESS_HEIGHT);
         for each(_loc2_ in this._prestigeProgressList)
         {
            if(_loc2_.height > _loc1_)
            {
               _loc1_ = _loc2_.height;
            }
         }
         return _loc1_;
      }
      
      public function setData(param1:EpicBattlesPrestigeProgressVO) : void
      {
         if(param1)
         {
            this._prestigeProgressVO = param1;
            invalidateData();
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._isSmallMode = param1 < BREAKING_POINT;
         invalidateSize();
      }
      
      private function positionPrestigeProgressElements() : void
      {
         var _loc1_:int = this._prestigeProgressList.length;
         var _loc2_:int = !!this._isSmallMode ? int(SMALL_BLOCK_ELEMENTS_X_OFFSET) : int(BLOCK_ELEMENTS_X_OFFSET);
         var _loc3_:int = !!this._isSmallMode ? int(SMALL_LINE_SEPARATOR_WIDTH) : int(LINE_SEPARATOR_WIDTH);
         var _loc4_:int = !!this._isSmallMode ? int(SMALL_LINE_SEPARATOR_BLOCK_X_OFFSET) : int(LINE_SEPARATOR_BLOCK_X_OFFSET);
         var _loc5_:int = -(TANK_REWARD_X_OFFSET + (_loc1_ - 1) * _loc2_) >> 1;
         var _loc6_:int = _loc1_ - 2;
         var _loc7_:int = 0;
         while(_loc7_ < _loc1_)
         {
            this._prestigeProgressList[_loc7_].x = _loc5_;
            this._prestigeProgressList[_loc7_].y = Y_PRESTIGE_PROGRESS_BLOCK_OFFSET;
            if(_loc7_ < this._lineSeparators.length)
            {
               this._lineSeparators[_loc7_].x = _loc5_ + _loc4_;
               this._lineSeparators[_loc7_].y = Y_PRESTIGE_PROGRESS_BLOCK_OFFSET;
               this._lineSeparators[_loc7_].width = _loc3_;
               if(this._prestigeProgressVO.progressBlocks[_loc7_].useShortSeparatorLine)
               {
                  this._lineSeparators[_loc7_].width *= SHORT_SEPERATOR_LINE_PERCENTAGE;
               }
            }
            _loc5_ += _loc7_ == _loc6_ ? TANK_REWARD_X_OFFSET : _loc2_;
            _loc7_++;
         }
      }
   }
}
