package net.wg.gui.lobby.rankedBattles19.view.rewards.year
{
   import flash.display.Sprite;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.rankedBattles19.data.RankedRewardYearItemVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RankedBattlesYearRewardBtn extends SoundButtonEx
   {
       
      
      public var points:RankedBattlesYearRewardPoints = null;
      
      public var glow:Sprite = null;
      
      private var _rewardData:RankedRewardYearItemVO = null;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      public function RankedBattlesYearRewardBtn()
      {
         super();
         constraintsDisabled = true;
         preventAutosizing = true;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._tooltipMgr = App.toolTipMgr;
         bgMc.mouseEnabled = bgMc.mouseChildren = false;
         this.glow.mouseEnabled = this.glow.mouseChildren = false;
         this.points.mouseEnabled = this.points.mouseChildren = false;
         if(focusIndicator)
         {
            focusIndicator.mouseEnabled = focusIndicator.mouseChildren = false;
         }
      }
      
      override protected function onDispose() : void
      {
         hitArea = null;
         this.points.dispose();
         this.points = null;
         this.glow = null;
         this._rewardData = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function showTooltip() : void
      {
         var _loc1_:String = this._rewardData.id;
         if(StringUtils.isNotEmpty(_loc1_))
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_YEAR_REWARD,null,_loc1_,this._rewardData.status);
         }
      }
      
      public function containerScale(param1:Number) : void
      {
         this.points.scaleX = this.points.scaleY = param1;
      }
      
      public function setData(param1:RankedRewardYearItemVO) : void
      {
         if(this._rewardData != param1 && param1 != null)
         {
            this._rewardData = param1;
            this.updateData();
         }
      }
      
      private function updateData() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         _loc1_ = this._rewardData.status;
         selected = RANKEDBATTLES_CONSTS.YEAR_REWARD_SELECTED_STATUSES.indexOf(_loc1_) >= 0;
         if(!selected)
         {
            if(RANKEDBATTLES_CONSTS.RANKED_REWARDS_YEAR_MAIN_AVAILABLE_FOR.indexOf(this._rewardData.id) >= 0)
            {
               soundType = SoundTypes.RANKED_BATTLES_YEAR_REWARDS_MAIN;
            }
            else
            {
               soundType = SoundTypes.RANKED_BATTLES_YEAR_REWARDS_SECOND;
            }
         }
         soundEnabled = !selected;
         _loc2_ = _loc1_ != RANKEDBATTLES_CONSTS.YEAR_REWARD_STATUS_CURRENT_FINAL && _loc1_ != RANKEDBATTLES_CONSTS.YEAR_REWARD_STATUS_CURRENT_CHOOSE;
         this.points.visible = _loc2_;
         if(_loc2_)
         {
            this.points.setData(this._rewardData.points);
         }
      }
      
      public function get id() : String
      {
         return this._rewardData.id;
      }
      
      public function get status() : String
      {
         return this._rewardData.status;
      }
      
      public function get statusText() : String
      {
         return this._rewardData.statusText;
      }
   }
}
