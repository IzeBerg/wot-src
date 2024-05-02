package net.wg.gui.lobby.rankedBattles19.rankedBattlesBattleResults
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.rankedBattles19.data.RankedListVO;
   import net.wg.gui.lobby.rankedBattles19.data.RankedListsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class RankedListsContainer extends UIComponentEx
   {
      
      private static const GAP:int = 10;
      
      private static const FIELD_BACKGROUND:String = "background";
       
      
      public var titleTF:TextField = null;
      
      private var _blinkStandOffItem:Boolean = false;
      
      private var _lists:Vector.<RankedListWithBackground> = null;
      
      private var _startY:int = -1;
      
      private var _startX:int = -1;
      
      public function RankedListsContainer()
      {
         super();
         this._lists = new Vector.<RankedListWithBackground>();
         var _loc1_:int = 0;
         var _loc2_:DisplayObject = getChildByName(FIELD_BACKGROUND + _loc1_);
         if(_loc2_)
         {
            this._startX = _loc2_.x;
            this._startY = _loc2_.y;
         }
         while(_loc2_)
         {
            this._lists.push(RankedListWithBackground(_loc2_));
            _loc1_++;
            _loc2_ = getChildByName(FIELD_BACKGROUND + _loc1_);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:RankedListWithBackground = null;
         for each(_loc1_ in this._lists)
         {
            _loc1_.dispose();
         }
         this._lists.splice(0,this._lists.length);
         this._lists = null;
         this.titleTF = null;
         super.onDispose();
      }
      
      public function blink() : void
      {
         var _loc2_:RankedListWithBackground = null;
         var _loc1_:int = this._lists.length;
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_)
         {
            _loc2_ = this._lists[_loc3_];
            if(_loc2_.visible)
            {
               _loc2_.blink();
               if(this._blinkStandOffItem && _loc3_ > 0)
               {
                  _loc2_.blinkStandOffItem();
               }
            }
            _loc3_++;
         }
      }
      
      public function setCompact(param1:Boolean) : void
      {
         var _loc2_:RankedListWithBackground = null;
         var _loc3_:int = this._startY;
         var _loc4_:int = this._lists.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            _loc2_ = this._lists[_loc5_];
            _loc2_.y = _loc3_;
            _loc2_.setCompact(param1);
            _loc3_ += _loc2_.rendererHeight * _loc2_.topCapacity + GAP;
            _loc5_++;
         }
      }
      
      public function setData(param1:RankedListsVO, param2:Boolean = false) : void
      {
         var _loc8_:RankedListWithBackground = null;
         var _loc9_:RankedListVO = null;
         var _loc10_:RankedListWithBackground = null;
         var _loc11_:int = 0;
         this.titleTF.htmlText = param1.title;
         this.titleTF.alpha = param1.titleAlpha;
         var _loc3_:int = this._startY;
         var _loc4_:Vector.<RankedListVO> = param1.tops;
         var _loc5_:int = _loc4_.length;
         var _loc6_:int = _loc5_ - this._lists.length;
         var _loc7_:Class = App.utils.classFactory.getClass(Linkages.RANKED_BATTLE_RESULT_LIST_WITH_BG);
         while(_loc6_ > 0)
         {
            _loc8_ = new _loc7_();
            addChild(_loc8_);
            _loc8_.x = this._startX;
            this._lists.push(_loc8_);
            _loc6_--;
         }
         _loc11_ = this._lists[0].rendererHeight;
         var _loc12_:Boolean = false;
         var _loc13_:int = 0;
         while(_loc13_ < _loc5_)
         {
            _loc9_ = _loc4_[_loc13_];
            _loc10_ = this._lists[_loc13_];
            _loc10_.visible = true;
            _loc10_.update(_loc9_,param2);
            _loc10_.y = _loc3_;
            _loc3_ += _loc11_ * _loc9_.topCapacity + GAP;
            if(!_loc12_)
            {
               _loc12_ = _loc9_.backgroundBlink;
            }
            _loc13_++;
         }
         this._blinkStandOffItem = !_loc12_;
      }
   }
}
