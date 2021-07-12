package net.wg.gui.lobby.rankedBattles19.view.rewards.year
{
   import flash.display.Sprite;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class RankedBattlesYearRewardBtn extends SoundButtonEx
   {
       
      
      public var circle:Sprite = null;
      
      public var glow:Sprite = null;
      
      private var _id:String = "";
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      private var _status:String = "";
      
      public function RankedBattlesYearRewardBtn()
      {
         super();
         constraintsDisabled = true;
         preventAutosizing = true;
         hitArea = this.circle;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         this._tooltipMgr = App.toolTipMgr;
         bgMc.mouseEnabled = bgMc.mouseChildren = false;
         this.glow.mouseEnabled = this.glow.mouseChildren = false;
         if(focusIndicator)
         {
            focusIndicator.mouseEnabled = focusIndicator.mouseChildren = false;
         }
         this.updateActivity();
      }
      
      override protected function onDispose() : void
      {
         hitArea = null;
         this.circle = null;
         this.glow = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function showTooltip() : void
      {
         if(StringUtils.isNotEmpty(this._id) && this._tooltipMgr)
         {
            this._tooltipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_YEAR_REWARD,null,this._id,this._status);
         }
      }
      
      public function containerScale(param1:Number) : void
      {
         this.circle.scaleX = this.circle.scaleY = param1;
      }
      
      private function updateActivity() : void
      {
         mouseEnabled = true;
         mouseChildren = true;
         buttonMode = false;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.updateActivity();
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
      }
      
      public function get id() : String
      {
         return this._id;
      }
      
      public function set id(param1:String) : void
      {
         this._id = param1;
      }
      
      public function get status() : String
      {
         return this._status;
      }
      
      public function set status(param1:String) : void
      {
         if(this._status == param1)
         {
            return;
         }
         this._status = param1;
         this.selected = param1 == RANKEDBATTLES_CONSTS.YEAR_REWARD_STATUS_CURRENT || param1 == RANKEDBATTLES_CONSTS.YEAR_REWARD_STATUS_CURRENT_FINAL;
         if(!selected)
         {
            if(RANKEDBATTLES_CONSTS.RANKED_REWARDS_YEAR_MAIN_AVAILABLE_FOR.indexOf(this._id) >= 0)
            {
               soundType = SoundTypes.RANKED_BATTLES_YEAR_REWARDS_MAIN;
            }
            else
            {
               soundType = SoundTypes.RANKED_BATTLES_YEAR_REWARDS_SECOND;
            }
         }
         soundEnabled = !selected;
      }
   }
}
