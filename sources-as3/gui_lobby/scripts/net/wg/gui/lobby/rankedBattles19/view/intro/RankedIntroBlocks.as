package net.wg.gui.lobby.rankedBattles19.view.intro
{
   import flash.events.Event;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesIntroBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   
   public class RankedIntroBlocks extends UIComponentEx implements IDisposable
   {
      
      private static const INV_SETTINGS:String = "invSettings";
       
      
      private var _blocks:Vector.<RankedIntroBlock> = null;
      
      private var _blocksData:Vector.<RankedBattlesIntroBlockVO> = null;
      
      private var _itemsWidth:int = 0;
      
      private var _contentHeight:int = 0;
      
      private var _viewSizeID:String = "";
      
      public function RankedIntroBlocks()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._blocksData)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.clearBlocks();
               this.createBlocks();
               invalidate(INV_SETTINGS);
            }
            if(isInvalid(INV_SETTINGS))
            {
               this.updateSettings();
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.doLayout();
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearBlocks();
         this._blocksData = null;
         super.onDispose();
      }
      
      public function setData(param1:Vector.<RankedBattlesIntroBlockVO>) : void
      {
         this._blocksData = param1;
         invalidateData();
      }
      
      public function updateSizeID(param1:String) : void
      {
         if(this._viewSizeID == param1)
         {
            return;
         }
         this._viewSizeID = param1;
         invalidate(INV_SETTINGS);
      }
      
      private function updateSettings() : void
      {
         if(this._viewSizeID == Values.EMPTY_STR)
         {
            return;
         }
         this._itemsWidth = Values.ZERO;
         this._contentHeight = Values.ZERO;
         var _loc1_:int = this._blocks.length;
         var _loc2_:RankedIntroBlock = null;
         var _loc3_:int = Values.ZERO;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._blocks[_loc3_];
            _loc2_.sizeID = this._viewSizeID;
            this._itemsWidth += _loc2_.width;
            this._contentHeight = Math.max(this._contentHeight,_loc2_.height);
            _loc3_++;
         }
         this._contentHeight ^= 0;
      }
      
      private function createBlocks() : void
      {
         this._blocks = new Vector.<RankedIntroBlock>();
         var _loc1_:int = this._blocksData.length;
         var _loc2_:RankedIntroBlock = null;
         var _loc3_:int = _loc1_ - 1;
         var _loc4_:int = Values.ZERO;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = App.utils.classFactory.getComponent(Linkages.RANKED_BATTLES_INTRO_BLOCK_UI,RankedIntroBlock);
            _loc2_.setData(this._blocksData[_loc4_],_loc4_ == _loc3_);
            addChild(_loc2_);
            this._blocks.push(_loc2_);
            _loc4_++;
         }
      }
      
      private function clearBlocks() : void
      {
         if(!this._blocks)
         {
            return;
         }
         var _loc1_:int = this._blocks.length;
         var _loc2_:RankedIntroBlock = null;
         var _loc3_:int = Values.ZERO;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._blocks.pop();
            removeChild(_loc2_);
            _loc2_.dispose();
            _loc2_ = null;
            _loc3_++;
         }
         this._blocks = null;
      }
      
      private function doLayout() : void
      {
         if(!this._blocks || this._viewSizeID == Values.EMPTY_STR)
         {
            return;
         }
         var _loc1_:int = this._blocks.length;
         var _loc2_:RankedIntroBlock = null;
         var _loc3_:int = -(this._itemsWidth >> 1);
         var _loc4_:int = Values.ZERO;
         while(_loc4_ < _loc1_)
         {
            _loc2_ = this._blocks[_loc4_];
            _loc2_.alignHeight = this._contentHeight;
            _loc2_.x = _loc3_;
            _loc3_ += _loc2_.width;
            _loc4_++;
         }
      }
      
      override public function get height() : Number
      {
         return this._contentHeight;
      }
   }
}
