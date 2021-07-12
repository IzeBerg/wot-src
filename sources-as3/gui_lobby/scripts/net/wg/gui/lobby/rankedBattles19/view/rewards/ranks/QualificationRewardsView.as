package net.wg.gui.lobby.rankedBattles19.view.rewards.ranks
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsRankRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.IStageSizeDependComponent;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.utils.Padding;
   
   public class QualificationRewardsView extends UIComponentEx implements IStageSizeDependComponent
   {
      
      private static const MAX_COUNT:int = 13;
      
      private static const MAX_1ST_ROW_COUNT:int = 6;
      
      private static const LINE_COUNT:int = 3;
      
      private static const STEP_X:int = 104;
      
      private static const STEP_Y:int = 104;
      
      private static const PADDING_TOP_HIGH:Number = 16;
      
      private static const BONUS_Y_OFFSET:Number = 8;
      
      private static const INV_VIEW_PADDING:String = "invViewPadding";
      
      private static const DESCRIPTION_TF_OFFSET_Y:uint = 60;
       
      
      public var descriptionTf:TextField = null;
      
      private var _data:RewardsRankRendererVO = null;
      
      private var _bonuses:Vector.<AwardItemRendererEx> = null;
      
      private var _separators:Vector.<Sprite> = null;
      
      private var _viewPadding:Padding;
      
      private var _separatorWidth:int = 0;
      
      private var _paddingTop:int = 0;
      
      public function QualificationRewardsView()
      {
         this._viewPadding = new Padding();
         super();
         mouseEnabled = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         App.stageSizeMgr.register(this);
         this.descriptionTf.text = RANKED_BATTLES.QUALIFICATIONREWARDS_DESCRIPTION;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateData();
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE,INV_VIEW_PADDING))
            {
               this.updateLayout();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.clearBonuses();
         this.clearSeparators();
         this.descriptionTf = null;
         this._data = null;
         this._viewPadding = null;
         super.onDispose();
      }
      
      public function setData(param1:Vector.<RewardsRankRendererVO>) : void
      {
         App.utils.asserter.assertNotNull(param1,"rewards" + Errors.CANT_NULL);
         App.utils.asserter.assert(param1.length > 0,Errors.CANT_EMPTY);
         var _loc2_:RewardsRankRendererVO = param1[0];
         if(this._data == _loc2_)
         {
            return;
         }
         this._data = _loc2_;
         invalidateData();
      }
      
      public function setSizePadding(param1:Padding) : void
      {
         if(this._viewPadding == param1)
         {
            return;
         }
         this._viewPadding = param1;
         invalidate(INV_VIEW_PADDING);
      }
      
      public function setStateSizeBoundaries(param1:int, param2:int) : void
      {
         var _loc3_:int = param2 < StageSizeBoundaries.HEIGHT_1080 ? int(Values.ZERO) : int(PADDING_TOP_HIGH);
         if(this._paddingTop != _loc3_)
         {
            this._paddingTop = _loc3_;
            invalidate(InvalidationType.SIZE);
         }
      }
      
      private function updateData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:AwardItemRendererEx = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:Sprite = null;
         if(this._data.bonuses)
         {
            _loc1_ = this._data.bonuses.length;
            this.clearBonuses();
            this.clearSeparators();
            this._bonuses = new Vector.<AwardItemRendererEx>();
            _loc2_ = null;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               _loc2_ = App.utils.classFactory.getComponent(Linkages.AWARD_RENDERER,AwardItemRendererEx);
               _loc2_.addEventListener(Event.CHANGE,this.onBonusChangeHandler);
               this.addChild(_loc2_);
               _loc2_.setData(this._data.bonuses[_loc3_]);
               this._bonuses.push(_loc2_);
               _loc3_++;
            }
            _loc4_ = _loc1_ > MAX_1ST_ROW_COUNT ? int(LINE_COUNT) : int(LINE_COUNT - 1);
            this._separators = new Vector.<Sprite>();
            _loc3_ = 0;
            while(_loc3_ < _loc4_)
            {
               _loc5_ = App.utils.classFactory.getComponent(Linkages.RANKED_BATTLES_QUALIFICATION_REWARD_HORIZONTAL_SEPARATOR,MovieClip);
               addChild(_loc5_);
               this._separators.push(_loc5_);
               if(this._separatorWidth == 0)
               {
                  this._separatorWidth = _loc5_.width;
               }
               _loc3_++;
            }
            dispatchEvent(new Event(Event.COMPLETE,true));
         }
      }
      
      private function updateLayout() : void
      {
         var _loc9_:DisplayObject = null;
         var _loc11_:Sprite = null;
         if(!this._bonuses)
         {
            return;
         }
         var _loc1_:int = this._bonuses.length;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(_loc1_ > MAX_1ST_ROW_COUNT)
         {
            _loc2_ = MAX_1ST_ROW_COUNT * STEP_X;
            _loc3_ = (_loc1_ - MAX_1ST_ROW_COUNT) * STEP_X;
            _loc4_ = width - _loc2_ >> 1;
            _loc5_ = width - _loc3_ >> 1;
         }
         else
         {
            _loc2_ = _loc1_ * STEP_X;
            _loc4_ = width - _loc2_ >> 1;
         }
         var _loc6_:int = Math.max(_loc2_,_loc3_);
         var _loc7_:int = width - this._viewPadding.left >> 1 > _loc6_ >> 1 ? int(-(this._viewPadding.left >> 1)) : int(0);
         var _loc8_:int = this._paddingTop + BONUS_Y_OFFSET;
         var _loc10_:int = 0;
         while(_loc10_ < _loc1_)
         {
            _loc9_ = this._bonuses[_loc10_];
            if(_loc10_ < MAX_1ST_ROW_COUNT)
            {
               _loc9_.x = _loc4_ + _loc10_ * STEP_X + _loc7_;
               _loc9_.y = _loc8_;
            }
            else
            {
               _loc9_.x = _loc5_ + (_loc10_ - MAX_1ST_ROW_COUNT) * STEP_X + _loc7_;
               _loc9_.y = STEP_Y + _loc8_;
            }
            _loc10_++;
         }
         _loc1_ = this._separators.length;
         _loc10_ = 0;
         while(_loc10_ < _loc1_)
         {
            _loc11_ = this._separators[_loc10_];
            _loc11_.x = (width - _loc11_.width >> 1) + _loc7_;
            _loc11_.y = _loc10_ * STEP_Y + this._paddingTop;
            _loc11_.width = Math.min(width,this._separatorWidth);
            _loc10_++;
         }
         this.descriptionTf.x = (width - this.descriptionTf.width >> 1) + _loc7_;
         this.descriptionTf.y = height - DESCRIPTION_TF_OFFSET_Y;
      }
      
      private function clearBonuses() : void
      {
         var _loc1_:AwardItemRendererEx = null;
         if(this._bonuses)
         {
            for each(_loc1_ in this._bonuses)
            {
               _loc1_.removeEventListener(Event.CHANGE,this.onBonusChangeHandler);
               this.removeChild(_loc1_);
               _loc1_.dispose();
            }
            this._bonuses.length = 0;
            this._bonuses = null;
         }
      }
      
      private function clearSeparators() : void
      {
         var _loc1_:Sprite = null;
         if(this._separators)
         {
            for each(_loc1_ in this._separators)
            {
               this.removeChild(_loc1_);
            }
            this._separators.length = 0;
            this._separators = null;
            this._separatorWidth = 0;
         }
      }
      
      private function onBonusChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      public function get rewardsIconSize() : String
      {
         return RANKEDBATTLES_CONSTS.RANKED_REWARDS_REWARD_SIZE_BIG;
      }
      
      public function get rewardsCount() : int
      {
         return MAX_COUNT;
      }
   }
}
