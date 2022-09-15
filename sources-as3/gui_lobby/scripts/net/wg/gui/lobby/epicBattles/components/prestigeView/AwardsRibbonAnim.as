package net.wg.gui.lobby.epicBattles.components.prestigeView
{
   import net.wg.gui.lobby.components.data.AwardItemRendererExVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class AwardsRibbonAnim extends UIComponentEx
   {
      
      public static const AWARD_SIZE_SMALL:int = 48;
      
      public static const AWARD_SIZE_BIG:int = 80;
      
      private static const BASE_DELAY:uint = 250;
       
      
      public var award1:AwardRendererAnim = null;
      
      public var award2:AwardRendererAnim = null;
      
      public var award3:AwardRendererAnim = null;
      
      public var award4:AwardRendererAnim = null;
      
      public var award5:AwardRendererAnim = null;
      
      public var award6:AwardRendererAnim = null;
      
      public var award7:AwardRendererAnim = null;
      
      public var award8:AwardRendererAnim = null;
      
      private var _awards:Vector.<AwardRendererAnim> = null;
      
      private var _maxAwardNum:uint = 0;
      
      private var _awardsNum:int = 0;
      
      private var _awardSize:int = 80;
      
      private var _awardGap:int = 0;
      
      public function AwardsRibbonAnim()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:AwardRendererAnim = null;
         for each(_loc1_ in this._awards)
         {
            _loc1_.dispose();
         }
         this._awards.length = 0;
         this._awards = null;
         this.award1 = this.award2 = this.award3 = this.award4 = this.award5 = this.award6 = this.award7 = this.award8 = null;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this._awards = new <AwardRendererAnim>[this.award1,this.award2,this.award3,this.award4,this.award5,this.award6,this.award7,this.award8];
         this._maxAwardNum = this._awards.length;
         var _loc1_:int = 0;
         while(_loc1_ < this._maxAwardNum)
         {
            this._awards[_loc1_].startDelay = _loc1_ * BASE_DELAY;
            _loc1_++;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(isInvalid(InvalidationType.LAYOUT))
         {
            _loc1_ = this._awardsNum * (this._awardSize + this._awardGap) - this._awardGap;
            _loc2_ = -(_loc1_ >> 1);
            _loc3_ = 0;
            while(_loc3_ < this._awardsNum)
            {
               this._awards[_loc3_].x = _loc2_;
               _loc2_ += this._awardSize + this._awardGap;
               _loc3_++;
            }
         }
      }
      
      public function setAwards(param1:Vector.<AwardItemRendererExVO>) : void
      {
         if(param1.length > this._maxAwardNum)
         {
            App.utils.asserter.assert(false,"Too many awards");
         }
         this._awardsNum = Math.min(param1.length,this._maxAwardNum);
         var _loc2_:AwardRendererAnim = null;
         var _loc3_:int = 0;
         while(_loc3_ < this._maxAwardNum)
         {
            _loc2_ = this._awards[_loc3_];
            if(_loc3_ < this._awardsNum)
            {
               _loc2_.setData(param1[_loc3_]);
               _loc2_.visible = true;
            }
            else
            {
               _loc2_.visible = false;
            }
            _loc3_++;
         }
      }
      
      public function show() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._awardsNum)
         {
            this._awards[_loc1_].show();
            _loc1_++;
         }
      }
      
      public function set awardSize(param1:int) : void
      {
         var _loc2_:int = 0;
         if(this._awardSize != param1)
         {
            this._awardSize = param1;
            _loc2_ = 0;
            while(_loc2_ < this._awardsNum)
            {
               this._awards[_loc2_].iconSize = param1;
               _loc2_++;
            }
            invalidateLayout();
         }
      }
      
      public function set awardGap(param1:int) : void
      {
         if(this._awardGap != param1)
         {
            this._awardGap = param1;
            invalidateLayout();
         }
      }
   }
}
