package net.wg.gui.battle.epicBattle.views.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EpicBattleConsumableButton extends BattleEquipmentButton
   {
      
      private static const LOCKED_INFO_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 6;
      
      private static const CONSUMABLE_LEVEL_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 7;
      
      private static const POSSIBLE_STACKS_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 8;
      
      private static const STACKS_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 9;
      
      private static const LOCKED_TF_ALPHA:Number = 0.5;
      
      private static const STACKS_MIN_VALUE:int = 2;
      
      private static const STACKS_MULTIPLY:String = "x";
       
      
      public var ranksMc:MovieClip = null;
      
      public var ranksHitArea:MovieClip = null;
      
      public var levelMc:MovieClip = null;
      
      public var stacksTf:TextField = null;
      
      private var _rankLevel:int = -1;
      
      private var _consumableLevel:int = -1;
      
      private var _possibleStacks:int = -1;
      
      private var _stacks:int = -1;
      
      private var _tooltipLockedStr:String = "";
      
      private var _isRankTooltipVisible:Boolean = false;
      
      private var _hasBindKey:Boolean = true;
      
      public function EpicBattleConsumableButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ranksHitArea.mouseEnabled = false;
         this.ranksMc.hitArea = this.ranksHitArea;
         App.utils.commons.addEmptyHitArea(Sprite(glow));
      }
      
      override public function showGlow(param1:int) : void
      {
         glow.showGlow(param1);
      }
      
      override public function updateLevelInformation(param1:int) : void
      {
         this._consumableLevel = param1;
         (glow as EpicBattleEquipmentButtonGlow).setLevel(this._consumableLevel);
         invalidate(CONSUMABLE_LEVEL_INV);
      }
      
      override public function updateLockedInformation(param1:int, param2:String) : void
      {
         this._rankLevel = param1;
         this._tooltipLockedStr = param2;
         invalidate(LOCKED_INFO_INV);
      }
      
      override public function showPossibleStacks(param1:int) : void
      {
         if(this._possibleStacks == param1)
         {
            return;
         }
         this._possibleStacks = param1;
         invalidate(POSSIBLE_STACKS_INV);
      }
      
      override public function updateStacks(param1:int) : void
      {
         if(this._stacks == param1)
         {
            return;
         }
         this._stacks = param1;
         invalidate(STACKS_INV);
      }
      
      override protected function setBindKeyText() : void
      {
         if(this._possibleStacks >= STACKS_MIN_VALUE)
         {
            glow.setBindKeyText(this.stacksString(this._possibleStacks));
            return;
         }
         this._hasBindKey = bindSfKeyCode != Values.DEFAULT_INT;
         this.setBindKeyVisibility();
         if(this._hasBindKey)
         {
            super.setBindKeyText();
         }
      }
      
      override public function set activated(param1:Boolean) : void
      {
         if(param1)
         {
            state = BATTLE_ITEM_STATES.RELOADED;
            isActivated = true;
         }
         else
         {
            isActivated = false;
            state = InteractiveStates.UP;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         var _loc6_:Boolean = false;
         super.draw();
         _loc1_ = this.isLockedRank();
         var _loc2_:Boolean = isInvalid(LOCKED_INFO_INV);
         var _loc3_:Boolean = isInvalid(CONSUMABLE_LEVEL_INV);
         var _loc4_:Boolean = isInvalid(POSSIBLE_STACKS_INV);
         var _loc5_:Boolean = isInvalid(STACKS_INV);
         if(_loc2_)
         {
            this.ranksMc.visible = mouseChildren = _loc1_;
            if(_loc1_)
            {
               this.ranksMc.gotoAndStop(this._rankLevel);
               this.ranksMc.addEventListener(MouseEvent.ROLL_OVER,this.onRanksMcRollOverHandler,false,0,true);
               this.ranksMc.addEventListener(MouseEvent.ROLL_OUT,this.onRanksMcRollOutHandler,false,0,true);
            }
            else
            {
               this.ranksMc.removeEventListener(MouseEvent.ROLL_OVER,this.onRanksMcRollOverHandler);
               this.ranksMc.removeEventListener(MouseEvent.ROLL_OUT,this.onRanksMcRollOutHandler);
            }
         }
         if(_loc3_)
         {
            _loc6_ = this._consumableLevel > 0;
            this.levelMc.visible = _loc6_;
            if(_loc6_)
            {
               this.levelMc.gotoAndStop(this._consumableLevel);
            }
         }
         if(_loc2_ || _loc3_)
         {
            this.levelMc.alpha = !!_loc1_ ? Number(LOCKED_TF_ALPHA) : Number(1);
            this.setBindKeyVisibility();
         }
         if(_loc4_)
         {
            this.setBindKeyText();
         }
         if(_loc5_ && this._stacks >= STACKS_MIN_VALUE)
         {
            this.stacksTf.text = this.stacksString(this._stacks);
         }
      }
      
      override protected function removeListeners() : void
      {
         super.removeListeners();
         this.ranksMc.removeEventListener(MouseEvent.ROLL_OVER,this.onRanksMcRollOverHandler);
         this.ranksMc.removeEventListener(MouseEvent.ROLL_OUT,this.onRanksMcRollOutHandler);
      }
      
      override protected function onDispose() : void
      {
         this.ranksMc = null;
         this.levelMc = null;
         this.ranksHitArea = null;
         this.stacksTf = null;
         super.onDispose();
      }
      
      override protected function invokeRollOverActions() : void
      {
         if(!this._isRankTooltipVisible && (enabled || isAllowedToShowToolTipOnDisabledState))
         {
            this.showTooltip();
         }
      }
      
      override protected function showTooltip() : void
      {
         if(!_isTooltipVisible && StringUtils.isNotEmpty(_tooltipStr))
         {
            _isTooltipVisible = true;
            if(_tooltipStr == TOOLTIPS_CONSTANTS.FRONTLINE_RANDOM_RESERVE)
            {
               App.toolTipMgr.showSpecial(_tooltipStr,null,consumablesVO.idx);
            }
            else
            {
               App.toolTipMgr.showComplex(_tooltipStr);
            }
         }
      }
      
      private function stacksString(param1:int) : String
      {
         return STACKS_MULTIPLY + param1;
      }
      
      private function onRanksMcRollOverHandler(param1:MouseEvent) : void
      {
         if(this.isLockedRank())
         {
            invokeRollOutActions();
            if(!this._isRankTooltipVisible)
            {
               this._isRankTooltipVisible = true;
               App.toolTipMgr.showSpecial(this._tooltipLockedStr,null,this._rankLevel);
            }
         }
      }
      
      private function onRanksMcRollOutHandler(param1:MouseEvent) : void
      {
         if(this._isRankTooltipVisible)
         {
            this._isRankTooltipVisible = false;
            App.toolTipMgr.hide();
         }
         if(hitArea.hitTestPoint(App.stage.mouseX,App.stage.mouseY))
         {
            this.invokeRollOverActions();
         }
      }
      
      private function isLockedRank() : Boolean
      {
         return StringUtils.isNotEmpty(this._tooltipLockedStr);
      }
      
      private function setBindKeyVisibility() : void
      {
         glow.setBindKeyTextVisibility(this._hasBindKey && !this.isLockedRank());
      }
   }
}
