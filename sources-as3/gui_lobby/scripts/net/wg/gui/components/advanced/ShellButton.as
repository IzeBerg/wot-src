package net.wg.gui.components.advanced
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.infrastructure.exceptions.ArgumentException;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   
   [InspectableList("soundId")]
   public class ShellButton extends CooldownSlot
   {
      
      private static const STATE_PREFIX_INACTIVE:String = "inactive_";
      
      private static const STATE_PREFIX_PASSIVE:String = "passive_";
      
      private static const INV_COUNTER:String = "invCounter";
      
      private static const INV_LEVEL:String = "invLevel";
      
      private static const INV_COUNTER_INDICATOR:String = "invCounterIndicator";
      
      private static const INV_PASSIVE:String = "invPassive";
      
      private static const INV_DEFAULT:String = "invDefault";
      
      private static const DISABLED_ALPHA:Number = 0.6;
      
      private static const ACTIVATE_FRAME_LABEL:String = "activate";
      
      private static const SHOW_ANIMATION_FRAME_LABEL:String = "showAnim";
      
      private static const UP_STATE_NAME:String = "up";
      
      private static const MAX_LEVEL:int = 10;
      
      private static const EMPTY_COUNT_VALUE:String = Values.EMPTY_STR;
      
      private static const INVALID_TOOLTIP_TYPE:String = "TooltipType value is invalid: ";
      
      private static const EMPTY_STR:String = "";
       
      
      public var count_txt:TextField;
      
      public var countBg:MovieClip;
      
      public var levelMc:MovieClip;
      
      public var counterIndicator:MovieClip;
      
      public var activatorMC:MovieClip;
      
      public var rechargeMc:MovieClip;
      
      public var defaultBg:MovieClip;
      
      private var _showCounterIndicator:Boolean = false;
      
      private var _statesPassive:Vector.<String>;
      
      private var _statesInactive:Vector.<String>;
      
      private var _historicalBattleID:int = -1;
      
      private var _ammunitionType:String;
      
      private var _count:String;
      
      private var _inventoryCount:int;
      
      private var _level:int = -1;
      
      private var _tooltipType:String = "hangarShell";
      
      private var _tooltip:String = "";
      
      private var _isPassive:Boolean = false;
      
      private var _isDefault:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function ShellButton()
      {
         this._statesPassive = Vector.<String>([STATE_PREFIX_PASSIVE]);
         this._statesInactive = Vector.<String>([STATE_PREFIX_INACTIVE]);
         this._toolTipMgr = App.toolTipMgr;
         super();
         soundType = SoundTypes.FITTING_BUTTON;
         soundId = SoundTypes.TANK_SHELL_SLOT;
         this.count = EMPTY_COUNT_VALUE;
      }
      
      override public function clear() : void
      {
         super.clear();
         this.count = EMPTY_COUNT_VALUE;
         this.level = -1;
         this._showCounterIndicator = false;
      }
      
      override public function setCoolDownPosAsPercent(param1:Number) : void
      {
         super.setCoolDownPosAsPercent(param1);
         if(isDischarging && !isCooolDownInProgress)
         {
            this.activatorMC.visible = true;
            this.activatorMC.gotoAndPlay(ACTIVATE_FRAME_LABEL);
         }
      }
      
      override public function setCooldown(param1:Number) : void
      {
         super.setCooldown(param1);
         if(param1 > 0 && !isCooolDownInProgress && isDischarging)
         {
            this.activatorMC.visible = true;
            this.activatorMC.gotoAndPlay(ACTIVATE_FRAME_LABEL);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.levelMc.visible = false;
         this.activatorMC.visible = false;
         this.defaultBg.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.rechargeMc = null;
         this.activatorMC = null;
         this.count_txt = null;
         this.countBg = null;
         this.levelMc = null;
         this.counterIndicator = null;
         this.defaultBg = null;
         this._statesPassive.splice(0,this._statesPassive.length);
         this._statesPassive = null;
         this._statesInactive.splice(0,this._statesInactive.length);
         this._statesInactive = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(INV_COUNTER))
         {
            this.count_txt.text = this._count;
            this.countBg.visible = this._count != EMPTY_COUNT_VALUE;
         }
         if(isInvalid(INV_LEVEL))
         {
            if(this._level > 0 && this._level <= MAX_LEVEL)
            {
               this.levelMc.visible = true;
               this.levelMc.gotoAndStop(this._level);
            }
            else
            {
               this.levelMc.visible = false;
            }
         }
         if(isInvalid(INV_COUNTER_INDICATOR))
         {
            if(this._showCounterIndicator)
            {
               this.counterIndicator.visible = true;
               this.counterIndicator.gotoAndPlay(SHOW_ANIMATION_FRAME_LABEL);
            }
            else
            {
               this.counterIndicator.visible = false;
            }
         }
         if(isInvalid(INV_PASSIVE))
         {
            iconLoader.alpha = !!this._isPassive ? Number(DISABLED_ALPHA) : Number(1);
         }
         if(isInvalid(INV_DEFAULT))
         {
            this.defaultBg.visible = this._isDefault;
         }
      }
      
      override protected function onMouseOver() : void
      {
         var _loc1_:String = null;
         super.onMouseOver();
         switch(this.tooltipType)
         {
            case TOOLTIPS_CONSTANTS.HANGAR_SHELL:
               _loc1_ = id;
               if(StringUtils.isNotEmpty(_loc1_))
               {
                  this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.HANGAR_SHELL,null,_loc1_,this.historicalBattleID);
               }
               break;
            case TOOLTIPS_CONSTANTS.SIMPLE:
               if(this._tooltip)
               {
                  this._toolTipMgr.show(this._tooltip);
               }
               break;
            case TOOLTIPS_CONSTANTS.COMPLEX:
               if(this._tooltip)
               {
                  this._toolTipMgr.showComplex(this._tooltip);
               }
               break;
            default:
               throw new ArgumentException(INVALID_TOOLTIP_TYPE + this.tooltipType);
         }
      }
      
      override protected function onMouseOut() : void
      {
         super.onMouseOut();
         this._toolTipMgr.hide();
      }
      
      override protected function onCooldownAnimatorFinished() : void
      {
         super.onCooldownAnimatorFinished();
         if(!isDischarging)
         {
            this.activatorMC.visible = true;
            this.activatorMC.gotoAndPlay(ACTIVATE_FRAME_LABEL);
         }
      }
      
      override protected function getStatePrefixes() : Vector.<String>
      {
         if(this._isPassive)
         {
            return this._statesPassive;
         }
         if(isInactive)
         {
            return this._statesInactive;
         }
         return !!_selected ? statesSelected : statesDefault;
      }
      
      public function highlightCounter(param1:Boolean) : void
      {
         if(this._showCounterIndicator != param1)
         {
            this._showCounterIndicator = param1;
            invalidate(INV_COUNTER_INDICATOR);
         }
      }
      
      public function playRechargeAnimation() : void
      {
         this.rechargeMc.visible = true;
         this.rechargeMc.gotoAndPlay(ACTIVATE_FRAME_LABEL);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         if(param1 == enabled)
         {
            return;
         }
         if(this.focusable && this.focused && !param1)
         {
            this.focused = 0;
         }
         super.enabled = param1;
         buttonMode = enabled;
         mouseEnabled = enabled;
      }
      
      override public function set isInactive(param1:Boolean) : void
      {
         super.isInactive = param1;
         setState(Boolean(_state) ? _state : UP_STATE_NAME);
      }
      
      public function get isDefault() : Boolean
      {
         return this._isDefault;
      }
      
      public function set isDefault(param1:Boolean) : void
      {
         this._isDefault = param1;
         invalidate(INV_DEFAULT);
      }
      
      public function get historicalBattleID() : int
      {
         return this._historicalBattleID;
      }
      
      public function set historicalBattleID(param1:int) : void
      {
         this._historicalBattleID = param1;
      }
      
      [Inspectable(defaultValue="",name="ammunitionType")]
      public function get ammunitionType() : String
      {
         return this._ammunitionType;
      }
      
      public function set ammunitionType(param1:String) : void
      {
         this._ammunitionType = param1;
      }
      
      [Inspectable(defaultValue="",name="count")]
      public function get count() : String
      {
         return this._count;
      }
      
      public function set count(param1:String) : void
      {
         this._count = param1;
         invalidate(INV_COUNTER);
      }
      
      public function get inventoryCount() : int
      {
         return this._inventoryCount;
      }
      
      public function set inventoryCount(param1:int) : void
      {
         this._inventoryCount = param1;
      }
      
      public function get level() : int
      {
         return this._level;
      }
      
      public function set level(param1:int) : void
      {
         this._level = param1;
         invalidate(INV_LEVEL);
      }
      
      public function get tooltipType() : String
      {
         return this._tooltipType;
      }
      
      public function set tooltipType(param1:String) : void
      {
         this._tooltipType = param1;
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
      }
      
      public function get isPassive() : Boolean
      {
         return this._isPassive;
      }
      
      public function set isPassive(param1:Boolean) : void
      {
         this._isPassive = param1;
         setState(Boolean(_state) ? _state : UP_STATE_NAME);
         invalidate(INV_PASSIVE);
      }
      
      [Inspectable(defaultValue="",name="ammunitionIcon")]
      public function get ammunitionIcon() : String
      {
         return EMPTY_STR;
      }
      
      public function set ammunitionIcon(param1:String) : void
      {
      }
   }
}
