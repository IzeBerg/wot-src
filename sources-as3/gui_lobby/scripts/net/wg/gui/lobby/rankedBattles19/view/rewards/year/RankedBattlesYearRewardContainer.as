package net.wg.gui.lobby.rankedBattles19.view.rewards.year
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.rankedBattles19.data.RankedRewardYearItemVO;
   import net.wg.gui.lobby.rankedBattles19.events.RewardYearEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RankedBattlesYearRewardContainer extends Sprite implements IDisposable
   {
      
      private static const COUNTER_SCALE_KOF:Number = 0.9;
      
      private static const CAPTION_TOP_SHIFT:int = 16;
      
      private static const CAPTION_IMG_TOP_SHIFT:int = -5;
      
      private static const CAPTION_IMG_LEFT_SHIFT:int = -32;
       
      
      public var reward0:RankedBattlesYearRewardBtn = null;
      
      public var reward1:RankedBattlesYearRewardBtn = null;
      
      public var reward2:RankedBattlesYearRewardBtn = null;
      
      public var reward3:RankedBattlesYearRewardBtn = null;
      
      public var captionTF:TextField = null;
      
      public var captionImg:Image = null;
      
      private var _selectedBtn:RankedBattlesYearRewardBtn = null;
      
      private var _buttons:Dictionary = null;
      
      private var _counterScale:Number = 1;
      
      public function RankedBattlesYearRewardContainer()
      {
         var _loc1_:RankedBattlesYearRewardBtn = null;
         super();
         this._buttons = new Dictionary();
         this._buttons[RANKEDBATTLES_CONSTS.RANKED_REWARDS_YEAR_SMALL] = this.reward0;
         this._buttons[RANKEDBATTLES_CONSTS.RANKED_REWARDS_YEAR_MEDIUM] = this.reward1;
         this._buttons[RANKEDBATTLES_CONSTS.RANKED_REWARDS_YEAR_BIG] = this.reward2;
         this._buttons[RANKEDBATTLES_CONSTS.RANKED_REWARDS_YEAR_LARGE] = this.reward3;
         for each(_loc1_ in this._buttons)
         {
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onBtnMouseRollOverHandler);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onBtnMouseRollOutHandler);
         }
      }
      
      private static function isMainAwardAvailableForBoxID(param1:String) : Boolean
      {
         return RANKEDBATTLES_CONSTS.RANKED_REWARDS_YEAR_MAIN_AVAILABLE_FOR.indexOf(param1) >= 0;
      }
      
      public final function dispose() : void
      {
         var _loc1_:RankedBattlesYearRewardBtn = null;
         this.captionTF = null;
         this._selectedBtn = null;
         for each(_loc1_ in this._buttons)
         {
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onBtnMouseRollOverHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onBtnMouseRollOutHandler);
            _loc1_.dispose();
         }
         App.utils.data.cleanupDynamicObject(this._buttons);
         this._buttons = null;
         this.captionImg.dispose();
         this.captionImg = null;
         this.reward0 = null;
         this.reward1 = null;
         this.reward2 = null;
         this.reward3 = null;
      }
      
      public function getPointsPos() : int
      {
         return this.reward0.y + this.reward0.points.y;
      }
      
      public function setData(param1:Vector.<RankedRewardYearItemVO>) : void
      {
         var _loc3_:RankedBattlesYearRewardBtn = null;
         var _loc4_:RankedRewardYearItemVO = null;
         var _loc7_:Boolean = false;
         var _loc2_:int = param1.length;
         this._selectedBtn = null;
         var _loc5_:int = 0;
         while(_loc5_ < _loc2_)
         {
            _loc4_ = param1[_loc5_];
            _loc3_ = this._buttons[_loc4_.id];
            if(_loc3_)
            {
               _loc3_.setData(_loc4_);
               if(_loc3_.selected)
               {
                  this._selectedBtn = _loc3_;
               }
            }
            _loc5_++;
         }
         var _loc6_:Boolean = this._selectedBtn != null;
         this.captionTF.visible = this.captionImg.visible = _loc6_;
         if(_loc6_)
         {
            this.captionTF.htmlText = this._selectedBtn.statusText;
            _loc7_ = this._selectedBtn.status == RANKEDBATTLES_CONSTS.YEAR_REWARD_STATUS_CURRENT_FINAL;
            this.captionImg.visible = _loc7_;
            if(_loc7_ && StringUtils.isEmpty(this.captionImg.source))
            {
               this.captionImg.source = RES_ICONS.MAPS_ICONS_LIBRARY_DONE;
            }
         }
         App.utils.commons.updateTextFieldSize(this.captionTF,true,false);
         this.updateCaption();
      }
      
      private function updateCaption() : void
      {
         if(this._selectedBtn)
         {
            this.captionTF.scaleX = this.captionTF.scaleY = this._counterScale;
            this.captionTF.x = this._selectedBtn.x - (this.captionTF.width >> 1);
            this.captionTF.y = this._selectedBtn.y + CAPTION_TOP_SHIFT * this._counterScale;
            if(this.captionImg.visible)
            {
               this.captionImg.scaleX = this.captionImg.scaleY = this._counterScale;
               this.captionImg.x = this.captionTF.x + CAPTION_IMG_LEFT_SHIFT * this._counterScale;
               this.captionImg.y = this.captionTF.y + CAPTION_IMG_TOP_SHIFT * this._counterScale;
            }
         }
      }
      
      public function set scale(param1:Number) : void
      {
         var _loc2_:RankedBattlesYearRewardBtn = null;
         scaleX = scaleY = param1;
         this._counterScale = Math.max(1,COUNTER_SCALE_KOF / param1);
         for each(_loc2_ in this._buttons)
         {
            _loc2_.containerScale(this._counterScale);
         }
         this.updateCaption();
      }
      
      private function onBtnMouseRollOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:RankedBattlesYearRewardBtn = RankedBattlesYearRewardBtn(param1.currentTarget);
         if(isMainAwardAvailableForBoxID(_loc2_.id))
         {
            dispatchEvent(new RewardYearEvent(RewardYearEvent.MAIN_AWARD_SHOW,false));
         }
      }
      
      private function onBtnMouseRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:RankedBattlesYearRewardBtn = RankedBattlesYearRewardBtn(param1.currentTarget);
         if(isMainAwardAvailableForBoxID(_loc2_.id))
         {
            dispatchEvent(new RewardYearEvent(RewardYearEvent.MAIN_AWARD_SHOW,true));
         }
      }
   }
}
