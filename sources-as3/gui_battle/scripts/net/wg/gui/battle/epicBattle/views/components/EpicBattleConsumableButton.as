package net.wg.gui.battle.epicBattle.views.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.InteractiveStates;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.generated.BATTLEATLAS;
   import net.wg.data.constants.generated.BATTLE_ITEM_STATES;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.gui.battle.views.consumablesPanel.BattleEquipmentButton;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class EpicBattleConsumableButton extends BattleEquipmentButton
   {
      
      private static const LOCKED_INFO_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 6;
      
      private static const CONSUMABLE_LEVEL_INV:uint = InvalidationType.SYSTEM_FLAGS_BORDER << 7;
      
      private static const LOCKED_TF_ALPHA:Number = 0.5;
      
      private static const DEFAULT_LVL_X:int = 52;
      
      private static const HIT_AREA_NAME:String = "emptyHitArea";
       
      
      public var ranksMc:MovieClip = null;
      
      public var ranksHitArea:MovieClip = null;
      
      public var levelIcon:BattleAtlasSprite = null;
      
      private var _rankLevel:int = -1;
      
      private var _consumableLevel:int;
      
      private var _tooltipLockedStr:String = "";
      
      private var _isRankTooltipVisible:Boolean = false;
      
      public function EpicBattleConsumableButton()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.ranksHitArea.mouseEnabled = false;
         this.ranksMc.hitArea = this.ranksHitArea;
         var _loc1_:Sprite = new Sprite();
         _loc1_.name = HIT_AREA_NAME;
         addChild(_loc1_);
         glow.hitArea = _loc1_;
      }
      
      override public function showGlow(param1:int) : void
      {
         glow.showGlow(param1);
      }
      
      override public function updateLevelInformation(param1:int) : void
      {
         this._consumableLevel = param1;
         invalidate(CONSUMABLE_LEVEL_INV);
      }
      
      override public function updateLockedInformation(param1:int, param2:String) : void
      {
         this._rankLevel = param1;
         this._tooltipLockedStr = param2;
         invalidate(LOCKED_INFO_INV);
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
         var _loc4_:Boolean = false;
         super.draw();
         _loc1_ = this.isLockedRank();
         var _loc2_:Boolean = isInvalid(LOCKED_INFO_INV);
         var _loc3_:Boolean = isInvalid(CONSUMABLE_LEVEL_INV);
         if(_loc2_)
         {
            this.ranksMc.visible = _loc1_;
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
            _loc4_ = this._consumableLevel > 0;
            this.levelIcon.visible = _loc4_;
            if(_loc4_)
            {
               this.levelIcon.imageName = BATTLEATLAS.level(this._consumableLevel.toString());
               this.levelIcon.drawImmediately();
               this.levelIcon.x = DEFAULT_LVL_X - this.levelIcon.width;
            }
         }
         if(_loc2_ || _loc3_)
         {
            this.levelIcon.alpha = !!_loc1_ ? Number(LOCKED_TF_ALPHA) : Number(1);
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
         this.levelIcon = null;
         this.ranksMc = null;
         this.ranksHitArea = null;
         super.onDispose();
      }
      
      override protected function invokeRollOverActions() : void
      {
         if(!this._isRankTooltipVisible && (enabled || isAllowedToShowToolTipOnDisabledState))
         {
            showTooltip();
         }
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
   }
}
