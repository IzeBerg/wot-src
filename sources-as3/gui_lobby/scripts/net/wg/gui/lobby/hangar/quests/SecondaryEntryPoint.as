package net.wg.gui.lobby.hangar.quests
{
   import fl.motion.AdjustColor;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.lobby.hangar.data.SecondaryEntryPointVO;
   import net.wg.infrastructure.base.meta.ISecondaryEntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.SecondaryEntryPointMeta;
   import net.wg.infrastructure.managers.ISoundManager;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterManager;
   import net.wg.utils.ICounterProps;
   import scaleform.gfx.MouseEventEx;
   
   public class SecondaryEntryPoint extends SecondaryEntryPointMeta implements ISecondaryEntryPointMeta
   {
      
      private static const COUNTER_PROPS:ICounterProps = new CounterProps(3,14,TextFormatAlign.RIGHT);
      
      private static const OUT_LABEL:String = "out";
      
      private static const OVER_LABEL:String = "over";
      
      private static const MAX_SIMPLE_TOOLTIP_DISABLED_WIDTH:int = 242;
      
      private static const MAX_COMPLEX_TOOLTIP_DISABLED_WIDTH:int = 306;
       
      
      public var hit:MovieClip = null;
      
      public var content:SecondaryEntryPointContent = null;
      
      private var _tooltip:String = "";
      
      private var _tooltipType:String = "";
      
      private var _soundMgr:ISoundManager;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _counterManager:ICounterManager;
      
      private var _isEnabled:Boolean = true;
      
      public function SecondaryEntryPoint()
      {
         this._soundMgr = App.soundMgr;
         this._toolTipMgr = App.toolTipMgr;
         this._counterManager = App.utils.counterManager;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.hit.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.hit.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.hit.addEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.hit.buttonMode = this.hit.useHandCursor = this._isEnabled;
      }
      
      override protected function setData(param1:SecondaryEntryPointVO) : void
      {
         this.content.setData(param1);
         this.isEnabled = param1.isEnabled;
         this._tooltip = param1.tooltip;
         this._tooltipType = param1.tooltipType;
      }
      
      override protected function onDispose() : void
      {
         this._counterManager.removeCounter(this);
         this.hit.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.hit.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.hit.removeEventListener(MouseEvent.CLICK,this.onMouseClickHandler);
         this.hit = null;
         this.content.dispose();
         this.content = null;
         this._soundMgr = null;
         this._toolTipMgr = null;
         this._counterManager = null;
         super.onDispose();
      }
      
      public function as_setCount(param1:int) : void
      {
         if(param1 > 0)
         {
            this._counterManager.setCounter(this.content.bounds,String(param1),null,COUNTER_PROPS);
         }
         else
         {
            this._counterManager.removeCounter(this.content.bounds);
         }
      }
      
      private function get isEnabled() : Boolean
      {
         return this._isEnabled;
      }
      
      private function set isEnabled(param1:Boolean) : void
      {
         var _loc2_:Array = null;
         var _loc3_:AdjustColor = null;
         if(this._isEnabled == param1)
         {
            return;
         }
         this._isEnabled = param1;
         if(param1)
         {
            _loc2_ = [];
         }
         else
         {
            _loc3_ = new AdjustColor();
            _loc3_.brightness = -30;
            _loc3_.saturation = -70;
            _loc3_.contrast = 0;
            _loc3_.hue = 0;
            _loc2_ = [new ColorMatrixFilter(_loc3_.CalculateFinalFlatArray())];
            this._counterManager.removeCounter(this.content.bounds);
         }
         this.content.filters = _loc2_;
         this.hit.buttonMode = this.hit.useHandCursor = this._isEnabled;
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
         gotoAndPlay(OUT_LABEL);
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         this._soundMgr.playControlsSnd(SoundManagerStates.SND_OVER,SoundTypes.SIMPLE_CONTROL,null);
         var _loc2_:ITooltipProps = ITooltipProps(this._toolTipMgr.getDefaultTooltipProps().clone());
         if(this._tooltipType == TOOLTIPS_CONSTANTS.WULF)
         {
            this._toolTipMgr.showWulfTooltip(this._tooltip,TOOLTIPS_CONSTANTS.BATTLE_PASS_AS3_TOOLTIP_CALL);
         }
         else if(this._tooltipType == TOOLTIPS_CONSTANTS.SIMPLE)
         {
            _loc2_.maxWidth = MAX_SIMPLE_TOOLTIP_DISABLED_WIDTH;
            this._toolTipMgr.show(this._tooltip,_loc2_);
         }
         else
         {
            _loc2_.maxWidth = MAX_COMPLEX_TOOLTIP_DISABLED_WIDTH;
            this._toolTipMgr.showComplex(this._tooltip,_loc2_);
         }
         gotoAndPlay(OVER_LABEL);
      }
      
      private function onMouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = null;
         var _loc3_:uint = 0;
         if(this.isEnabled)
         {
            _loc2_ = param1 as MouseEventEx;
            _loc3_ = _loc2_ == null ? uint(0) : uint(_loc2_.buttonIdx);
            if(_loc3_ == MouseEventEx.LEFT_BUTTON)
            {
               this._soundMgr.playControlsSnd(SoundManagerStates.SND_PRESS,SoundTypes.SIMPLE_CONTROL,null);
               onClickS();
            }
         }
      }
   }
}
